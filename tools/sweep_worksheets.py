# -*- coding: utf-8 -*-
"""Open every published worksheet the way the client does, over HTTP.

Not by importing the generator - that is how the last audit lied to itself.
This asks the running API the same question the app asks, with the same
subject, grade and skill the worksheet detail endpoint hands the client, and
records what comes back.

Found this way: "Theme & Tone Reading Pack" 500s, because its title matched
the Chinese pinyin rule and pinyin_tone cannot run on a reading worksheet.
"""
import sys, json, collections
import urllib.request, urllib.parse

sys.path.insert(0, "/var/www/littlescholarhub/lsh.api")
sys.path.insert(0, "/var/www/littlescholarhub/lsh.api/app")

from app import create_app                                       # noqa: E402
from routes.content import (_skill_from_title, DEMO_CONTENT_TYPES,   # noqa: E402
                            NO_QUESTION_SUBJECTS)
from utils.db import qry                                         # noqa: E402

API = "http://127.0.0.1:5001/api/questions/generate"
GRADE = {0: "TK", 1: "K", 2: "1st", 3: "2nd", 4: "3rd", 5: "4th", 6: "5th", 7: "6th"}


def fetch(subject, grade, skill, theme, n=5):
    q = urllib.parse.urlencode({"subject": subject, "grade": grade,
                                "count": n, "skill": skill or "", "theme": theme or ""})
    try:
        with urllib.request.urlopen(API + "?" + q, timeout=25) as r:
            return json.loads(r.read().decode("utf-8")), None
    except urllib.error.HTTPError as e:
        return None, "HTTP %s" % e.code
    except Exception as e:
        return None, str(e)[:60]


app = create_app()
with app.test_request_context():
    rows = qry("""SELECT w.worksheet_id, w.title, s.slug, w.grade_id,
                         w.content_type, w.interest_tag
                  FROM dbo.Worksheets w JOIN dbo.Subjects s ON s.subject_id=w.subject_id
                  WHERE w.is_published=1 ORDER BY w.worksheet_id""")

broken, empty, thin, good = [], [], [], 0
for r in rows:
    ctype, subj, grade = (r.get("content_type") or ""), r["slug"], int(r["grade_id"])
    if ctype in DEMO_CONTENT_TYPES or subj in NO_QUESTION_SUBJECTS:
        continue
    skill = _skill_from_title(r["title"])
    data, err = fetch(subj, grade, skill, r.get("interest_tag"))
    label = (r["worksheet_id"], r["title"], subj, GRADE[grade], skill or "-")
    if err:
        broken.append(label + (err,))
        continue
    qs = data.get("questions") or []
    if not qs:
        empty.append(label)
    elif len(qs) < 3:
        thin.append(label + (len(qs),))
    else:
        good += 1

print("")
print("worksheets serving >=3 questions : %d" % good)
print("serving 1-2 only                 : %d" % len(thin))
print("serving ZERO                     : %d" % len(empty))
print("ERRORING                         : %d" % len(broken))

for name, rowsx in (("ERRORING", broken), ("ZERO QUESTIONS", empty), ("THIN", thin)):
    if not rowsx:
        continue
    print("\n=== %s ===" % name)
    for t in rowsx:
        print("  ws%-5s %-36s %-9s %-5s skill=%-16s %s"
              % (t[0], str(t[1])[:36], t[2], t[3], t[4], t[5] if len(t) > 5 else ""))
