"""
utils/validators.py  –  Input validation helpers.
"""

import re
from typing import Optional


EMAIL_RE = re.compile(r"^[a-zA-Z0-9_.+\-]+@[a-zA-Z0-9\-]+\.[a-zA-Z0-9\-.]+$")


def validate_email(email: str) -> Optional[str]:
    """Returns None if valid, else an error message."""
    if not email or not EMAIL_RE.match(email.strip()):
        return "Invalid email address."
    return None


def validate_password(password: str) -> Optional[str]:
    if not password or len(password) < 8:
        return "Password must be at least 8 characters."
    return None


def validate_grade_id(grade_id) -> Optional[str]:
    try:
        gid = int(grade_id)
        if gid < 0 or gid > 7:
            return "grade_id must be 0 (TK) through 7 (6th grade)."
    except (TypeError, ValueError):
        return "grade_id must be an integer."
    return None


def sanitise_str(value, max_len: int = 256) -> str:
    """Strip and truncate a string value."""
    if not isinstance(value, str):
        value = str(value or "")
    return value.strip()[:max_len]


def parse_int(value, default: int = 0, min_val: int = None, max_val: int = None) -> int:
    try:
        result = int(value)
    except (TypeError, ValueError):
        return default
    if min_val is not None:
        result = max(min_val, result)
    if max_val is not None:
        result = min(max_val, result)
    return result
