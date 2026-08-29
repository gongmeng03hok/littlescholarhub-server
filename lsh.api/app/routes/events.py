# -*- coding: utf-8 -*-
"""
routes/events.py — /api/events

First-party funnel telemetry. Deliberately the smallest thing that answers
"where do people stop", and nothing more.

What it does NOT record, on purpose: IP address, cookie, user agent, family or
child id, or any text a person typed. `session_key` is a random value the
browser keeps in sessionStorage for the life of the tab; it cannot be joined to
an account and does not survive the tab closing.

The product is sold on "COPPA & kid-privacy-first" and is used by four-year-olds.
A third-party analytics tag would contradict that, so there isn't one.
"""
import re

from flask import Blueprint, request, jsonify

from utils.db import qry

events_bp = Blueprint("events", __name__)

#: Only these are accepted. An allowlist keeps the table from filling with
#: whatever a future caller invents, and makes the funnel query stable.
ALLOWED = {
    "landing_view",        # someone arrived
    "cta_click",           # pressed "Build my child's plan"
    "assessment_start",    # first question shown
    "assessment_step",     # step = question number reached
    "assessment_complete", # answered the last one
    "plan_view",           # the plan reveal screen
    "register_view",       # reached the sign-up form
    "register_success",    # account created
    "child_added",         # the point the plan becomes real
    "sample_view",         # opened a worksheet preview
    "pricing_view",        # scrolled to pricing
}

_KEY = re.compile(r"^[A-Za-z0-9]{16}$")
_META = re.compile(r"^[A-Za-z0-9 _.:/-]{0,64}$")


@events_bp.post("")
@events_bp.post("/")
def record():
    """Fire-and-forget. Always 204, never blocks the page, never errors upward.

    Telemetry must not be able to break the product it is measuring, so every
    failure path here is silent.
    """
    try:
        body = request.get_json(silent=True) or {}
        name = str(body.get("event", ""))[:48]
        if name not in ALLOWED:
            return "", 204

        key = str(body.get("session", ""))[:16]
        if not _KEY.match(key):
            return "", 204

        step = body.get("step")
        try:
            step = int(step) if step is not None else None
            if step is not None and not (0 <= step <= 999):
                step = None
        except (TypeError, ValueError):
            step = None

        meta = body.get("meta")
        meta = str(meta)[:64] if meta is not None else None
        if meta is not None and not _META.match(meta):
            meta = None

        qry(
            "INSERT INTO dbo.FunnelEvents (event_name, session_key, step, meta)"
            " VALUES (?, ?, ?, ?)",
            (name, key, step, meta), fetch="exec"
        )
    except Exception:
        # A dropped measurement is a smaller problem than a broken page.
        pass
    return "", 204
