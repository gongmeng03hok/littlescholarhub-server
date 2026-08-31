"""
services/badge_service.py
Evaluates earned badges after each attempt / session.
"""

from utils.db import qry
from datetime import date


BADGE_RULES = {
    "first_sheet": lambda stats: stats.get("total_attempts", 0) >= 1,
    "perfect_day": lambda stats: stats.get("day_perfect", False),
    "speed_star":  lambda stats: stats.get("fast_correct_5", False),
    "drill_master":lambda stats: stats.get("drill_perfect", False),
    "week_warrior":lambda stats: stats.get("days_this_week", 0) >= 5,
    "topic_mastered": lambda stats: stats.get("best_mastery_pct", 0) >= 80,
    "streak_3":    lambda stats: stats.get("current_streak", 0) >= 3,
    "streak_7":    lambda stats: stats.get("current_streak", 0) >= 7,
    "xp_100":      lambda stats: stats.get("total_xp", 0) >= 100,
    "xp_500":      lambda stats: stats.get("total_xp", 0) >= 500,
    # These four are in dbo.Badges but had no rule, so nothing checked them.
    "xp_1000":     lambda stats: stats.get("total_xp", 0) >= 1000,
    "level_5":     lambda stats: stats.get("level", 0) >= 5,
    "level_10":    lambda stats: stats.get("level", 0) >= 10,
    "streak_30":   lambda stats: stats.get("current_streak", 0) >= 30,
    # Generic, cross-subject achievements (any of the 9 subjects, not just math)
    "first_worksheet":         lambda stats: stats.get("worksheet_viewed", False),
    "first_culture_worksheet": lambda stats: stats.get("cultural_worksheet_viewed", False),
    "first_mini_book":         lambda stats: stats.get("mini_book_viewed", False),
    "first_language_switch":   lambda stats: stats.get("language_switched", False),
    # Homework-scanner milestone stickers
    "homework_1st_scan":  lambda stats: stats.get("homework_scan_count", 0) >= 1,
    "homework_5_scans":   lambda stats: stats.get("homework_scan_count", 0) >= 5,
    "homework_10_scans":  lambda stats: stats.get("homework_scan_count", 0) >= 10,
}


def evaluate_badges(child_id: int, stats: dict) -> list:
    """
    Check which badges a child has newly earned.
    Returns list of newly earned badge slugs.
    """
    # Get already-earned badges
    earned_rows = qry(
        "SELECT badge_slug FROM dbo.ChildBadges WHERE child_id=?",
        (child_id,)
    ) or []
    already = {r["badge_slug"] for r in earned_rows}

    new_badges = []
    for slug, rule_fn in BADGE_RULES.items():
        if slug not in already and rule_fn(stats):
            try:
                qry(
                    "INSERT INTO dbo.ChildBadges (child_id, badge_slug) VALUES (?,?)",
                    (child_id, slug), fetch="exec"
                )
                new_badges.append(slug)
            except Exception:
                pass

    return new_badges


def evaluate_and_award(child_id: int, event_type: str, event_meta: dict = None) -> list:
    """
    Assemble the relevant stats slice for an event and run evaluate_badges().
    event_type: "worksheet_view" | "session_log"
    """
    event_meta = event_meta or {}
    stats = {}

    if event_type == "worksheet_view":
        stats["worksheet_viewed"] = True
        if event_meta.get("is_cultural"):
            stats["cultural_worksheet_viewed"] = True
        if event_meta.get("content_type") == "mini_book":
            stats["mini_book_viewed"] = True
        if event_meta.get("language_switched"):
            stats["language_switched"] = True

    elif event_type in ("session_log", "attempt"):
        streak = qry(
            "SELECT current_streak FROM dbo.Streaks WHERE child_id=?",
            (child_id,), fetch="one"
        ) or {}
        stats["current_streak"] = streak.get("current_streak", 0)

        game = qry(
            "SELECT total_xp, level FROM dbo.ChildGameStats WHERE child_id=?",
            (child_id,), fetch="one"
        ) or {}
        stats["total_xp"] = game.get("total_xp") or 0
        stats["level"] = game.get("level") or 0

        # One round trip for the attempt-shaped stats rather than five.
        row = qry(
            "SELECT "
            " (SELECT COUNT(*) FROM dbo.QuestionAttempts WHERE child_id=?) AS total_attempts,"
            " (SELECT COUNT(*) FROM dbo.QuestionAttempts WHERE child_id=?"
            "   AND CAST(attempted_at AS DATE)=CAST(GETDATE() AS DATE)) AS today_total,"
            " (SELECT COUNT(*) FROM dbo.QuestionAttempts WHERE child_id=? AND is_correct=1"
            "   AND CAST(attempted_at AS DATE)=CAST(GETDATE() AS DATE)) AS today_correct,"
            " (SELECT COUNT(*) FROM dbo.QuestionAttempts WHERE child_id=? AND is_correct=1"
            "   AND time_sec IS NOT NULL AND time_sec <= 10) AS fast_correct,"
            " (SELECT COUNT(DISTINCT CAST(session_date AS DATE)) FROM dbo.SessionLogs"
            "   WHERE child_id=? AND session_date >= CAST(DATEADD(day,-7,GETDATE()) AS DATE))"
            "   AS days_this_week",
            (child_id,) * 5, fetch="one"
        ) or {}
        stats["total_attempts"] = row.get("total_attempts") or 0
        # A perfect day needs enough answers to mean something; one correct
        # answer is not a perfect day.
        stats["day_perfect"] = ((row.get("today_total") or 0) >= 5
                                and row.get("today_correct") == row.get("today_total"))
        stats["fast_correct_5"] = (row.get("fast_correct") or 0) >= 5
        stats["days_this_week"] = row.get("days_this_week") or 0

    elif event_type == "homework_submission":
        stats["homework_scan_count"] = event_meta.get("scan_count", 0)

    if not stats:
        return []
    return evaluate_badges(child_id, stats)


def get_child_badges(child_id: int) -> list:
    rows = qry(
        "SELECT cb.badge_slug, b.label, b.icon, b.description, b.xp_value, cb.earned_at"
        " FROM dbo.ChildBadges cb"
        " JOIN dbo.Badges b ON cb.badge_slug = b.slug"
        " WHERE cb.child_id=?"
        " ORDER BY cb.earned_at DESC",
        (child_id,)
    )
    return rows or []


def get_weekly_xp(child_id: int) -> dict:
    week = date.today().isocalendar()[1]
    year = date.today().year
    row = qry(
        "SELECT total_xp, total_correct, total_attempts"
        " FROM dbo.MathWeeklyXP WHERE child_id=? AND week_num=? AND year_num=?",
        (child_id, week, year), fetch="one"
    )
    return row or {"total_xp": 0, "total_correct": 0, "total_attempts": 0}
