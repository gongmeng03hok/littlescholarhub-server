"""
models/content.py  –  Data-class wrappers for content entities.
"""

from dataclasses import dataclass, field
from datetime import datetime, date
from typing import Optional, List


@dataclass
class Worksheet:
    worksheet_id: int
    subject_id: int
    grade_id: int
    title: str
    language_id: int = 1
    difficulty_id: int = 2
    description: Optional[str] = None
    pdf_url: Optional[str] = None
    thumbnail_url: Optional[str] = None
    estimated_min: Optional[int] = None
    teacher_name: Optional[str] = None
    is_published: bool = True

    @classmethod
    def from_row(cls, row: dict) -> "Worksheet":
        return cls(**{k: v for k, v in row.items() if k in cls.__dataclass_fields__})

    def to_dict(self) -> dict:
        return {
            "worksheet_id": self.worksheet_id,
            "title": self.title,
            "description": self.description,
            "pdf_url": self.pdf_url,
            "thumbnail_url": self.thumbnail_url,
            "estimated_min": self.estimated_min,
            "teacher_name": self.teacher_name,
        }


@dataclass
class Story:
    story_id: int
    grade_id: int
    language_id: int
    title: str
    body_text: str
    read_min: int = 5
    theme_tag: Optional[str] = None
    vocab_json: Optional[str] = None
    audio_url: Optional[str] = None
    is_published: bool = True

    def to_dict(self) -> dict:
        return {
            "story_id": self.story_id,
            "title": self.title,
            "body_text": self.body_text,
            "read_min": self.read_min,
            "theme_tag": self.theme_tag,
            "vocab_json": self.vocab_json,
            "audio_url": self.audio_url,
        }


@dataclass
class DailyWisdom:
    wisdom_id: int
    language_id: int
    source_track: str
    text_original: str
    text_english: Optional[str] = None
    author: Optional[str] = None

    def to_dict(self) -> dict:
        return {
            "text_original": self.text_original,
            "text_english": self.text_english,
            "author": self.author,
            "source_track": self.source_track,
        }


@dataclass
class QuestionTemplate:
    template_id: int
    subject_id: int
    grade_id: int
    difficulty_id: int
    template_type: str
    template_text: str
    params_json: Optional[str] = None
    answer_expr: Optional[str] = None
    options_json: Optional[str] = None
    is_active: bool = True

    def to_dict(self) -> dict:
        return {
            "template_id": self.template_id,
            "subject_id": self.subject_id,
            "grade_id": self.grade_id,
            "template_type": self.template_type,
            "template_text": self.template_text,
        }
