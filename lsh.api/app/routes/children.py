"""
routes/children.py — /api/children
CRUD for child profiles + kid profile management (PIN, avatar).
"""

import json
from datetime import date, timedelta
from flask import Blueprint, request, jsonify, g
from utils.db   import qry
from utils.auth import require_auth, require_parent_or_admin, hash_password, check_password
from services.plan_builder import build_weekly_plan

children_bp = Blueprint("children", __name__)


# ── Children list / add / update / delete ────────────────────

@children_bp.get("/")
@require_auth
def list_children():
    rows = qry(
        "SELECT c.child_id, c.nickname, c.grade_id, g.label AS grade_label, "
        "       c.birth_year, c.avatar_url, c.created_at, "
        "       kp.display_name, kp.avatar_slug, "
        "       CASE WHEN kp.pin_hash IS NULL THEN 0 ELSE 1 END AS has_pin "
        "FROM dbo.Children c "
        "JOIN dbo.Grades g ON c.grade_id = g.grade_id "
        "LEFT JOIN dbo.KidProfiles kp ON kp.child_id = c.child_id "
        "WHERE c.family_id=? "
        "ORDER BY c.created_at",
        (g.family_id,)
    )
    return jsonify(rows or [])


@children_bp.post("/")
@require_parent_or_admin
def add_child():
    body       = request.json or {}
    nickname   = (body.get("nickname") or "").strip()
    grade_id   = body.get("grade_id")
    birth_year = body.get("birth_year")

    if not nickname or grade_id is None:
        return jsonify({"error": "nickname and grade_id required"}), 400

    count = qry("SELECT COUNT(*) FROM dbo.Children WHERE family_id=?",
                (g.family_id,), fetch="scalar") or 0
    if count >= 4:
        return jsonify({"error": "Maximum 4 children per family"}), 403

    qry(
        "INSERT INTO dbo.Children (family_id, nickname, grade_id, birth_year) "
        "VALUES (?, ?, ?, ?)",
        (g.family_id, nickname, int(grade_id), birth_year), fetch="exec"
    )
    child = qry(
        "SELECT TOP 1 child_id FROM dbo.Children WHERE family_id=? ORDER BY created_at DESC",
        (g.family_id,), fetch="one"
    )
    child_id = child["child_id"] if child else None

    # Parents no longer take an assessment — seed a sensible default weekly
    # plan straight from grade level so the dashboard/plan screen isn't empty.
    if child_id:
        try:
            plan = build_weekly_plan({}, int(grade_id))
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
            pass  # non-fatal — child creation should still succeed without a plan

    return jsonify({"ok": True, "child_id": child_id}), 201


@children_bp.patch("/<int:child_id>")
@require_parent_or_admin
def update_child(child_id: int):
    body = request.json or {}
    owns = qry(
        "SELECT 1 FROM dbo.Children WHERE child_id=? AND family_id=?",
        (child_id, g.family_id), fetch="one"
    )
    if not owns:
        return jsonify({"error": "Not found"}), 404

    fields, params = [], []
    for col in ("nickname", "grade_id", "birth_year", "avatar_url"):
        if col in body:
            fields.append(f"{col}=?")
            params.append(body[col])
    if fields:
        params.append(child_id)
        qry(f"UPDATE dbo.Children SET {', '.join(fields)} WHERE child_id=?",
            params, fetch="exec")
    return jsonify({"ok": True})


@children_bp.delete("/<int:child_id>")
@require_parent_or_admin
def delete_child(child_id: int):
    qry("DELETE FROM dbo.Children WHERE child_id=? AND family_id=?",
        (child_id, g.family_id), fetch="exec")
    return jsonify({"ok": True})


# ── Kid Profile (PIN + avatar) ────────────────────────────────

@children_bp.get("/<int:child_id>/kid-profile")
@require_parent_or_admin
def get_kid_profile(child_id: int):
    _verify_ownership(child_id)
    row = qry(
        "SELECT kid_profile_id, child_id, display_name, avatar_slug, "
        "       CASE WHEN pin_hash IS NULL THEN 0 ELSE 1 END AS has_pin, created_at "
        "FROM dbo.KidProfiles WHERE child_id=?",
        (child_id,), fetch="one"
    )
    if not row:
        return jsonify({"error": "No kid profile yet"}), 404
    return jsonify(row)


@children_bp.post("/<int:child_id>/kid-profile")
@require_parent_or_admin
def create_kid_profile(child_id: int):
    _verify_ownership(child_id)
    body         = request.json or {}
    display_name = body.get("display_name") or qry(
        "SELECT nickname FROM dbo.Children WHERE child_id=?",
        (child_id,), fetch="one"
    )["nickname"]
    avatar_slug  = body.get("avatar_slug", "star")
    pin          = body.get("pin")   # optional 4-digit string
    pin_hash     = hash_password(pin) if pin else None

    existing = qry("SELECT 1 FROM dbo.KidProfiles WHERE child_id=?",
                   (child_id,), fetch="one")
    if existing:
        return jsonify({"error": "Profile already exists — use PATCH to update"}), 409

    qry(
        "INSERT INTO dbo.KidProfiles (child_id, display_name, avatar_slug, pin_hash) "
        "VALUES (?,?,?,?)",
        (child_id, display_name, avatar_slug, pin_hash), fetch="exec"
    )
    return jsonify({"ok": True}), 201


@children_bp.patch("/<int:child_id>/kid-profile")
@require_parent_or_admin
def update_kid_profile(child_id: int):
    _verify_ownership(child_id)
    body = request.json or {}
    fields, params = [], []

    if "display_name" in body:
        fields.append("display_name=?"); params.append(body["display_name"])
    if "avatar_slug" in body:
        fields.append("avatar_slug=?");  params.append(body["avatar_slug"])
    if "pin" in body:
        new_pin = body["pin"]
        if new_pin:
            fields.append("pin_hash=?"); params.append(hash_password(new_pin))
        else:
            fields.append("pin_hash=NULL")

    if not fields:
        return jsonify({"error": "Nothing to update"}), 400
    params.append(child_id)
    qry(f"UPDATE dbo.KidProfiles SET {', '.join(fields)} WHERE child_id=?",
        params, fetch="exec")
    return jsonify({"ok": True})


def _verify_ownership(child_id: int):
    row = qry("SELECT 1 FROM dbo.Children WHERE child_id=? AND family_id=?",
              (child_id, g.family_id), fetch="one")
    if not row:
        from flask import abort
        abort(404)
