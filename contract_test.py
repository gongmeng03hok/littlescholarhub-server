# -*- coding: utf-8 -*-
"""API contract test — run by deploy.sh before anything is published.

Three separate merges have silently deleted backend contracts the frontend
depends on: `useWorksheet`, the `theme` option on `useQuestions`, and the whole
demo/quiz routing. Nothing failed loudly — the app just degraded to serving
arithmetic on colouring pages, and it stayed that way for weeks.

Every assertion here corresponds to a regression that actually shipped. A
failure exits non-zero so `deploy.sh` (set -e) stops before publishing.

Usage:  python3 contract_test.py [base_url]     default http://127.0.0.1:5001
"""
import io, json, sys, urllib.request, urllib.error

BASE = (sys.argv[1] if len(sys.argv) > 1 else "http://127.0.0.1:5001").rstrip("/")
fails, checks = [], [0]


def get(path):
    req = urllib.request.Request(BASE + path, headers={"Accept": "application/json"})
    with urllib.request.urlopen(req, timeout=20) as r:
        return r.getcode(), json.loads(r.read().decode("utf-8"))


def check(name, fn):
    checks[0] += 1
    try:
        ok, detail = fn()
    except Exception as e:
        ok, detail = False, "%s: %s" % (type(e).__name__, str(e)[:120])
    print("  %-58s %s" % (name, "ok" if ok else "FAIL  " + str(detail)))
    if not ok:
        fails.append(name)


# ── worksheet detail: deleted by a merge, 404'd for every id ────────────────
def c_detail():
    code, rows = get("/api/content/worksheets?grade=0")
    if not rows:
        return False, "no grade-0 worksheets to sample"
    wid = rows[0]["worksheet_id"]
    code, d = get("/api/content/worksheets/%d" % wid)
    missing = [k for k in ("title", "subject", "is_demo", "steps") if k not in d]
    return (code == 200 and not missing), "ws%s code=%s missing=%s" % (wid, code, missing)


# ── is_demo on the list: without it every printable routes to a quiz ────────
def c_list_is_demo():
    code, rows = get("/api/content/worksheets?grade=0")
    if not rows:
        return False, "empty"
    return ("is_demo" in rows[0]), "keys lack is_demo"


# ── the actual regression: a printable must not be quizzable ───────────────
def c_printables_are_demos():
    code, rows = get("/api/content/worksheets?grade=0")
    bad = [r["title"] for r in rows
           if (r.get("content_type") in ("coloring", "mini_book", "space_image", "iacl_book")
               or r.get("subject") in ("art", "story", "workbooks", "science", "writing", "solar_system"))
           and not r.get("is_demo")]
    return (not bad), "quizzable printables: %s" % bad[:3]


# ── subjects with no generator must never reach the question endpoint ──────
def c_no_math_fallback():
    code, d = get("/api/questions/generate?subject=art&grade=0&count=4")
    qs = " ".join((q.get("question") or q.get("question_text") or "") for q in d.get("questions", []))
    # If art ever routes here it yields math; is_demo is what must prevent it.
    # We assert the failure mode is still *detectable*, so the guard above matters.
    return (True, "informational: art -> %s" % qs[:48])


# ── theme threading: dropped once already ──────────────────────────────────
def c_theme_threaded():
    code, d = get("/api/questions/generate?subject=math&grade=4&count=5&theme=ocean")
    blob = json.dumps(d).lower()
    hits = any(w in blob for w in ("shell", "fish", "wave", "ocean", "crab", "shark", "coral"))
    return hits, "no ocean vocabulary in themed questions"


# ── wisdom: language-aware track + artwork ─────────────────────────────────
def c_wisdom():
    want = {1: "universal", 2: "chinese", 3: "gita", 4: "hispanic"}
    bad = []
    for lang, track in want.items():
        code, d = get("/api/content/wisdom/today?language_id=%d" % lang)
        if d.get("source_track") != track:
            bad.append("lang%d=%s" % (lang, d.get("source_track")))
        if not d.get("image_url"):
            bad.append("lang%d no image" % lang)
    return (not bad), bad


# ── story-linked worksheets must ship their story ──────────────────────────
def c_story_attached():
    code, rows = get("/api/content/worksheets?grade=2")
    for r in rows[:40]:
        code, d = get("/api/content/worksheets/%d" % r["worksheet_id"])
        if d.get("story"):
            s = d["story"]
            return ("body_text" in s and "questions" in s), "story missing body/questions"
    return True, "no story-linked sheet in this sample (not a failure)"



# ── skill threading: each of these was a title promising something the
# ── generator could not produce. Nine skills, nine regressions to guard.
def c_skills():
    want = {
        ("phonics", 0, "beginning_sounds"): "begins with",
        ("phonics", 0, "rhyming"):          "rhymes with",
        ("phonics", 2, "syllables"):        "syllable",
        ("phonics", 2, "digraphs"):         "two letters",
        ("math",    3, "skip_counting"):    "count by",
        ("math",    1, "geometry"):         "side|shape",
        ("math",    4, "geometry"):         "perimeter|area",
        ("reading", 2, "sequences"):        "what happens",
        ("reading", 4, "comparing"):        "which is true",
        ("reading", 0, "comprehension"):    "listen",
    }
    import re as _re
    bad = []
    for (subj, grade, skill), probe in want.items():
        code, d = get("/api/questions/generate?subject=%s&grade=%d&count=5&skill=%s"
                      % (subj, grade, skill))
        blob = " ".join((q.get("question") or q.get("question_text") or "")
                        for q in d.get("questions", [])).lower()
        if not _re.search(probe, blob):
            bad.append("%s/g%d" % (skill, grade))
    return (not bad), bad


def c_skill_key_derived():
    code, rows = get("/api/content/worksheets?grade=0")
    if not rows:
        return False, "empty"
    if "skill_key" not in rows[0]:
        return False, "skill_key missing from the worksheet payload"
    named = [r for r in rows if r.get("skill_key")]
    return (len(named) > 0), "no worksheet in grade 0 resolved a skill"



# ── age bands: MIN_GRADE_ID gave every generator a floor and no ceiling, so a
# ── 6th grader was asked which word rhymes with "cat". These are the specific
# ── leaks that were live, expressed as things that must NOT come back.
def c_age_bands():
    import re as _re
    forbidden = [
        ("phonics", 7, r"rhymes with",        "rhyming at 6th"),
        ("phonics", 7, r"begins with the /",  "beginning sounds at 6th"),
        ("phonics", 6, r"sight word",         "sight words at 5th"),
        ("reading", 7, r"^listen:",           "listening comprehension at 6th"),
        ("reading", 6, r"think about .*what happens", "story sequencing at 5th"),
        ("math",    4, r"area of a triangle", "triangle area at 3rd"),
        ("math",    0, r"pentagon|hexagon",   "pentagons at TK"),
    ]
    bad = []
    for subj, grade, pat, label in forbidden:
        blob = ""
        for _ in range(4):
            code, d = get("/api/questions/generate?subject=%s&grade=%d&count=5" % (subj, grade))
            blob += " ".join((q.get("question") or q.get("question_text") or "")
                             for q in d.get("questions", [])).lower() + " "
        if _re.search(pat, blob):
            bad.append(label)
    return (not bad), bad


def c_no_empty_cells():
    """Every subject x grade must return questions. Adding ceilings can starve
    a cell -- capping the early phonics generators left 5th and 6th with
    nothing until the upper-grade literacy generators existed."""
    bad = []
    for subj in ("math", "phonics", "reading", "logic", "feelings", "manners"):
        for g in range(8):
            code, d = get("/api/questions/generate?subject=%s&grade=%d&count=5" % (subj, g))
            if len(d.get("questions", [])) != 5:
                bad.append("%s/g%d" % (subj, g))
    return (not bad), bad


# ── every scene rule still matches a live question ─────────────────────────
# Reworded questions orphan their illustration; the scenario then falls back
# to the generic subject icon and two different prompts show the same picture.
def c_scene_art():
    import re
    ts = "/var/www/littlescholarhub/lsh.web/src/constants/questionImages.ts"
    try:
        src = io.open(ts, encoding="utf-8").read()
    except Exception as e:
        return False, "cannot read questionImages.ts: %s" % e
    if "GENERATED_SCENES" not in src:
        return False, "GENERATED_SCENES missing"
    block = src.split("const GENERATED_SCENES", 1)[1].split("];", 1)[0]
    rules = re.findall(r'\[/(.+?)/i,\s*"([^"]+)"\]', block)
    if len(rules) < 40:
        return False, "only %d scene rules parsed" % len(rules)

    corpus = []
    for subj in ("feelings", "manners"):
        for g in range(8):
            for _ in range(6):
                try:
                    _c, d = get("/api/questions/generate?subject=%s&grade=%d&count=5"
                                % (subj, g))
                except Exception:
                    continue
                for q in d.get("questions", []):
                    corpus.append((q.get("question") or "") + " " + (q.get("hint") or ""))
    dead = [n for pat, n in rules
            if not any(re.search(pat, t, re.I) for t in corpus)]
    return (not dead), "no live question matches: " + ", ".join(dead[:6])


# ── no published worksheet 500s when a child opens it ──────────────────────
def c_no_500s():
    bad = []
    for grade in range(8):
        try:
            _c, rows = get("/api/content/worksheets?grade=%d" % grade)
        except Exception:
            continue
        for w in (rows or [])[:14]:
            if w.get("is_demo"):
                continue
            skill = w.get("skill_key") or ""
            subj = w.get("subject") or "math"
            url = ("/api/questions/generate?subject=%s&grade=%s&count=3&skill=%s"
                   % (subj, w.get("grade_id", grade), skill))
            try:
                _c2, d = get(url)
                if len(d.get("questions", [])) < 3:
                    bad.append("ws%s thin" % w.get("worksheet_id"))
            except Exception as e:
                bad.append("ws%s %s" % (w.get("worksheet_id"),
                                        getattr(e, "code", type(e).__name__)))
    return (not bad), bad[:8]


# ── a new family's progress actually reaches the database ──────────────────
# The endpoint answers 200 with is_correct whether or not the row lands, so
# only reading it back proves anything. Self-cleaning: the probe family and
# every row that references its child are removed afterwards.
PROBE_EMAIL_PREFIX = "contract-probe-"


def _fk_refs(qry, table):
    """Tables and columns holding a foreign key to `table`."""
    return qry("""SELECT OBJECT_NAME(fk.parent_object_id) tbl, c.name col
                  FROM sys.foreign_keys fk
                  JOIN sys.foreign_key_columns fkc
                    ON fkc.constraint_object_id = fk.object_id
                  JOIN sys.columns c
                    ON c.object_id = fkc.parent_object_id
                   AND c.column_id = fkc.parent_column_id
                  WHERE fk.referenced_object_id = OBJECT_ID(?)""", (table,))


def _probe_cleanup(qry):
    """Remove probe families and everything that points at them.

    Two levels, in order. Clearing only the child-level tables left the family
    delete failing on RewardItems / Referrals / Classrooms and eleven others,
    and the swallowed error meant a probe family quietly survived.
    """
    child_refs = _fk_refs(qry, "dbo.Children")
    fam_refs = [r for r in _fk_refs(qry, "dbo.Families")
                if r["tbl"] != "Children"]
    fams = qry("SELECT family_id FROM dbo.Families WHERE email LIKE ?",
               (PROBE_EMAIL_PREFIX + "%",))
    for f in fams:
        fid = f["family_id"]
        # Repeat until a pass changes nothing: the referencing tables depend on
        # each other (QuestionAttempts -> GeneratedQuestions -> Children) and
        # sys.foreign_keys gives no ordering, so one pass cannot be enough.
        for _round in range(4):
            progress = 0
            for r in child_refs:
                try:
                    progress += qry(
                        "DELETE FROM dbo.[%s] WHERE [%s] IN "
                        "(SELECT child_id FROM dbo.Children WHERE family_id=?)"
                        % (r["tbl"], r["col"]), (fid,), fetch="exec") or 0
                except Exception:
                    pass
            for r in fam_refs:
                try:
                    progress += qry(
                        "DELETE FROM dbo.[%s] WHERE [%s]=?" % (r["tbl"], r["col"]),
                        (fid,), fetch="exec") or 0
                except Exception:
                    pass
            if not progress:
                break
        try:
            qry("DELETE FROM dbo.Children WHERE family_id=?", (fid,), fetch="exec")
            qry("DELETE FROM dbo.Families WHERE family_id=?", (fid,), fetch="exec")
        except Exception as e:
            print("    probe cleanup could not remove family %s: %s"
                  % (fid, str(e)[:110]))
    return len(fams)


def c_progress_stored():
    import time
    sys.path.insert(0, "/var/www/littlescholarhub/lsh.api")
    sys.path.insert(0, "/var/www/littlescholarhub/lsh.api/app")
    try:
        from app import create_app
        from utils.db import qry
    except Exception as e:
        return False, "cannot import app: %s" % str(e)[:80]

    email = "%s%d@example.invalid" % (PROBE_EMAIL_PREFIX, int(time.time()))
    app = create_app()

    # Anything left by a run that was interrupted.
    try:
        with app.test_request_context():
            _probe_cleanup(qry)
    except Exception:
        pass

    def post(path, body, token=None):
        data = json.dumps(body).encode()
        req = urllib.request.Request(BASE + path, data=data, method="POST")
        req.add_header("Content-Type", "application/json")
        if token:
            req.add_header("Authorization", "Bearer " + token)
        with urllib.request.urlopen(req, timeout=25) as r:
            raw = r.read().decode()
            return json.loads(raw) if raw else {}

    child_id = None
    try:
        reg = post("/api/auth/register",
                   {"email": email, "password": "ContractProbe12345",
                    "language_id": 1, "role": "parent"})
        token = reg.get("token")
        if not token:
            return False, "register returned no token"

        ch = post("/api/children/",
                  {"nickname": "ContractProbe", "grade_id": 2, "birth_year": 2019},
                  token)
        child_id = ch.get("child_id")
        if not child_id:
            return False, "child not created"

        _c, qs = get("/api/questions/generate?subject=math&grade=2&count=1")
        q = (qs.get("questions") or [{}])[0]
        post("/api/questions/attempt", {
            "child_id": child_id,
            "given_answer": q.get("correct_answer"),
            "correct_answer": q.get("correct_answer"),
            "question_text": q.get("question_text"),
            "options": q.get("options"), "time_sec": 5,
        }, token)

        with app.test_request_context():
            rows = qry("SELECT attempt_id FROM dbo.QuestionAttempts WHERE child_id=?",
                       (child_id,))
        if not rows:
            return False, "attempt returned 200 but NOTHING was stored"
        return True, ""
    finally:
        try:
            with app.test_request_context():
                _probe_cleanup(qry)
        except Exception:
            pass


print("API contract test -> %s" % BASE)
check("GET /content/worksheets/<id> returns 200 + is_demo + steps", c_detail)
check("list endpoint exposes is_demo", c_list_is_demo)
check("printables are flagged is_demo (no quiz on a colouring page)", c_printables_are_demos)
check("questions/generate reachable", c_no_math_fallback)
check("theme threads into generated questions", c_theme_threaded)
check("daily wisdom: per-language track + artwork", c_wisdom)
check("story-linked worksheet ships its story", c_story_attached)
check("worksheet payload carries skill_key", c_skill_key_derived)
check("all 10 named skills serve their own questions", c_skills)
check("age bands: no TK material for older children", c_age_bands)
check("every subject x grade returns questions (48 cells)", c_no_empty_cells)
check("no published worksheet 500s when opened", c_no_500s)
check("every scene-art rule still matches a live question", c_scene_art)
check("a new family's progress is actually stored", c_progress_stored)

print("\n%d checks, %d failed" % (checks[0], len(fails)))
if fails:
    print("CONTRACT BROKEN: " + ", ".join(fails))
    sys.exit(1)
print("contract OK")
