"""
services/recommendation.py
Suggests worksheets and stories based on a child's weak subjects from progress data.
"""

from utils.db import qry


def get_recommendations(child_id: int, grade_id: int, limit: int = 6) -> dict:
    """
    Returns recommended worksheets and stories for a child.
    Strategy:
      1. Find subjects with fewest sessions in last 30 days → weakest subjects.
      2. Pull worksheets and stories for those subjects at the child's grade.
    """
    # Subjects practiced least in last 30 days
    practiced = qry(
        "SELECT subject_id, COUNT(*) AS cnt"
        " FROM dbo.SessionLogs"
        " WHERE child_id=? AND session_date >= CAST(DATEADD(day,-30,GETDATE()) AS DATE)"
        " GROUP BY subject_id"
        " ORDER BY cnt ASC",
        (child_id,)
    ) or []

    practiced_ids = {row["subject_id"]: row["cnt"] for row in practiced}

    # Get all subjects
    all_subjects = qry("SELECT subject_id FROM dbo.Subjects WHERE is_cultural=0") or []
    all_ids = [s["subject_id"] for s in all_subjects]

    # Prioritise unpracticed, then least practiced
    unpracticed = [sid for sid in all_ids if sid not in practiced_ids]
    weak_ids    = unpracticed[:3] or sorted(practiced_ids, key=practiced_ids.get)[:3]
    if not weak_ids:
        weak_ids = [3, 1, 7]  # math, phonics, logic as defaults

    # Fetch worksheets for weak subjects
    placeholders = ",".join("?" * len(weak_ids))
    worksheets = qry(
        f"SELECT TOP {limit} worksheet_id, title, description, pdf_url, thumbnail_url,"
        f"       estimated_min, subject_id"
        f" FROM dbo.Worksheets"
        f" WHERE is_published=1 AND grade_id<=? AND subject_id IN ({placeholders})"
        f" ORDER BY NEWID()",
        [grade_id] + weak_ids
    ) or []

    # Fetch a story
    story = qry(
        "SELECT TOP 1 story_id, title, read_min, theme_tag"
        " FROM dbo.Stories WHERE is_published=1 AND grade_id<=? ORDER BY NEWID()",
        (grade_id,), fetch="one"
    )

    return {
        "recommended_worksheets": worksheets,
        "featured_story": story,
        "based_on": "least-practiced subjects",
    }
