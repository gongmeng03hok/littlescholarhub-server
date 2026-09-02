"""
routes/content.py — /api/content
Subjects, Worksheets, Stories, Daily Wisdom, Grades
"""

import json
import logging
import re
import hmac
import hashlib
from flask import Blueprint, request, jsonify, Response, g, current_app
from utils.db import qry, get_db
from utils.auth import require_parent_or_admin, require_admin, require_auth
from services.badge_service import evaluate_and_award

content_bp = Blueprint("content", __name__)


def file_token(file_id: int) -> str:
    """Unguessable capability token for a stored file, derived from the app secret.
    Lets private files (e.g. children's homework photos) be shown by <img> without an
    auth header, while preventing enumeration by sequential file_id."""
    secret = (current_app.config.get("JWT_SECRET") or "").encode()
    return hmac.new(secret, f"file:{file_id}".encode(), hashlib.sha256).hexdigest()[:32]


def file_url(file_id: int) -> str:
    """Public URL for a file. Non-PDF (private) files get a capability token."""
    return f"/api/content/files/{file_id}?t={file_token(file_id)}"


def _verify_child(child_id: int, family_id: int) -> bool:
    return bool(qry(
        "SELECT 1 FROM dbo.Children WHERE child_id=? AND family_id=?",
        (child_id, family_id), fetch="one"
    ))


@content_bp.get("/files/<int:file_id>")
def get_uploaded_file(file_id: int):
    """File stream. Public worksheet PDFs are open (loaded via openURL/<img>, which
    can't send an auth header). Private files (homework photos are images) require an
    unguessable capability token so they can't be enumerated by sequential file_id."""
    row = qry(
        "SELECT filename, mime_type, data FROM dbo.UploadedFiles WHERE file_id=?",
        (file_id,), fetch="one"
    )
    if not row:
        return jsonify({"error": "Not found"}), 404
    mime = row["mime_type"] or ""
    if not mime.startswith("application/pdf"):
        token = request.args.get("t", "")
        if not hmac.compare_digest(token, file_token(file_id)):
            return jsonify({"error": "Not found"}), 404
    return Response(
        bytes(row["data"]), mimetype=row["mime_type"],
        headers={"Content-Disposition": f'inline; filename="{row["filename"]}"'}
    )

STATIC_SUBJECTS = [
    {"subject_id":1,"slug":"phonics",    "label":"English & Phonics",       "icon":"📖","is_cultural":False},
    {"subject_id":2,"slug":"reading",    "label":"Reading Comprehension",    "icon":"📚","is_cultural":False},
    {"subject_id":3,"slug":"math",       "label":"Math",                     "icon":"🧮","is_cultural":False},
    {"subject_id":4,"slug":"art",        "label":"Art & Creativity",         "icon":"🎨","is_cultural":False},
    {"subject_id":5,"slug":"story",      "label":"Story Activities",         "icon":"🐉","is_cultural":False},
    {"subject_id":6,"slug":"workbooks",  "label":"Printable Workbooks",      "icon":"📕","is_cultural":False},
    {"subject_id":7,"slug":"logic",      "label":"Logic & Critical Thinking","icon":"🧩","is_cultural":False},
    {"subject_id":8,"slug":"feelings",   "label":"Feelings & Emotions",      "icon":"💛","is_cultural":False},
    {"subject_id":9,"slug":"manners",    "label":"Character & Manners",      "icon":"🌱","is_cultural":False},
    {"subject_id":10,"slug":"pinyin",    "label":"Pinyin",                   "icon":"🏮","is_cultural":True},
    {"subject_id":11,"slug":"hanzi",     "label":"汉字 Hanzi",               "icon":"🏮","is_cultural":True},
    {"subject_id":12,"slug":"tangshi",   "label":"唐诗 Tang Poems",          "icon":"🏮","is_cultural":True},
    {"subject_id":13,"slug":"gita",      "label":"Gita Stories",             "icon":"🪔","is_cultural":True},
    {"subject_id":14,"slug":"letras",    "label":"Letras",                   "icon":"🌻","is_cultural":True},
    {"subject_id":15,"slug":"fiestas",   "label":"Fiestas",                  "icon":"🌻","is_cultural":True},
    {"subject_id":16,"slug":"maestros",  "label":"Maestros",                 "icon":"🌻","is_cultural":True},
    {"subject_id":17,"slug":"solar_system","label":"Solar System",           "icon":"🪐","is_cultural":False},
]

STATIC_GRADES = [
    {"grade_id":0,"label":"TK","sort_order":0},
    {"grade_id":1,"label":"K", "sort_order":1},
    {"grade_id":2,"label":"1st","sort_order":2},
    {"grade_id":3,"label":"2nd","sort_order":3},
    {"grade_id":4,"label":"3rd","sort_order":4},
    {"grade_id":5,"label":"4th","sort_order":5},
    {"grade_id":6,"label":"5th","sort_order":6},
    {"grade_id":7,"label":"6th","sort_order":7},
]

STATIC_WISDOM = [
    {"text_original":"You have the right to perform your actions, but not to the fruits of your actions.",
     "text_english":None,"author":"Bhagavad Gita 2.47","source_track":"gita"},
    {"text_original":"学而时习之，不亦说乎","text_english":"Is it not pleasant to learn with perseverance?",
     "author":"Confucius","source_track":"chinese"},
    {"text_original":"Dime con quién andas y te diré quién eres.",
     "text_english":"Tell me who you walk with and I will tell you who you are.",
     "author":"Spanish proverb","source_track":"hispanic"},
]

STATIC_LEVELS = [
    {"level_id":1,"slug":"warm-up",   "label":"Warm-up"},
    {"level_id":2,"slug":"on-level",  "label":"On level"},
    {"level_id":3,"slug":"challenge", "label":"Challenge"},
]

STATIC_INTERESTS = [
    {"slug":"animals",   "label":"Animals",   "icon":"🦁"},
    {"slug":"dinosaurs", "label":"Dinosaurs", "icon":"🦕"},
    {"slug":"space",     "label":"Space",     "icon":"🚀"},
    {"slug":"ocean",     "label":"Ocean",     "icon":"🌊"},
    {"slug":"fantasy",   "label":"Fantasy",   "icon":"🐉"},
    {"slug":"vehicles",  "label":"Vehicles",  "icon":"🚗"},
    {"slug":"holidays",  "label":"Holidays",  "icon":"🎉"},
    {"slug":"sports",    "label":"Sports",    "icon":"⚽"},
    {"slug":"nature",    "label":"Nature",    "icon":"🌿"},
]

# Dev-mode fallback (no DB configured) — mirrors 11_content_library.sql seed
STATIC_LIBRARY = [
    {"worksheet_id":101,"subject":"art","grade_id":0,"content_type":"coloring","interest_tag":"fantasy",
     "title":"Color the Magical Unicorn","description":"A warm-up coloring page featuring a friendly unicorn.",
     "estimated_min":10,"page_count":2,"view_count":92000,"rating_avg":4.9,"rating_count":640,
     "social_badge":"instagram","is_trending":True,"level_slug":"warm-up","teacher_name":"Ms. Rivera",
     "pdf_url":None,"thumbnail_url":None},
    {"worksheet_id":102,"subject":"art","grade_id":0,"content_type":"coloring","interest_tag":"dinosaurs",
     "title":"Color the T-Rex Friend","description":"A gentle dinosaur coloring page for our youngest scholars.",
     "estimated_min":10,"page_count":2,"view_count":78000,"rating_avg":4.9,"rating_count":512,
     "social_badge":"tiktok","is_trending":True,"level_slug":"warm-up","teacher_name":"Ms. Rivera",
     "pdf_url":None,"thumbnail_url":None},
    {"worksheet_id":103,"subject":"art","grade_id":0,"content_type":"coloring","interest_tag":"nature",
     "title":"Color the Garden Flower","description":"Mother's Day coloring page — color the garden flower.",
     "estimated_min":10,"page_count":2,"view_count":41000,"rating_avg":4.8,"rating_count":305,
     "social_badge":None,"is_trending":True,"level_slug":"warm-up","teacher_name":"Ms. Rivera",
     "pdf_url":None,"thumbnail_url":None},
    {"worksheet_id":104,"subject":"story","grade_id":1,"content_type":"mini_book","interest_tag":"animals",
     "title":"Mini-Book: I See a Cat","description":"An 8-page emergent reader mini-book about a curious cat.",
     "estimated_min":10,"page_count":8,"view_count":47000,"rating_avg":4.9,"rating_count":260,
     "social_badge":"teachers","is_trending":True,"level_slug":"warm-up","teacher_name":"Mrs. Kim",
     "pdf_url":None,"thumbnail_url":None},
    {"worksheet_id":105,"subject":"tangshi","grade_id":3,"content_type":"mini_book","interest_tag":None,
     "title":"静夜思 (Quiet Night)","description":"A Tang poem mini-book with pinyin and illustrations.",
     "estimated_min":15,"page_count":6,"view_count":8600,"rating_avg":4.8,"rating_count":90,
     "social_badge":None,"is_trending":False,"level_slug":"on-level","teacher_name":"老师 Wang",
     "pdf_url":None,"thumbnail_url":None},
    {"worksheet_id":106,"subject":"letras","grade_id":4,"content_type":"mini_book","interest_tag":None,
     "title":"La Flor de Nochebuena","description":"A bilingual Spanish mini-book for Cuentos time.",
     "estimated_min":15,"page_count":8,"view_count":5200,"rating_avg":4.7,"rating_count":64,
     "social_badge":None,"is_trending":False,"level_slug":"on-level","teacher_name":"Sra. Gomez",
     "pdf_url":None,"thumbnail_url":None},
    {"worksheet_id":107,"subject":"gita","grade_id":5,"content_type":"mini_book","interest_tag":None,
     "title":"The Little Lamp (Gita)","description":"An inspirational Gita mini-book about a small light with big purpose.",
     "estimated_min":15,"page_count":8,"view_count":6100,"rating_avg":4.8,"rating_count":71,
     "social_badge":None,"is_trending":False,"level_slug":"on-level","teacher_name":"Priya Auntie",
     "pdf_url":None,"thumbnail_url":None},
    {"worksheet_id":108,"subject":"feelings","grade_id":5,"content_type":"workbook","interest_tag":None,
     "title":"Empathy Scenarios","description":"End-of-year SEL workbook — read the scenario, choose the kind response.",
     "estimated_min":20,"page_count":12,"view_count":3900,"rating_avg":4.7,"rating_count":48,
     "social_badge":None,"is_trending":False,"level_slug":"on-level","teacher_name":"Mr. Chen",
     "pdf_url":None,"thumbnail_url":None},
    {"worksheet_id":109,"subject":"math","grade_id":6,"content_type":"workbook","interest_tag":None,
     "title":"Singapore Bar Model: Ratios","description":"Math review workbook using bar models to reason about ratios.",
     "estimated_min":25,"page_count":10,"view_count":4400,"rating_avg":4.8,"rating_count":55,
     "social_badge":None,"is_trending":False,"level_slug":"challenge","teacher_name":"Mrs. Patel",
     "pdf_url":None,"thumbnail_url":None},
]

STATIC_FEATURED = [
    {"featured_id":1,"worksheet_id":103,"subtitle_override":"TK · Mother's Day",   "sort_order":0},
    {"featured_id":2,"worksheet_id":105,"subtitle_override":"2nd · AAPI Heritage", "sort_order":1},
    {"featured_id":3,"worksheet_id":106,"subtitle_override":"3rd · Cuentos",       "sort_order":2},
    {"featured_id":4,"worksheet_id":107,"subtitle_override":"4th · Inspiration",   "sort_order":3},
    {"featured_id":5,"worksheet_id":108,"subtitle_override":"4th · SEL · end-of-year","sort_order":4},
    {"featured_id":6,"worksheet_id":109,"subtitle_override":"5th · Math review",   "sort_order":5},
]


@content_bp.get("/subjects")
def list_subjects():
    rows = qry("SELECT subject_id,slug,label,icon,is_cultural FROM dbo.Subjects ORDER BY subject_id")
    return jsonify(rows if rows else STATIC_SUBJECTS)


@content_bp.get("/grades")
def list_grades():
    rows = qry("SELECT grade_id,label,sort_order FROM dbo.Grades ORDER BY sort_order")
    return jsonify(rows if rows else STATIC_GRADES)


#: Title phrase -> skill key understood by QuestionGenerator.SKILL_GENERATORS.
#: Ordered: the most specific phrase must win, so "skip counting" is tested
#: before the bare word "counting".
_SKILL_PATTERNS = [
    (r"beginning sound|initial sound|first sound|letter sound", "beginning_sounds"),
    (r"rhym",                                                   "rhyming"),
    (r"syllab",                                                 "syllables"),
    (r"digraph|\bsh, ch, th\b",                                 "digraphs"),
    (r"skip count",                                             "skip_counting"),
    (r"sight word|high.frequency",                              "sight_words"),
    (r"short [aeiou]\b|long [aeiou]\b|medial|vowel|cvc",        "vowels"),
    (r"place value|tens and ones|expanded form",                "place_value"),
    (r"multipl|times table",                                    "multiplication"),
    (r"divi",                                                   "division"),
    (r"fraction",                                               "fractions"),
    (r"decimal",                                                "decimals"),
    (r"percent",                                                "percentage"),
    (r"round",                                                  "rounding"),
    (r"money|coin|cent\b",                                      "money"),
    (r"elapsed|telling time|clock|half hour",                   "time"),
    (r"geometr|shape|angle|perimeter|area\b",                   "geometry"),
    (r"compar|greater|less than|more or less",                  "comparing"),
    (r"word problem",                                           "word_problems"),
    (r"factors?\\b|primes?\\b|prime number",                                           "factors_primes"),
    (r"order of operation",                                     "order_of_ops"),
    (r"i before e|ie or ei",                                     "ie_ei"),
    (r"spelling pattern|word pattern",                          "ie_ei"),
    # Skills the generators already cover; these titles simply were not matched.
    (r"prefix|suffix|affix",                                    "prefix_suffix"),
    (r"\broots?\b|greek . latin|greek and latin|word origin|where words come from|etymolog",
                                                                "root_word"),
    (r"homophone|commonly confused|confusing word",             "homophones"),
    (r"synonym|antonym|opposite word",                          "synonym_antonym"),
    (r"beginning.{0,6}middle.{0,6}end|retell the story|story order|sequenc",
                                                                "sequences"),
    (r"what doesn.?t belong|which one is different|same or different|odd one",
                                                                "odd_one_out"),
    (r"deductive reasoning|logic puzzle|who owns",              "logic_grid"),
    (r"what comes next",                                        "patterns"),
    (r"multisyllab|word chunking|word stress",                  "syllables"),
    # Reading strategies
    # Logic and number sense
    (r"ordinal|1st, 2nd, 3rd",                                  "ordinals"),
    (r"sorting by|sort by|same or different",                   "sorting"),
    (r"true or false",                                          "true_false"),
    (r"if.then|if then",                                        "if_then"),
    (r"true for all|all or some",                               "quantifiers"),
    (r"logical fallac|faulty reasoning",                        "fallacies"),
    (r"guess my number|mystery number",                         "guess_number"),
    (r"number bond",                                            "number_bonds"),
    (r"big and small|bigger or smaller|size sorting",           "size_sorting"),
    (r"pre.algebra|variable|solve for x|algebra",               "prealgebra"),
    (r"ratio|proportion|bar model",                             "ratios"),
    # Cultural tracks - the generators existed, the patterns did not
    # Not a bare "tone": "Theme & Tone Reading Pack" is 5th-grade English and
    # was being served "What tone is the syllable hao?". Both real Chinese
    # sheets carry an explicit pinyin/声调 cue, so the cue is enough.
    (r"pinyin|声调|tone mark",                                  "pinyin_tone"),
    # Likewise not a bare "poem", which would capture any English poetry sheet.
    (r"tang shi|tang poem|唐诗",                                    "tang_poem"),
    (r"primeras palabras|spanish word|vocabulario|palabras",    "spanish_vocab"),
    (r"context clue",                                           "context_clues"),
    (r"fact or opinion|fact vs|fact and opinion",               "fact_opinion"),
    (r"cause . effect|cause and effect",                        "cause_effect"),
    (r"author.?s purpose|author.?s word choice|author.?s craft", "author_purpose"),
    (r"predict|picture walk|what happens next",                 "prediction"),
    (r"text feature|parts of a book|nonfiction text",           "text_features"),
    (r"picture clue",                                           "prediction"),
    (r"who, what, where|wh.? question",                         "comprehension"),
    (r"making inference|inferen",                               "comprehension"),
    (r"theme vs|theme and topic|theme . tone|main idea",        "comprehension"),
    # Phonics patterns
    (r"ending sound|final sound|last sound",                    "ending_sounds"),
    (r"silent e|magic e",                                       "silent_e"),
    (r"soft c|soft g|hard c|hard g",                            "soft_cg"),
    (r"compound word",                                          "compound_words"),
    (r"contraction",                                            "contractions"),
    (r"silent letter",                                          "silent_letters"),
    (r"spelling pattern|i before e",                            "silent_letters"),
    # Social-emotional: the banded banks already cover these concepts
    (r"calm.down|breathing|self.regulat|trigger|big feeling|how do you feel|what makes me feel|zones of regulation",
                                                                "feelings"),
    (r"empathy|seeing both sides|conflict resolution|peer pressure|self.esteem|problem size|kind words",
                                                                "feelings"),
    (r"kind or unkind|good listener|sharing|taking turns|saying sorry|good sport|"
     r"etiquette|including others|respectful|respecting|handling mistakes|manners",
                                                                "manners"),
    (r"sudoku",                                                 "sudoku"),
    (r"logic grid",                                             "logic_grid"),
    (r"code break|cipher|secret code",                          "cipher"),
    (r"pattern",                                                "patterns"),
    (r"odd one out",                                            "odd_one_out"),
    (r"sequenc",                                                "sequences"),
    (r"comprehension|main idea|summariz",                       "comprehension"),
    (r"feeling|emotion",                                        "feelings"),
    (r"manner|kindness|polite|character",                       "manners"),
    (r"subtract|minus|take away",                               "subtraction"),
    (r"add\b|addition|sum\b|plus",                              "addition"),
]


def _skill_from_title(title: str) -> str:
    """The skill a worksheet title promises, or "" if it names none.

    Derived from the title rather than stored, so a retitled sheet can never
    drift from the questions it serves.
    """
    t = (title or "").lower()
    for pat, key in _SKILL_PATTERNS:
        # Anchored at a word boundary: "Mis Primeras Palabras" was matching
        # "prime" inside "Primeras" and being served factor questions.
        if re.search(r"\b(?:" + pat + ")", t):
            return key
    return ""


#: Content that is shown rather than answered. A worksheet of one of these
#: types must never be routed into the question player — there are no questions
#: behind it, and the player would fall back to another subject's generator.
DEMO_CONTENT_TYPES = {"coloring", "space_image", "mini_book", "iacl_book"}

#: Subjects with no entry in QuestionGenerator.GENERATORS. Asking for questions
#: here silently yields MATH, which is how "Animals Art - Grade 2nd" ended up
#: asking a child to count dimes.
NO_QUESTION_SUBJECTS = {"art", "story", "workbooks", "solar_system", "science", "writing"}


def _decorate_worksheet(r: dict) -> dict:
    """Fill in the derived fields the frontend needs to render a worksheet."""
    if not r.get("pdf_url") and r.get("pdf_generator_key"):
        r["pdf_url"] = (request.url_root.rstrip("/")
                        + f"/api/content/worksheets/{r['worksheet_id']}/pdf")

    # steps_json is stored as a JSON array of strings; hand the frontend a real
    # list so it never has to parse. Bad JSON degrades to no steps, not a 500.
    raw = r.pop("steps_json", None)
    steps = []
    if raw:
        try:
            parsed = json.loads(raw)
            if isinstance(parsed, list):
                steps = [str(x).strip() for x in parsed if str(x).strip()]
        except (ValueError, TypeError):
            logging.warning("worksheet %s has unparseable steps_json", r.get("worksheet_id"))
    r["steps"] = steps

    # Single source of truth for "show this, don't quiz on it", so the web app
    # and any future client agree.
    # The skill the title promises, threaded to the generator by the client.
    r["skill_key"] = _skill_from_title(r.get("title"))

    # A tracing sheet is a pencil-and-paper exercise. There is nothing to answer
    # on a screen, so it must never reach the question player - "Trace Letters
    # A-Z" was being served phonics questions.
    title_l = (r.get("title") or "").lower()
    is_tracing = title_l.startswith("trace ") or " tracing" in title_l

    r["is_demo"] = bool(
        r.get("content_type") in DEMO_CONTENT_TYPES
        or r.get("subject") in NO_QUESTION_SUBJECTS
        or is_tracing
    )
    return r


@content_bp.get("/worksheets/<int:ws_id>")
def get_worksheet(ws_id: int):
    """One worksheet by id — used by the public sample screen, which is reached
    by URL and so cannot rely on a list already being in memory."""
    row = qry(
        "SELECT w.worksheet_id, s.slug AS subject, w.grade_id, w.content_type,"
        "       w.interest_tag, dl.slug AS level_slug, w.title, w.description,"
        "       w.pdf_url, w.thumbnail_url, w.estimated_min, w.page_count,"
        "       w.view_count, w.rating_avg, w.rating_count, w.social_badge,"
        "       w.is_trending, w.teacher_name, w.is_free, w.pdf_generator_key,"
        "       w.week_of, w.game_data, w.video_url, w.steps_json, w.materials,"
        "       w.story_id"
        " FROM dbo.Worksheets w"
        " JOIN dbo.Subjects s ON w.subject_id = s.subject_id"
        " JOIN dbo.DifficultyLevels dl ON w.difficulty_id = dl.level_id"
        " WHERE w.worksheet_id=? AND w.is_published=1",
        (ws_id,), fetch="one"
    )
    if not row:
        return jsonify({"error": "Not found"}), 404
    _decorate_worksheet(row)

    # A "<Theme> Story - Grade N" worksheet is an activity *about* a story. Ship
    # the story with it, or the child opens something called a story and finds
    # only a printable.
    if row.get("story_id"):
        story = qry(
            "SELECT story_id, title, body_text, audio_url, read_min, vocab_json,"
            "       thumbnail_url, questions_json"
            " FROM dbo.Stories WHERE story_id=? AND is_published=1",
            (row["story_id"],), fetch="one"
        )
        if story:
            raw = story.pop("vocab_json", None)
            try:
                story["vocab"] = json.loads(raw) if raw else []
            except (ValueError, TypeError):
                story["vocab"] = []
            # A reading quiz used to show a story and then ask the generic pool,
            # so a child could read about Sam the cat and be asked about a puppy.
            rawq = story.pop("questions_json", None)
            try:
                qs = json.loads(rawq) if rawq else []
                story["questions"] = qs if isinstance(qs, list) else []
            except (ValueError, TypeError):
                logging.warning("story %s has unparseable questions_json", story.get("story_id"))
                story["questions"] = []
            row["story"] = story
    return jsonify(row)


@content_bp.get("/worksheets")
def list_worksheets():
    subject      = request.args.get("subject")
    grade        = request.args.get("grade")
    lang         = request.args.get("language_id", "1")
    content_type = request.args.get("content_type")
    interest     = request.args.get("interest")
    level        = request.args.get("level")       # slug: warm-up | on-level | challenge
    trending     = request.args.get("trending")    # "true" → is_trending=1 only

    sql = ("SELECT w.worksheet_id, s.slug AS subject, w.grade_id, w.content_type, "
           "       w.interest_tag, dl.slug AS level_slug, w.title, w.description, "
           "       w.pdf_url, w.thumbnail_url, w.estimated_min, w.page_count, "
           "       w.view_count, w.rating_avg, w.rating_count, w.social_badge, "
           "       w.is_trending, w.teacher_name, w.is_free, w.pdf_generator_key, w.week_of, w.game_data, "
           "       w.video_url, w.steps_json, w.materials"
           " FROM dbo.Worksheets w"
           " JOIN dbo.Subjects s ON w.subject_id = s.subject_id"
           " JOIN dbo.DifficultyLevels dl ON w.difficulty_id = dl.level_id"
           " WHERE w.is_published=1 AND w.language_id=?")
    params = [lang]
    if subject:
        sql += " AND s.slug=?"
        params.append(subject)
    if grade:
        sql += " AND w.grade_id=?"
        params.append(int(grade))
    if content_type:
        sql += " AND w.content_type=?"
        params.append(content_type)
    if interest:
        sql += " AND w.interest_tag=?"
        params.append(interest)
    if level:
        sql += " AND dl.slug=?"
        params.append(level)
    if trending == "true":
        sql += " AND w.is_trending=1"
    if content_type == "weekly_packet":
        sql += " ORDER BY w.week_of ASC"
    else:
        sql += " ORDER BY w.is_trending DESC, w.view_count DESC, w.created_at DESC"

    rows = qry(sql, params)
    if rows:
        for r in rows:
            _decorate_worksheet(r)
        return jsonify(rows)

    # Dev-mode fallback filtering over the static seed mirror
    items = STATIC_LIBRARY
    if subject:
        items = [i for i in items if i["subject"] == subject]
    if grade is not None and grade != "":
        items = [i for i in items if i["grade_id"] == int(grade)]
    if content_type:
        items = [i for i in items if i["content_type"] == content_type]
    if interest:
        items = [i for i in items if i["interest_tag"] == interest]
    if level:
        items = [i for i in items if i["level_slug"] == level]
    if trending == "true":
        items = [i for i in items if i["is_trending"]]
    return jsonify(items)


@content_bp.get("/worksheets/<int:ws_id>/pdf")
def worksheet_pdf(ws_id: int):
    """Streams a real, on-the-fly generated PDF for catalog worksheets that
    have a pdf_generator_key instead of a manually-uploaded file."""
    import io
    from flask import send_file
    from services.worksheet_pdf_generator import generate as generate_pdf

    row = qry(
        "SELECT worksheet_id, title, pdf_generator_key, content_data, grade_id FROM dbo.Worksheets WHERE worksheet_id=?",
        (ws_id,), fetch="one"
    )
    if not row or not row.get("pdf_generator_key"):
        return jsonify({"error": "No generated PDF available for this worksheet"}), 404

    try:
        pdf_bytes = generate_pdf(row["pdf_generator_key"], row.get("content_data"),
                                 grade=row.get("grade_id"))
    except KeyError:
        return jsonify({"error": "Unknown PDF generator"}), 500
    except Exception as exc:
        return jsonify({"error": str(exc)}), 500

    safe_title = "".join(c if c.isalnum() else "_" for c in row["title"])[:60]
    return send_file(
        io.BytesIO(pdf_bytes),
        mimetype="application/pdf",
        as_attachment=False,
        download_name=f"LSH_{safe_title}.pdf"
    )


@content_bp.get("/practice-packet")
def get_practice_packet():
    """DB-driven weekly practice packet (pilot — Kindergarten Week 1).

    Composes a grade+week's packet from the PacketCategories/PacketQuestions
    bank via usp_GetOrCreateWeeklyPacket, which idempotently persists its
    category/question selection the first time a given (grade, week) is
    requested — repeat requests return the same content rather than
    re-shuffling. This is a separate pipeline from the pdf_generator_key /
    reportlab weekly-packet feature on Worksheets: content here is authored
    as rows in the DB and rendered by the frontend, not hardcoded in Python.
    """
    from datetime import datetime

    grade_id = request.args.get("grade", type=int)
    week_of_raw = request.args.get("week_of")
    if grade_id is None or not week_of_raw:
        return jsonify({"error": "grade and week_of are required"}), 400
    try:
        week_of = datetime.strptime(week_of_raw, "%Y-%m-%d").date()
    except ValueError:
        return jsonify({"error": "week_of must be YYYY-MM-DD"}), 400

    db = get_db()
    if db is None:
        return jsonify({"error": "Database unavailable"}), 503

    cur = db.cursor()
    try:
        cur.execute(
            # 3 categories per subject per week — the stored proc rotates
            # deterministically through each subject's category list (by
            # week number) so consecutive weeks show different categories
            # instead of the same full list every time. Subjects with 3 or
            # fewer categories total (writing, science, etc.) just show
            # everything every week since there's nothing to rotate.
            # @groups_per_week caps how many of the newer, non-always-on
            # subject_areas (sel, cognitive_skills, etc. — see
            # dbo.PacketSubjectAreas) are active in any given week, so
            # packets stay in the 30-50 question band as more subject
            # areas are added over time instead of firing all of them
            # every week.
            "EXEC dbo.usp_GetOrCreateWeeklyPacket @grade_id=?, @week_of=?, @categories_per_subject=?, @groups_per_week=?",
            (grade_id, week_of, 3, 3)
        )
    except Exception as exc:
        db.rollback()
        return jsonify({"error": str(exc)}), 500

    def rows_from(c):
        cols = [d[0] for d in c.description]
        return [dict(zip(cols, r)) for r in c.fetchall()]

    header_rows = rows_from(cur)
    cur.nextset()
    category_rows = rows_from(cur)
    cur.nextset()
    question_rows = rows_from(cur)
    db.commit()

    if not header_rows:
        return jsonify({"error": "Could not generate packet"}), 500

    categories = []
    cat_by_plan_cat_id = {}
    for c in sorted(category_rows, key=lambda r: r["sort_order"]):
        entry = {
            "category_id": c["category_id"],
            "category_name": c["category_name"],
            "subject_area": c["subject_area"],
            "layout_type": c["layout_type"],
            "intro_text": c.get("intro_text"),
            "questions": [],
        }
        cat_by_plan_cat_id[c["plan_cat_id"]] = entry
        categories.append(entry)

    for q in sorted(question_rows, key=lambda r: (r["plan_cat_id"], r["sort_order"])):
        entry = cat_by_plan_cat_id.get(q["plan_cat_id"])
        if not entry:
            continue
        choices = None
        if q.get("choices_json"):
            try:
                choices = json.loads(q["choices_json"])
            except (TypeError, ValueError):
                choices = None
        diagram = None
        if q.get("diagram_data"):
            try:
                diagram = json.loads(q["diagram_data"])
            except (TypeError, ValueError):
                diagram = None
        entry["questions"].append({
            "question_id": q["question_id"],
            "question_type": q["question_type"],
            "prompt": q["prompt"],
            "choices": choices,
            "answer": q["answer_text"],
            "diagram_type": q.get("diagram_type"),
            "diagram_data": diagram,
        })

    header = header_rows[0]
    return jsonify({
        "plan_id": header["plan_id"],
        "grade_id": header["grade_id"],
        "week_of": str(header["week_of"]),
        "title": header["title"],
        "categories": categories,
    })


@content_bp.get("/outdoor-games")
@require_admin
def outdoor_games_library():
    """Full Outdoor Games bank across every grade — admin-only reference
    view of the whole pool (see 68/69/70/71/82/83/84_outdoor_games_*.sql).
    Deliberately NOT exposed to parent/teacher/kid: they should only ever
    see the weekly-rotated 7-of-N subset for their own grade via
    /practice-packet (Weekly Packets), not the full library browsable on
    demand. (A brief attempt to open this route + add dedicated Outdoor
    Games pages to those three portals was reverted the same day.)
    Parses each question's structured prompt (built by each batch's
    gen_*.py build_prompt()) back into separate fields for the admin UI.
    'inspiration' (the 80s-games batch's "80s Inspiration:" line) is only
    present on games from 71_outdoor_games_retro80s_content.sql onward —
    empty string for earlier batches' games, which don't have that line."""
    rows = qry(
        "SELECT g.grade_id, g.label AS grade_label, q.prompt, q.answer_text, q.diagram_data "
        "FROM dbo.PacketQuestions q "
        "JOIN dbo.PacketCategories c ON c.category_id = q.category_id "
        "JOIN dbo.Grades g ON g.grade_id = c.grade_id "
        "WHERE c.category_name = 'Outdoor Games' AND q.is_active = 1 "
        "ORDER BY g.grade_id, q.sort_order",
        fetch="all"
    )

    inspiration_re = re.compile(r"^\d0s Inspiration:")

    games = []
    for r in rows:
        parts = (r["prompt"] or "").split("\n\n")
        name = parts[0].strip() if parts else ""
        inspiration, objective, materials, players, prerequisites = "", "", [], "", ""
        for part in parts[1:]:
            if inspiration_re.match(part):
                inspiration = part[part.index(":") + 1:].strip()
            elif part.startswith("Objective:"):
                objective = part[len("Objective:"):].strip()
            elif part.startswith("Players:"):
                players = part[len("Players:"):].strip()
            elif part.startswith("Prerequisites:"):
                prerequisites = part[len("Prerequisites:"):].strip()
            elif part.startswith("Materials:"):
                materials = [m.strip() for m in part[len("Materials:"):].strip().split(" | ") if m.strip()]

        steps = []
        if r.get("diagram_data"):
            try:
                steps = json.loads(r["diagram_data"]).get("steps", [])
            except (ValueError, TypeError):
                steps = []

        games.append({
            "grade_id": r["grade_id"],
            "grade_label": r["grade_label"],
            "name": name,
            "inspiration": inspiration,
            "objective": objective,
            "players": players,
            "prerequisites": prerequisites,
            "materials": materials,
            "steps": steps,
            "safety_tip": r["answer_text"],
        })

    return jsonify({"games": games})


@content_bp.post("/worksheets/print-batch")
@require_parent_or_admin
def print_batch():
    """Merges several worksheets into one PDF for a single print job —
    each catalog worksheet is either already a PDF (uploaded, or
    on-the-fly generated via pdf_generator_key) or, for image-based
    entries like Solar System photos, gets wrapped onto its own PDF page
    first so everything ends up in one combined document."""
    import io
    import requests as _requests
    from flask import send_file
    from pypdf import PdfReader, PdfWriter
    from services.worksheet_pdf_generator import generate as generate_pdf

    body = request.json or {}
    ids = body.get("worksheet_ids") or []
    if not isinstance(ids, list) or not ids:
        return jsonify({"error": "worksheet_ids required"}), 400
    ids = [int(i) for i in ids][:20]  # sane cap per print job

    placeholders = ",".join(["?"] * len(ids))
    rows = qry(
        f"SELECT worksheet_id, title, pdf_url, pdf_generator_key, content_data "
        f"FROM dbo.Worksheets WHERE worksheet_id IN ({placeholders})",
        ids
    ) or []
    rows_by_id = {r["worksheet_id"]: r for r in rows}

    writer = PdfWriter()
    skipped = []
    for wid in ids:
        row = rows_by_id.get(wid)
        if not row:
            skipped.append(wid)
            continue
        try:
            if row.get("pdf_generator_key"):
                pdf_bytes = generate_pdf(row["pdf_generator_key"], row.get("content_data"))
            elif row.get("pdf_url"):
                resp = _requests.get(row["pdf_url"], timeout=10)
                resp.raise_for_status()
                ctype = resp.headers.get("Content-Type", "")
                if "pdf" in ctype:
                    pdf_bytes = resp.content
                elif "image" in ctype:
                    from reportlab.pdfgen import canvas as _canvas
                    from reportlab.lib.pagesizes import letter as _letter
                    from PIL import Image as _PILImage
                    img = _PILImage.open(io.BytesIO(resp.content)).convert("RGB")
                    buf = io.BytesIO()
                    c = _canvas.Canvas(buf, pagesize=_letter)
                    iw, ih = img.size
                    max_w, max_h = 500, 650
                    scale = min(max_w / iw, max_h / ih)
                    w, h = iw * scale, ih * scale
                    c.drawInlineImage(img, (_letter[0] - w) / 2, (_letter[1] - h) / 2, width=w, height=h)
                    c.save()
                    pdf_bytes = buf.getvalue()
                else:
                    skipped.append(wid)
                    continue
            else:
                skipped.append(wid)
                continue
            for page in PdfReader(io.BytesIO(pdf_bytes)).pages:
                writer.add_page(page)
        except Exception:
            skipped.append(wid)

    if len(writer.pages) == 0:
        return jsonify({"error": "None of the selected worksheets could be prepared for printing"}), 400

    writer.add_metadata({"/Title": "Little Scholars Hub Worksheets", "/Author": "Little Scholars Hub"})
    out = io.BytesIO()
    writer.write(out)
    out.seek(0)
    resp = send_file(out, mimetype="application/pdf", as_attachment=False, download_name="LSH_worksheets.pdf")
    if skipped:
        resp.headers["X-Skipped-Ids"] = ",".join(str(i) for i in skipped)
    return resp


# ── Weekly Story Packs (ThemeWeeks) ───────────────────────────

@content_bp.get("/theme-weeks")
def list_theme_weeks():
    """Published story packs, optionally filtered by grade."""
    grade = request.args.get("grade")
    sql = (
        "SELECT tw.theme_week_id, tw.title, tw.theme_slug, tw.description, "
        "       tw.grade_id, tw.journal_prompt, tw.sort_order, "
        "       s.story_id, s.title AS story_title, s.read_min "
        "FROM dbo.ThemeWeeks tw "
        "LEFT JOIN dbo.Stories s ON tw.story_id = s.story_id "
        "WHERE tw.is_published=1"
    )
    params = []
    if grade:
        sql += " AND (tw.grade_id=? OR tw.grade_id IS NULL)"
        params.append(int(grade))
    sql += " ORDER BY tw.sort_order, tw.theme_week_id DESC"
    rows = qry(sql, params) or []
    return jsonify(rows)


@content_bp.get("/theme-weeks/<int:theme_week_id>")
def get_theme_week(theme_week_id: int):
    week = qry(
        "SELECT tw.theme_week_id, tw.title, tw.theme_slug, tw.description, "
        "       tw.grade_id, tw.journal_prompt, "
        "       s.story_id, s.title AS story_title, s.body_text AS story_body, "
        "       s.read_min, s.vocab_json, s.audio_url "
        "FROM dbo.ThemeWeeks tw "
        "LEFT JOIN dbo.Stories s ON tw.story_id = s.story_id "
        "WHERE tw.theme_week_id=? AND tw.is_published=1",
        (theme_week_id,), fetch="one"
    )
    if not week:
        return jsonify({"error": "Not found"}), 404

    if week.get("vocab_json") and isinstance(week["vocab_json"], str):
        try:
            week["vocab_json"] = json.loads(week["vocab_json"])
        except Exception:
            week["vocab_json"] = []

    week["worksheets"] = qry(
        "SELECT tww.role, ws.worksheet_id, ws.title, ws.pdf_url, ws.thumbnail_url, "
        "       ws.estimated_min, sub.slug AS subject, ws.pdf_generator_key "
        "FROM dbo.ThemeWeekWorksheets tww "
        "JOIN dbo.Worksheets ws ON tww.worksheet_id = ws.worksheet_id "
        "JOIN dbo.Subjects sub ON ws.subject_id = sub.subject_id "
        "WHERE tww.theme_week_id=? AND ws.is_published=1 "
        "ORDER BY tww.sort_order",
        (theme_week_id,)
    ) or []
    for w in week["worksheets"]:
        if not w.get("pdf_url") and w.get("pdf_generator_key"):
            w["pdf_url"] = request.url_root.rstrip("/") + f"/api/content/worksheets/{w['worksheet_id']}/pdf"

    return jsonify(week)


@content_bp.get("/interests")
def list_interests():
    return jsonify(STATIC_INTERESTS)


@content_bp.get("/levels")
def list_levels():
    rows = qry("SELECT level_id, slug, label FROM dbo.DifficultyLevels ORDER BY level_id")
    return jsonify(rows if rows else STATIC_LEVELS)


@content_bp.get("/featured")
def list_featured():
    rows = qry(
        "SELECT f.featured_id, f.worksheet_id, f.subtitle_override, f.sort_order, "
        "       w.title, w.content_type, w.thumbnail_url, w.grade_id, g.label AS grade_label, "
        "       s.slug AS subject "
        "FROM dbo.FeaturedCollections f "
        "JOIN dbo.Worksheets w ON f.worksheet_id = w.worksheet_id "
        "JOIN dbo.Grades g ON w.grade_id = g.grade_id "
        "JOIN dbo.Subjects s ON w.subject_id = s.subject_id "
        "WHERE f.is_active=1 "
        "  AND (f.starts_at IS NULL OR f.starts_at <= CAST(SYSUTCDATETIME() AS DATE)) "
        "  AND (f.ends_at   IS NULL OR f.ends_at   >= CAST(SYSUTCDATETIME() AS DATE)) "
        "ORDER BY f.sort_order"
    )
    if rows:
        return jsonify(rows)

    by_id = {i["worksheet_id"]: i for i in STATIC_LIBRARY}
    out = []
    for f in STATIC_FEATURED:
        item = by_id.get(f["worksheet_id"])
        if not item:
            continue
        out.append({
            "featured_id": f["featured_id"], "worksheet_id": f["worksheet_id"],
            "subtitle_override": f["subtitle_override"], "sort_order": f["sort_order"],
            "title": item["title"], "content_type": item["content_type"],
            "thumbnail_url": item["thumbnail_url"], "grade_id": item["grade_id"],
            "subject": item["subject"],
        })
    return jsonify(out)


@content_bp.post("/worksheets/<int:worksheet_id>/view")
def record_view(worksheet_id: int):
    qry("UPDATE dbo.Worksheets SET view_count = view_count + 1 WHERE worksheet_id=?",
        (worksheet_id,), fetch="exec")

    # Optional: award cross-subject achievement badges. This endpoint has no
    # auth (called from the public landing page too), so child_id is only
    # trusted enough for awarding a cosmetic badge — never for private data.
    body = request.json if request.is_json else {}
    child_id = (body or {}).get("child_id")
    if child_id:
        child_exists = qry("SELECT 1 FROM dbo.Children WHERE child_id=?", (child_id,), fetch="one")
        if child_exists:
            ws = qry(
                "SELECT w.content_type, w.language_id, s.is_cultural, f.language_id AS family_language_id "
                "FROM dbo.Worksheets w "
                "JOIN dbo.Subjects s ON w.subject_id = s.subject_id "
                "JOIN dbo.Children c ON c.child_id = ? "
                "JOIN dbo.Families f ON c.family_id = f.family_id "
                "WHERE w.worksheet_id=?",
                (child_id, worksheet_id), fetch="one"
            )
            if ws:
                evaluate_and_award(child_id, "worksheet_view", {
                    "is_cultural":        bool(ws["is_cultural"]),
                    "content_type":       ws["content_type"],
                    "language_switched":  ws["language_id"] != ws["family_language_id"],
                })

    return jsonify({"ok": True})


@content_bp.get("/story/today")
def story_today():
    grade = int(request.args.get("grade", 2))
    lang  = int(request.args.get("language_id", 1))

    story = qry(
        "SELECT TOP 1 story_id,grade_id,title,body_text,read_min,theme_tag,vocab_json,"
        "       audio_url,thumbnail_url,pdf_url,source_url,source_attribution"
        " FROM dbo.Stories"
        " WHERE grade_id<=? AND language_id=? AND is_published=1"
        " ORDER BY NEWID()",
        (grade, lang), fetch="one"
    )
    if not story:
        story = {
            "story_id": 1,
            "title": "Kai and the Dragon",
            "body_text": (
                "Once in a valley ringed by mountains lived a boy named Kai. "
                "Every morning he watched a silver dragon glide over the peaks. "
                "One day the dragon landed beside him. 'I have flown ten thousand miles,' "
                "said the dragon, 'but never found a child so curious.' "
                "Kai smiled. 'Where do you go?' 'Everywhere learning begins,' the dragon answered. "
                "From that day, Kai read one page before sunrise — and the dragon always circled to check."
            ),
            "read_min": 5,
            "theme_tag": "chinese_culture",
            "vocab_json": json.dumps([{"word":"curious","definition":"eager to learn or know things"}]),
            "audio_url": None,
        }
    if story.get("vocab_json") and isinstance(story["vocab_json"], str):
        try:
            story["vocab_json"] = json.loads(story["vocab_json"])
        except Exception:
            story["vocab_json"] = []
    return jsonify(story)


@content_bp.get("/stories/library")
@require_parent_or_admin
def stories_library():
    """All published mini-stories a parent can browse and assign to a
    child — distinct from /story/today's single random daily pick.
    When child_id is given, each row also reports whether — and when —
    this family already assigned it to that child, plus how many times
    this family has assigned it in total (to any child)."""
    grade    = request.args.get("grade")
    lang     = int(request.args.get("language_id", 1))
    child_id = request.args.get("child_id")

    if child_id and not _verify_child(int(child_id), g.family_id):
        return jsonify({"error": "Child not found"}), 404

    sql = (
        "SELECT st.story_id, st.grade_id, st.title, st.read_min, st.theme_tag, "
        "       st.thumbnail_url, st.audio_url, st.pdf_url, "
        "       (SELECT COUNT(*) FROM dbo.StudentAssignments sa "
        "        WHERE sa.story_id = st.story_id AND sa.family_id = ?) AS times_assigned, "
        "       cur.assignment_id AS current_assignment_id, "
        "       cur.assigned_at AS current_assigned_at, "
        "       cur.completed_at AS current_completed_at "
        "FROM dbo.Stories st "
        "OUTER APPLY ("
        "   SELECT TOP 1 assignment_id, assigned_at, completed_at "
        "   FROM dbo.StudentAssignments "
        "   WHERE story_id = st.story_id AND family_id = ? AND child_id = ? "
        "   ORDER BY assigned_at DESC"
        ") cur "
        "WHERE st.language_id=? AND st.is_published=1"
    )
    params = [g.family_id, g.family_id, int(child_id) if child_id else 0, lang]
    if grade is not None and grade != "":
        sql += " AND st.grade_id<=?"
        params.append(int(grade))
    sql += " ORDER BY st.grade_id, st.title"

    rows = qry(sql, params) or []
    return jsonify(rows)


@content_bp.post("/classrooms/join")
@require_parent_or_admin
def join_classroom():
    body     = request.json or {}
    child_id = body.get("child_id")
    code     = (body.get("classroom_code") or "").strip().upper()
    if not child_id or not code:
        return jsonify({"error": "child_id and classroom_code required"}), 400
    if not _verify_child(child_id, g.family_id):
        return jsonify({"error": "Child not found"}), 404

    classroom = qry(
        "SELECT classroom_id, classroom_name FROM dbo.Classrooms WHERE classroom_code=? AND is_active=1",
        (code,), fetch="one"
    )
    if not classroom:
        return jsonify({"error": "Invalid classroom code"}), 404

    existing = qry(
        "SELECT 1 FROM dbo.StudentClassroomLink WHERE child_id=? AND classroom_id=?",
        (child_id, classroom["classroom_id"]), fetch="one"
    )
    if existing:
        return jsonify({"error": "Already joined this classroom"}), 409

    qry("INSERT INTO dbo.StudentClassroomLink (child_id, classroom_id) VALUES (?,?)",
        (child_id, classroom["classroom_id"]), fetch="exec")
    return jsonify({
        "ok": True,
        "classroom_id":   classroom["classroom_id"],
        "classroom_name": classroom["classroom_name"],
    }), 201


@content_bp.get("/assignments")
@require_parent_or_admin
def get_assignments():
    child_id = request.args.get("child_id")
    if not child_id:
        return jsonify({"error": "child_id required"}), 400
    child_id = int(child_id)
    if not _verify_child(child_id, g.family_id):
        return jsonify({"error": "Child not found"}), 404

    rows = qry(
        "SELECT a.assignment_id, a.classroom_id, cl.classroom_name, a.worksheet_id, a.story_id, "
        "       COALESCE(w.title, st.title) AS worksheet_title, "
        "       w.pdf_url, COALESCE(w.thumbnail_url, st.thumbnail_url) AS thumbnail_url, "
        "       CASE WHEN a.story_id IS NOT NULL THEN 'mini_story' ELSE w.content_type END AS content_type, "
        "       st.body_text AS story_body_text, st.audio_url AS story_audio_url, st.read_min AS story_read_min, "
        "       st.pdf_url AS story_pdf_url, w.game_data, "
        "       a.note, a.assigned_at, a.completed_at, "
        "       CASE WHEN a.classroom_id IS NOT NULL THEN 'teacher' ELSE 'parent' END AS source "
        "FROM dbo.StudentAssignments a "
        "LEFT JOIN dbo.Classrooms cl ON a.classroom_id = cl.classroom_id "
        "LEFT JOIN dbo.Worksheets w ON a.worksheet_id = w.worksheet_id "
        "LEFT JOIN dbo.Stories st ON a.story_id = st.story_id "
        "WHERE (a.family_id = ? AND a.child_id = ?) "
        "   OR (a.classroom_id IS NOT NULL AND (a.child_id = ? OR a.child_id IS NULL) "
        "       AND EXISTS (SELECT 1 FROM dbo.StudentClassroomLink scl "
        "                   WHERE scl.classroom_id = a.classroom_id AND scl.child_id = ?)) "
        "ORDER BY a.assigned_at DESC",
        (g.family_id, child_id, child_id, child_id)
    ) or []
    return jsonify(rows)


@content_bp.post("/assignments")
@require_parent_or_admin
def create_assignment():
    """Parent assigns a worksheet OR a mini-story directly to their own
    child (no teacher/classroom involved) — exactly one of worksheet_id /
    story_id is expected."""
    body        = request.json or {}
    child_id    = body.get("child_id")
    worksheet_id = body.get("worksheet_id")
    story_id     = body.get("story_id")
    note        = (body.get("note") or "").strip() or None

    if not child_id or (not worksheet_id and not story_id):
        return jsonify({"error": "child_id and either worksheet_id or story_id required"}), 400
    if not _verify_child(int(child_id), g.family_id):
        return jsonify({"error": "Child not found"}), 404

    if story_id:
        story = qry("SELECT story_id FROM dbo.Stories WHERE story_id=? AND is_published=1",
                     (story_id,), fetch="one")
        if not story:
            return jsonify({"error": "Story not found"}), 404
        row = qry(
            "INSERT INTO dbo.StudentAssignments (classroom_id, family_id, child_id, story_id, note) "
            "OUTPUT INSERTED.assignment_id AS assignment_id "
            "VALUES (NULL, ?, ?, ?, ?)",
            (g.family_id, child_id, story_id, note), fetch="one"
        )
    else:
        worksheet = qry("SELECT worksheet_id FROM dbo.Worksheets WHERE worksheet_id=? AND is_published=1",
                         (worksheet_id,), fetch="one")
        if not worksheet:
            return jsonify({"error": "Worksheet not found"}), 404
        row = qry(
            "INSERT INTO dbo.StudentAssignments (classroom_id, family_id, child_id, worksheet_id, note) "
            "OUTPUT INSERTED.assignment_id AS assignment_id "
            "VALUES (NULL, ?, ?, ?, ?)",
            (g.family_id, child_id, worksheet_id, note), fetch="one"
        )
    if row:
        get_db().commit()
    return jsonify({"ok": True, "assignment_id": row["assignment_id"]}), 201


@content_bp.delete("/assignments/<int:assignment_id>")
@require_parent_or_admin
def delete_assignment(assignment_id: int):
    """Parent removes a worksheet they assigned themselves. Teacher-issued
    assignments (classroom_id set) cannot be removed from this endpoint."""
    row = qry(
        "SELECT assignment_id FROM dbo.StudentAssignments WHERE assignment_id=? AND family_id=?",
        (assignment_id, g.family_id), fetch="one"
    )
    if not row:
        return jsonify({"error": "Assignment not found"}), 404

    qry("DELETE FROM dbo.StudentAssignments WHERE assignment_id=?", (assignment_id,), fetch="exec")
    return jsonify({"ok": True})


ALLOWED_WORKSHEET_UPLOAD_MIME = {
    "application/pdf", "image/jpeg", "image/png", "image/webp", "image/heic", "image/heif",
}
MAX_WORKSHEET_UPLOAD_BYTES = 15 * 1024 * 1024  # 15MB


@content_bp.post("/worksheets/upload")
@require_parent_or_admin
def upload_worksheet():
    """Parent uploads their own worksheet file (PDF or image) and assigns it
    straight to one of their children. Stored privately (is_published=0,
    owner_family_id set) — never shown in the public worksheet catalog."""
    f = request.files.get("file")
    if not f or not f.filename:
        return jsonify({"error": "No file provided"}), 400
    mime = f.mimetype or "application/octet-stream"
    if mime not in ALLOWED_WORKSHEET_UPLOAD_MIME:
        return jsonify({"error": "Only PDF or image files (jpg/png/webp/heic) are allowed"}), 400
    data = f.read()
    if not data:
        return jsonify({"error": "File is empty"}), 400
    if len(data) > MAX_WORKSHEET_UPLOAD_BYTES:
        return jsonify({"error": "File exceeds 15MB limit"}), 400

    child_id = request.form.get("child_id", type=int)
    if not child_id:
        return jsonify({"error": "child_id required"}), 400
    if not _verify_child(child_id, g.family_id):
        return jsonify({"error": "Child not found"}), 404

    title = (request.form.get("title") or f.filename).strip()[:200]
    note = (request.form.get("note") or "").strip() or None
    subject_id = request.form.get("subject_id", type=int) or 6  # default: workbooks
    grade_row = qry("SELECT grade_id FROM dbo.Children WHERE child_id=?", (child_id,), fetch="one")
    grade_id = grade_row["grade_id"] if grade_row else 2

    file_row = qry(
        "INSERT INTO dbo.UploadedFiles (filename, mime_type, file_size, data, uploaded_by) "
        "OUTPUT INSERTED.file_id AS file_id "
        "VALUES (?,?,?,?,?)",
        (f.filename, mime, len(data), data, g.family_id), fetch="one"
    )
    if file_row:
        get_db().commit()
    pdf_url = request.url_root.rstrip("/") + f"/api/content/files/{file_row['file_id']}"

    ws_row = qry(
        "INSERT INTO dbo.Worksheets "
        "  (subject_id, grade_id, title, pdf_url, is_published, content_type, owner_family_id) "
        "OUTPUT INSERTED.worksheet_id AS worksheet_id "
        "VALUES (?,?,?,?,0,'worksheet',?)",
        (subject_id, grade_id, title, pdf_url, g.family_id), fetch="one"
    )
    if ws_row:
        get_db().commit()
    worksheet_id = ws_row["worksheet_id"]

    assign_row = qry(
        "INSERT INTO dbo.StudentAssignments (classroom_id, family_id, child_id, worksheet_id, note) "
        "OUTPUT INSERTED.assignment_id AS assignment_id "
        "VALUES (NULL, ?, ?, ?, ?)",
        (g.family_id, child_id, worksheet_id, note), fetch="one"
    )
    if assign_row:
        get_db().commit()

    return jsonify({
        "ok": True,
        "worksheet_id": worksheet_id,
        "assignment_id": assign_row["assignment_id"],
        "pdf_url": pdf_url,
    }), 201


@content_bp.put("/assignments/<int:assignment_id>/complete")
@require_parent_or_admin
def complete_assignment(assignment_id: int):
    body     = request.json or {}
    child_id = body.get("child_id")
    if not child_id:
        return jsonify({"error": "child_id required"}), 400
    if not _verify_child(child_id, g.family_id):
        return jsonify({"error": "Child not found"}), 404

    # Only per-child assignment rows track completion in v1; broadcast
    # (child_id IS NULL, whole-class) rows have no per-child completions table yet.
    assignment = qry(
        "SELECT assignment_id FROM dbo.StudentAssignments WHERE assignment_id=? AND child_id=?",
        (assignment_id, child_id), fetch="one"
    )
    if not assignment:
        return jsonify({"error": "Assignment not found for this child"}), 404

    # Guard against double-awarding coins if this is called again on an
    # already-completed assignment (e.g. a duplicate click/request).
    already_done = qry(
        "SELECT 1 FROM dbo.StudentAssignments WHERE assignment_id=? AND completed_at IS NOT NULL",
        (assignment_id,), fetch="one"
    )

    qry("UPDATE dbo.StudentAssignments SET completed_at=SYSUTCDATETIME() WHERE assignment_id=?",
        (assignment_id,), fetch="exec")

    if not already_done:
        from services.gamification_service import award_xp
        award_xp(child_id, xp=15, coins=10)

    return jsonify({"ok": True})


# Default source_track per language_id when the caller doesn't pin one —
# see 70/71_*.sql: language 1 (English) used to hard-default to 'gita'
# here regardless of the caller's language, so an English-home family's
# dashboard opened on Bhagavad Gita scripture. 'gita' stays the correct
# default for Hindi (language 3) — it's one of the three cultural tracks
# families choose on purpose, not a fallback.
_DEFAULT_WISDOM_TRACK = {1: "universal", 2: "chinese", 3: "gita", 4: "hispanic"}


@content_bp.get("/wisdom/today")
def wisdom_today():
    from datetime import date
    lang  = int(request.args.get("language_id", 1))
    # The daily wisdom follows the family's home language unless a caller asks
    # for a specific track. This used to default to "gita" for everyone, so a
    # family who chose English opened their dashboard to Bhagavad Gita
    # scripture as the first block on the page. The Indian track is still there
    # -- it is one of the three cultural tracks families pick on purpose -- it
    # is simply no longer what English defaults to.
    track = request.args.get("track") or _DEFAULT_WISDOM_TRACK.get(lang, "universal")

    # Day-of-year rotation: same verse for everyone on the same calendar day
    day_of_year = date.today().timetuple().tm_yday

    count = qry(
        "SELECT COUNT(*) FROM dbo.DailyWisdom WHERE language_id=? AND source_track=?",
        (lang, track), fetch="scalar"
    ) or 0

    if count:
        offset = (day_of_year - 1) % count
        row = qry(
            "SELECT text_original, text_english, author, source_track, image_url "
            "FROM dbo.DailyWisdom WHERE language_id=? AND source_track=? "
            "ORDER BY wisdom_id "
            "OFFSET ? ROWS FETCH NEXT 1 ROWS ONLY",
            (lang, track, offset), fetch="one"
        )
        if row:
            return jsonify(row)

    # Nothing on the preferred track in this language. The cultural pools are
    # not all stored per-language -- the Gita rows, for instance, live under
    # language_id 1 with English text -- so try the same track in English
    # before giving up on it. A Hindi-speaking family should still get the
    # Gita rather than the generic pool.
    row = None
    if lang != 1:
        row = qry(
            "SELECT TOP 1 text_original, text_english, author, source_track, image_url "
            "FROM dbo.DailyWisdom WHERE language_id=1 AND source_track=? "
            "ORDER BY NEWID()",
            (track,), fetch="one"
        )

    # Then any track in this language, then the English pool.
    if not row:
        row = qry(
            "SELECT TOP 1 text_original, text_english, author, source_track, image_url "
            "FROM dbo.DailyWisdom WHERE language_id=? ORDER BY NEWID()",
            (lang,), fetch="one"
        )
    if not row and lang != 1:
        row = qry(
            "SELECT TOP 1 text_original, text_english, author, source_track, image_url "
            "FROM dbo.DailyWisdom WHERE language_id=1 AND source_track='universal' "
            "ORDER BY NEWID()",
            fetch="one"
        )
    import random
    return jsonify(row if row else random.choice(STATIC_WISDOM))
