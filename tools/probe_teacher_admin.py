# -*- coding: utf-8 -*-
"""Do the teacher and admin portals work once you are past the front door?

The earlier probe only got as far as 403 - correct, since a new teacher is
unapproved - which proves the gate works but says nothing about what is behind
it. This approves a probe teacher and elevates a probe admin, then exercises
the screens each portal is built from.

Everything it creates is removed at the end.
"""
import json, sys, time, urllib.request, urllib.error

API = "http://127.0.0.1:5001/api"
ST = int(time.time())
T_EMAIL = "ta-probe-t-%d@example.invalid" % ST
A_EMAIL = "ta-probe-a-%d@example.invalid" % ST
P_EMAIL = "ta-probe-p-%d@example.invalid" % ST
PW = "TaProbe1234567"

sys.path.insert(0, "/var/www/littlescholarhub/lsh.api")
sys.path.insert(0, "/var/www/littlescholarhub/lsh.api/app")
from app import create_app                                   # noqa: E402
from utils.db import qry                                     # noqa: E402

app = create_app()
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


def login(email):
    _c, r = call("POST", "/auth/login", {"email": email, "password": PW})
    return r.get("token")


# ── set up: a parent with a child, a teacher, an admin ─────────────────────
_c, preg = call("POST", "/auth/register",
                {"email": P_EMAIL, "password": PW, "language_id": 1, "role": "parent"})
ptok = preg.get("token")
_c, ch = call("POST", "/children/",
              {"nickname": "TAKid", "grade_id": 2, "birth_year": 2019}, ptok)
kid = ch.get("child_id")

_c, treg = call("POST", "/auth/register",
                {"email": T_EMAIL, "password": PW, "language_id": 1, "role": "teacher",
                 "teacher_name": "Probe Teacher", "teacher_school": "Probe School"})
t_family = treg.get("family_id")

_c, areg = call("POST", "/auth/register",
                {"email": A_EMAIL, "password": PW, "language_id": 1, "role": "parent"})
a_family = areg.get("family_id")

with app.test_request_context():
    qry("UPDATE dbo.Families SET role='admin', is_approved=1 WHERE family_id=?",
        (a_family,), fetch="exec")
atok = login(A_EMAIL)

print("=" * 66)
print("ADMIN PORTAL")
print("=" * 66)
for label, path in [("list users", "/admin/users"),
                    ("pending teachers", "/admin/teachers/pending"),
                    ("app config", "/config"),
                    ("worksheet admin list", "/admin/worksheets")]:
    c, _ = call("GET", path, None, atok)
    check(label, c == 200, "HTTP %s" % c)

c, pend = call("GET", "/admin/teachers/pending", None, atok)
ids = [p.get("family_id") for p in (pend if isinstance(pend, list) else pend.get("teachers", []))]
check("our probe teacher is listed as pending", t_family in ids,
      "pending=%s" % ids[:5])

c, _ = call("PUT", "/admin/teachers/%s/approve" % t_family, {}, atok)
check("admin can approve a teacher", c in (200, 204), "HTTP %s" % c)

with app.test_request_context():
    row = qry("SELECT is_approved FROM dbo.Families WHERE family_id=?",
              (t_family,), fetch="one")
check("approval persisted", bool(row and row["is_approved"]),
      "is_approved=%s" % (row or {}).get("is_approved"))

print()
print("=" * 66)
print("TEACHER PORTAL  (now approved)")
print("=" * 66)
ttok = login(T_EMAIL)
for label, path in [("classrooms", "/teacher/classrooms"),
                    ("students", "/teacher/students"),
                    ("parents", "/teacher/parents"),
                    ("homework queue", "/homework/teacher-queue")]:
    c, _ = call("GET", path, None, ttok)
    check(label, c == 200, "HTTP %s" % c)

c, cls = call("POST", "/teacher/classrooms",
              {"classroom_name": "Probe Class", "grade_id": 2}, ttok)
check("create a classroom", c in (200, 201), "HTTP %s" % c)
room = cls.get("classroom_id") or (cls.get("classroom") or {}).get("classroom_id")

if room:
    c, _ = call("GET", "/teacher/classrooms/%s/roster" % room, None, ttok)
    check("classroom roster", c == 200, "HTTP %s" % c)
    c, _ = call("GET", "/teacher/classrooms/%s/gradebook" % room, None, ttok)
    check("gradebook", c == 200, "HTTP %s" % c)
    c, _ = call("GET", "/teacher/classrooms/%s/assignments" % room, None, ttok)
    check("classroom assignments", c == 200, "HTTP %s" % c)

print()
print("=" * 66)
print("BOUNDARIES")
print("=" * 66)
c, _ = call("GET", "/admin/users", None, ttok)
check("teacher BLOCKED from admin", c in (401, 403), "HTTP %s" % c)
c, _ = call("GET", "/teacher/students", None, ptok)
check("parent BLOCKED from teacher", c in (401, 403), "HTTP %s" % c)

# ── cleanup ────────────────────────────────────────────────────────────────
print()
with app.test_request_context():
    def refs(tb):
        return qry("""SELECT OBJECT_NAME(fk.parent_object_id) tbl, c.name col
                      FROM sys.foreign_keys fk
                      JOIN sys.foreign_key_columns fkc ON fkc.constraint_object_id=fk.object_id
                      JOIN sys.columns c ON c.object_id=fkc.parent_object_id
                       AND c.column_id=fkc.parent_column_id
                      WHERE fk.referenced_object_id=OBJECT_ID(?)""", (tb,))
    cr = refs("dbo.Children")
    fr = [r for r in refs("dbo.Families") if r["tbl"] != "Children"]
    for f in qry("SELECT family_id FROM dbo.Families WHERE email LIKE 'ta-probe-%'"):
        fid = f["family_id"]
        for _ in range(5):
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
    left = qry("SELECT COUNT(*) c FROM dbo.Families WHERE email LIKE 'ta-probe-%'",
               fetch="one")["c"]
    print("cleanup: probe rows left =", left)
    print("families=%s children=%s" % (
        qry("SELECT COUNT(*) c FROM dbo.Families", fetch="one")["c"],
        qry("SELECT COUNT(*) c FROM dbo.Children", fetch="one")["c"]))

bad = [r for r in results if not r[1]]
print()
print("%d checks, %d failed" % (len(results), len(bad)))
for label, _ok, detail in bad:
    print("   FAILED: %s  (%s)" % (label, detail))
