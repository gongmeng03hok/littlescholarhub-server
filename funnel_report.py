# -*- coding: utf-8 -*-
"""Funnel report — where do people stop?

    lsh.api/venv/bin/python funnel_report.py [days]

Reads dbo.FunnelEvents. Counts SESSIONS, not events: one person answering
eighteen questions is one visit, not eighteen.
"""
import sys, collections, datetime
import pyodbc

DAYS = int(sys.argv[1]) if len(sys.argv) > 1 else 14

for line in open("/var/www/littlescholarhub/lsh.api/.env", encoding="utf-8", errors="replace"):
    if line.strip().startswith("DB_CONN="):
        CS = line.strip().split("=", 1)[1].strip().strip('"').strip("'")

c = pyodbc.connect(CS); cur = c.cursor()
cur.execute("""SELECT event_name, session_key, step, meta, CONVERT(date, created_at)
               FROM dbo.FunnelEvents
               WHERE created_at >= DATEADD(day, -?, SYSUTCDATETIME())""", DAYS)
rows = cur.fetchall()

if not rows:
    print("No events in the last %d days.\n" % DAYS)
    print("If the site has had visitors, telemetry may not be deployed — check that")
    print("dist was published after the tracker was added.")
    raise SystemExit(0)

sessions = collections.defaultdict(set)
maxstep = collections.defaultdict(int)
byday = collections.defaultdict(set)
for name, key, step, meta, day in rows:
    sessions[key].add(name)
    if name == "assessment_step" and step:
        maxstep[key] = max(maxstep[key], step)
    byday[day].add(key)

total = len(sessions)
STAGES = [
    ("landing_view",        "arrived on the landing page"),
    ("pricing_view",        "looked at pricing"),
    ("assessment_start",    "opened the assessment"),
    ("assessment_complete", "finished all the questions"),
    ("register_view",       "reached the sign-up form"),
    ("register_success",    "created an account"),
    ("child_added",         "added a child (plan becomes real)"),
]

print("Funnel — last %d days\n" % DAYS)
print("  visits (unique sessions): %d\n" % total)
print("  %-38s %6s %8s %8s" % ("stage", "visits", "of all", "of prev"))
print("  " + "-" * 64)
prev = None
for name, label in STAGES:
    n = sum(1 for k, ev in sessions.items() if name in ev)
    pct = (100.0 * n / total) if total else 0
    step = ("%7.0f%%" % (100.0 * n / prev)) if prev else "      —"
    print("  %-38s %6d %7.0f%% %8s" % (label, n, pct, step))
    if n:
        prev = n

if maxstep:
    print("\n  Where the assessment stops (last question reached):")
    hist = collections.Counter(maxstep.values())
    worst = max(hist.values())
    for q in sorted(hist):
        bar = "#" * int(20.0 * hist[q] / worst)
        print("    q%-3d %3d  %s" % (q, hist[q], bar))
    started = len(maxstep)
    finished = sum(1 for k, ev in sessions.items() if "assessment_complete" in ev)
    print("    started %d, finished %d (%.0f%%)"
          % (started, finished, 100.0 * finished / started if started else 0))

print("\n  Visits per day:")
for d in sorted(byday):
    print("    %s  %3d" % (d, len(byday[d])))

drop = []
prevn = None
for name, label in STAGES:
    n = sum(1 for k, ev in sessions.items() if name in ev)
    if prevn and n < prevn:
        drop.append((prevn - n, label, 100.0 - 100.0 * n / prevn))
    if n:
        prevn = n
if drop:
    lost, label, pct = max(drop)
    print("\n  Biggest single drop: %.0f%% are lost before they %s (%d visits)."
          % (pct, label, lost))
