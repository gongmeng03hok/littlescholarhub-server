"""
routes/questions.py — /api/questions
GET  /generate         — algorithmic question generation
POST /attempt          — record a child's answer
GET  /templates        — list DB question templates
"""

import json
from datetime import datetime
from flask import Blueprint, request, jsonify, g, current_app
from utils.db import qry, child_in_family, get_db
from utils.auth import require_auth
from services.question_generator import QuestionGenerator
from services.gamification_service import award_reward
from services.badge_service import evaluate_and_award

questions_bp = Blueprint("questions", __name__)

VALID_SUBJECTS = list(QuestionGenerator.GENERATORS.keys())


@questions_bp.get("/generate")
def generate():
    subject = request.args.get("subject", "math")
    grade   = int(request.args.get("grade", 2))
    count   = min(int(request.args.get("count", 5)), 20)
    # dbo.Worksheets.interest_tag — "Ocean Math", "Dinosaurs Logic" and the rest
    # of the themed catalog pass it so the questions match the title.
    theme   = request.args.get("theme", "")
    # The skill the worksheet title promises. Without it a sheet called
    # "Beginning Sounds: S, M, T" drew from the generic phonics pool.
    skill   = request.args.get("skill", "")

    if subject not in VALID_SUBJECTS:
        subject = "math"

    questions = QuestionGenerator.generate(subject, grade, count, theme, skill)
    normalized = []
    for q in questions:
        normalized.append({
            **q,
            "question_text": q.get("question_text") or q.get("question") or "",
            "correct_answer": q.get("correct_answer") or q.get("answer") or "",
        })

    return jsonify({"questions": normalized, "subject": subject,
                    "grade": grade, "theme": theme, "skill": skill, "count": len(normalized)})


@questions_bp.post("/attempt")
@require_auth
def record_attempt():
    body          = request.json or {}
    given         = str(body.get("given_answer", "")).strip().lower()
    correct       = str(body.get("correct_answer", "")).strip().lower()
    is_correct    = given == correct
    child_id      = body.get("child_id")
    time_sec      = body.get("time_sec")

    # Ownership guard — a family may only record attempts for its own children
    if not child_in_family(child_id, g.family_id):
        return jsonify({"error": "Not found"}), 404

    try:
        # Insert the question and take its id in the SAME batch. Split across
        # two calls, SCOPE_IDENTITY() is NULL (it is scope-local and qry runs
        # each statement as its own batch) and @@IDENTITY would cross scopes
        # and could return a trigger's row id instead.
        # SET NOCOUNT ON so the INSERT's row count is not returned as a result
        # set ahead of the SELECT.
        row = qry(
            "SET NOCOUNT ON; "
            "INSERT INTO dbo.GeneratedQuestions "
            "(template_id, child_id, question_text, correct_answer, options_json, params_json) "
            "VALUES (1, ?, ?, ?, ?, ?); "
            "SELECT CAST(SCOPE_IDENTITY() AS INT) AS id;",
            (child_id, body.get("question_text", ""), correct,
             json.dumps(body.get("options")), json.dumps(body.get("params"))),
            fetch="one"
        )
        # qry only commits on fetch='exec', and the connection is
        # autocommit=False, so this batch must be committed by hand.
        get_db().commit()

        gq_id = (row or {}).get("id")
        if gq_id is not None:            # the dict is truthy even when id is None
            qry(
                "INSERT INTO dbo.QuestionAttempts "
                "(child_id, gq_id, given_answer, is_correct, time_sec) "
                "VALUES (?, ?, ?, ?, ?)",
                (child_id, gq_id, given, 1 if is_correct else 0, time_sec),
                fetch="exec"
            )
        else:
            current_app.logger.error(
                "progress write: no identity returned for child_id=%s", child_id)
    except Exception:
        # Never silent. This is the one record a family would miss, and a
        # swallowed failure looks exactly like a child who did no work.
        current_app.logger.exception(
            "progress write FAILED for child_id=%s — attempt not recorded", child_id)

    # Gamification: reward correct answers with XP (drives levels + badges). DB-safe.
    if is_correct:
        award_reward(child_id, gems=2, xp=10, coins=1)

    # Badges. Without this nothing ever evaluated them on an answer, so
    # first_sheet - which needs a single attempt - never fired across 47 of
    # them. Awarding must never break answering, hence the guard.
    earned = []
    try:
        earned = evaluate_and_award(child_id, "attempt") or []
    except Exception:
        current_app.logger.exception("badge evaluation failed for child_id=%s", child_id)

    # The screen cannot celebrate what it is not told about. Full rows, so
    # the popup has the label and the art without another round trip.
    new_badges = []
    if earned:
        try:
            marks = ",".join("?" for _ in earned)
            new_badges = qry(
                "SELECT slug AS badge_slug, label, icon, icon_url, description, xp_value"
                " FROM dbo.Badges WHERE slug IN (%s)" % marks,
                tuple(earned)
            ) or []
        except Exception:
            current_app.logger.exception("could not load newly earned badges")

    return jsonify({"is_correct": is_correct,
                    "correct_answer": body.get("correct_answer"),
                    "hint": body.get("hint"),
                    "new_badges": new_badges})


@questions_bp.get("/subjects")
def list_subjects():
    return jsonify([{"slug": s, "label": s.replace("_", " ").title()}
                    for s in VALID_SUBJECTS])


@questions_bp.get("/templates")
@require_auth
def list_templates():
    rows = qry(
        "SELECT qt.template_id, s.slug subject, g.label grade, d.label difficulty,"
        "       qt.template_type, qt.template_text, qt.is_active"
        " FROM dbo.QuestionTemplates qt"
        " JOIN dbo.Subjects s ON qt.subject_id = s.subject_id"
        " JOIN dbo.Grades g   ON qt.grade_id   = g.grade_id"
        " JOIN dbo.DifficultyLevels d ON qt.difficulty_id = d.level_id"
        " ORDER BY qt.subject_id, qt.grade_id"
    )
    return jsonify(rows or [])
