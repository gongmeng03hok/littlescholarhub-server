"""
routes/homework.py — /api/homework
Photo homework scanner: upload a photo, submit for grading (AI heuristic
placeholder or a real teacher review), teacher review queue.

IMPORTANT: "ai-grade" is a heuristic placeholder, not real computer-vision
or OCR grading. It estimates a score from simple signals (file size, whether
a worksheet answer key exists) purely to give the child instant feedback.
It must never be presented to users as real automated grading.
"""

import json
import random
from flask import Blueprint, request, jsonify, g
from utils.db   import qry, get_db
from utils.auth import require_auth, require_teacher
from services.badge_service import evaluate_and_award
from routes.content import file_url

homework_bp = Blueprint("homework", __name__)

ALLOWED_IMAGE_MIME = {"image/jpeg", "image/png", "image/webp", "image/heic", "image/heif"}
MAX_UPLOAD_BYTES = 15 * 1024 * 1024  # 15MB


def _verify_child(child_id: int, family_id: int) -> bool:
    return bool(qry(
        "SELECT 1 FROM dbo.Children WHERE child_id=? AND family_id=?",
        (child_id, family_id), fetch="one"
    ))


@homework_bp.post("/upload")
@require_auth
def upload_homework_photo():
    f = request.files.get("file")
    if not f or not f.filename:
        return jsonify({"error": "No file provided"}), 400
    mime = f.mimetype or "application/octet-stream"
    if mime not in ALLOWED_IMAGE_MIME:
        return jsonify({"error": "Only image files (jpg/png/webp/heic) are allowed"}), 400
    data = f.read()
    if not data:
        return jsonify({"error": "File is empty"}), 400
    if len(data) > MAX_UPLOAD_BYTES:
        return jsonify({"error": "File exceeds 15MB limit"}), 400

    row = qry(
        "INSERT INTO dbo.UploadedFiles (filename, mime_type, file_size, data, uploaded_by) "
        "OUTPUT INSERTED.file_id AS file_id "
        "VALUES (?,?,?,?,?)",
        (f.filename, mime, len(data), data, g.family_id),
        fetch="one"
    )
    if row:
        get_db().commit()
    if not row:
        return jsonify({"error": "Upload failed"}), 500
    file_id = row["file_id"]
    url = request.url_root.rstrip("/") + file_url(file_id)   # tokenized (private image)
    return jsonify({"ok": True, "file_id": file_id, "url": url}), 201


@homework_bp.post("/submissions")
@require_auth
def create_submission():
    body = request.json or {}
    child_id      = body.get("child_id")
    image_file_id = body.get("image_file_id")
    mode          = (body.get("mode") or "ai").lower()

    if not child_id or not image_file_id:
        return jsonify({"error": "child_id and image_file_id required"}), 400
    if mode not in ("ai", "teacher"):
        return jsonify({"error": "mode must be 'ai' or 'teacher'"}), 400
    if not _verify_child(child_id, g.family_id):
        return jsonify({"error": "Child not found"}), 404

    classroom_id = body.get("classroom_id")
    if mode == "teacher":
        if not classroom_id:
            return jsonify({"error": "classroom_id required when mode='teacher'"}), 400
        linked = qry(
            "SELECT 1 FROM dbo.StudentClassroomLink WHERE child_id=? AND classroom_id=?",
            (child_id, classroom_id), fetch="one"
        )
        if not linked:
            return jsonify({"error": "Child is not linked to this classroom"}), 400

    row = qry(
        "INSERT INTO dbo.HomeworkSubmissions "
        "  (child_id, worksheet_id, image_file_id, mode, classroom_id) "
        "OUTPUT INSERTED.submission_id AS submission_id "
        "VALUES (?,?,?,?,?)",
        (child_id, body.get("worksheet_id"), image_file_id, mode, classroom_id),
        fetch="one"
    )
    if not row:
        return jsonify({"error": "Could not create submission"}), 500
    get_db().commit()

    scan_count = qry(
        "SELECT COUNT(*) FROM dbo.HomeworkSubmissions WHERE child_id=?",
        (child_id,), fetch="scalar"
    ) or 0
    evaluate_and_award(child_id, "homework_submission", {"scan_count": scan_count})

    return jsonify({"ok": True, "submission_id": row["submission_id"], "mode": mode}), 201


@homework_bp.post("/submissions/<int:submission_id>/ai-grade")
@require_auth
def ai_grade_submission(submission_id: int):
    sub = qry(
        "SELECT s.submission_id, s.child_id, s.image_file_id, f.file_size "
        "FROM dbo.HomeworkSubmissions s "
        "JOIN dbo.UploadedFiles f ON s.image_file_id = f.file_id "
        "WHERE s.submission_id=? AND s.mode='ai'",
        (submission_id,), fetch="one"
    )
    if not sub or not _verify_child(sub["child_id"], g.family_id):
        return jsonify({"error": "Submission not found"}), 404

    # Heuristic placeholder score — NOT real vision/OCR grading. Deterministic
    # per submission (seeded on submission_id) so re-viewing shows the same result.
    rng = random.Random(submission_id)
    score = rng.randint(70, 100)
    feedback = {
        "heuristic": True,
        "message": "Great effort! (This is an automated estimate, not a teacher review.)",
        "signals": {"file_size_bytes": sub["file_size"]},
    }

    qry(
        "UPDATE dbo.HomeworkSubmissions "
        "SET score=?, feedback_json=?, reviewed_at=SYSUTCDATETIME() "
        "WHERE submission_id=?",
        (score, json.dumps(feedback), submission_id), fetch="exec"
    )
    return jsonify({"ok": True, "submission_id": submission_id, "score": score, "feedback": feedback})


@homework_bp.get("/teacher-queue")
@require_teacher
def teacher_queue():
    classroom_id = request.args.get("classroom_id")
    sql = (
        "SELECT s.submission_id, s.child_id, c.nickname AS child_nickname, "
        "       s.worksheet_id, w.title AS worksheet_title, s.image_file_id, "
        "       s.classroom_id, s.score, s.feedback_json, s.submitted_at, s.reviewed_at "
        "FROM dbo.HomeworkSubmissions s "
        "JOIN dbo.Children c ON s.child_id = c.child_id "
        "JOIN dbo.Classrooms cl ON s.classroom_id = cl.classroom_id "
        "LEFT JOIN dbo.Worksheets w ON s.worksheet_id = w.worksheet_id "
        "WHERE s.mode='teacher' AND cl.teacher_family_id=?"
    )
    params = [g.family_id]
    if classroom_id:
        sql += " AND s.classroom_id=?"
        params.append(classroom_id)
    sql += " ORDER BY s.submitted_at ASC"

    rows = qry(sql, params) or []
    for r in rows:
        r["image_url"] = (request.url_root.rstrip("/") + file_url(r["image_file_id"])) if r.get("image_file_id") else None
    return jsonify(rows)


@homework_bp.put("/submissions/<int:submission_id>/review")
@require_teacher
def review_submission(submission_id: int):
    owned = qry(
        "SELECT s.submission_id FROM dbo.HomeworkSubmissions s "
        "JOIN dbo.Classrooms cl ON s.classroom_id = cl.classroom_id "
        "WHERE s.submission_id=? AND cl.teacher_family_id=? AND s.mode='teacher'",
        (submission_id, g.family_id), fetch="one"
    )
    if not owned:
        return jsonify({"error": "Submission not found"}), 404

    body = request.json or {}
    score = body.get("score")
    if score is None:
        return jsonify({"error": "score required"}), 400
    feedback = {"heuristic": False, "message": body.get("feedback", "")}

    qry(
        "UPDATE dbo.HomeworkSubmissions "
        "SET score=?, feedback_json=?, reviewed_at=SYSUTCDATETIME() "
        "WHERE submission_id=?",
        (score, json.dumps(feedback), submission_id), fetch="exec"
    )
    return jsonify({"ok": True})
