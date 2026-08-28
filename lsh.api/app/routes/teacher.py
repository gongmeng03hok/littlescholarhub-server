"""
routes/teacher.py — /api/teacher
Classroom CRUD + roster, student grades/activity, for approved teacher accounts.
"""

import random
from datetime import date, timedelta
from flask import Blueprint, request, jsonify, g
from utils.db   import qry, get_db
from utils.auth import require_teacher
from services.badge_service import get_child_badges

teacher_bp = Blueprint("teacher", __name__)


def _gen_classroom_code() -> str:
    chars = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789"
    return "".join(random.choices(chars, k=8))


def _new_unique_code() -> str:
    for _ in range(10):
        code = _gen_classroom_code()
        exists = qry("SELECT 1 FROM dbo.Classrooms WHERE classroom_code=?", (code,), fetch="one")
        if not exists:
            return code
    raise RuntimeError("Could not generate a unique classroom code")


# ── Students (all classrooms) ────────────────────────────────

@teacher_bp.get("/students")
@require_teacher
def list_all_students():
    """Flat roster across every classroom this teacher runs — used by the
    Students tab, as distinct from the per-classroom roster on Classrooms."""
    rows = qry(
        "SELECT c.child_id, c.nickname, c.grade_id, "
        "       cl.classroom_id, cl.classroom_name, scl.joined_at, "
        "       CASE WHEN c.family_id = ? THEN 1 ELSE 0 END AS is_teacher_added "
        "FROM dbo.StudentClassroomLink scl "
        "JOIN dbo.Children c ON scl.child_id = c.child_id "
        "JOIN dbo.Classrooms cl ON scl.classroom_id = cl.classroom_id "
        "WHERE cl.teacher_family_id=? AND cl.is_active=1 "
        "ORDER BY c.nickname ASC",
        (g.family_id, g.family_id)
    ) or []
    return jsonify(rows)


# ── Classrooms ────────────────────────────────────────────────

@teacher_bp.get("/classrooms")
@require_teacher
def list_classrooms():
    rows = qry(
        "SELECT c.classroom_id, c.classroom_name, c.school_name, c.classroom_code, "
        "       c.created_at, c.is_active, c.grade_id, gr.label AS grade_label, "
        "       (SELECT COUNT(*) FROM dbo.StudentClassroomLink scl "
        "        WHERE scl.classroom_id = c.classroom_id) AS student_count "
        "FROM dbo.Classrooms c "
        "LEFT JOIN dbo.Grades gr ON c.grade_id = gr.grade_id "
        "WHERE teacher_family_id=? AND is_active=1 "
        "ORDER BY CASE WHEN c.grade_id IS NULL THEN 1 ELSE 0 END, gr.sort_order, c.created_at DESC",
        (g.family_id,)
    ) or []
    return jsonify(rows)


@teacher_bp.post("/classrooms")
@require_teacher
def create_classroom():
    body = request.json or {}
    name = (body.get("classroom_name") or "").strip()
    if not name:
        return jsonify({"error": "classroom_name required"}), 400
    grade_id = body.get("grade_id")
    if grade_id is None:
        return jsonify({"error": "grade_id required"}), 400
    grade = qry("SELECT grade_id FROM dbo.Grades WHERE grade_id=?", (grade_id,), fetch="one")
    if not grade:
        return jsonify({"error": "Invalid grade_id"}), 400
    code = _new_unique_code()
    row = qry(
        "INSERT INTO dbo.Classrooms (teacher_family_id, classroom_name, school_name, classroom_code, grade_id) "
        "OUTPUT INSERTED.classroom_id AS classroom_id "
        "VALUES (?,?,?,?,?)",
        (g.family_id, name, body.get("school_name"), code, grade_id),
        fetch="one"
    )
    if not row:
        return jsonify({"error": "Could not create classroom"}), 500
    get_db().commit()
    return jsonify({"ok": True, "classroom_id": row["classroom_id"], "classroom_code": code}), 201


@teacher_bp.put("/classrooms/<int:classroom_id>")
@require_teacher
def update_classroom(classroom_id: int):
    owned = qry(
        "SELECT classroom_id FROM dbo.Classrooms WHERE classroom_id=? AND teacher_family_id=?",
        (classroom_id, g.family_id), fetch="one"
    )
    if not owned:
        return jsonify({"error": "Classroom not found"}), 404

    body = request.json or {}
    name = (body.get("classroom_name") or "").strip()
    if not name:
        return jsonify({"error": "classroom_name required"}), 400
    grade_id = body.get("grade_id")
    if grade_id is None:
        return jsonify({"error": "grade_id required"}), 400
    grade = qry("SELECT grade_id FROM dbo.Grades WHERE grade_id=?", (grade_id,), fetch="one")
    if not grade:
        return jsonify({"error": "Invalid grade_id"}), 400
    qry(
        "UPDATE dbo.Classrooms SET classroom_name=?, school_name=?, grade_id=? WHERE classroom_id=?",
        (name, body.get("school_name"), grade_id, classroom_id), fetch="exec"
    )
    return jsonify({"ok": True})


@teacher_bp.delete("/classrooms/<int:classroom_id>")
@require_teacher
def delete_classroom(classroom_id: int):
    """Archives the classroom (is_active=0) rather than hard-deleting, since
    rosters/assignments/homework submissions may still reference it."""
    owned = qry(
        "SELECT classroom_id FROM dbo.Classrooms WHERE classroom_id=? AND teacher_family_id=?",
        (classroom_id, g.family_id), fetch="one"
    )
    if not owned:
        return jsonify({"error": "Classroom not found"}), 404
    qry("UPDATE dbo.Classrooms SET is_active=0 WHERE classroom_id=?",
        (classroom_id,), fetch="exec")
    return jsonify({"ok": True})


@teacher_bp.put("/classrooms/<int:classroom_id>/regenerate-code")
@require_teacher
def regenerate_code(classroom_id: int):
    owned = qry(
        "SELECT classroom_id FROM dbo.Classrooms WHERE classroom_id=? AND teacher_family_id=?",
        (classroom_id, g.family_id), fetch="one"
    )
    if not owned:
        return jsonify({"error": "Classroom not found"}), 404
    code = _new_unique_code()
    qry("UPDATE dbo.Classrooms SET classroom_code=? WHERE classroom_id=?",
        (code, classroom_id), fetch="exec")
    return jsonify({"ok": True, "classroom_code": code})


@teacher_bp.get("/classrooms/<int:classroom_id>/roster")
@require_teacher
def classroom_roster(classroom_id: int):
    owned = qry(
        "SELECT classroom_id FROM dbo.Classrooms WHERE classroom_id=? AND teacher_family_id=?",
        (classroom_id, g.family_id), fetch="one"
    )
    if not owned:
        return jsonify({"error": "Classroom not found"}), 404
    rows = qry(
        "SELECT scl.link_id, c.child_id, c.nickname, c.grade_id, scl.joined_at, "
        "       CASE WHEN c.family_id = ? THEN 1 ELSE 0 END AS is_teacher_added "
        "FROM dbo.StudentClassroomLink scl "
        "JOIN dbo.Children c ON scl.child_id = c.child_id "
        "WHERE scl.classroom_id=? ORDER BY scl.joined_at ASC",
        (g.family_id, classroom_id)
    ) or []
    return jsonify(rows)


@teacher_bp.post("/classrooms/<int:classroom_id>/roster")
@require_teacher
def add_to_roster(classroom_id: int):
    """Teacher-added student: creates a Child record (of record under the
    teacher's own account) and links it to the classroom directly, as an
    alternative to the student/parent self-joining with the classroom code."""
    if not _owned_classroom(classroom_id):
        return jsonify({"error": "Classroom not found"}), 404

    body = request.json or {}
    nickname = (body.get("nickname") or "").strip()
    grade_id = body.get("grade_id")
    if not nickname:
        return jsonify({"error": "nickname required"}), 400
    if grade_id is None:
        return jsonify({"error": "grade_id required"}), 400

    child = qry(
        "INSERT INTO dbo.Children (family_id, nickname, grade_id, birth_year) "
        "OUTPUT INSERTED.child_id AS child_id "
        "VALUES (?,?,?,?)",
        (g.family_id, nickname, grade_id, body.get("birth_year")),
        fetch="one"
    )
    if not child:
        return jsonify({"error": "Could not create student"}), 500
    child_id = child["child_id"]

    qry("INSERT INTO dbo.StudentClassroomLink (child_id, classroom_id) VALUES (?,?)",
        (child_id, classroom_id), fetch="exec")
    get_db().commit()
    return jsonify({"ok": True, "child_id": child_id}), 201


@teacher_bp.put("/classrooms/<int:classroom_id>/roster/<int:child_id>")
@require_teacher
def update_roster_student(classroom_id: int, child_id: int):
    """Edit a student's nickname/grade — only for students the teacher added
    directly (family_id = teacher's own). Students who joined via a parent
    account belong to that family and can't be edited here."""
    if not _owned_classroom(classroom_id):
        return jsonify({"error": "Classroom not found"}), 404

    child = qry(
        "SELECT c.child_id FROM dbo.Children c "
        "JOIN dbo.StudentClassroomLink scl ON scl.child_id = c.child_id "
        "WHERE c.child_id=? AND scl.classroom_id=? AND c.family_id=?",
        (child_id, classroom_id, g.family_id), fetch="one"
    )
    if not child:
        return jsonify({"error": "Student not found or not editable (joined via a parent account)"}), 404

    body = request.json or {}
    nickname = (body.get("nickname") or "").strip()
    grade_id = body.get("grade_id")
    if not nickname:
        return jsonify({"error": "nickname required"}), 400
    if grade_id is None:
        return jsonify({"error": "grade_id required"}), 400

    qry("UPDATE dbo.Children SET nickname=?, grade_id=? WHERE child_id=?",
        (nickname, grade_id, child_id), fetch="exec")
    return jsonify({"ok": True})


@teacher_bp.delete("/classrooms/<int:classroom_id>/roster/<int:child_id>")
@require_teacher
def remove_from_roster(classroom_id: int, child_id: int):
    owned = qry(
        "SELECT classroom_id FROM dbo.Classrooms WHERE classroom_id=? AND teacher_family_id=?",
        (classroom_id, g.family_id), fetch="one"
    )
    if not owned:
        return jsonify({"error": "Classroom not found"}), 404
    qry("DELETE FROM dbo.StudentClassroomLink WHERE classroom_id=? AND child_id=?",
        (classroom_id, child_id), fetch="exec")
    return jsonify({"ok": True})


# ── Add existing students by parent lookup ───────────────────
# Lets a teacher search the registered-parent directory and link one or more
# of a parent's *real* children into a classroom, instead of only being able
# to type in a brand-new, disconnected student record.

@teacher_bp.get("/parents")
@require_teacher
def search_parents():
    search = (request.args.get("search") or "").strip()
    if len(search) < 2:
        return jsonify([])
    rows = qry(
        "SELECT f.family_id, f.email, COUNT(c.child_id) AS child_count "
        "FROM dbo.Families f LEFT JOIN dbo.Children c ON c.family_id = f.family_id "
        "WHERE f.role='parent' AND f.email LIKE ? "
        "GROUP BY f.family_id, f.email "
        "ORDER BY f.email",
        (f"%{search}%",)
    ) or []
    return jsonify(rows[:25])


@teacher_bp.get("/parents/<int:family_id>/children")
@require_teacher
def parent_children(family_id: int):
    fam = qry("SELECT family_id FROM dbo.Families WHERE family_id=? AND role='parent'",
              (family_id,), fetch="one")
    if not fam:
        return jsonify({"error": "Parent not found"}), 404
    rows = qry(
        "SELECT c.child_id, c.nickname, c.grade_id, g.label AS grade_label "
        "FROM dbo.Children c JOIN dbo.Grades g ON c.grade_id = g.grade_id "
        "WHERE c.family_id=? ORDER BY c.nickname",
        (family_id,)
    ) or []
    return jsonify(rows)


@teacher_bp.post("/classrooms/<int:classroom_id>/roster/link")
@require_teacher
def link_students_to_classroom(classroom_id: int):
    """Link one or more existing children (found via the parent lookup) into
    this classroom — unlike POST /roster, this never creates a new Child
    record, it only links accounts that already belong to a real parent."""
    if not _owned_classroom(classroom_id):
        return jsonify({"error": "Classroom not found"}), 404

    body = request.json or {}
    child_ids = body.get("child_ids")
    if not isinstance(child_ids, list) or not child_ids:
        return jsonify({"error": "child_ids (a non-empty list) required"}), 400

    linked, skipped = [], []
    for cid in child_ids:
        child = qry("SELECT child_id FROM dbo.Children WHERE child_id=?", (cid,), fetch="one")
        if not child:
            skipped.append(cid)
            continue
        already = qry(
            "SELECT 1 FROM dbo.StudentClassroomLink WHERE child_id=? AND classroom_id=?",
            (cid, classroom_id), fetch="one"
        )
        if already:
            skipped.append(cid)
            continue
        qry("INSERT INTO dbo.StudentClassroomLink (child_id, classroom_id) VALUES (?,?)",
            (cid, classroom_id), fetch="exec")
        linked.append(cid)

    return jsonify({"ok": True, "linked": linked, "skipped": skipped}), 201


# ── Student Assignments ──────────────────────────────────────

def _owned_classroom(classroom_id: int):
    return qry(
        "SELECT classroom_id FROM dbo.Classrooms WHERE classroom_id=? AND teacher_family_id=?",
        (classroom_id, g.family_id), fetch="one"
    )


@teacher_bp.get("/classrooms/<int:classroom_id>/assignments")
@require_teacher
def list_assignments(classroom_id: int):
    if not _owned_classroom(classroom_id):
        return jsonify({"error": "Classroom not found"}), 404
    rows = qry(
        "SELECT a.assignment_id, a.child_id, c.nickname AS child_nickname, "
        "       a.worksheet_id, w.title AS worksheet_title, a.note, "
        "       a.assigned_at, a.completed_at "
        "FROM dbo.StudentAssignments a "
        "JOIN dbo.Worksheets w ON a.worksheet_id = w.worksheet_id "
        "LEFT JOIN dbo.Children c ON a.child_id = c.child_id "
        "WHERE a.classroom_id=? ORDER BY a.assigned_at DESC",
        (classroom_id,)
    ) or []
    return jsonify(rows)


@teacher_bp.post("/classrooms/<int:classroom_id>/assignments")
@require_teacher
def create_assignment(classroom_id: int):
    if not _owned_classroom(classroom_id):
        return jsonify({"error": "Classroom not found"}), 404
    body = request.json or {}
    worksheet_id = body.get("worksheet_id")
    if not worksheet_id:
        return jsonify({"error": "worksheet_id required"}), 400
    child_id = body.get("child_id")  # None = whole-class broadcast

    if child_id:
        owns_child = qry(
            "SELECT 1 FROM dbo.StudentClassroomLink WHERE classroom_id=? AND child_id=?",
            (classroom_id, child_id), fetch="one"
        )
        if not owns_child:
            return jsonify({"error": "Child is not in this classroom"}), 400

    row = qry(
        "INSERT INTO dbo.StudentAssignments (classroom_id, child_id, worksheet_id, note) "
        "OUTPUT INSERTED.assignment_id AS assignment_id "
        "VALUES (?,?,?,?)",
        (classroom_id, child_id, worksheet_id, body.get("note")),
        fetch="one"
    )
    if not row:
        return jsonify({"error": "Could not create assignment"}), 500
    get_db().commit()
    return jsonify({"ok": True, "assignment_id": row["assignment_id"]}), 201


@teacher_bp.delete("/assignments/<int:assignment_id>")
@require_teacher
def delete_assignment(assignment_id: int):
    owned = qry(
        "SELECT a.assignment_id FROM dbo.StudentAssignments a "
        "JOIN dbo.Classrooms c ON a.classroom_id = c.classroom_id "
        "WHERE a.assignment_id=? AND c.teacher_family_id=?",
        (assignment_id, g.family_id), fetch="one"
    )
    if not owned:
        return jsonify({"error": "Assignment not found"}), 404
    qry("DELETE FROM dbo.StudentAssignments WHERE assignment_id=?",
        (assignment_id,), fetch="exec")
    return jsonify({"ok": True})


# ── Grades (gradebook) ───────────────────────────────────────

@teacher_bp.get("/classrooms/<int:classroom_id>/gradebook")
@require_teacher
def classroom_gradebook(classroom_id: int):
    if not _owned_classroom(classroom_id):
        return jsonify({"error": "Classroom not found"}), 404
    rows = qry(
        "SELECT c.child_id, c.nickname, c.grade_id, "
        "       COUNT(hs.submission_id) AS submission_count, "
        "       SUM(CASE WHEN hs.score IS NOT NULL THEN 1 ELSE 0 END) AS graded_count, "
        "       AVG(CASE WHEN hs.score IS NOT NULL THEN CAST(hs.score AS FLOAT) END) AS avg_score, "
        "       (SELECT COUNT(*) FROM dbo.StudentAssignments a "
        "         WHERE a.classroom_id=scl.classroom_id AND (a.child_id=c.child_id OR a.child_id IS NULL)) AS assignment_count "
        "FROM dbo.StudentClassroomLink scl "
        "JOIN dbo.Children c ON scl.child_id = c.child_id "
        "LEFT JOIN dbo.HomeworkSubmissions hs "
        "       ON hs.child_id = c.child_id AND hs.classroom_id = scl.classroom_id "
        "WHERE scl.classroom_id=? "
        "GROUP BY c.child_id, c.nickname, c.grade_id, scl.classroom_id "
        "ORDER BY c.nickname ASC",
        (classroom_id,)
    ) or []
    return jsonify(rows)


# ── Per-student grades & activity ────────────────────────────

def _owned_student(child_id: int):
    """A student counts as 'owned' if linked to any classroom this teacher runs."""
    return qry(
        "SELECT TOP 1 c.child_id, c.nickname, c.grade_id "
        "FROM dbo.Children c "
        "JOIN dbo.StudentClassroomLink scl ON scl.child_id = c.child_id "
        "JOIN dbo.Classrooms cl ON scl.classroom_id = cl.classroom_id "
        "WHERE c.child_id=? AND cl.teacher_family_id=?",
        (child_id, g.family_id), fetch="one"
    )


@teacher_bp.get("/students/<int:child_id>/grades")
@require_teacher
def student_grades(child_id: int):
    student = _owned_student(child_id)
    if not student:
        return jsonify({"error": "Student not found"}), 404

    submissions = qry(
        "SELECT s.submission_id, s.worksheet_id, w.title AS worksheet_title, "
        "       s.classroom_id, cl.classroom_name, s.mode, s.score, s.feedback_json, "
        "       s.submitted_at, s.reviewed_at "
        "FROM dbo.HomeworkSubmissions s "
        "JOIN dbo.Classrooms cl ON s.classroom_id = cl.classroom_id "
        "LEFT JOIN dbo.Worksheets w ON s.worksheet_id = w.worksheet_id "
        "WHERE s.child_id=? AND cl.teacher_family_id=? "
        "ORDER BY s.submitted_at DESC",
        (child_id, g.family_id)
    ) or []

    graded = [s["score"] for s in submissions if s["score"] is not None]
    avg_score = round(sum(graded) / len(graded), 1) if graded else None

    return jsonify({
        "student": student,
        "avg_score": avg_score,
        "graded_count": len(graded),
        "submissions": submissions,
    })


@teacher_bp.get("/students/<int:child_id>/progress")
@require_teacher
def student_progress(child_id: int):
    student = _owned_student(child_id)
    if not student:
        return jsonify({"error": "Student not found"}), 404

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

    rows = qry(
        "SELECT session_date, SUM(duration_min) AS total_min"
        " FROM dbo.SessionLogs"
        " WHERE child_id=? AND session_date >= CAST(DATEADD(day,-6,GETDATE()) AS DATE)"
        " GROUP BY session_date ORDER BY session_date",
        (child_id,)
    ) or []
    today = date.today()
    day_map = {r["session_date"]: r["total_min"] for r in rows}
    chart = []
    for i in range(6, -1, -1):
        d = today - timedelta(days=i)
        chart.append({"date": str(d), "minutes": day_map.get(d, 0)})

    badges = get_child_badges(child_id)

    return jsonify({
        "student": student,
        "streak": streak,
        "weekly": weekly,
        "by_subject": by_subject,
        "chart": chart,
        "badges": badges,
    })
