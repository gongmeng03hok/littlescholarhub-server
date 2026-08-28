"""
services/tts_service.py
Generates read-aloud narration audio for Stories using gTTS (Google
Translate's free text-to-speech endpoint — no API key required). The
resulting mp3 is stored in dbo.UploadedFiles (same BLOB pattern as
worksheet uploads) rather than on disk.
"""

import io
import logging
import re

from flask import request
from gtts import gTTS

from utils.db import qry, get_db

logger = logging.getLogger(__name__)

# gTTS language codes keyed by dbo.Languages.language_id.
# All four platform tracks are covered — narrating a Spanish story with the
# English voice (the old {1: "en"} default) mispronounced every word of it.
_LANG_CODES = {
    1: "en",       # English
    2: "zh-CN",    # 中文
    3: "hi",       # हिन्दी
    4: "es",       # Español
}


def _clean_for_speech(text: str) -> str:
    """Strip markup/placeholder artifacts that read badly aloud."""
    text = re.sub(r"<[^>]+>", " ", text)          # any stray HTML
    text = re.sub(r"_{2,}", " blank ", text)        # fill-in-the-blank underscores
    text = re.sub(r"\s+", " ", text).strip()
    return text


def generate_story_audio(story_id: int, text: str, language_id: int = 1) -> str:
    """Generates narration for `text`, stores it, and returns the file URL.
    Raises on failure — callers should catch and surface a clear error rather
    than silently leaving audio_url empty."""
    from routes.content import file_url  # local import avoids a circular import

    clean = _clean_for_speech(text)
    if not clean:
        raise ValueError("Nothing to narrate — body_text is empty after cleanup")

    lang = _LANG_CODES.get(language_id, "en")
    buf = io.BytesIO()
    gTTS(text=clean, lang=lang, slow=False).write_to_fp(buf)
    audio_bytes = buf.getvalue()

    filename = f"story_{story_id}_readaloud.mp3"
    row = qry(
        "INSERT INTO dbo.UploadedFiles (filename, mime_type, file_size, data, uploaded_by) "
        "OUTPUT INSERTED.file_id AS file_id "
        "VALUES (?,?,?,?,NULL)",
        (filename, "audio/mpeg", len(audio_bytes), audio_bytes),
        fetch="one"
    )
    get_db().commit()
    # Other callers (homework.py, progress.py) always wrap file_url() with
    # request.url_root — a bare relative path won't resolve as an <audio>/
    # expo-av source on the frontend, which has no notion of "this API's origin".
    return request.url_root.rstrip("/") + file_url(row["file_id"])
