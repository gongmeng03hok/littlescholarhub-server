"""
routes/gamification.py — /api/gamification
Daily check-in rewards · profile (xp/level/coins/badges) · opt-in leaderboard · settings.

Privacy: the leaderboard reads dbo.vw_Leaderboard, which exposes ONLY a child's
nickname, avatar, and a coarse region, and only for families that have opted in
(Families.show_on_leaderboard = 1). No email, real name, or precise location.
"""

from datetime import date
from flask import Blueprint, request, jsonify, g
from utils.db import qry, child_in_family
from utils.auth import require_auth, require_parent_or_admin
from services.gamification_service import level_for_xp, daily_checkin

gamification_bp = Blueprint("gamification", __name__)


@gamification_bp.get("/profile/<int:child_id>")
@require_auth
def profile(child_id):
    if not child_in_family(child_id, g.family_id):
        return jsonify({"error": "Not found"}), 404

    row = qry(
        "SELECT total_xp, level, coins, gems, stars, checkin_streak, best_checkin_streak, last_checkin_date "
        "FROM dbo.ChildGameStats WHERE child_id=?",
        (child_id,), fetch="one"
    ) or {"total_xp": 0, "coins": 0, "gems": 0, "stars": 0, "checkin_streak": 0,
          "best_checkin_streak": 0, "last_checkin_date": None}

    prof = qry(
        "SELECT ISNULL(avatar_slug,'star') AS avatar_slug, ISNULL(chest_style,'classic') AS chest_style "
        "FROM dbo.KidProfiles WHERE child_id=?",
        (child_id,), fetch="one"
    ) or {"avatar_slug": "star", "chest_style": "classic"}

    lvl = level_for_xp(row.get("total_xp") or 0)
    badges = qry(
        "SELECT b.slug, b.label, b.icon, b.description, cb.earned_at "
        "FROM dbo.ChildBadges cb JOIN dbo.Badges b ON cb.badge_slug = b.slug "
        "WHERE cb.child_id=? ORDER BY cb.earned_at DESC",
        (child_id,)
    ) or []

    return jsonify({
        "child_id":          child_id,
        "total_xp":          lvl["total_xp"],
        "level":             lvl["level"],
        "xp_into_level":     lvl["xp_into_level"],
        "xp_for_next":       lvl["xp_for_next"],
        "coins":             row.get("coins") or 0,
        "gems":              row.get("gems") or 0,
        "stars":             row.get("stars") or 0,
        "avatar_slug":       prof.get("avatar_slug") or "star",
        "chest_style":       prof.get("chest_style") or "classic",
        "checkin_streak":    row.get("checkin_streak") or 0,
        "best_checkin_streak": row.get("best_checkin_streak") or 0,
        "checked_in_today":  str(row.get("last_checkin_date")) == str(date.today()),
        "badges":            badges,
    })


@gamification_bp.post("/avatar")
@require_auth
def set_avatar():
    """Child picks an avatar buddy + treasure-chest style (registration / customize)."""
    body = request.json or {}
    child_id = body.get("child_id")
    if not child_in_family(child_id, g.family_id):
        return jsonify({"error": "Not found"}), 404
    avatar = (body.get("avatar_slug") or "").strip()[:32] or "star"
    chest  = (body.get("chest_style") or "").strip()[:24] or "classic"
    if qry("SELECT 1 FROM dbo.KidProfiles WHERE child_id=?", (child_id,), fetch="one"):
        qry("UPDATE dbo.KidProfiles SET avatar_slug=?, chest_style=? WHERE child_id=?",
            (avatar, chest, child_id), fetch="exec")
    else:
        nick = qry("SELECT nickname FROM dbo.Children WHERE child_id=?", (child_id,), fetch="scalar") or "Scholar"
        qry("INSERT INTO dbo.KidProfiles (child_id, display_name, avatar_slug, chest_style) VALUES (?,?,?,?)",
            (child_id, nick, avatar, chest), fetch="exec")
    return jsonify({"ok": True, "avatar_slug": avatar, "chest_style": chest})


@gamification_bp.post("/checkin")
@require_auth
def checkin():
    body = request.json or {}
    child_id = body.get("child_id")
    if not child_in_family(child_id, g.family_id):
        return jsonify({"error": "Not found"}), 404
    return jsonify(daily_checkin(child_id))


@gamification_bp.get("/leaderboard")
@require_auth
def leaderboard():
    child_id = request.args.get("child_id", type=int)
    scope    = request.args.get("scope", "global")           # 'global' | 'region'
    limit    = min(max(request.args.get("limit", 20, type=int), 1), 100)

    region = None
    if child_id and child_in_family(child_id, g.family_id):
        rrow = qry(
            "SELECT f.region FROM dbo.Children c "
            "JOIN dbo.Families f ON c.family_id = f.family_id WHERE c.child_id=?",
            (child_id,), fetch="one"
        )
        region = (rrow or {}).get("region")

    if scope == "region" and region:
        rows = qry(
            "SELECT TOP (?) display_name, avatar_slug, region, total_xp, level "
            "FROM dbo.vw_Leaderboard WHERE region=? ORDER BY total_xp DESC, display_name",
            (limit, region)
        ) or []
    else:
        scope = "global"
        rows = qry(
            "SELECT TOP (?) display_name, avatar_slug, region, total_xp, level "
            "FROM dbo.vw_Leaderboard ORDER BY total_xp DESC, display_name",
            (limit,)
        ) or []

    for i, r in enumerate(rows):
        r["rank"] = i + 1
    return jsonify({"scope": scope, "region": region, "entries": rows})


@gamification_bp.post("/settings")
@require_parent_or_admin
def settings():
    """Parent opt-in to the leaderboard and set a COARSE region (e.g. state/country)."""
    body   = request.json or {}
    opt_in = 1 if body.get("show_on_leaderboard") else 0
    region = (body.get("region") or "").strip()[:64] or None
    qry(
        "UPDATE dbo.Families SET show_on_leaderboard=?, region=? WHERE family_id=?",
        (opt_in, region, g.family_id), fetch="exec"
    )
    return jsonify({"ok": True, "show_on_leaderboard": bool(opt_in), "region": region})
