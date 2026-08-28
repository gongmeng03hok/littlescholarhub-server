"""
routes/auth.py — /api/auth
register, login, admin-login, kid-login, me, refresh, forgot/reset password
"""

import secrets
import traceback
from datetime import datetime, timedelta
from flask import Blueprint, request, jsonify, g
from utils.db   import qry
from utils.auth import (make_token, make_kid_token, hash_password,
                        check_password, gen_referral_code, require_auth,
                        require_parent_or_admin)
from services.email_service import send_password_reset

auth_bp = Blueprint("auth", __name__)


# ── Register ─────────────────────────────────────────────────

@auth_bp.post("/register")
def register():
    body        = request.json or {}
    email       = (body.get("email") or "").strip().lower()
    password    = body.get("password", "")
    language_id = int(body.get("language_id", 1))
    role        = (body.get("role") or "parent").strip().lower()

    if role not in ("parent", "teacher"):
        return jsonify({"error": "role must be 'parent' or 'teacher'"}), 400
    if not email or len(password) < 8:
        return jsonify({"error": "Valid email and password (8+ chars) required"}), 400

    teacher_name   = (body.get("teacher_name") or "").strip() or None
    teacher_school = (body.get("teacher_school") or "").strip() or None
    if role == "teacher" and not teacher_name:
        return jsonify({"error": "teacher_name required for teacher registration"}), 400

    is_approved = 0 if role == "teacher" else 1
    hashed = hash_password(password)
    ref    = gen_referral_code()

    try:
        qry(
            "INSERT INTO dbo.Families "
            "  (email, password_hash, plann, language_id, referral_code, role, "
            "   is_approved, teacher_name, teacher_school)"
            " VALUES (?, ?, 'explorer', ?, ?, ?, ?, ?, ?)",
            (email, hashed, language_id, ref, role, is_approved, teacher_name, teacher_school),
            fetch="exec"
        )
        fam = qry(
            "SELECT family_id FROM dbo.Families WHERE email=?",
            (email,), fetch="one"
        )
        family_id = fam["family_id"] if fam else 1
    except Exception as exc:
        traceback.print_exc()   # full detail to server logs only
        msg = str(exc).lower()
        if "uq_family_email" in msg or "violation" in msg or "duplicate" in msg or "unique" in msg:
            return jsonify({"error": "Email already registered"}), 409
        return jsonify({"error": "Registration failed. Please try again."}), 500

    # Track "give a month, get a month" referral, if a valid code was supplied
    referred_code = (body.get("referral_code") or "").strip().upper()
    if referred_code:
        try:
            referrer = qry(
                "SELECT family_id FROM dbo.Families WHERE referral_code=?",
                (referred_code,), fetch="one"
            )
            if referrer and referrer["family_id"] != family_id:
                qry(
                    "INSERT INTO dbo.Referrals (referrer_family_id, referred_family_id, code_used) "
                    "VALUES (?, ?, ?)",
                    (referrer["family_id"], family_id, referred_code), fetch="exec"
                )
        except Exception:
            pass  # referral tracking is best-effort, never blocks signup

    return jsonify({
        "token":         make_token(family_id, role, is_approved=bool(is_approved)),
        "family_id":     family_id,
        "role":          role,
        "is_approved":   bool(is_approved),
        "referral_code": ref,
    }), 201


# ── Parent / Family login ────────────────────────────────────

@auth_bp.post("/login")
def login():
    body     = request.json or {}
    email    = (body.get("email") or "").strip().lower()
    password = body.get("password", "")

    fam = qry(
        "SELECT family_id, password_hash, role, is_approved FROM dbo.Families WHERE email=?",
        (email,), fetch="one"
    )
    if not fam or not check_password(password, fam["password_hash"] or ""):
        return jsonify({"error": "Invalid email or password"}), 401

    role        = fam.get("role", "parent")
    is_approved = bool(fam.get("is_approved", 1))
    return jsonify({
        "token":       make_token(fam["family_id"], role, is_approved=is_approved),
        "family_id":   fam["family_id"],
        "role":        role,
        "is_approved": is_approved,
    })


# ── Forgot / reset password ──────────────────────────────────

@auth_bp.post("/forgot-password")
def forgot_password():
    """Always responds the same way regardless of whether the email exists,
    so this endpoint can't be used to discover which emails are registered."""
    body  = request.json or {}
    email = (body.get("email") or "").strip().lower()
    generic = jsonify({"ok": True, "message": "If that email is registered, we've sent a reset link."})

    if not email:
        return generic

    fam = qry("SELECT family_id FROM dbo.Families WHERE email=?", (email,), fetch="one")
    if not fam:
        return generic

    token   = secrets.token_urlsafe(32)
    expires = datetime.utcnow() + timedelta(hours=1)
    qry(
        "UPDATE dbo.Families SET reset_token=?, reset_token_expires=? WHERE family_id=?",
        (token, expires, fam["family_id"]), fetch="exec"
    )

    reset_url = request.url_root.rstrip("/") + f"/reset-password?token={token}"
    try:
        send_password_reset(email, reset_url)
    except Exception:
        pass  # never leak email-delivery failures to the client

    return generic


@auth_bp.post("/reset-password")
def reset_password():
    body     = request.json or {}
    token    = (body.get("token") or "").strip()
    password = body.get("password", "")

    if not token or len(password) < 8:
        return jsonify({"error": "A valid reset link and a password (8+ chars) are required"}), 400

    fam = qry(
        "SELECT family_id, reset_token_expires FROM dbo.Families WHERE reset_token=?",
        (token,), fetch="one"
    )
    if not fam or not fam["reset_token_expires"] or fam["reset_token_expires"] < datetime.utcnow():
        return jsonify({"error": "This reset link is invalid or has expired. Please request a new one."}), 400

    qry(
        "UPDATE dbo.Families SET password_hash=?, reset_token=NULL, reset_token_expires=NULL WHERE family_id=?",
        (hash_password(password), fam["family_id"]), fetch="exec"
    )
    return jsonify({"ok": True})


# ── Admin-specific login ─────────────────────────────────────

@auth_bp.post("/admin-login")
def admin_login():
    """Separate endpoint for admin — returns 403 if account is not admin role."""
    body     = request.json or {}
    email    = (body.get("email") or "").strip().lower()
    password = body.get("password", "")

    fam = qry(
        "SELECT family_id, password_hash, role FROM dbo.Families WHERE email=?",
        (email,), fetch="one"
    )
    if not fam or not check_password(password, fam["password_hash"] or ""):
        return jsonify({"error": "Invalid credentials"}), 401
    if fam.get("role") != "admin":
        return jsonify({"error": "Not an admin account"}), 403

    return jsonify({
        "token":     make_token(fam["family_id"], "admin"),
        "family_id": fam["family_id"],
        "role":      "admin",
    })


# ── Kid login ────────────────────────────────────────────────

@auth_bp.post("/kid-login")
@require_parent_or_admin
def kid_login():
    """
    Parent selects a child profile → optionally enters PIN →
    returns a short-lived KID-scoped JWT.
    """
    body     = request.json or {}
    child_id = body.get("child_id")
    pin      = body.get("pin")   # optional 4-digit PIN string

    if not child_id:
        return jsonify({"error": "child_id required"}), 400

    # Verify child belongs to this family
    child = qry(
        "SELECT c.child_id, c.nickname, c.grade_id "
        "FROM dbo.Children c "
        "WHERE c.child_id=? AND c.family_id=?",
        (child_id, g.family_id), fetch="one"
    )
    if not child:
        return jsonify({"error": "Child not found"}), 404

    # Check PIN if profile has one set
    profile = qry(
        "SELECT pin_hash, avatar_slug, display_name "
        "FROM dbo.KidProfiles WHERE child_id=?",
        (child_id,), fetch="one"
    )
    if profile and profile.get("pin_hash"):
        if not pin:
            return jsonify({"error": "PIN required", "pin_required": True}), 401
        from utils.auth import check_password as _chk
        if not _chk(pin, profile["pin_hash"]):
            return jsonify({"error": "Incorrect PIN"}), 401

    return jsonify({
        "token":        make_kid_token(g.family_id, child_id),
        "kid_id":       child_id,
        "role":         "kid",
        "nickname":     child["nickname"],
        "grade_id":     child["grade_id"],
        "avatar_slug":  profile["avatar_slug"] if profile else "star",
    })


# ── Me / Refresh ─────────────────────────────────────────────

@auth_bp.get("/me")
@require_auth
def me():
    fam = qry(
        "SELECT family_id, email, plann, language_id, referral_code, "
        "       trial_ends_at, created_at, role, is_approved, "
        "       teacher_name, teacher_school "
        "FROM dbo.Families WHERE family_id=?",
        (g.family_id,), fetch="one"
    )
    if not fam:
        return jsonify({"error": "Family not found"}), 404
    fam["role"] = fam.get("role") or "parent"
    fam["is_approved"] = bool(fam.get("is_approved", 1))
    return jsonify(fam)


@auth_bp.put("/me")
@require_auth
def update_me():
    body = request.json or {}
    language_id = body.get("language_id")
    if language_id is None:
        return jsonify({"error": "language_id required"}), 400
    qry("UPDATE dbo.Families SET language_id=?, updated_at=SYSUTCDATETIME() WHERE family_id=?",
        (language_id, g.family_id), fetch="exec")
    return jsonify({"ok": True, "language_id": language_id})


@auth_bp.get("/referrals")
@require_auth
def my_referrals():
    rows = qry(
        "SELECT referred_family_id, created_at FROM dbo.Referrals "
        "WHERE referrer_family_id=? ORDER BY created_at DESC",
        (g.family_id,)
    ) or []
    return jsonify({"count": len(rows), "referrals": rows})


@auth_bp.post("/refresh")
@require_auth
def refresh():
    return jsonify({"token": make_token(g.family_id, g.role, is_approved=bool(getattr(g, "is_approved", True)))})
