"""
routes/questions.py — /api/questions
GET  /generate         — algorithmic question generation
POST /attempt          — record a child's answer
GET  /templates        — list DB question templates
"""

import json
from datetime import datetime
from flask import Blueprint, request, jsonify, g
from utils.db import qry, child_in_family
from utils.auth import require_auth
from services.question_generator import QuestionGenerator
from services.gamification_service import award_reward

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
        # Insert into GeneratedQuestions first to get gq_id
        qry(
            "INSERT INTO dbo.GeneratedQuestions "
            "(template_id, child_id, question_text, correct_answer, options_json, params_json) "
            "VALUES (1, ?, ?, ?, ?, ?)",
            (child_id, body.get("question_text", ""), correct,
             json.dumps(body.get("options")), json.dumps(body.get("params"))),
            fetch="exec"
        )
        gq_id = qry("SELECT @@IDENTITY AS id", fetch="one")
        if gq_id:
            qry(
                "INSERT INTO dbo.QuestionAttempts "
                "(child_id, gq_id, given_answer, is_correct, time_sec) "
                "VALUES (?, ?, ?, ?, ?)",
                (child_id, gq_id["id"], given, 1 if is_correct else 0, time_sec),
                fetch="exec"
            )
    except Exception:
        pass

    # Gamification: reward correct answers with XP (drives levels + badges). DB-safe.
    if is_correct:
        award_reward(child_id, gems=2, xp=10, coins=1)

    return jsonify({"is_correct": is_correct,
                    "correct_answer": body.get("correct_answer"),
                    "hint": body.get("hint")})


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
