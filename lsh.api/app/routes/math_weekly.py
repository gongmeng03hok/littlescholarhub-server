"""
routes/math_weekly.py  –  /api/math
Weekly math worksheet endpoints.

GET  /api/math/week?grade=2&week=14        → full 5-day packet
GET  /api/math/day?grade=2&day=Monday      → single day sheet
GET  /api/math/drill?grade=2               → 30-fact timed drill
GET  /api/math/topics?grade=2              → topic schedule for grade
GET  /api/math/topic?grade=2&slug=add_regroup&n=12 → ad-hoc topic questions
POST /api/math/attempt                     → record answer + XP
GET  /api/math/leaderboard?child_id=1      → weekly accuracy stats
"""

import json
from datetime import date
from flask import Blueprint, request, jsonify, g
from utils.auth import require_auth
from utils.db   import qry, child_in_family
from utils.validators import parse_int
from services.gamification_service import award_reward
from services.math_weekly_generator import (
    generate_weekly_packet,
    generate_daily_sheet,
    generate_timed_drill,
    get_current_week_topic,
    WEEKLY_TOPICS,
    REGISTRY,
    TopicGenerators,
)
from services.dynamic_math import DynamicMathQuestionService

math_weekly_bp = Blueprint("math_weekly", __name__)


# ── helpers ────────────────────────────────────────────────────────────────

def _grade(default=2):
    try:
        return max(0, min(7, int(request.args.get("grade", default))))
    except (ValueError, TypeError):
        return default


# ── routes ─────────────────────────────────────────────────────────────────

@math_weekly_bp.get("/week")
def get_week():
    """Full Mon–Fri packet for current (or specified) ISO week."""
    grade = _grade()
    week  = request.args.get("week")
    week  = int(week) if week else None
    packet = generate_weekly_packet(grade, week)
    return jsonify(packet)


@math_weekly_bp.get("/day")
def get_day():
    """Single day worksheet."""
    grade = _grade()
    day   = request.args.get("day", "Monday").capitalize()
    valid_days = ["Monday","Tuesday","Wednesday","Thursday","Friday"]
    if day not in valid_days:
        return jsonify({"error": f"day must be one of {valid_days}"}), 400

    topic = get_current_week_topic(grade)
    sheet = generate_daily_sheet(grade, day, topic["slug"], topic["label"], topic["week"])
    return jsonify(sheet)


@math_weekly_bp.get("/drill")
def get_drill():
    """30-problem timed fluency drill."""
    grade = _grade()
    return jsonify(generate_timed_drill(grade))


@math_weekly_bp.get("/dynamic-questions")
def get_dynamic_questions():
    """Fetch dynamically generated math questions from DB-backed templates."""
    grade = _grade()
    count = min(max(int(request.args.get("count", 5)), 1), 12)
    questions = DynamicMathQuestionService.get_db_questions(grade, count)
    if not questions:
        questions = DynamicMathQuestionService.generate_questions(grade, count)
    return jsonify({
        "grade_id": grade,
        "count": len(questions),
        "questions": questions,
    })


@math_weekly_bp.get("/topics")
def list_topics():
    """Return the full topic schedule for a grade."""
    grade  = _grade()
    topics = WEEKLY_TOPICS.get(grade, WEEKLY_TOPICS[2])
    current = get_current_week_topic(grade)
    return jsonify({
        "grade_id": grade,
        "current_week": current,
        "schedule": [
            {"week_in_cycle": w, "slug": s, "label": l}
            for w, s, l in topics
        ]
    })


@math_weekly_bp.get("/topic")
def get_topic_questions():
    """Generate questions for any topic slug on demand."""
    grade = _grade()
    slug  = request.args.get("slug", "add_to_20")
    n     = min(int(request.args.get("n", 10)), 30)

    fn = REGISTRY.get(slug)
    if not fn:
        return jsonify({"error": f"Unknown topic slug '{slug}'"}), 404

    try:
        questions = fn(n)
    except Exception as exc:
        return jsonify({"error": str(exc)}), 500

    topic_label = next(
        (l for topics in WEEKLY_TOPICS.values() for _, s, l in topics if s == slug),
        slug.replace("_", " ").title()
    )
    return jsonify({
        "slug": slug,
        "label": topic_label,
        "grade_id": grade,
        "questions": questions,
    })


@math_weekly_bp.post("/attempt")
@require_auth
def record_attempt():
    """Record a student answer and return correctness + XP awarded."""
    body         = request.json or {}
    child_id     = body.get("child_id")

    # Ownership guard — a family may only record attempts for its own children
    if not child_in_family(child_id, g.family_id):
        return jsonify({"error": "Not found"}), 404

    given        = str(body.get("given_answer", "")).strip().lower()
    correct_ans  = str(body.get("correct_answer", "")).strip().lower()
    is_correct   = given == correct_ans
    topic_slug   = body.get("topic_slug", "")
    week_num     = parse_int(body.get("week", date.today().isocalendar()[1]),
                             default=date.today().isocalendar()[1], min_val=1, max_val=53)
    time_sec     = body.get("time_sec")

    xp = 10 if is_correct else 0
    if is_correct and time_sec and time_sec < 15:
        xp += 5   # speed bonus

    try:
        qry(
            "INSERT INTO dbo.MathAttempts"
            " (child_id, topic_slug, week_num, question_text, given_answer,"
            "  correct_answer, is_correct, time_sec, xp_earned)"
            " VALUES (?,?,?,?,?,?,?,?,?)",
            (child_id, topic_slug, week_num,
             body.get("question_text",""), given,
             body.get("correct_answer",""), 1 if is_correct else 0,
             time_sec, xp),
            fetch="exec"
        )
    except Exception:
        pass   # dev / no DB

    # Gamification: bank the earned XP toward levels + milestone badges. DB-safe.
    if xp:
        award_reward(child_id, gems=2 if is_correct else 0, xp=xp, coins=1 if is_correct else 0)

    return jsonify({
        "is_correct":     is_correct,
        "correct_answer": body.get("correct_answer"),
        "hint":           body.get("hint"),
        "xp_earned":      xp,
    })


@math_weekly_bp.get("/leaderboard")
@require_auth
def leaderboard():
    """Weekly accuracy + XP for a child, by topic."""
    child_id = request.args.get("child_id", type=int)
    if not child_in_family(child_id, g.family_id):
        return jsonify({"error": "Not found"}), 404
    week     = request.args.get("week", date.today().isocalendar()[1], type=int)

    rows = qry(
        "SELECT topic_slug,"
        "       COUNT(*) total_attempts,"
        "       SUM(CASE WHEN is_correct=1 THEN 1 ELSE 0 END) correct,"
        "       SUM(xp_earned) xp,"
        "       AVG(CAST(time_sec AS FLOAT)) avg_sec"
        " FROM dbo.MathAttempts"
        " WHERE child_id=? AND week_num=?"
        " GROUP BY topic_slug"
        " ORDER BY xp DESC",
        (child_id, week)
    ) or []

    total_xp = sum(r["xp"] for r in rows if r["xp"])
    return jsonify({"week": week, "topics": rows, "total_xp": total_xp})


@math_weekly_bp.get("/summary")
@require_auth
def weekly_summary():
    """Accuracy summary across all weeks for a child."""
    child_id = request.args.get("child_id", type=int)
    if not child_in_family(child_id, g.family_id):
        return jsonify({"error": "Not found"}), 404
    rows = qry(
        "SELECT week_num,"
        "       COUNT(*) total,"
        "       SUM(CASE WHEN is_correct=1 THEN 1 ELSE 0 END) correct,"
        "       SUM(xp_earned) xp"
        " FROM dbo.MathAttempts WHERE child_id=?"
        " GROUP BY week_num ORDER BY week_num",
        (child_id,)
    ) or []
    return jsonify(rows)
