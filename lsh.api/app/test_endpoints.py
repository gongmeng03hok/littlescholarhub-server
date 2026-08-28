"""
test_endpoints.py — Smoke-test all new endpoints against a running server.
Usage:  python test_endpoints.py [base_url]
Default base_url: http://localhost:5000/api
"""

import sys, json, time
import urllib.request, urllib.error

BASE = sys.argv[1] if len(sys.argv) > 1 else "http://localhost:5000/api"
PASS = "✅ PASS"
FAIL = "❌ FAIL"

def req(method, path, body=None, token=None, expect=200):
    url = BASE + path
    data = json.dumps(body).encode() if body else None
    headers = {"Content-Type": "application/json"}
    if token:
        headers["Authorization"] = f"Bearer {token}"
    rq = urllib.request.Request(url, data=data, headers=headers, method=method)
    try:
        with urllib.request.urlopen(rq, timeout=5) as r:
            status = r.status
            resp = json.loads(r.read())
    except urllib.error.HTTPError as e:
        status = e.code
        try: resp = json.loads(e.read())
        except: resp = {}
    ok = status == expect
    label = PASS if ok else FAIL
    print(f"  {label}  {method:6} {path:50} → {status}  {str(resp)[:80]}")
    return resp, status, ok

results = []

print(f"\n{'='*70}")
print(f"LSH Backend Smoke Test  |  {BASE}")
print(f"{'='*70}\n")

# ── Health ────────────────────────────────────────────────────
print("── Health ──")
_, _, ok = req("GET", "/health"); results.append(ok)

# ── Public config ─────────────────────────────────────────────
print("\n── Public Config ──")
cfg, _, ok = req("GET", "/config"); results.append(ok)
_, _, ok = req("GET", "/config/hero.tagline"); results.append(ok)
_, _, ok = req("GET", "/config/pricing.family_price"); results.append(ok)

# ── Auth: register ───────────────────────────────────────────
print("\n── Auth ──")
ts = int(time.time())
reg, _, ok = req("POST", "/auth/register",
    {"email": f"test_{ts}@example.com", "password": "TestPass123", "language_id": 1},
    expect=201)
results.append(ok)
parent_token = reg.get("token", "")

# login
login_resp, _, ok = req("POST", "/auth/login",
    {"email": f"test_{ts}@example.com", "password": "TestPass123"})
results.append(ok)

# me
_, _, ok = req("GET", "/auth/me", token=parent_token); results.append(ok)

# refresh
_, _, ok = req("POST", "/auth/refresh", token=parent_token); results.append(ok)

# admin-login with non-admin → 403
_, _, ok = req("POST", "/auth/admin-login",
    {"email": f"test_{ts}@example.com", "password": "TestPass123"}, expect=403)
results.append(ok)

# ── Children ─────────────────────────────────────────────────
print("\n── Children ──")
child_resp, _, ok = req("POST", "/children/",
    {"nickname": "Tester", "grade_id": 2}, token=parent_token, expect=201)
results.append(ok)
child_id = child_resp.get("child_id", 1)

_, _, ok = req("GET", "/children/", token=parent_token); results.append(ok)
_, _, ok = req("PATCH", f"/children/{child_id}",
    {"nickname": "Tester Updated"}, token=parent_token)
results.append(ok)

# ── Kid profile ───────────────────────────────────────────────
print("\n── Kid Profile ──")
_, _, ok = req("POST", f"/children/{child_id}/kid-profile",
    {"display_name": "Tester Jr", "avatar_slug": "rocket", "pin": "1234"},
    token=parent_token, expect=201)
results.append(ok)

_, _, ok = req("GET", f"/children/{child_id}/kid-profile",
    token=parent_token); results.append(ok)

# ── Kid login ─────────────────────────────────────────────────
print("\n── Kid Login ──")
# Wrong PIN → 401
_, _, ok = req("POST", "/auth/kid-login",
    {"child_id": child_id, "pin": "0000"}, token=parent_token, expect=401)
results.append(ok)
# Correct PIN → 200
kid_resp, _, ok = req("POST", "/auth/kid-login",
    {"child_id": child_id, "pin": "1234"}, token=parent_token)
results.append(ok)
kid_token = kid_resp.get("token", "")

# ── Assessment ────────────────────────────────────────────────
print("\n── Assessment ──")
_, _, ok = req("GET", "/assessment/questions"); results.append(ok)

# ── Content ───────────────────────────────────────────────────
print("\n── Content ──")
_, _, ok = req("GET", "/content/subjects"); results.append(ok)
_, _, ok = req("GET", "/content/grades"); results.append(ok)
_, _, ok = req("GET", "/content/worksheets"); results.append(ok)
_, _, ok = req("GET", "/content/story/today?grade=2"); results.append(ok)
_, _, ok = req("GET", "/content/wisdom/today"); results.append(ok)

# ── Questions ─────────────────────────────────────────────────
print("\n── Questions ──")
_, _, ok = req("GET", "/questions/generate?subject=math&grade=2&count=3"); results.append(ok)

# ── Progress ─────────────────────────────────────────────────
print("\n── Progress ──")
_, _, ok = req("POST", "/progress/log",
    {"child_id": child_id, "subject_id": 3, "duration_min": 15},
    token=parent_token); results.append(ok)
_, _, ok = req("GET", f"/progress/{child_id}", token=parent_token); results.append(ok)
_, _, ok = req("GET", f"/progress/{child_id}/chart", token=parent_token); results.append(ok)

# ── Admin (requires admin token — skipped if no admin token available) ──
print("\n── Admin (skipped — needs admin JWT) ──")
print("   → Run with ADMIN_TOKEN env var to test admin endpoints")
print("   → Or call POST /api/admin/set-password after seeding")

# ── Summary ──────────────────────────────────────────────────
total = len(results)
passed = sum(results)
print(f"\n{'='*70}")
print(f"Results: {passed}/{total} passed")
if passed == total:
    print("🎉  All tests passed!")
else:
    print(f"⚠️   {total - passed} test(s) failed — check output above")
print(f"{'='*70}\n")
