"""
Fixes emoji stored as ?? in AssessmentQuestions.options_json
by re-sending data via parameterized queries (ensure_ascii=False).
"""
import pyodbc, json

CONN_STR = (
    "DRIVER={ODBC Driver 18 for SQL Server};"
    "SERVER=94.72.121.94,1433;"
    "DATABASE=LittleScholarHub;"
    "UID=SA;PWD=Password123!;"
    "TrustServerCertificate=yes;Encrypt=yes;"
)

QUESTIONS = [
    {"step_key": "age", "options": [
        {"v": "4",  "label": "4 years old",  "emo": "🧸"},
        {"v": "5",  "label": "5 years old",  "emo": "🎈"},
        {"v": "6",  "label": "6 years old",  "emo": "🪁"},
        {"v": "7",  "label": "7 years old",  "emo": "🚲"},
        {"v": "8",  "label": "8 years old",  "emo": "⚽"},
        {"v": "9",  "label": "9 years old",  "emo": "🎸"},
        {"v": "10", "label": "10 years old", "emo": "🔬"},
        {"v": "11", "label": "11 years old", "emo": "🎨"},
        {"v": "12", "label": "12 years old", "emo": "📚"},
    ]},
    {"step_key": "grade", "options": [
        {"v": "TK", "label": "Transitional Kindergarten"},
        {"v": "K",  "label": "Kindergarten"},
        {"v": "1",  "label": "1st grade"},
        {"v": "2",  "label": "2nd grade"},
        {"v": "3",  "label": "3rd grade"},
        {"v": "4",  "label": "4th grade"},
        {"v": "5",  "label": "5th grade"},
        {"v": "6",  "label": "6th grade"},
    ]},
    {"step_key": "program", "options": [
        {"v": "afterschool", "label": "Afterschool enrichment",       "emo": "🌇"},
        {"v": "homeschool",  "label": "Homeschool (main curriculum)", "emo": "🏠"},
        {"v": "explore",     "label": "Just exploring for now",       "emo": "🔍"},
    ]},
    {"step_key": "math", "options": [
        {"v": "struggling", "label": "Struggling — needs to build confidence", "emo": "🌱"},
        {"v": "onlevel",    "label": "Right on grade level",                  "emo": "✅"},
        {"v": "ahead",      "label": "Ahead — ready for more challenge",       "emo": "🚀"},
    ]},
    {"step_key": "spelling", "options": [
        {"v": "struggling", "label": "Reverses letters or guesses at words", "emo": "🌱"},
        {"v": "onlevel",    "label": "Spells most grade-level words",        "emo": "✅"},
        {"v": "ahead",      "label": "Spells accurately beyond grade",       "emo": "🚀"},
    ]},
    {"step_key": "reading", "options": [
        {"v": "pre",     "label": "Pre-reader — knows some letters",       "emo": "🔤"},
        {"v": "early",   "label": "Reads short sentences / sight words",   "emo": "📖"},
        {"v": "chapter", "label": "Reads early chapter books",             "emo": "📚"},
        {"v": "novel",   "label": "Reads novels independently",            "emo": "📕"},
    ]},
    {"step_key": "science", "options": [
        {"v": "sparingly",  "label": "Not really — not their thing yet",         "emo": "💭"},
        {"v": "sometimes",  "label": "Sometimes — sparks of curiosity",          "emo": "🔎"},
        {"v": "constantly", "label": "Constantly asks 'why' about everything",   "emo": "🔬"},
    ]},
    {"step_key": "art", "options": [
        {"v": "avoids", "label": "Avoids it",             "emo": "🎭"},
        {"v": "okay",   "label": "Enjoys it sometimes",   "emo": "🖍️"},
        {"v": "loves",  "label": "Draws or builds daily", "emo": "🎨"},
    ]},
    {"step_key": "logic", "options": [
        {"v": "new",    "label": "Haven't tried much",               "emo": "🌱"},
        {"v": "enjoys", "label": "Enjoys a good puzzle",             "emo": "🧩"},
        {"v": "loves",  "label": "Loves them — give more challenge", "emo": "♟️"},
    ]},
    {"step_key": "emotions", "options": [
        {"v": "overwhelmed", "label": "Gets overwhelmed often",      "emo": "🌧️"},
        {"v": "learning",    "label": "Learning to name feelings",   "emo": "💛"},
        {"v": "confident",   "label": "Calm and articulate",         "emo": "🌈"},
    ]},
    {"step_key": "manners", "options": [
        {"v": "foundational", "label": "We're building the basics",        "emo": "🌱"},
        {"v": "growing",      "label": "Going well — keep reinforcing",    "emo": "🌿"},
        {"v": "strong",       "label": "Strong — ready for deeper values", "emo": "🌳"},
    ]},
    {"step_key": "interest", "options": [
        {"v": "animals",  "label": "Animals & pets",        "emo": "🐶"},
        {"v": "space",    "label": "Space & planets",        "emo": "🚀"},
        {"v": "ocean",    "label": "Ocean & sea creatures",  "emo": "🐙"},
        {"v": "building", "label": "Building & inventing",   "emo": "🔧"},
        {"v": "sports",   "label": "Sports & movement",      "emo": "⚽"},
        {"v": "art",      "label": "Art & music",            "emo": "🎨"},
        {"v": "mystery",  "label": "Mysteries & puzzles",    "emo": "🔎"},
        {"v": "nature",   "label": "Nature & plants",        "emo": "🌿"},
        {"v": "food",     "label": "Food & cooking",         "emo": "🍪"},
        {"v": "dragons",  "label": "Dragons & magic",        "emo": "🐉"},
    ]},
    {"step_key": "style", "options": [
        {"v": "video", "label": "Short videos & demos", "emo": "▶️"},
        {"v": "print", "label": "Worksheets & books",   "emo": "📝"},
        {"v": "story", "label": "Hearing stories",      "emo": "📖"},
        {"v": "hands", "label": "Hands-on projects",    "emo": "🧩"},
    ]},
    {"step_key": "time", "options": [
        {"v": "15",  "label": "15 minutes",           "emo": "⏱️"},
        {"v": "30",  "label": "30 minutes",           "emo": "⏰"},
        {"v": "45",  "label": "45 minutes",           "emo": "📘"},
        {"v": "60",  "label": "1 hour",               "emo": "📚"},
        {"v": "120", "label": "2+ hours (homeschool)", "emo": "🎓"},
    ]},
    {"step_key": "days", "options": [
        {"v": "3", "label": "3 days"},
        {"v": "5", "label": "5 days (weekdays)"},
        {"v": "6", "label": "6 days"},
        {"v": "7", "label": "Every day"},
    ]},
    {"step_key": "language", "options": [
        {"v": "en", "label": "English only",      "emo": "🇺🇸"},
        {"v": "zh", "label": "Mandarin (中文)",   "emo": "🇨🇳"},
        {"v": "hi", "label": "Hindi (हिन्दी)",    "emo": "🇮🇳"},
        {"v": "es", "label": "Spanish (Español)", "emo": "🇪🇸"},
    ]},
    {"step_key": "goal", "options": [
        {"v": "catchup",     "label": "Catch up to grade level",             "emo": "🏁"},
        {"v": "enrich",      "label": "Enrich & keep curious",               "emo": "✨"},
        {"v": "accelerate",  "label": "Accelerate beyond grade",             "emo": "🚀"},
        {"v": "confidence",  "label": "Build confidence & love of learning", "emo": "💛"},
    ]},
    {"step_key": "focus", "options": [
        {"v": "reading",  "label": "Reading & phonics",         "emo": "📖"},
        {"v": "math",     "label": "Math",                      "emo": "🧮"},
        {"v": "logic",    "label": "Logic & critical thinking", "emo": "🧩"},
        {"v": "emotions", "label": "Feelings & emotional SEL",  "emo": "💛"},
        {"v": "manners",  "label": "Character & manners",       "emo": "🌱"},
        {"v": "art",      "label": "Art & creativity",          "emo": "🎨"},
    ]},
]


def main():
    conn = pyodbc.connect(CONN_STR, timeout=15)
    conn.autocommit = True
    cur = conn.cursor()
    print(f"Connected. Updating {len(QUESTIONS)} rows...\n")

    ok = 0
    for q in QUESTIONS:
        opts_json = json.dumps(q["options"], ensure_ascii=False)
        cur.execute(
            "UPDATE dbo.AssessmentQuestions SET options_json=? WHERE step_key=?",
            (opts_json, q["step_key"]),
        )
        ok += cur.rowcount
        first_emo = q["options"][0].get("emo", "-")
        emo_repr = first_emo.encode("unicode_escape").decode("ascii")
        print(f"  {q['step_key']:<12}  rowcount={cur.rowcount}  first_emo={emo_repr}")

    cur.close()
    conn.close()
    print(f"\nDone — {ok}/{len(QUESTIONS)} rows updated.")


if __name__ == "__main__":
    main()
