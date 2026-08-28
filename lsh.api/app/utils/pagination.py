"""
utils/pagination.py  –  Simple offset/limit pagination helper.
"""

from flask import request


def get_pagination(default_limit: int = 20, max_limit: int = 100) -> dict:
    """Extract page/limit from query params; return offset + limit dict."""
    try:
        page  = max(1, int(request.args.get("page",  1)))
        limit = min(max_limit, max(1, int(request.args.get("limit", default_limit))))
    except ValueError:
        page, limit = 1, default_limit

    return {"page": page, "limit": limit, "offset": (page - 1) * limit}


def paginate_query(base_sql: str, count_sql: str, params: list, pagination: dict) -> dict:
    """
    Append OFFSET/FETCH to base_sql and return
    {"items": [...], "total": int, "page": int, "pages": int}.
    """
    from utils.db import qry

    total   = qry(count_sql, params, fetch="scalar") or 0
    paged   = (base_sql
               + f" OFFSET {pagination['offset']} ROWS"
               + f" FETCH NEXT {pagination['limit']} ROWS ONLY")
    items   = qry(paged, params) or []
    pages   = max(1, -(-total // pagination["limit"]))  # ceiling division

    return {
        "items":  items,
        "total":  total,
        "page":   pagination["page"],
        "pages":  pages,
        "limit":  pagination["limit"],
    }
