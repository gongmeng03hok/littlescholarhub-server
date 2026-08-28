"""
routes/progress.py — /api/progress
GET  /<child_id>       — streak + weekly summary
POST /log              — log a completed session
GET  /<child_id>/chart — last 7-day activity for chart
"""

from datetime import datetime, date, timedelta
from flask import Blueprint, request, jsonify, g
from utils.db import qry, child_in_family
from utils.auth import require_auth
from services.badge_service import get_child_badges, evaluate_and_award
from utils.validators import parse_int

progress_bp = Blueprint("progress", __name__)


def _verify_child(child_id: int, family_id: int) -> bool:
    return child_in_family(child_id, family_id)


@progress_bp.get("/<int:child_id>")
@require_auth
def get_progress(child_id):
    if not _verify_child(child_id, g.family_id):
        return jsonify({"error": "Not found"}), 404

    streak = qry(
        "SELECT current_streak, longest_streak, last_active, total_hours"
        " FROM dbo.Streaks WHERE child_id=?",
        (child_id,), fetch="one"
    ) or {"current_streak": 0, "longest_streak": 0, "last_active": None, "total_hours": 0}

    weekly = qry(
        "SELECT COUNT(*) AS sessions, ISNULL(SUM(duration_min), 0) AS mins"
        " FROM dbo.SessionLogs"
        " WHERE child_id=? AND session_date >= CAST(DATEADD(day,-7,GETDATE()) AS DATE)",
        (child_id,), fetch="one"
    ) or {"sessions": 0, "mins": 0}

    by_subject = qry(
        "SELECT s.slug, s.label, SUM(sl.duration_min) AS total_min"
        " FROM dbo.SessionLogs sl"
        " JOIN dbo.Subjects s ON sl.subject_id = s.subject_id"
        " WHERE sl.child_id=? AND sl.session_date >= CAST(DATEADD(day,-30,GETDATE()) AS DATE)"
        " GROUP BY s.slug, s.label"
        " ORDER BY total_min DESC",
        (child_id,)
    ) or []

    return jsonify({"streak": streak, "weekly": weekly, "by_subject": by_subject})


@progress_bp.post("/log")
@require_auth
def log_session():
    body       = request.json or {}
    child_id   = body.get("child_id")
    subject_id = body.get("subject_id", 3)
    duration   = parse_int(body.get("duration_min", 15), default=15, min_val=0, max_val=240)

    if not child_id:
        return jsonify({"error": "child_id required"}), 400

    # Ownership guard — a family may only log sessions for its own children
    if not _verify_child(child_id, g.family_id):
        return jsonify({"error": "Not found"}), 404

    try:
        qry(
            "INSERT INTO dbo.SessionLogs (child_id, subject_id, duration_min, completed)"
            " VALUES (?, ?, ?, 1)",
            (child_id, subject_id, duration), fetch="exec"
        )
        # Upsert streak
        qry(
            """
            MERGE dbo.Streaks AS tgt
            USING (SELECT ? AS cid) AS src ON tgt.child_id = src.cid
            WHEN MATCHED THEN UPDATE SET
                current_streak = CASE
                    WHEN last_active = CAST(DATEADD(day,-1,GETDATE()) AS DATE) THEN current_streak + 1
                    WHEN last_active = CAST(GETDATE() AS DATE) THEN current_streak
                    ELSE 1 END,
                longest_streak = CASE
                    WHEN (CASE
                        WHEN last_active = CAST(DATEADD(day,-1,GETDATE()) AS DATE) THEN current_streak + 1
                        WHEN last_active = CAST(GETDATE() AS DATE) THEN current_streak
                        ELSE 1 END) > longest_streak
                    THEN (CASE
                        WHEN last_active = CAST(DATEADD(day,-1,GETDATE()) AS DATE) THEN current_streak + 1
                        WHEN last_active = CAST(GETDATE() AS DATE) THEN current_streak
                        ELSE 1 END)
                    ELSE longest_streak END,
                last_active = CAST(GETDATE() AS DATE),
                total_hours = total_hours + ? / 60.0,
                updated_at  = GETDATE()
            WHEN NOT MATCHED THEN INSERT
                (child_id, current_streak, longest_streak, last_active, total_hours)
                VALUES (?, 1, 1, CAST(GETDATE() AS DATE), ? / 60.0);
            """,
            (child_id, duration, child_id, duration), fetch="exec"
        )
    except Exception:
        pass

    return jsonify({"ok": True})


@progress_bp.get("/<int:child_id>/activities")
@require_auth
def activities(child_id):
    """Itemized 'answer sheet' feed for parents: recent quiz attempts (with
    the actual question, the child's answer, and the correct answer) plus
    recent homework photo submissions."""
    if not _verify_child(child_id, g.family_id):
        return jsonify({"error": "Not found"}), 404
    limit = min(request.args.get("limit", 30, type=int), 100)

    quiz = qry(
        "SELECT TOP (?) qa.attempt_id, gq.question_text, qa.given_answer, "
        "       gq.correct_answer, qa.is_correct, qa.time_sec, qa.attempted_at "
        "FROM dbo.QuestionAttempts qa "
        "JOIN dbo.GeneratedQuestions gq ON qa.gq_id = gq.gq_id "
        "WHERE qa.child_id=? ORDER BY qa.attempted_at DESC",
        (limit, child_id)
    ) or []

    homework = qry(
        "SELECT TOP (?) hs.submission_id, hs.worksheet_id, w.title AS worksheet_title, "
        "       hs.image_file_id, hs.score, hs.mode, hs.submitted_at, hs.reviewed_at "
        "FROM dbo.HomeworkSubmissions hs "
        "LEFT JOIN dbo.Worksheets w ON hs.worksheet_id = w.worksheet_id "
        "WHERE hs.child_id=? ORDER BY hs.submitted_at DESC",
        (limit, child_id)
    ) or []
    if homework:
        from routes.content import file_url
        for h in homework:
            if h.get("image_file_id"):
                h["image_url"] = request.url_root.rstrip("/") + file_url(h["image_file_id"])

    return jsonify({"quiz_attempts": quiz, "homework": homework})


@progress_bp.get("/<int:child_id>/badges")
@require_auth
def badges(child_id):
    if not _verify_child(child_id, g.family_id):
        return jsonify({"error": "Not found"}), 404
    return jsonify(get_child_badges(child_id))


@progress_bp.get("/<int:child_id>/chart")
@require_auth
def chart_data(child_id):
    if not _verify_child(child_id, g.family_id):
        return jsonify({"error": "Not found"}), 404

    rows = qry(
        "SELECT session_date, SUM(duration_min) AS total_min"
        " FROM dbo.SessionLogs"
        " WHERE child_id=? AND session_date >= CAST(DATEADD(day,-6,GETDATE()) AS DATE)"
        " GROUP BY session_date ORDER BY session_date",
        (child_id,)
    ) or []

    # Fill missing days with 0
    today = date.today()
    day_map = {r["session_date"]: r["total_min"] for r in rows}
    chart = []
    for i in range(6, -1, -1):
        d = today - timedelta(days=i)
        chart.append({"date": str(d), "minutes": day_map.get(d, 0)})

    return jsonify(chart)
