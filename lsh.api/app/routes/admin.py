"""
routes/admin.py — /api/admin
Full CRUD for all content + user management + config CMS.
All endpoints require role=admin via @require_admin.
"""

import io
import json
from flask import Blueprint, request, jsonify, g
from utils.db   import qry, get_db
from utils.auth import require_admin, hash_password, make_token

admin_bp = Blueprint("admin", __name__)


# ── Stats ────────────────────────────────────────────────────

@admin_bp.get("/stats")
@require_admin
def stats():
    families   = qry("SELECT COUNT(*) FROM dbo.Families",    fetch="scalar") or 0
    children   = qry("SELECT COUNT(*) FROM dbo.Children",    fetch="scalar") or 0
    sessions   = qry("SELECT COUNT(*) FROM dbo.SessionLogs", fetch="scalar") or 0
    worksheets = qry("SELECT COUNT(*) FROM dbo.Worksheets",  fetch="scalar") or 0
    stories    = qry("SELECT COUNT(*) FROM dbo.Stories",     fetch="scalar") or 0
    wisdom     = qry("SELECT COUNT(*) FROM dbo.DailyWisdom", fetch="scalar") or 0
    return jsonify({
        "families": families, "children": children,
        "sessions": sessions, "worksheets": worksheets,
        "stories": stories, "wisdom": wisdom,
    })


@admin_bp.get("/stats/detailed")
@require_admin
def stats_detailed():
    # Homework submissions by grade/subject, last 14 days
    submissions_by_grade = qry(
        "SELECT g.label AS grade_label, COUNT(*) AS submission_count "
        "FROM dbo.HomeworkSubmissions s "
        "JOIN dbo.Children c ON s.child_id = c.child_id "
        "JOIN dbo.Grades g ON c.grade_id = g.grade_id "
        "WHERE s.submitted_at >= DATEADD(day,-14,SYSUTCDATETIME()) "
        "GROUP BY g.label, g.sort_order "
        "ORDER BY g.sort_order"
    ) or []

    submissions_by_subject = qry(
        "SELECT sub.label AS subject_label, COUNT(*) AS submission_count "
        "FROM dbo.HomeworkSubmissions s "
        "JOIN dbo.Worksheets w ON s.worksheet_id = w.worksheet_id "
        "JOIN dbo.Subjects sub ON w.subject_id = sub.subject_id "
        "WHERE s.submitted_at >= DATEADD(day,-14,SYSUTCDATETIME()) "
        "GROUP BY sub.label "
        "ORDER BY COUNT(*) DESC"
    ) or []

    # Plan mix — % of families on each plan
    plan_mix = qry(
        "SELECT plann AS plan_name, COUNT(*) AS family_count, "
        "       CAST(100.0 * COUNT(*) / NULLIF((SELECT COUNT(*) FROM dbo.Families),0) AS DECIMAL(5,1)) AS pct "
        "FROM dbo.Families GROUP BY plann ORDER BY family_count DESC"
    ) or []

    # Classroom directory
    classrooms = qry(
        "SELECT c.classroom_id, c.classroom_name, c.school_name, c.classroom_code, "
        "       f.email AS teacher_email, ISNULL(f.teacher_name, f.email) AS teacher_name, "
        "       (SELECT COUNT(*) FROM dbo.StudentClassroomLink scl WHERE scl.classroom_id = c.classroom_id) AS student_count "
        "FROM dbo.Classrooms c "
        "JOIN dbo.Families f ON c.teacher_family_id = f.family_id "
        "ORDER BY c.created_at DESC"
    ) or []

    # School/district-level rollup — groups classrooms sharing a school_name.
    # Stand-in for the "District admin dashboard & reporting" pricing claim
    # until a real multi-tenant District entity exists.
    by_school = qry(
        "SELECT ISNULL(NULLIF(LTRIM(RTRIM(c.school_name)),''), 'Unassigned') AS school_name, "
        "       COUNT(DISTINCT c.classroom_id) AS classroom_count, "
        "       COUNT(DISTINCT c.teacher_family_id) AS teacher_count, "
        "       (SELECT COUNT(*) FROM dbo.StudentClassroomLink scl "
        "         JOIN dbo.Classrooms c2 ON scl.classroom_id = c2.classroom_id "
        "         WHERE ISNULL(NULLIF(LTRIM(RTRIM(c2.school_name)),''), 'Unassigned') "
        "               = ISNULL(NULLIF(LTRIM(RTRIM(c.school_name)),''), 'Unassigned')) AS student_count "
        "FROM dbo.Classrooms c "
        "GROUP BY ISNULL(NULLIF(LTRIM(RTRIM(c.school_name)),''), 'Unassigned') "
        "ORDER BY student_count DESC"
    ) or []

    return jsonify({
        "submissions_by_grade":   submissions_by_grade,
        "submissions_by_subject": submissions_by_subject,
        "plan_mix":               plan_mix,
        "classrooms":             classrooms,
        "by_school":              by_school,
    })


# ── User management ──────────────────────────────────────────

@admin_bp.get("/users")
@require_admin
def list_users():
    role_filter = request.args.get("role")
    sql = ("SELECT family_id, email, plann, language_id, role, is_approved, "
           "       teacher_name, teacher_school, created_at, trial_ends_at "
           "FROM dbo.Families")
    params = []
    if role_filter:
        sql += " WHERE role=?"
        params.append(role_filter)
    sql += " ORDER BY created_at DESC"
    rows = qry(sql, params) or []
    return jsonify(rows)


@admin_bp.put("/users/<int:family_id>/role")
@require_admin
def set_user_role(family_id: int):
    body = request.json or {}
    role = body.get("role", "").lower()
    if role not in ("admin", "parent"):
        return jsonify({"error": "role must be 'admin' or 'parent'"}), 400
    qry("UPDATE dbo.Families SET role=? WHERE family_id=?",
        (role, family_id), fetch="exec")
    return jsonify({"ok": True, "family_id": family_id, "role": role})


# ── Teacher approval queue ───────────────────────────────────

@admin_bp.get("/teachers/pending")
@require_admin
def list_pending_teachers():
    rows = qry(
        "SELECT family_id, email, teacher_name, teacher_school, created_at "
        "FROM dbo.Families "
        "WHERE role='teacher' AND is_approved=0 "
        "ORDER BY created_at ASC"
    ) or []
    return jsonify(rows)


@admin_bp.put("/teachers/<int:family_id>/approve")
@require_admin
def approve_teacher(family_id: int):
    fam = qry("SELECT family_id FROM dbo.Families WHERE family_id=? AND role='teacher'",
              (family_id,), fetch="one")
    if not fam:
        return jsonify({"error": "Teacher not found"}), 404
    qry("UPDATE dbo.Families SET is_approved=1 WHERE family_id=?",
        (family_id,), fetch="exec")
    return jsonify({"ok": True, "family_id": family_id})


@admin_bp.put("/teachers/<int:family_id>/deny")
@require_admin
def deny_teacher(family_id: int):
    fam = qry("SELECT family_id FROM dbo.Families WHERE family_id=? AND role='teacher' AND is_approved=0",
              (family_id,), fetch="one")
    if not fam:
        return jsonify({"error": "Pending teacher not found"}), 404
    qry("DELETE FROM dbo.Families WHERE family_id=?", (family_id,), fetch="exec")
    return jsonify({"ok": True, "family_id": family_id})


@admin_bp.get("/families")
@require_admin
def list_families():
    rows = qry(
        "SELECT family_id, email, plann, language_id, role, created_at "
        "FROM dbo.Families ORDER BY created_at DESC"
    )
    return jsonify(rows or [])


# ── Children under a parent (admin view/edit) ────────────────

@admin_bp.get("/families/<int:family_id>/children")
@require_admin
def list_family_children(family_id: int):
    rows = qry(
        "SELECT c.child_id, c.nickname, c.grade_id, g.label AS grade_label, "
        "       c.birth_year, c.avatar_url, c.created_at, "
        "       CASE WHEN kp.pin_hash IS NULL THEN 0 ELSE 1 END AS has_pin "
        "FROM dbo.Children c "
        "JOIN dbo.Grades g ON c.grade_id = g.grade_id "
        "LEFT JOIN dbo.KidProfiles kp ON kp.child_id = c.child_id "
        "WHERE c.family_id=? ORDER BY c.created_at",
        (family_id,)
    ) or []
    return jsonify(rows)


@admin_bp.put("/children/<int:child_id>")
@require_admin
def admin_update_child(child_id: int):
    """Admin can edit any child's profile — not restricted to a family's own children."""
    child = qry("SELECT child_id FROM dbo.Children WHERE child_id=?", (child_id,), fetch="one")
    if not child:
        return jsonify({"error": "Child not found"}), 404

    body = request.json or {}
    col_map = {"nickname": "nickname", "grade_id": "grade_id", "birth_year": "birth_year"}
    fields, params = [], []
    for key, col in col_map.items():
        if key in body:
            fields.append(f"{col}=?")
            params.append(body[key])
    if not fields:
        return jsonify({"error": "No fields to update"}), 400

    params.append(child_id)
    qry(f"UPDATE dbo.Children SET {', '.join(fields)} WHERE child_id=?", params, fetch="exec")
    return jsonify({"ok": True})


# ── Classrooms + students under a teacher (admin view) ───────

@admin_bp.get("/families/<int:family_id>/classrooms")
@require_admin
def list_family_classrooms(family_id: int):
    classrooms = qry(
        "SELECT classroom_id, classroom_name, school_name, classroom_code, is_active, created_at "
        "FROM dbo.Classrooms WHERE teacher_family_id=? ORDER BY created_at DESC",
        (family_id,)
    ) or []
    for c in classrooms:
        c["students"] = qry(
            "SELECT ch.child_id, ch.nickname, ch.grade_id, g.label AS grade_label "
            "FROM dbo.StudentClassroomLink scl "
            "JOIN dbo.Children ch ON scl.child_id = ch.child_id "
            "JOIN dbo.Grades g ON ch.grade_id = g.grade_id "
            "WHERE scl.classroom_id=? ORDER BY ch.nickname",
            (c["classroom_id"],)
        ) or []
    return jsonify(classrooms)


# ── Admin impersonation ───────────────────────────────────────

@admin_bp.post("/impersonate/<int:family_id>")
@require_admin
def impersonate(family_id: int):
    """Mint a normal session token for another parent/teacher account so an
    admin can see exactly what they see. The frontend keeps the admin's own
    token stashed separately so it can restore it via 'Return to admin'."""
    target = qry(
        "SELECT family_id, role, is_approved, email FROM dbo.Families WHERE family_id=?",
        (family_id,), fetch="one"
    )
    if not target:
        return jsonify({"error": "Account not found"}), 404
    if target["role"] not in ("parent", "teacher"):
        return jsonify({"error": "Can only impersonate parent or teacher accounts"}), 400

    token = make_token(target["family_id"], target["role"], bool(target["is_approved"]))
    return jsonify({
        "token": token, "family_id": target["family_id"],
        "role": target["role"], "email": target["email"],
    })


# ── Worksheets CRUD ──────────────────────────────────────────


@admin_bp.get("/worksheets")
@require_admin
def list_worksheets():
    rows = qry(
        "SELECT w.worksheet_id, s.slug AS subject, w.grade_id, "
        "       w.language_id, w.title, w.description, w.pdf_url, "
        "       w.thumbnail_url, w.estimated_min, w.teacher_name, w.is_published, "
        "       w.content_type, w.interest_tag, w.page_count, w.view_count, "
        "       w.rating_avg, w.rating_count, w.social_badge, w.is_trending, "
        "       w.difficulty_id, w.is_free, w.pdf_generator_key "
        "FROM dbo.Worksheets w "
        "JOIN dbo.Subjects s ON w.subject_id = s.subject_id "
        "WHERE w.owner_family_id IS NULL "
        "ORDER BY w.worksheet_id DESC"
    ) or []
    return jsonify(rows)

@admin_bp.post("/worksheets")
@require_admin
def create_worksheet():
    body = request.json or {}
    required = ("title", "subject_id", "grade_id")
    if not all(body.get(k) for k in required):
        return jsonify({"error": f"Required fields: {required}"}), 400
    qry(
        "INSERT INTO dbo.Worksheets "
        "  (subject_id, grade_id, language_id, difficulty_id, title, description, "
        "   pdf_url, thumbnail_url, estimated_min, teacher_name, is_published, "
        "   content_type, interest_tag, page_count, social_badge, is_trending, "
        "   is_free, pdf_generator_key) "
        "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
        (body["subject_id"], body["grade_id"],
         body.get("language_id", 1), body.get("difficulty_id", 2),
         body["title"], body.get("description"),
         body.get("pdf_url"), body.get("thumbnail_url"),
         body.get("estimated_min", 20), body.get("teacher_name"),
         1 if body.get("is_published", True) else 0,
         body.get("content_type", "worksheet"), body.get("interest_tag"),
         body.get("page_count"), body.get("social_badge"),
         1 if body.get("is_trending", False) else 0,
         1 if body.get("is_free", False) else 0, body.get("pdf_generator_key")),
        fetch="exec"
    )
    return jsonify({"ok": True}), 201


@admin_bp.put("/worksheets/<int:ws_id>")
@require_admin
def update_worksheet(ws_id: int):
    body = request.json or {}
    allowed = ("title", "description", "pdf_url", "thumbnail_url",
               "estimated_min", "teacher_name", "is_published",
               "subject_id", "grade_id", "language_id", "difficulty_id",
               "content_type", "interest_tag", "page_count",
               "social_badge", "is_trending", "rating_avg", "rating_count",
               "is_free", "pdf_generator_key")
    fields, params = [], []
    for col in allowed:
        if col in body:
            val = body[col]
            if col in ("is_published", "is_trending", "is_free"):
                val = 1 if val else 0
            fields.append(f"{col}=?")
            params.append(val)
    if not fields:
        return jsonify({"error": "Nothing to update"}), 400
    params.append(ws_id)
    qry(f"UPDATE dbo.Worksheets SET {', '.join(fields)} WHERE worksheet_id=?",
        params, fetch="exec")
    return jsonify({"ok": True})


@admin_bp.delete("/worksheets/<int:ws_id>")
@require_admin
def delete_worksheet(ws_id: int):
    # Soft delete
    qry("UPDATE dbo.Worksheets SET is_published=0 WHERE worksheet_id=?",
        (ws_id,), fetch="exec")
    return jsonify({"ok": True})


# ── File uploads (stored as VARBINARY in the DB) ──────────────

ALLOWED_UPLOAD_MIME = {"application/pdf"}
MAX_UPLOAD_BYTES = 20 * 1024 * 1024  # 20MB

@admin_bp.post("/uploads")
@require_admin
def upload_file():
    f = request.files.get("file")
    if not f or not f.filename:
        return jsonify({"error": "No file provided"}), 400
    mime = f.mimetype or "application/octet-stream"
    if mime not in ALLOWED_UPLOAD_MIME:
        return jsonify({"error": "Only PDF files are allowed"}), 400
    data = f.read()
    if not data:
        return jsonify({"error": "File is empty"}), 400
    if len(data) > MAX_UPLOAD_BYTES:
        return jsonify({"error": "File exceeds 20MB limit"}), 400

    # Uses OUTPUT INSERTED (not a follow-up SCOPE_IDENTITY() call) because pyodbc
    # runs parameterised INSERTs via sp_prepare/sp_execute, which opens a nested
    # scope — a separate SCOPE_IDENTITY() statement after it always reads NULL.
    row = qry(
        "INSERT INTO dbo.UploadedFiles (filename, mime_type, file_size, data, uploaded_by) "
        "OUTPUT INSERTED.file_id AS file_id "
        "VALUES (?,?,?,?,?)",
        (f.filename, mime, len(data), data, g.family_id),
        fetch="one"
    )
    if row:
        get_db().commit()
    file_id = row["file_id"] if row else None
    url = request.url_root.rstrip("/") + f"/api/content/files/{file_id}"
    return jsonify({"ok": True, "file_id": file_id, "url": url}), 201


# ── Featured Collections CRUD ────────────────────────────────

@admin_bp.get("/featured")
@require_admin
def list_featured_admin():
    rows = qry(
        "SELECT f.featured_id, f.worksheet_id, f.subtitle_override, f.sort_order, "
        "       f.is_active, f.starts_at, f.ends_at, w.title, w.content_type "
        "FROM dbo.FeaturedCollections f "
        "JOIN dbo.Worksheets w ON f.worksheet_id = w.worksheet_id "
        "ORDER BY f.sort_order"
    ) or []
    return jsonify(rows)


@admin_bp.post("/featured")
@require_admin
def create_featured():
    body = request.json or {}
    if not body.get("worksheet_id"):
        return jsonify({"error": "worksheet_id required"}), 400
    qry(
        "INSERT INTO dbo.FeaturedCollections "
        "  (worksheet_id, subtitle_override, sort_order, is_active, starts_at, ends_at) "
        "VALUES (?,?,?,?,?,?)",
        (body["worksheet_id"], body.get("subtitle_override"),
         body.get("sort_order", 0), 1 if body.get("is_active", True) else 0,
         body.get("starts_at"), body.get("ends_at")),
        fetch="exec"
    )
    return jsonify({"ok": True}), 201


@admin_bp.put("/featured/<int:featured_id>")
@require_admin
def update_featured(featured_id: int):
    body = request.json or {}
    allowed = ("worksheet_id", "subtitle_override", "sort_order",
               "is_active", "starts_at", "ends_at")
    fields, params = [], []
    for col in allowed:
        if col in body:
            val = body[col]
            if col == "is_active":
                val = 1 if val else 0
            fields.append(f"{col}=?")
            params.append(val)
    if not fields:
        return jsonify({"error": "Nothing to update"}), 400
    params.append(featured_id)
    qry(f"UPDATE dbo.FeaturedCollections SET {', '.join(fields)} WHERE featured_id=?",
        params, fetch="exec")
    return jsonify({"ok": True})


@admin_bp.delete("/featured/<int:featured_id>")
@require_admin
def delete_featured(featured_id: int):
    qry("DELETE FROM dbo.FeaturedCollections WHERE featured_id=?",
        (featured_id,), fetch="exec")
    return jsonify({"ok": True})


# ── Stories CRUD ─────────────────────────────────────────────


@admin_bp.get("/stories")
@require_admin
def list_stories():
    rows = qry(
        "SELECT story_id, grade_id, language_id, title, "
        "       body_text, read_min, theme_tag, vocab_json, "
        "       audio_url, thumbnail_url, pdf_url, source_url, source_attribution, is_published "
        "FROM dbo.Stories ORDER BY story_id DESC"
    ) or []
    return jsonify(rows)

@admin_bp.post("/stories")
@require_admin
def create_story():
    body = request.json or {}
    if not body.get("title") or not body.get("body_text"):
        return jsonify({"error": "title and body_text required"}), 400
    vocab = body.get("vocab_json")
    if isinstance(vocab, list):
        vocab = json.dumps(vocab)
    qry(
        "INSERT INTO dbo.Stories "
        "  (grade_id, language_id, title, body_text, read_min, "
        "   theme_tag, vocab_json, audio_url, is_published) "
        "VALUES (?,?,?,?,?,?,?,?,?)",
        (body.get("grade_id", 2), body.get("language_id", 1),
         body["title"], body["body_text"], body.get("read_min", 5),
         body.get("theme_tag"), vocab, body.get("audio_url"),
         1 if body.get("is_published", True) else 0),
        fetch="exec"
    )
    return jsonify({"ok": True}), 201


@admin_bp.put("/stories/<int:story_id>")
@require_admin
def update_story(story_id: int):
    body = request.json or {}
    allowed = ("title", "body_text", "read_min", "theme_tag",
               "vocab_json", "audio_url", "thumbnail_url",
               "source_url", "source_attribution", "is_published",
               "grade_id", "language_id")
    fields, params = [], []
    for col in allowed:
        if col in body:
            val = body[col]
            if col == "vocab_json" and isinstance(val, list):
                val = json.dumps(val)
            fields.append(f"{col}=?")
            params.append(val)
    if not fields:
        return jsonify({"error": "Nothing to update"}), 400
    params.append(story_id)
    qry(f"UPDATE dbo.Stories SET {', '.join(fields)} WHERE story_id=?",
        params, fetch="exec")
    return jsonify({"ok": True})


@admin_bp.delete("/stories/<int:story_id>")
@require_admin
def delete_story(story_id: int):
    qry("UPDATE dbo.Stories SET is_published=0 WHERE story_id=?",
        (story_id,), fetch="exec")
    return jsonify({"ok": True})


@admin_bp.post("/stories/<int:story_id>/generate-audio")
@require_admin
def generate_story_audio(story_id: int):
    """Narrates the story's body_text with TTS and saves it as the read-aloud audio_url."""
    from services.tts_service import generate_story_audio as _generate

    story = qry(
        "SELECT body_text, language_id FROM dbo.Stories WHERE story_id=?",
        (story_id,), fetch="one"
    )
    if not story:
        return jsonify({"error": "Story not found"}), 404
    try:
        audio_url = _generate(story_id, story["body_text"], story["language_id"])
    except Exception as exc:
        return jsonify({"error": f"Audio generation failed: {exc}"}), 500
    qry("UPDATE dbo.Stories SET audio_url=? WHERE story_id=?",
        (audio_url, story_id), fetch="exec")
    return jsonify({"ok": True, "audio_url": audio_url})


MAX_STORY_PDF_BYTES = 15 * 1024 * 1024  # 15MB


@admin_bp.post("/stories/upload-pdf")
@require_admin
def upload_story_pdf():
    """Admin uploads a real PDF story. The PDF is stored as a BLOB (same
    pattern as worksheet uploads). Text is extracted from the PDF's text
    layer when it has one; scanned/image-only PDFs fall back to OCR
    (Tesseract, via PyMuPDF page rendering) so a photographed or scanned
    book still becomes readable, TTS-narratable body_text."""
    import re
    from pypdf import PdfReader
    from services.tts_service import generate_story_audio as _generate_audio

    f = request.files.get("file")
    if not f or not f.filename:
        return jsonify({"error": "No file uploaded"}), 400
    if (f.mimetype or "") != "application/pdf":
        return jsonify({"error": "Only PDF files are supported"}), 400

    data = f.read()
    if len(data) > MAX_STORY_PDF_BYTES:
        return jsonify({"error": "File too large (max 15MB)"}), 400

    title = (request.form.get("title") or "").strip()
    if not title:
        return jsonify({"error": "title required"}), 400
    grade_id    = int(request.form.get("grade_id", 2))
    language_id = int(request.form.get("language_id", 1))
    theme_tag   = (request.form.get("theme_tag") or "").strip() or None

    try:
        reader = PdfReader(io.BytesIO(data))
        raw_text = "\n".join(page.extract_text() or "" for page in reader.pages)
    except Exception as exc:
        return jsonify({"error": f"Couldn't read that PDF: {exc}"}), 400

    body_text = re.sub(r"[ \t]+", " ", raw_text)
    body_text = re.sub(r"\n{3,}", "\n\n", body_text).strip()

    ocr_used = False
    if not body_text:
        # No text layer (scanned/photographed pages) — render each page to
        # an image and OCR it instead. Capped at 40 pages so one huge scan
        # can't tie up the request for minutes.
        try:
            import fitz  # PyMuPDF
            import pytesseract
            from PIL import Image
            doc = fitz.open(stream=data, filetype="pdf")
            ocr_pages = []
            for page in doc[:40]:
                pix = page.get_pixmap(dpi=200)
                img = Image.frombytes("RGB", (pix.width, pix.height), pix.samples)
                ocr_pages.append(pytesseract.image_to_string(img))
            doc.close()
        except Exception as exc:
            return jsonify({"error": f"Couldn't OCR that PDF: {exc}"}), 400
        raw_ocr = "\n".join(ocr_pages)
        body_text = re.sub(r"[ \t]+", " ", raw_ocr)
        body_text = re.sub(r"\n{3,}", "\n\n", body_text).strip()
        ocr_used = True

    if not body_text:
        return jsonify({"error": "No readable text found in that PDF, even with OCR — the scan quality may be too low."}), 400

    file_row = qry(
        "INSERT INTO dbo.UploadedFiles (filename, mime_type, file_size, data, uploaded_by) "
        "OUTPUT INSERTED.file_id AS file_id "
        "VALUES (?,?,?,?,NULL)",
        (f.filename, "application/pdf", len(data), data), fetch="one"
    )
    get_db().commit()
    from routes.content import file_url
    pdf_url = request.url_root.rstrip("/") + file_url(file_row["file_id"])

    # Cover thumbnail = a real render of page 1 (not a placeholder), so the
    # shelf card looks like an actual book instead of a blank gray box.
    thumbnail_url = None
    try:
        import fitz  # PyMuPDF
        cover_doc = fitz.open(stream=data, filetype="pdf")
        pix = cover_doc[0].get_pixmap(dpi=120)
        thumb_bytes = pix.tobytes("png")
        cover_doc.close()
        thumb_row = qry(
            "INSERT INTO dbo.UploadedFiles (filename, mime_type, file_size, data, uploaded_by) "
            "OUTPUT INSERTED.file_id AS file_id "
            "VALUES (?,?,?,?,NULL)",
            (f"{f.filename}.cover.png", "image/png", len(thumb_bytes), thumb_bytes), fetch="one"
        )
        get_db().commit()
        thumbnail_url = request.url_root.rstrip("/") + file_url(thumb_row["file_id"])
    except Exception:
        pass  # Cover art is a nice-to-have — a missing thumbnail shouldn't fail the upload.

    read_min = max(2, round(len(body_text.split()) / 130))  # ~130 wpm read-aloud pace

    story_row = qry(
        "INSERT INTO dbo.Stories (grade_id, language_id, title, body_text, read_min, theme_tag, pdf_url, thumbnail_url, is_published) "
        "OUTPUT INSERTED.story_id AS story_id "
        "VALUES (?,?,?,?,?,?,?,?,1)",
        (grade_id, language_id, title, body_text, read_min, theme_tag, pdf_url, thumbnail_url), fetch="one"
    )
    get_db().commit()
    story_id = story_row["story_id"]

    audio_url = None
    try:
        audio_url = _generate_audio(story_id, body_text, language_id)
        qry("UPDATE dbo.Stories SET audio_url=? WHERE story_id=?", (audio_url, story_id), fetch="exec")
    except Exception as exc:
        # The story itself is saved either way — narration can be retried
        # from the admin panel if generation happened to fail here.
        pass

    return jsonify({
        "ok": True, "story_id": story_id, "pdf_url": pdf_url, "audio_url": audio_url,
        "read_min": read_min, "ocr_used": ocr_used,
    }), 201


# ── Wisdom CRUD ──────────────────────────────────────────────

@admin_bp.get("/wisdom")
@require_admin
def list_wisdom():
    rows = qry(
        "SELECT wisdom_id, language_id, source_track, text_original, "
        "       text_english, author, active_date "
        "FROM dbo.DailyWisdom ORDER BY wisdom_id DESC"
    ) or []
    return jsonify(rows)


@admin_bp.post("/wisdom")
@require_admin
def create_wisdom():
    body = request.json or {}
    if not body.get("text_original"):
        return jsonify({"error": "text_original required"}), 400
    qry(
        "INSERT INTO dbo.DailyWisdom "
        "  (language_id, source_track, text_original, text_english, author, active_date) "
        "VALUES (?,?,?,?,?,?)",
        (body.get("language_id", 1),
         body.get("source_track", "universal"),
         body["text_original"], body.get("text_english"),
         body.get("author"), body.get("active_date")),
        fetch="exec"
    )
    return jsonify({"ok": True}), 201


@admin_bp.put("/wisdom/<int:wisdom_id>")
@require_admin
def update_wisdom(wisdom_id: int):
    body = request.json or {}
    allowed = ("language_id", "source_track", "text_original",
               "text_english", "author", "active_date")
    fields, params = [], []
    for col in allowed:
        if col in body:
            fields.append(f"{col}=?")
            params.append(body[col])
    if not fields:
        return jsonify({"error": "Nothing to update"}), 400
    params.append(wisdom_id)
    qry(f"UPDATE dbo.DailyWisdom SET {', '.join(fields)} WHERE wisdom_id=?",
        params, fetch="exec")
    return jsonify({"ok": True})


@admin_bp.delete("/wisdom/<int:wisdom_id>")
@require_admin
def delete_wisdom(wisdom_id: int):
    qry("DELETE FROM dbo.DailyWisdom WHERE wisdom_id=?",
        (wisdom_id,), fetch="exec")
    return jsonify({"ok": True})


# ── Question Templates CRUD ───────────────────────────────────

@admin_bp.get("/questions")
@require_admin
def list_question_templates():
    rows = qry(
        "SELECT qt.template_id, s.slug AS subject, qt.grade_id, "
        "       dl.label AS difficulty, qt.template_type, qt.template_text, "
        "       qt.params_json, qt.options_json, qt.answer_expr, qt.is_active "
        "FROM dbo.QuestionTemplates qt "
        "JOIN dbo.Subjects s ON qt.subject_id = s.subject_id "
        "JOIN dbo.DifficultyLevels dl ON qt.difficulty_id = dl.level_id "
        "ORDER BY qt.template_id DESC"
    ) or []
    return jsonify(rows)


@admin_bp.put("/questions/<int:template_id>")
@require_admin
def update_question(template_id: int):
    body = request.json or {}
    allowed = ("template_text", "params_json", "options_json",
               "answer_expr", "is_active", "difficulty_id",
               "subject_id", "grade_id", "template_type")
    fields, params = [], []
    for col in allowed:
        if col in body:
            fields.append(f"{col}=?")
            params.append(body[col])
    if not fields:
        return jsonify({"error": "Nothing to update"}), 400
    params.append(template_id)
    qry(f"UPDATE dbo.QuestionTemplates SET {', '.join(fields)} WHERE template_id=?",
        params, fetch="exec")
    return jsonify({"ok": True})


# ── AppConfig CMS ────────────────────────────────────────────

@admin_bp.get("/config")
@require_admin
def list_config():
    """?language_id=N filters to one language (default 1=English);
    ?language_id=all returns every language's rows (English rows first)."""
    lang_param = request.args.get("language_id", "1")
    if lang_param == "all":
        rows = qry(
            "SELECT config_key, config_value, config_type, label, section, language_id, updated_at "
            "FROM dbo.AppConfig ORDER BY section, config_key, language_id"
        ) or []
    else:
        try:
            lang = int(lang_param)
        except ValueError:
            lang = 1
        rows = qry(
            "SELECT config_key, config_value, config_type, label, section, language_id, updated_at "
            "FROM dbo.AppConfig WHERE language_id=? ORDER BY section, config_key",
            (lang,)
        ) or []
    return jsonify(rows)


@admin_bp.put("/config/<path:key>")
@require_admin
def update_config(key: str):
    body = request.json or {}
    if "value" not in body:
        return jsonify({"error": "'value' field required"}), 400
    lang = int(body.get("language_id", 1))

    value = body["value"]
    # Coerce to string for storage
    if isinstance(value, bool):
        value = "true" if value else "false"
    elif isinstance(value, (int, float)):
        value = str(value)
    elif isinstance(value, (list, dict)):
        value = json.dumps(value)

    # Detect type
    raw = body["value"]
    if isinstance(raw, bool):
        cfg_type = "boolean"
    elif isinstance(raw, (int, float)):
        cfg_type = "number"
    elif isinstance(raw, (list, dict)):
        cfg_type = "json"
    else:
        cfg_type = "text"

    # Upsert (per config_key + language_id)
    existing = qry("SELECT 1 FROM dbo.AppConfig WHERE config_key=? AND language_id=?",
                   (key, lang), fetch="one")
    if existing:
        qry(
            "UPDATE dbo.AppConfig "
            "SET config_value=?, config_type=?, updated_by=?, updated_at=SYSUTCDATETIME() "
            "WHERE config_key=? AND language_id=?",
            (value, cfg_type, g.family_id, key, lang), fetch="exec"
        )
    else:
        label   = body.get("label", key)
        section = key.split(".")[0] if "." in key else "general"
        qry(
            "INSERT INTO dbo.AppConfig "
            "  (config_key, config_value, config_type, label, section, language_id, updated_by) "
            "VALUES (?,?,?,?,?,?,?)",
            (key, value, cfg_type, label, section, lang, g.family_id), fetch="exec"
        )

    return jsonify({"ok": True, "key": key, "language_id": lang})


# ── Kid Profiles management ──────────────────────────────────

@admin_bp.get("/kid-profiles")
@require_admin
def list_kid_profiles():
    rows = qry(
        "SELECT kp.kid_profile_id, kp.child_id, c.nickname, "
        "       kp.display_name, kp.avatar_slug, kp.created_at, "
        "       CASE WHEN kp.pin_hash IS NULL THEN 0 ELSE 1 END AS has_pin "
        "FROM dbo.KidProfiles kp "
        "JOIN dbo.Children c ON kp.child_id = c.child_id "
        "ORDER BY kp.created_at DESC"
    ) or []
    return jsonify(rows)


# ── Admin password reset ─────────────────────────────────────

@admin_bp.post("/set-password")
@require_admin
def set_admin_password():
    """
    One-time use: set the real bcrypt hash for the seeded admin account.
    POST { "email": "admin@...", "new_password": "..." }
    """
    body = request.json or {}
    email    = (body.get("email") or "").strip().lower()
    new_pass = body.get("new_password", "")
    if len(new_pass) < 12:
        return jsonify({"error": "Password must be 12+ characters"}), 400
    new_hash = hash_password(new_pass)
    qry("UPDATE dbo.Families SET password_hash=? WHERE email=? AND role='admin'",
        (new_hash, email), fetch="exec")
    return jsonify({"ok": True, "message": "Admin password updated"})


# ── Weekly Story Packs (ThemeWeeks) CRUD ──────────────────────
# A themed bundle: one read-aloud story + a set of worksheets
# (vocab/math/art/workbook) + a journal prompt, all on one theme.

@admin_bp.get("/theme-weeks")
@require_admin
def list_theme_weeks():
    weeks = qry(
        "SELECT tw.theme_week_id, tw.title, tw.theme_slug, tw.description, "
        "       tw.grade_id, tw.story_id, s.title AS story_title, "
        "       tw.journal_prompt, tw.is_published, tw.sort_order, tw.created_at "
        "FROM dbo.ThemeWeeks tw "
        "LEFT JOIN dbo.Stories s ON tw.story_id = s.story_id "
        "ORDER BY tw.sort_order, tw.theme_week_id DESC"
    ) or []
    for w in weeks:
        w["worksheets"] = qry(
            "SELECT tww.link_id, tww.worksheet_id, tww.role, tww.sort_order, "
            "       ws.title AS worksheet_title, sub.slug AS subject "
            "FROM dbo.ThemeWeekWorksheets tww "
            "JOIN dbo.Worksheets ws ON tww.worksheet_id = ws.worksheet_id "
            "JOIN dbo.Subjects sub ON ws.subject_id = sub.subject_id "
            "WHERE tww.theme_week_id=? ORDER BY tww.sort_order",
            (w["theme_week_id"],)
        ) or []
    return jsonify(weeks)


@admin_bp.post("/theme-weeks")
@require_admin
def create_theme_week():
    body = request.json or {}
    title = (body.get("title") or "").strip()
    slug  = (body.get("theme_slug") or "").strip().lower().replace(" ", "-")
    if not title or not slug:
        return jsonify({"error": "title and theme_slug required"}), 400
    row = qry(
        "INSERT INTO dbo.ThemeWeeks "
        "  (title, theme_slug, description, grade_id, story_id, journal_prompt, is_published, sort_order) "
        "OUTPUT INSERTED.theme_week_id AS theme_week_id "
        "VALUES (?,?,?,?,?,?,?,?)",
        (title, slug, body.get("description"), body.get("grade_id"),
         body.get("story_id"), body.get("journal_prompt"),
         1 if body.get("is_published", True) else 0, body.get("sort_order", 0)),
        fetch="one"
    )
    if not row:
        return jsonify({"error": "Could not create theme week (slug may already exist)"}), 400
    get_db().commit()
    return jsonify({"ok": True, "theme_week_id": row["theme_week_id"]}), 201


@admin_bp.put("/theme-weeks/<int:theme_week_id>")
@require_admin
def update_theme_week(theme_week_id: int):
    body = request.json or {}
    allowed = ("title", "theme_slug", "description", "grade_id",
               "story_id", "journal_prompt", "is_published", "sort_order")
    fields, params = [], []
    for col in allowed:
        if col in body:
            val = body[col]
            if col == "is_published":
                val = 1 if val else 0
            fields.append(f"{col}=?")
            params.append(val)
    if not fields:
        return jsonify({"error": "Nothing to update"}), 400
    params.append(theme_week_id)
    qry(f"UPDATE dbo.ThemeWeeks SET {', '.join(fields)} WHERE theme_week_id=?",
        params, fetch="exec")
    return jsonify({"ok": True})


@admin_bp.delete("/theme-weeks/<int:theme_week_id>")
@require_admin
def delete_theme_week(theme_week_id: int):
    qry("UPDATE dbo.ThemeWeeks SET is_published=0 WHERE theme_week_id=?",
        (theme_week_id,), fetch="exec")
    return jsonify({"ok": True})


@admin_bp.post("/theme-weeks/<int:theme_week_id>/worksheets")
@require_admin
def add_theme_week_worksheet(theme_week_id: int):
    body = request.json or {}
    worksheet_id = body.get("worksheet_id")
    role = body.get("role", "worksheet")
    if not worksheet_id:
        return jsonify({"error": "worksheet_id required"}), 400
    if role not in ("vocab", "math", "art", "workbook", "worksheet"):
        return jsonify({"error": "invalid role"}), 400
    qry(
        "INSERT INTO dbo.ThemeWeekWorksheets (theme_week_id, worksheet_id, role, sort_order) "
        "VALUES (?,?,?,?)",
        (theme_week_id, worksheet_id, role, body.get("sort_order", 0)), fetch="exec"
    )
    return jsonify({"ok": True}), 201


@admin_bp.delete("/theme-weeks/<int:theme_week_id>/worksheets/<int:link_id>")
@require_admin
def remove_theme_week_worksheet(theme_week_id: int, link_id: int):
    qry("DELETE FROM dbo.ThemeWeekWorksheets WHERE link_id=? AND theme_week_id=?",
        (link_id, theme_week_id), fetch="exec")
    return jsonify({"ok": True})
