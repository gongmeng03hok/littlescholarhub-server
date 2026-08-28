"""
utils/db.py — SQL Server connection helper (pyodbc)
Falls back to a no-op mock when pyodbc is not installed (dev mode).
"""

import json
from flask import g, current_app

try:
    import pyodbc
    HAS_PYODBC = True
except ImportError:
    HAS_PYODBC = False


def get_db():
    if "_db" not in g:
        if HAS_PYODBC:
            g._db = pyodbc.connect(current_app.config["DB_CONN"], autocommit=False)
        else:
            g._db = None
    return g._db


def close_db(_=None):
    db = g.pop("_db", None)
    if db:
        db.close()


def qry(sql: str, params=(), fetch="all"):
    """
    Execute a parameterised SQL statement.
    fetch: 'all' → list[dict], 'one' → dict|None,
           'scalar' → single value, 'exec' → rowcount
    """
    db = get_db()
    if db is None:
        return [] if fetch == "all" else None

    cur = db.cursor()
    cur.execute(sql, params)

    if fetch == "exec":
        db.commit()
        return cur.rowcount

    cols = [d[0] for d in cur.description]
    if fetch == "one":
        row = cur.fetchone()
        return dict(zip(cols, row)) if row else None
    if fetch == "scalar":
        row = cur.fetchone()
        return row[0] if row else None
    return [dict(zip(cols, row)) for row in cur.fetchall()]


def exec_many(sql: str, param_list: list):
    db = get_db()
    if db is None:
        return
    cur = db.cursor()
    cur.executemany(sql, param_list)
    db.commit()


def child_in_family(child_id, family_id) -> bool:
    """Per-child ownership guard (IDOR protection).

    Returns True only when child_id belongs to family_id. In dev / no-DB mode
    there is no data to protect, so it returns True to keep local dev working.
    """
    db = get_db()
    if db is None:                       # dev / no-DB mode — nothing to protect
        return True
    if not child_id or not family_id:
        return False
    row = qry(
        "SELECT 1 FROM dbo.Children WHERE child_id=? AND family_id=?",
        (child_id, family_id), fetch="one"
    )
    return bool(row)
