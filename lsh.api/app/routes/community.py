"""
routes/community.py — /api/community
Weekly teacher office-hours RSVP tracking. Group listings & the office-hours
schedule itself live in AppConfig (read via /api/config); this blueprint only
tracks who's coming.
"""

from flask import Blueprint, request, jsonify, g
from utils.db   import qry, get_db
from utils.auth import require_auth

community_bp = Blueprint("community", __name__)


@community_bp.get("/office-hours/rsvp")
@require_auth
def get_rsvp():
    session_label = request.args.get("session_label", "")
    if not session_label:
        return jsonify({"error": "session_label required"}), 400
    row = qry(
        "SELECT 1 FROM dbo.OfficeHourRSVPs WHERE family_id=? AND session_label=?",
        (g.family_id, session_label), fetch="one"
    )
    return jsonify({"rsvped": bool(row)})


@community_bp.post("/office-hours/rsvp")
@require_auth
def rsvp():
    body = request.json or {}
    session_label = (body.get("session_label") or "").strip()
    if not session_label:
        return jsonify({"error": "session_label required"}), 400

    existing = qry(
        "SELECT 1 FROM dbo.OfficeHourRSVPs WHERE family_id=? AND session_label=?",
        (g.family_id, session_label), fetch="one"
    )
    if not existing:
        qry(
            "INSERT INTO dbo.OfficeHourRSVPs (family_id, session_label) VALUES (?,?)",
            (g.family_id, session_label), fetch="exec"
        )
    return jsonify({"ok": True, "rsvped": True})
