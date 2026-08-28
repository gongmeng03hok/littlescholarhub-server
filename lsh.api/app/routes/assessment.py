"""
routes/assessment.py — /api/assessment
GET  /questions          → ordered question list (from DB, fallback to hardcoded)
POST /submit             → build + save personalised weekly plan
GET  /plan/<child_id>    → retrieve latest plan
"""

import json
from datetime import datetime, date, timedelta
from flask import Blueprint, request, jsonify, g
from utils.db import qry, child_in_family
from utils.auth import require_auth, try_auth
from utils.validators import parse_int
from services.plan_builder import build_weekly_plan

assessment_bp = Blueprint("assessment", __name__)

# ── Fallback question list (used when DB table is not yet migrated) ───────────

ASSESSMENT_FLOW = [
    {
        "step": "age_grade",
        "subject": None,
        "text": "How old is your child and what grade are they in?",
        "input_type": "select",
        "options": ["TK (4-5 yrs)", "Kindergarten (5-6)", "1st Grade", "2nd Grade",
                    "3rd Grade", "4th Grade", "5th Grade", "6th Grade"]
    },
    {
        "step": "math_comfort",
        "subject": "math",
        "text": "How comfortable is your child with addition and subtraction?",
        "input_type": "scale",
        "options": ["1 – Needs a lot of help", "2", "3 – On track", "4", "5 – Advanced"]
    },
    {
        "step": "reading_level",
        "subject": "reading",
        "text": "How well does your child read on their own?",
        "input_type": "scale",
        "options": ["1 – Pre-reader", "2", "3 – Reading short books", "4", "5 – Chapter books"]
    },
    {
        "step": "phonics",
        "subject": "phonics",
        "text": "Can your child sound out new words they haven't seen before?",
        "input_type": "scale",
        "options": ["1 – Not yet", "2", "3 – Sometimes", "4", "5 – Confidently"]
    },
    {
        "step": "logic",
        "subject": "logic",
        "text": "Does your child enjoy puzzles, patterns, or brain teasers?",
        "input_type": "scale",
        "options": ["1 – Not really", "2", "3 – Sometimes", "4", "5 – Loves them"]
    },
    {
        "step": "feelings",
        "subject": "feelings",
        "text": "How well does your child talk about their emotions?",
        "input_type": "scale",
        "options": ["1 – Rarely", "2", "3 – Sometimes", "4", "5 – Openly"]
    },
    {
        "step": "manners",
        "subject": "manners",
        "text": "How does your child do with manners and social situations?",
        "input_type": "scale",
        "options": ["1 – Developing", "2", "3 – Usually good", "4", "5 – Excellent"]
    },
    {
        "step": "interests",
        "subject": None,
        "text": "What does your child love most? Pick up to 3.",
        "input_type": "multiselect",
        "options": ["Animals", "Space", "Art", "Sports", "Music", "Cooking",
                    "Nature", "Superheroes", "Dinosaurs", "Fantasy / Dragons"]
    },
    {
        "step": "language",
        "subject": None,
        "text": "What language does your family mainly speak at home?",
        "input_type": "select",
        "options": ["English", "Mandarin / Chinese", "Hindi", "Spanish", "Other"]
    },
    {
        "step": "culture",
        "subject": None,
        "text": "Which cultural programs interest your family?",
        "input_type": "multiselect",
        "options": ["Chinese Culture (Pinyin → 汉字 → 唐诗)",
                    "Indian Culture (Gita Stories + Art)",
                    "Hispanic Culture (Letras + Fiestas + Maestros)",
                    "None / Not sure yet"]
    },
    {
        "step": "time",
        "subject": None,
        "text": "How many minutes a day can your child study?",
        "input_type": "select",
        "options": ["15 minutes", "20 minutes", "30 minutes", "45 minutes", "60 minutes"]
    },
    {
        "step": "screen",
        "subject": None,
        "text": "Do you prefer printable worksheets, digital, or both?",
        "input_type": "select",
        "options": ["Printable only", "Digital / interactive", "Both"]
    },
    {
        "step": "goals",
        "subject": None,
        "text": "What is your main goal for your child this year?",
        "input_type": "select",
        "options": ["Reading fluency", "Math confidence", "Cultural connection",
                    "Emotional growth", "All-around enrichment"]
    },
    {
        "step": "heritage",
        "subject": None,
        "text": "Is there a heritage language you want your child to maintain?",
        "input_type": "select",
        "options": ["No", "Mandarin", "Hindi / Urdu", "Spanish", "Other"]
    },
    {
        "step": "anything_else",
        "subject": None,
        "text": "Anything else we should know about your child? (optional)",
        "input_type": "text",
        "options": []
    },
]


def _questions_from_db():
    """Fetch assessment questions from dbo.AssessmentQuestions. Returns [] on any error."""
    try:
        rows = qry(
            "SELECT step_key, subject, question_text,"
            "       ISNULL(sub_text,'') AS sub_text,"
            "       input_type, options_json"
            " FROM dbo.AssessmentQuestions"
            " WHERE is_active = 1"
            " ORDER BY sort_order",
            fetch="all"
        )
        if not rows:
            return []
        result = []
        for r in rows:
            result.append({
                "step":       r["step_key"],
                "subject":    r["subject"],
                "text":       r["question_text"],
                "sub":        r.get("sub_text", ""),
                "input_type": r["input_type"],
                "options":    json.loads(r["options_json"]) if r.get("options_json") else [],
            })
        return result
    except Exception:
        return []


@assessment_bp.get("/questions")
def get_questions():
    db_questions = _questions_from_db()
    return jsonify(db_questions if db_questions else ASSESSMENT_FLOW)



_GRADE_ANSWER_TO_ID = {"TK": 0, "K": 1, "1": 2, "2": 3, "3": 4, "4": 5, "5": 6, "6": 7}


def _grade_id_from_answers(answers, default=2):
    """grade_id (0-7) from assessment answers, tolerating either key."""
    raw = answers.get("grade")
    if isinstance(raw, str):
        mapped = _GRADE_ANSWER_TO_ID.get(raw.strip().upper())
        if mapped is not None:
            return mapped
    return parse_int(answers.get("grade_id", default), default=default, min_val=0, max_val=7)


@assessment_bp.post("/submit")
def submit_assessment():
    """Build a weekly plan from assessment answers.
    Works for both authenticated users (plan saved to DB) and guests (plan returned only).
    """
    is_authed = try_auth()
    body      = request.json or {}
    child_id  = body.get("child_id")
    answers   = body.get("answers", {})

    # Resolve grade: from child record if authenticated, else from answers.
    # The assessment sends a school year under "grade" ("TK", "K", "1".."6");
    # dbo.Grades keys on grade_id (0=TK, 1=K, 2=1st .. 7=6th). Reading only
    # "grade_id" meant the answer was never seen and every guest plan was built
    # for 1st grade -- including the ones whose reveal screen said "TK".
    grade = _grade_id_from_answers(answers)

    # Only trust / persist a child_id that actually belongs to this family (IDOR guard)
    owns_child = bool(is_authed and child_id and child_in_family(child_id, g.family_id))
    if owns_child:
        try:
            owns = qry(
                "SELECT grade_id FROM dbo.Children WHERE child_id=? AND family_id=?",
                (child_id, g.family_id), fetch="one"
            )
            if owns:
                grade = owns["grade_id"]
        except Exception:
            pass

    plan = build_weekly_plan(answers, grade)

    # Persist to DB only when the child is confirmed to belong to this family
    if owns_child:
        try:
            qry(
                "INSERT INTO dbo.AssessmentSessions (child_id, completed_at, total_q)"
                " VALUES (?, ?, ?)",
                (child_id, datetime.utcnow(), len(answers)), fetch="exec"
            )
            week_start = date.today() - timedelta(days=date.today().weekday())
            qry(
                "MERGE dbo.WeeklyPlans AS t"
                " USING (SELECT ? AS child_id, ? AS week_start) AS s"
                "   ON t.child_id = s.child_id AND t.week_start = s.week_start"
                " WHEN MATCHED THEN UPDATE SET plan_json=?, daily_min=?, generated_at=GETDATE()"
                " WHEN NOT MATCHED THEN INSERT (child_id, week_start, daily_min, plan_json)"
                "   VALUES (?, ?, ?, ?);",
                (child_id, str(week_start),
                 json.dumps(plan), plan["daily_min"],
                 child_id, str(week_start), plan["daily_min"], json.dumps(plan)),
                fetch="exec"
            )
        except Exception:
            pass

    # Top 3 subjects by allocated minutes → shown as starter activities on success screen
    subject_alloc = plan.get("subject_allocation", {})
    top_subjects = sorted(subject_alloc.items(), key=lambda x: x[1], reverse=True)[:3]
    starter_activities = [
        {"subject": slug, "minutes": mins} for slug, mins in top_subjects
    ]

    return jsonify({
        "plan":               plan,
        "starter_activities": starter_activities,
        "saved":              owns_child,
    })


@assessment_bp.get("/plan/<int:child_id>")
@require_auth
def get_plan(child_id):
    # Ownership guard — a family may only read plans for its own children
    if not child_in_family(child_id, g.family_id):
        return jsonify({"error": "No plan found"}), 404

    row = qry(
        "SELECT TOP 1 plan_id, week_start, daily_min, plan_json, generated_at"
        " FROM dbo.WeeklyPlans WHERE child_id=? ORDER BY week_start DESC",
        (child_id,), fetch="one"
    )
    if not row:
        return jsonify({"error": "No plan found"}), 404
    row["plan_json"] = json.loads(row["plan_json"]) if row.get("plan_json") else {}
    return jsonify(row)
