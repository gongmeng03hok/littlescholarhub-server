"""
models/family.py  –  Data-class wrappers for Family & Children rows.
These are plain Python dataclasses; no ORM is used (we use raw pyodbc).
"""

from dataclasses import dataclass, field
from datetime import datetime
from typing import Optional


@dataclass
class Family:
    family_id: int
    email: str
    plann: str = "explorer"
    language_id: int = 1
    referral_code: str = ""
    stripe_cust_id: Optional[str] = None
    trial_ends_at: Optional[datetime] = None
    created_at: Optional[datetime] = None

    @classmethod
    def from_row(cls, row: dict) -> "Family":
        return cls(
            family_id=row["family_id"],
            email=row["email"],
            plann=row.get("plann", "explorer"),
            language_id=row.get("language_id", 1),
            referral_code=row.get("referral_code", ""),
            stripe_cust_id=row.get("stripe_cust_id"),
            trial_ends_at=row.get("trial_ends_at"),
            created_at=row.get("created_at"),
        )

    def to_dict(self) -> dict:
        return {
            "family_id": self.family_id,
            "email": self.email,
            "plann": self.plann,
            "language_id": self.language_id,
            "referral_code": self.referral_code,
        }


@dataclass
class Child:
    child_id: int
    family_id: int
    nickname: str
    grade_id: int
    grade_label: str = ""
    birth_year: Optional[int] = None
    avatar_url: Optional[str] = None
    created_at: Optional[datetime] = None

    @classmethod
    def from_row(cls, row: dict) -> "Child":
        return cls(
            child_id=row["child_id"],
            family_id=row["family_id"],
            nickname=row["nickname"],
            grade_id=row["grade_id"],
            grade_label=row.get("grade_label", ""),
            birth_year=row.get("birth_year"),
            avatar_url=row.get("avatar_url"),
            created_at=row.get("created_at"),
        )

    def to_dict(self) -> dict:
        return {
            "child_id": self.child_id,
            "family_id": self.family_id,
            "nickname": self.nickname,
            "grade_id": self.grade_id,
            "grade_label": self.grade_label,
            "birth_year": self.birth_year,
            "avatar_url": self.avatar_url,
        }
