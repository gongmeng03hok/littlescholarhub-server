# -*- coding: utf-8 -*-
"""Full round trip: does a session a child actually does come back out again?

Storing is only half of it. The parent's progress screen reads SessionLogs and
Streaks, the activity feed reads QuestionAttempts, and the kid's profile reads
ChildGameStats - three different tables written by two different endpoints. A
child can answer ten questions and a parent still see an empty week if only one
of them fired.

So: play a realistic session - answer several questions, some right and some
wrong, then log the session the way the practice screen does - and assert on
the NUMBERS that come back, not on the status codes.

Cleans up everything it creates.
"""
import json, sys, time, urllib.request, urllib.error

API = "http://127.0.0.1:5001/api"
EMAIL = "e2e-probe-%d@example.invalid" % int(time.time())
PW = "E2eProbe123456"

RIGHT, WRONG = 4, 2          # answers to give
DURATION = 12                # minutes for the logged session
SUBJECT_ID = 3               # math

results = []


def call(method, path, body=None, token=None):
    data = json.dumps(body).encode() if body is not None else None
    req = urllib.request.Request(API + path, data=data, method=method)
    req.add_header("Content-Type", "application/json")
    if token:
        req.add_header("Authorization", "Bearer " + token)
    try:
        with urllib.request.urlopen(req, timeout=25) as r:
            raw = r.read().decode()
            return r.getcode(), (json.loads(raw) if raw else {})
    except urllib.error.HTTPError as e:
        raw = e.read().decode()
        try:
            return e.code, json.loads(raw)
        except Exception:
            return e.code, {"raw": raw[:150]}
    except Exception as e:
        return 0, {"err": str(e)[:100]}


def check(label, ok, detail=""):
    results.append((label, ok, detail))
    print("  %-4s %-46s %s" % ("ok" if ok else "FAIL", label, detail))


# ── set up a family and a child ────────────────────────────────────────────
code, reg = call("POST", "/auth/register",
                 {"email": EMAIL, "password": PW, "language_id": 1, "role": "parent"})
tok = reg.get("token")
code, ch = call("POST", "/children/",
                {"nickname": "E2EKid", "grade_id": 2, "birth_year": 2019}, tok)
kid = ch.get("child_id")
print("child_id = %s\n" % kid)

# ── play the session ───────────────────────────────────────────────────────
print("PLAYING A SESSION  (%d right, %d wrong, %d min)" % (RIGHT, WRONG, DURATION))
code, qs = call("GET", "/questions/generate?subject=math&grade=2&count=%d" % (RIGHT + WRONG))
questions = qs.get("questions", [])
for i, q in enumerate(questions):
    correct = q.get("correct_answer")
    given = correct if i < RIGHT else "definitely-wrong"
    call("POST", "/questions/attempt", {
        "child_id": kid, "given_answer": given, "correct_answer": correct,
        "question_text": q.get("question_text"), "options": q.get("options"),
        "time_sec": 6,
    }, tok)
code, _ = call("POST", "/progress/log",
               {"child_id": kid, "subject_id": SUBJECT_ID, "duration_min": DURATION}, tok)
check("session logged", code == 200, "HTTP %s" % code)
print()

# ── now read it all back ───────────────────────────────────────────────────
print("READING IT BACK")

code, prog = call("GET", "/progress/%s" % kid, None, tok)
weekly = (prog or {}).get("weekly") or {}
streak = (prog or {}).get("streak") or {}
by_subj = (prog or {}).get("by_subject") or []
check("weekly sessions counted", weekly.get("sessions", 0) >= 1,
      "sessions=%s mins=%s" % (weekly.get("sessions"), weekly.get("mins")))
check("weekly minutes match", weekly.get("mins", 0) == DURATION,
      "expected %d, got %s" % (DURATION, weekly.get("mins")))
check("streak started", (streak.get("current_streak") or 0) >= 1,
      "current=%s longest=%s" % (streak.get("current_streak"), streak.get("longest_streak")))
check("subject breakdown populated", len(by_subj) >= 1,
      "%s" % [(b.get("slug"), b.get("total_min")) for b in by_subj])

code, chart = call("GET", "/progress/%s/chart" % kid, None, tok)
pts = chart if isinstance(chart, list) else (chart or {}).get("data", [])
nonzero = [p for p in pts if (p.get("minutes") or p.get("total_min") or p.get("mins") or 0)]
check("7-day chart has today's data", bool(nonzero),
      "%d points, %d non-zero" % (len(pts), len(nonzero)))

code, acts = call("GET", "/progress/%s/activities" % kid, None, tok)
quiz = (acts or {}).get("quiz_attempts", []) if isinstance(acts, dict) else []
n_right = len([a for a in quiz if a.get("is_correct")])
check("activity feed lists every attempt", len(quiz) == RIGHT + WRONG,
      "expected %d, got %d" % (RIGHT + WRONG, len(quiz)))
check("correct/incorrect recorded faithfully", n_right == RIGHT,
      "expected %d correct, got %d" % (RIGHT, n_right))
check("activity feed carries the question text",
      bool(quiz and quiz[0].get("question_text")),
      repr((quiz[0].get("question_text") if quiz else "")[:44]))

code, gam = call("GET", "/gamification/profile/%s" % kid, None, tok)
xp = (gam or {}).get("xp") or (gam or {}).get("total_xp") or 0
gems = (gam or {}).get("gems") or 0
check("XP awarded for correct answers", xp > 0, "xp=%s gems=%s" % (xp, gems))

code, badges = call("GET", "/progress/%s/badges" % kid, None, tok)
blist = badges if isinstance(badges, list) else (badges or {}).get("badges", [])
check("badges endpoint returns a list", isinstance(blist, list), "%d badges" % len(blist))

# ── what landed in the tables ──────────────────────────────────────────────
print()
print("TABLES")
sys.path.insert(0, "/var/www/littlescholarhub/lsh.api")
sys.path.insert(0, "/var/www/littlescholarhub/lsh.api/app")
from app import create_app                                   # noqa: E402
from utils.db import qry                                     # noqa: E402
app = create_app()
with app.test_request_context():
    for t, col in (("QuestionAttempts", "child_id"), ("SessionLogs", "child_id"),
                   ("Streaks", "child_id"), ("ChildGameStats", "child_id"),
                   ("TopicMastery", "child_id")):
        try:
            n = qry("SELECT COUNT(*) c FROM dbo.%s WHERE %s=?" % (t, col),
                    (kid,), fetch="one")["c"]
            print("    %-18s %s" % (t, n))
        except Exception as e:
            print("    %-18s ERR %s" % (t, str(e)[:50]))

    # cleanup
    def refs(tb):
        return qry("""SELECT OBJECT_NAME(fk.parent_object_id) tbl, c.name col
                      FROM sys.foreign_keys fk
                      JOIN sys.foreign_key_columns fkc ON fkc.constraint_object_id=fk.object_id
                      JOIN sys.columns c ON c.object_id=fkc.parent_object_id
                       AND c.column_id=fkc.parent_column_id
                      WHERE fk.referenced_object_id=OBJECT_ID(?)""", (tb,))
    cr = refs("dbo.Children")
    fr = [r for r in refs("dbo.Families") if r["tbl"] != "Children"]
    for f in qry("SELECT family_id FROM dbo.Families WHERE email LIKE 'e2e-probe-%'"):
        fid = f["family_id"]
        for _ in range(4):
            n = 0
            for r in cr:
                try:
                    n += qry("DELETE FROM dbo.[%s] WHERE [%s] IN (SELECT child_id FROM dbo.Children WHERE family_id=?)"
                             % (r["tbl"], r["col"]), (fid,), fetch="exec") or 0
                except Exception:
                    pass
            for r in fr:
                try:
                    n += qry("DELETE FROM dbo.[%s] WHERE [%s]=?" % (r["tbl"], r["col"]),
                             (fid,), fetch="exec") or 0
                except Exception:
                    pass
            if not n:
                break
        qry("DELETE FROM dbo.Children WHERE family_id=?", (fid,), fetch="exec")
        qry("DELETE FROM dbo.Families WHERE family_id=?", (fid,), fetch="exec")

print()
bad = [r for r in results if not r[1]]
print("%d checks, %d failed" % (len(results), len(bad)))
for label, _ok, detail in bad:
    print("   FAILED: %s  (%s)" % (label, detail))
