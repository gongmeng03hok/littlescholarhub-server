"""
utils/auth.py — JWT creation/validation + bcrypt + role decorators
Extended: role field in token, kid tokens, require_admin, require_any_auth
"""

import random
from datetime import datetime, timedelta, timezone
from functools import wraps

import bcrypt
import jwt
from flask import request, jsonify, g, current_app


# ── Token helpers ────────────────────────────────────────────

def make_token(family_id: int, role: str = "parent", is_approved: bool = True) -> str:
    """Standard 30-day token for PARENT, TEACHER, or ADMIN."""
    payload = {
        "sub":      str(family_id),
        "role":     role,
        "approved": is_approved,
        "iat":      datetime.now(timezone.utc),
        "exp":      datetime.now(timezone.utc) + timedelta(days=30),
    }
    return jwt.encode(payload, current_app.config["JWT_SECRET"], algorithm="HS256")


def make_kid_token(family_id: int, child_id: int) -> str:
    """Short-lived 8-hour token for KID mode sessions."""
    payload = {
        "sub":    str(family_id),
        "role":   "kid",
        "kid_id": child_id,
        "iat":    datetime.now(timezone.utc),
        "exp":    datetime.now(timezone.utc) + timedelta(hours=8),
    }
    return jwt.encode(payload, current_app.config["JWT_SECRET"], algorithm="HS256")


def decode_token(token: str) -> dict:
    data = jwt.decode(token, current_app.config["JWT_SECRET"], algorithms=["HS256"])
    data["sub"] = int(data["sub"])
    return data


def hash_password(plain: str) -> str:
    return bcrypt.hashpw(plain.encode(), bcrypt.gensalt()).decode()


def check_password(plain: str, hashed: str) -> bool:
    # Guard against empty/NULL hashes (e.g. a seeded admin before set-password),
    # which would otherwise make bcrypt raise "Invalid salt" → HTTP 500 on login.
    if not plain or not hashed:
        return False
    try:
        return bcrypt.checkpw(plain.encode(), hashed.encode())
    except (ValueError, TypeError):
        return False


def gen_referral_code() -> str:
    chars = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789"
    return "LSH-FAM-" + "".join(random.choices(chars, k=8))


# ── Auth decorators ──────────────────────────────────────────

def _parse_token():
    """Parse Bearer token, populate g.family_id / g.role / g.kid_id."""
    auth = request.headers.get("Authorization", "")
    if not auth.startswith("Bearer "):
        return None, (jsonify({"error": "Missing or invalid Authorization header"}), 401)
    try:
        data = decode_token(auth[7:])
        g.family_id   = data["sub"]
        g.role        = data.get("role", "parent")
        g.kid_id      = data.get("kid_id")
        g.is_approved = data.get("approved", True)
        return data, None
    except jwt.ExpiredSignatureError:
        return None, (jsonify({"error": "Token expired"}), 401)
    except jwt.PyJWTError as exc:
        return None, (jsonify({"error": str(exc)}), 401)


def try_auth() -> bool:
    """Parse token if present; sets g.family_id/role/kid_id. Returns True if authenticated.
    Unlike require_auth, never returns an error — safe to call on public endpoints."""
    auth = request.headers.get("Authorization", "")
    if not auth.startswith("Bearer "):
        g.family_id = None
        g.role      = None
        g.kid_id    = None
        return False
    try:
        data = decode_token(auth[7:])
        g.family_id = data["sub"]
        g.role      = data.get("role", "parent")
        g.kid_id    = data.get("kid_id")
        return True
    except Exception:
        g.family_id = None
        g.role      = None
        g.kid_id    = None
        return False


def require_auth(f):
    """Require any valid token (parent, admin, or kid)."""
    @wraps(f)
    def decorated(*args, **kwargs):
        _, err = _parse_token()
        if err:
            return err
        return f(*args, **kwargs)
    return decorated


def require_admin(f):
    """Require role == 'admin'."""
    @wraps(f)
    def decorated(*args, **kwargs):
        _, err = _parse_token()
        if err:
            return err
        if g.role != "admin":
            return jsonify({"error": "Admin access required"}), 403
        return f(*args, **kwargs)
    return decorated


def require_parent_or_admin(f):
    """Require role == 'parent' or 'admin' (not kid)."""
    @wraps(f)
    def decorated(*args, **kwargs):
        _, err = _parse_token()
        if err:
            return err
        if g.role not in ("parent", "admin"):
            return jsonify({"error": "Parent or admin access required"}), 403
        return f(*args, **kwargs)
    return decorated


def require_teacher(f):
    """Require role == 'teacher' and an approved account."""
    @wraps(f)
    def decorated(*args, **kwargs):
        _, err = _parse_token()
        if err:
            return err
        if g.role != "teacher":
            return jsonify({"error": "Teacher access required"}), 403
        if not g.is_approved:
            return jsonify({"error": "Teacher account pending admin approval"}), 403
        return f(*args, **kwargs)
    return decorated
