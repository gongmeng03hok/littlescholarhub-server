"""
services/plan_builder.py
Builds a personalised weekly study plan from assessment answers.
Ported from the reference site's buildPlan() JavaScript function.
"""

from datetime import datetime


GRADE_ORDER = ["TK", "K", "1", "2", "3", "4", "5", "6"]

_HOMESCHOOL_MINS  = [90, 120, 150, 180, 210, 240, 270, 300]
_AFTERSCHOOL_MINS = [20,  25,  30,  35,  45,  50,  60,  60]
_EXPLORE_MINS     = [15,  20,  25,  30,  35,  40,  45,  45]

_SUBJECT_META = {
    "reading":  {"label": "Reading",               "icon": "📖", "color": "#5d7a96"},
    "math":     {"label": "Math",                  "icon": "🧮", "color": "#6d8466"},
    "writing":  {"label": "Writing & Spelling",    "icon": "✏️", "color": "#d8785f"},
    "science":  {"label": "Science",               "icon": "🔬", "color": "#847695"},
    "art":      {"label": "Art & Creativity",      "icon": "🎨", "color": "#c08a7e"},
    "story":    {"label": "Story Activity",        "icon": "🐉", "color": "#9a7f3a"},
    "logic":    {"label": "Logic & Critical Thinking", "icon": "🧩", "color": "#4f6b8a"},
    "emotions": {"label": "Feelings & Emotions",   "icon": "💛", "color": "#b08a95"},
    "manners":  {"label": "Character & Manners",   "icon": "🌱", "color": "#8f9c7e"},
    "pinyin":   {"label": "Pinyin",                "icon": "🏮", "color": "#c4745a"},
    "hanzi":    {"label": "汉字 Hanzi",             "icon": "🏮", "color": "#c4745a"},
    "tangshi":  {"label": "唐诗 Tang Poems",        "icon": "📜", "color": "#9a7f3a"},
    "gita":     {"label": "Gita Stories",          "icon": "🪔", "color": "#b08a95"},
    "letras":   {"label": "Letras",                "icon": "🌻", "color": "#6d8466"},
    "fiestas":  {"label": "Fiestas",               "icon": "🎉", "color": "#c08a7e"},
}

_INTEREST_LABELS = {
    "animals": "Animals & pets", "space": "Space & planets",
    "ocean": "Ocean & sea creatures", "building": "Building & inventing",
    "sports": "Sports & movement", "art": "Art & music",
    "mystery": "Mysteries & puzzles", "nature": "Nature & plants",
    "food": "Food & cooking", "dragons": "Dragons & magic",
}
_INTEREST_EMOS = {
    "animals": "🐶", "space": "🚀", "ocean": "🐙", "building": "🔧",
    "sports": "⚽", "art": "🎨", "mystery": "🔎", "nature": "🌿",
    "food": "🍪", "dragons": "🐉",
}
_GRADE_LABELS = {
    "TK": "Transitional Kindergarten", "K": "Kindergarten",
    "1": "1st grade", "2": "2nd grade", "3": "3rd grade",
    "4": "4th grade", "5": "5th grade", "6": "6th grade",
}
_LANG_LABELS = {
    "en": "English", "zh": "English + 中文",
    "hi": "English + हिन्दी", "es": "English + Español",
}
_GOAL_LABELS = {
    "catchup": "Catch up", "enrich": "Enrich",
    "accelerate": "Accelerate", "confidence": "Build confidence",
}


def _subject_notes(answers: dict) -> dict:
    reading  = answers.get("reading",  "early")
    spelling = answers.get("spelling", "onlevel")
    math     = answers.get("math",     "onlevel")
    science  = answers.get("science",  "sometimes")
    art      = answers.get("art",      "okay")
    logic    = answers.get("logic",    "enjoys")
    emotions = answers.get("emotions", "learning")
    manners  = answers.get("manners",  "growing")
    return {
        "reading":  "Advanced passages + inference"    if reading == "novel"        else ("Phonics & sight words"            if reading == "pre"      else "Leveled passages + comprehension"),
        "math":     "Confidence builders + bar models" if math == "struggling"      else ("Enrichment + challenge problems"   if math == "ahead"       else "Spiral review + fluency"),
        "writing":  "Phonics spelling ladder"          if spelling == "struggling"  else "Composition + handwriting",
        "science":  "Weekly experiments + nature journal" if science == "constantly" else "Curious-kid intro series",
        "art":      "Studio-style projects"            if art == "loves"            else "15-min quick makes",
        "story":    "Story-of-the-day tailored to their interest",
        "logic":    "Olympiad-style puzzles + chess challenges" if logic == "loves" else ("Gentle pattern + sequence starters" if logic == "new" else "Logic grids, pattern puzzles, chess mini-lessons"),
        "emotions": "Feelings wheel + calm-down cards" if emotions == "overwhelmed" else ("Empathy scenarios + conflict resolution" if emotions == "confident" else "Name-it-to-tame-it journaling + big-emotion stories"),
        "manners":  "Please/thank-you, table manners, greeting practice" if manners == "foundational" else ("Leadership, empathy, values-in-action stories" if manners == "strong" else "Friendship scripts, kindness challenges, cultural traditions"),
        "pinyin":   "Tones + syllables → reading pinyin fluently",
        "hanzi":    "Character recognition + stroke order",
        "tangshi":  "Classic poem recitation + meaning",
        "gita":     "Gita stories + moral reflection",
        "letras":   "Alphabet + phonics in Spanish",
        "fiestas":  "Cultural celebrations + vocabulary",
    }


def _about_child(answers: dict, grade_str: str) -> dict:
    age      = answers.get("age")
    interest = answers.get("interest", "")
    language = answers.get("language", "en")
    goal     = answers.get("goal", "enrich")
    return {
        "age":      (str(age) + " years old") if age else "Age not set",
        "grade":    _GRADE_LABELS.get(grade_str, grade_str + "th grade"),
        "interest": (_INTEREST_EMOS.get(interest, "") + " " + _INTEREST_LABELS.get(interest, "Not set")).strip() or "Not set — we'll pick a mix",
        "language": _LANG_LABELS.get(language, "English"),
        "goal":     _GOAL_LABELS.get(goal, "Balanced growth"),
    }


def build_weekly_plan(answers: dict, grade: int) -> dict:
    # ── Grade ──────────────────────────────────────────────────────────────────
    grade_str = str(answers.get("grade", grade))
    grade_idx = GRADE_ORDER.index(grade_str) if grade_str in GRADE_ORDER else min(int(grade), 7)

    # ── Daily minutes ──────────────────────────────────────────────────────────
    program = answers.get("program", "afterschool")
    if program == "homeschool":
        base_mins = _HOMESCHOOL_MINS[grade_idx]
    elif program == "afterschool":
        base_mins = _AFTERSCHOOL_MINS[grade_idx]
    else:
        base_mins = _EXPLORE_MINS[grade_idx]

    time_val = str(answers.get("time", "")).strip()
    daily_min    = min(base_mins, int(time_val)) if time_val.isdigit() else base_mins
    study_days   = int(answers.get("days", 5))
    weekly_min   = daily_min * study_days
    sessions_day = 3 if daily_min >= 60 else (2 if daily_min >= 30 else 1)

    # ── Subject weights ────────────────────────────────────────────────────────
    w = {"reading": 18, "math": 20, "writing": 10, "science": 8,
         "art": 7, "story": 10, "logic": 14, "emotions": 7, "manners": 6}

    def bump(k, amt): w[k] = w.get(k, 0) + amt

    reading  = answers.get("reading",  "early")
    spelling = answers.get("spelling", "onlevel")
    math     = answers.get("math",     "onlevel")
    science  = answers.get("science",  "sometimes")
    art      = answers.get("art",      "okay")
    logic    = answers.get("logic",    "enjoys")
    emotions = answers.get("emotions", "learning")
    manners  = answers.get("manners",  "growing")

    if reading in ("pre", "early"):     bump("reading", 10)
    if spelling == "struggling":         bump("writing", 8)
    if math == "struggling":             bump("math", 10)
    elif math == "ahead":                bump("math", 5)
    if science == "constantly":          bump("science", 7)
    if art == "loves":                   bump("art", 5)
    if logic == "loves":                 bump("logic", 10)
    elif logic == "enjoys":              bump("logic", 5)
    if emotions == "overwhelmed":        bump("emotions", 8)
    elif emotions == "learning":         bump("emotions", 4)
    if manners == "foundational":        bump("manners", 6)
    elif manners == "growing":           bump("manners", 3)

    focus = answers.get("focus", "")
    if focus: bump(focus, 10)

    goal = answers.get("goal", "enrich")
    if goal == "catchup":    bump("reading", 5);  bump("math", 5)
    elif goal == "accelerate": bump("math", 5);   bump("logic", 5);  bump("science", 5)
    elif goal == "confidence": bump("emotions", 4); bump("manners", 3)

    # ── Cultural tracks ────────────────────────────────────────────────────────
    language = answers.get("language", "en")
    if language == "zh":   w["pinyin"] = 15;  w["hanzi"] = 12;  w["tangshi"] = 10
    elif language == "hi": w["gita"]   = 15
    elif language == "es": w["letras"] = 15;  w["fiestas"] = 10

    # ── Allocate real sessions across the week ─────────────────────────────────
    # Previously the daily budget was divided across every subject at once, with
    # a 1-3 minute floor. A TK child on 20 min/day therefore "did" nine subjects
    # a day and the reveal screen read "Art & Creativity - 1 min/day" directly
    # above the note "15-min quick makes". Children do not study nine subjects
    # in twenty minutes; they do two or three and the rest come round later in
    # the week. So we budget whole sessions over the week instead, and a subject
    # that cannot earn one is named as rotating in rather than shown at 1 min.
    session_min    = 10 if grade_idx <= 2 else 15
    weekly_budget  = daily_min * study_days
    total_sessions = max(1, weekly_budget // session_min)

    ranked  = sorted(w.items(), key=lambda kv: kv[1], reverse=True)
    total_w = sum(w.values()) or 1

    # Largest-remainder apportionment, capped at one session per subject per
    # study day so a single subject cannot swallow the whole week.
    exact     = {k: (v / total_w) * total_sessions for k, v in ranked}
    sessions  = {k: min(int(x), study_days) for k, x in exact.items()}
    remaining = total_sessions - sum(sessions.values())
    for k, _ in sorted(exact.items(), key=lambda kv: kv[1] - int(kv[1]), reverse=True):
        if remaining <= 0:
            break
        if sessions[k] < study_days:
            sessions[k] += 1
            remaining   -= 1

    # Anything that earned nothing rotates in when the week gets longer.
    rotates_in = [k for k, n in sessions.items() if n == 0]
    sessions   = {k: n for k, n in sessions.items() if n > 0}

    # `alloc` is now minutes *per week* for each subject that is actually in it.
    alloc = {k: n * session_min for k, n in sessions.items()}

    # ── Subjects array (sorted desc) with notes ────────────────────────────────
    notes = _subject_notes(answers)
    subjects = sorted([
        {
            "key":     k,
            "label":   _SUBJECT_META.get(k, {}).get("label",  k.title()),
            "icon":    _SUBJECT_META.get(k, {}).get("icon",   "📚"),
            "color":   _SUBJECT_META.get(k, {}).get("color",  "#888"),
            "minutes":           mins,          # minutes per week
            "sessions_per_week": sessions[k],
            "session_min":       session_min,
            "note":              notes.get(k, ""),
        }
        for k, mins in alloc.items()
    ], key=lambda x: x["minutes"], reverse=True)

    # ── 5-day schedule ─────────────────────────────────────────────────────────
    days_list  = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    active_days = days_list[:max(1, min(5, study_days))]
    schedule    = {day: [] for day in days_list}
    idx = 0
    for subj in subjects:
        # Spread a subject's sessions across different days rather than stacking
        # them, so no single day is all one subject.
        for _ in range(subj["sessions_per_week"]):
            schedule[active_days[idx % len(active_days)]].append({
                "subject": subj["key"], "slug": subj["key"],
                "minutes": session_min, "label": subj["label"],
            })
            idx += 1

    # ── Plan kind label ────────────────────────────────────────────────────────
    kind = ("Homeschool plan · personalized" if program == "homeschool"
            else "Starter exploration plan" if program == "explore"
            else "Afterschool plan · personalized")

    return {
        "grade":            grade_idx,
        "grade_label":      grade_str,
        "program":          program,
        "kind":             kind,
        "daily_min":        daily_min,
        "weekly_min":       weekly_min,
        "weekly_hrs":       round(weekly_min / 60, 1),
        "study_days":       study_days,
        "sessions_per_day": sessions_day,
        "session_min":        session_min,
        "sessions_total":     sum(sessions.values()),
        "rotates_in":         rotates_in,
        "subject_allocation": alloc,   # minutes per week
        "subjects":         subjects,
        "about":            _about_child(answers, grade_str),
        "schedule":         schedule,
        "generated_at":     datetime.utcnow().isoformat(),
    }
