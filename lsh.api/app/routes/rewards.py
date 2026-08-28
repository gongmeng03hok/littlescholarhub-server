"""
routes/rewards.py — /api/rewards
Parent-curated reward store (e.g. an Amazon item the parent picked
themselves) redeemable with a child's game-economy coins
(dbo.ChildGameStats.coins). There is no real payment or Amazon API
integration here — redeeming just spends points and creates a pending
request for the parent to approve, deny, or mark fulfilled once they've
actually bought/given the item themselves.
"""

from flask import Blueprint, request, jsonify, g
from utils.db import qry, get_db, child_in_family
from utils.auth import require_auth, require_parent_or_admin

rewards_bp = Blueprint("rewards", __name__)


def _verify_reward(reward_id, family_id):
    return qry(
        "SELECT reward_id FROM dbo.RewardItems WHERE reward_id=? AND family_id=?",
        (reward_id, family_id), fetch="one"
    )


@rewards_bp.get("/items")
@require_auth
def list_items():
    """Kid + parent view. A reward with child_id=NULL is shared/visible to
    every kid in the family; a reward with a specific child_id is only
    visible to (and redeemable by) that kid.

    Kids only ever see active items scoped to themselves (or shared).
    A parent/admin managing the store can pass ?all=1 to also see paused
    (inactive) items and every kid's items, or ?child_id=<id> to preview
    what a specific kid sees."""
    show_all = request.args.get("all") == "1" and g.role in ("parent", "admin")

    filter_child_id = g.kid_id if g.role == "kid" else request.args.get("child_id", type=int)

    sql = (
        "SELECT ri.reward_id, ri.family_id, ri.child_id, c.nickname AS child_nickname, "
        "       ri.title, ri.description, ri.image_url, ri.product_url, "
        "       ri.point_cost, ri.is_active, ri.created_at "
        "FROM dbo.RewardItems ri "
        "LEFT JOIN dbo.Children c ON ri.child_id = c.child_id "
        "WHERE ri.family_id=?"
    )
    params = [g.family_id]
    if not show_all:
        sql += " AND ri.is_active=1"
    if filter_child_id:
        sql += " AND (ri.child_id IS NULL OR ri.child_id=?)"
        params.append(filter_child_id)
    sql += " ORDER BY ri.point_cost ASC"
    return jsonify(qry(sql, params) or [])


@rewards_bp.post("/items")
@require_parent_or_admin
def create_item():
    body = request.json or {}
    title = (body.get("title") or "").strip()
    point_cost = body.get("point_cost")
    child_id = body.get("child_id") or None  # None/omitted = shared across all kids
    if not title or not point_cost or int(point_cost) <= 0:
        return jsonify({"error": "title and a positive point_cost are required"}), 400
    if child_id and not child_in_family(child_id, g.family_id):
        return jsonify({"error": "Child not found"}), 404

    row = qry(
        "INSERT INTO dbo.RewardItems (family_id, child_id, title, description, image_url, product_url, point_cost) "
        "OUTPUT INSERTED.reward_id AS reward_id "
        "VALUES (?,?,?,?,?,?,?)",
        (g.family_id, child_id, title, body.get("description"), body.get("image_url"),
         body.get("product_url"), int(point_cost)), fetch="one"
    )
    if row:
        get_db().commit()
    return jsonify({"ok": True, "reward_id": row["reward_id"]}), 201


@rewards_bp.put("/items/<int:reward_id>")
@require_parent_or_admin
def update_item(reward_id):
    if not _verify_reward(reward_id, g.family_id):
        return jsonify({"error": "Not found"}), 404

    body = request.json or {}
    if "child_id" in body and body["child_id"] and not child_in_family(body["child_id"], g.family_id):
        return jsonify({"error": "Child not found"}), 404

    col_map = {
        "title": "title", "description": "description", "image_url": "image_url",
        "product_url": "product_url", "point_cost": "point_cost", "is_active": "is_active",
        "child_id": "child_id",
    }
    fields, params = [], []
    for key, col in col_map.items():
        if key in body:
            if key == "is_active":
                params.append(int(bool(body[key])))
            elif key == "child_id":
                params.append(body[key] or None)  # falsy/null clears it back to "shared"
            else:
                params.append(body[key])
            fields.append(f"{col}=?")
    if not fields:
        return jsonify({"error": "No fields to update"}), 400

    params.append(reward_id)
    qry(f"UPDATE dbo.RewardItems SET {', '.join(fields)} WHERE reward_id=?", params, fetch="exec")
    return jsonify({"ok": True})


@rewards_bp.delete("/items/<int:reward_id>")
@require_parent_or_admin
def delete_item(reward_id):
    if not _verify_reward(reward_id, g.family_id):
        return jsonify({"error": "Not found"}), 404
    qry("DELETE FROM dbo.RewardItems WHERE reward_id=?", (reward_id,), fetch="exec")
    return jsonify({"ok": True})


@rewards_bp.post("/redeem")
@require_auth
def redeem():
    """Kid (or parent on their behalf) spends points on a reward item.
    Creates a pending request — no real purchase happens here."""
    body      = request.json or {}
    child_id  = body.get("child_id")
    reward_id = body.get("reward_id")
    if not child_id or not reward_id:
        return jsonify({"error": "child_id and reward_id required"}), 400
    if not child_in_family(child_id, g.family_id):
        return jsonify({"error": "Child not found"}), 404

    reward = qry(
        "SELECT reward_id, point_cost FROM dbo.RewardItems "
        "WHERE reward_id=? AND family_id=? AND is_active=1 AND (child_id IS NULL OR child_id=?)",
        (reward_id, g.family_id, child_id), fetch="one"
    )
    if not reward:
        return jsonify({"error": "Reward not found"}), 404

    stats = qry("SELECT coins FROM dbo.ChildGameStats WHERE child_id=?", (child_id,), fetch="one")
    coins = (stats or {}).get("coins") or 0
    cost  = reward["point_cost"]
    if coins < cost:
        return jsonify({"error": f"Not enough points — needs {cost}, has {coins}"}), 400

    conn = get_db()
    cur = conn.cursor()
    cur.execute("UPDATE dbo.ChildGameStats SET coins = coins - ? WHERE child_id=?", (cost, child_id))
    cur.execute(
        "INSERT INTO dbo.RewardRedemptions (reward_id, child_id, family_id, points_spent) "
        "OUTPUT INSERTED.redemption_id AS redemption_id VALUES (?,?,?,?)",
        (reward_id, child_id, g.family_id, cost)
    )
    row = cur.fetchone()
    conn.commit()
    return jsonify({
        "ok": True, "redemption_id": row[0],
        "points_spent": cost, "remaining_coins": coins - cost,
    }), 201


@rewards_bp.get("/redemptions")
@require_auth
def list_redemptions():
    """Parent sees every request for the family; a kid session only sees its own."""
    sql = (
        "SELECT rr.redemption_id, rr.child_id, c.nickname AS child_nickname, "
        "       rr.reward_id, ri.title AS reward_title, ri.image_url, ri.product_url, "
        "       rr.points_spent, rr.status, rr.requested_at, rr.resolved_at, rr.resolved_note "
        "FROM dbo.RewardRedemptions rr "
        "JOIN dbo.RewardItems ri ON rr.reward_id = ri.reward_id "
        "JOIN dbo.Children c ON rr.child_id = c.child_id "
        "WHERE rr.family_id=?"
    )
    params = [g.family_id]
    if g.role == "kid" and g.kid_id:
        sql += " AND rr.child_id=?"
        params.append(g.kid_id)
    sql += " ORDER BY rr.requested_at DESC"
    return jsonify(qry(sql, params) or [])


@rewards_bp.put("/redemptions/<int:redemption_id>/resolve")
@require_parent_or_admin
def resolve_redemption(redemption_id):
    body = request.json or {}
    status = body.get("status")
    if status not in ("approved", "denied", "fulfilled"):
        return jsonify({"error": "status must be approved, denied, or fulfilled"}), 400

    row = qry(
        "SELECT redemption_id, child_id, points_spent, status FROM dbo.RewardRedemptions "
        "WHERE redemption_id=? AND family_id=?",
        (redemption_id, g.family_id), fetch="one"
    )
    if not row:
        return jsonify({"error": "Not found"}), 404
    if row["status"] != "pending":
        return jsonify({"error": f"Already {row['status']}"}), 400

    conn = get_db()
    cur = conn.cursor()
    if status == "denied":
        cur.execute(
            "UPDATE dbo.ChildGameStats SET coins = coins + ? WHERE child_id=?",
            (row["points_spent"], row["child_id"])
        )
    cur.execute(
        "UPDATE dbo.RewardRedemptions SET status=?, resolved_at=SYSUTCDATETIME(), resolved_note=? "
        "WHERE redemption_id=?",
        (status, body.get("note"), redemption_id)
    )
    conn.commit()
    return jsonify({"ok": True, "status": status})
