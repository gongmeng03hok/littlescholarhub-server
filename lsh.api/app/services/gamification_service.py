"""
services/gamification_service.py — XP, levels, coins, daily check-in, milestone badges.

Every DB write here is defensive (a no-op when the DB is unavailable) so awarding
XP can never break the core answer/attempt flow. Reuses the existing
ChildGameStats / Badges / ChildBadges tables (see 11_gamification.sql).
"""

from datetime import date, timedelta
from utils.db import qry, get_db

DAILY_BASE_COINS = 5
DAILY_BASE_XP    = 10


# ── Level curve (gentle, kid-friendly ramp) ──────────────────────────────────
def xp_for_level(level: int) -> int:
    """XP required to advance FROM `level` to the next one."""
    return 100 + (max(1, level) - 1) * 50   # L1->2:100, L2->3:150, L3->4:200 ...


def level_for_xp(total_xp) -> dict:
    total = max(0, int(total_xp or 0))
    level, remaining, need = 1, total, xp_for_level(1)
    while remaining >= need:
        remaining -= need
        level += 1
        need = xp_for_level(level)
    return {"level": level, "xp_into_level": remaining,
            "xp_for_next": need, "total_xp": total}


# ── Stats helpers ────────────────────────────────────────────────────────────
def _get_stats_row(child_id):
    return qry(
        "SELECT total_xp, level, coins, gems, stars, last_checkin_date, checkin_streak, best_checkin_streak "
        "FROM dbo.ChildGameStats WHERE child_id=?",
        (child_id,), fetch="one"
    )


def _ensure_stats(child_id):
    qry(
        "IF NOT EXISTS (SELECT 1 FROM dbo.ChildGameStats WHERE child_id=?) "
        "INSERT INTO dbo.ChildGameStats (child_id) VALUES (?)",
        (child_id, child_id), fetch="exec"
    )


# ── Public API ───────────────────────────────────────────────────────────────
def award_reward(child_id, gems: int = 0, stars: int = 0, xp: int = 0, coins: int = 0):
    """Add gems/stars/xp/coins, recompute level, evaluate milestone badges. No-op without DB."""
    if not child_id or get_db() is None:
        return None
    try:
        _ensure_stats(child_id)
        row = _get_stats_row(child_id) or {"total_xp": 0}
        new_total = int(row.get("total_xp") or 0) + max(0, int(xp or 0))
        lvl = level_for_xp(new_total)["level"]
        qry(
            "UPDATE dbo.ChildGameStats "
            "SET total_xp=?, level=?, coins=coins+?, gems=gems+?, stars=stars+?, updated_at=SYSUTCDATETIME() "
            "WHERE child_id=?",
            (new_total, lvl, max(0, int(coins or 0)),
             max(0, int(gems or 0)), max(0, int(stars or 0)), child_id),
            fetch="exec"
        )
        evaluate_milestones(child_id)
        return level_for_xp(new_total)
    except Exception:
        return None


def award_xp(child_id, xp: int = 0, coins: int = 0):
    """Back-compat wrapper (XP/coins only) — delegates to award_reward()."""
    return award_reward(child_id, xp=xp, coins=coins)


def daily_checkin(child_id):
    """Award the daily reward once per calendar day and update the check-in streak."""
    if not child_id or get_db() is None:
        return {"claimed": False, "reason": "no-db"}
    try:
        _ensure_stats(child_id)
        row = _get_stats_row(child_id) or {}
        today = date.today()
        last = row.get("last_checkin_date")
        if last == today:
            return {"claimed": False, "already_today": True,
                    "checkin_streak": row.get("checkin_streak") or 0}

        streak = (row.get("checkin_streak") or 0)
        streak = streak + 1 if last == today - timedelta(days=1) else 1
        best = max(streak, row.get("best_checkin_streak") or 0)

        bonus = min(streak, 7)                 # streak bonus, capped
        coins = DAILY_BASE_COINS + bonus
        xp    = DAILY_BASE_XP + bonus

        qry(
            "UPDATE dbo.ChildGameStats "
            "SET last_checkin_date=?, checkin_streak=?, best_checkin_streak=? WHERE child_id=?",
            (str(today), streak, best, child_id), fetch="exec"
        )
        award_reward(child_id, stars=1, xp=xp, coins=coins)   # a star per day + level/badges
        return {"claimed": True, "coins": coins, "xp": xp, "stars": 1,
                "checkin_streak": streak, "best_checkin_streak": best}
    except Exception:
        return {"claimed": False, "reason": "error"}


def _award_badge(child_id, slug):
    qry(
        "IF NOT EXISTS (SELECT 1 FROM dbo.ChildBadges WHERE child_id=? AND badge_slug=?) "
        "INSERT INTO dbo.ChildBadges (child_id, badge_slug) VALUES (?, ?)",
        (child_id, slug, child_id, slug), fetch="exec"
    )


def evaluate_milestones(child_id):
    """Grant level/streak/xp milestone badges the child now qualifies for."""
    if not child_id or get_db() is None:
        return
    try:
        row = _get_stats_row(child_id)
        if not row:
            return
        lvl    = row.get("level") or 1
        total  = row.get("total_xp") or 0
        streak = row.get("checkin_streak") or 0
        if lvl >= 5:      _award_badge(child_id, "level_5")
        if lvl >= 10:     _award_badge(child_id, "level_10")
        if streak >= 7:   _award_badge(child_id, "streak_7")
        if streak >= 30:  _award_badge(child_id, "streak_30")
        if total >= 1000: _award_badge(child_id, "xp_1000")
    except Exception:
        return
