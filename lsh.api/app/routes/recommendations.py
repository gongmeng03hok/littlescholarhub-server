"""
routes/recommendations.py  –  /api/recommendations/<child_id>
Returns personalised worksheet and story recommendations.
"""

from flask import Blueprint, jsonify, g
from utils.auth import require_auth
from utils.db   import qry
from services.recommendation import get_recommendations

recommendations_bp = Blueprint("recommendations", __name__)


@recommendations_bp.get("/<int:child_id>")
@require_auth
def get_recs(child_id):
    # Verify ownership
    child = qry(
        "SELECT grade_id FROM dbo.Children WHERE child_id=? AND family_id=?",
        (child_id, g.family_id), fetch="one"
    )
    if not child:
        return jsonify({"error": "Not found"}), 404

    recs = get_recommendations(child_id, child["grade_id"])
    return jsonify(recs)
