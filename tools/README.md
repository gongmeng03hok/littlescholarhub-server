# Probes

Scripts that exercise the live API the way a real user does, then assert on
what comes back — not on status codes. A 200 with an empty body is how most of
the bugs in this codebase have looked.

Run them from `lsh.api`, so `.env` is loaded and `DB_CONN` resolves:

    cd /var/www/littlescholarhub/lsh.api
    ./venv/bin/python ../tools/probe_progress_roundtrip.py

Each creates its own throwaway family and deletes everything afterwards,
including rows in the seventeen tables that reference a child. They sweep on
entry too, so a run killed halfway leaves nothing permanent. Check the tail of
the output: it prints the family and children counts, which should match what
you started with (13 and 12 at the time of writing).

| script | what it proves |
| --- | --- |
| `probe_progress_roundtrip.py` | a session a child does comes back out again — minutes logged, attempts listed, correct count, XP, badges |
| `probe_teacher_admin.py` | an admin can approve a teacher, and an approved teacher can run a classroom |
| `sweep_worksheets.py` | every published worksheet still serves questions |

The round trip is also wired into `contract_test.py`, so `deploy.sh` fails
rather than publishing a build where progress stops being saved or stops being
shown. Both halves matter: the save path broke once and the endpoint still
answered `200 {is_correct: true}` while writing nothing.

## Why they create real accounts

There is no staging database. The alternative — asserting against the 13 real
families — would either prove nothing or corrupt their data. A throwaway
family that is removed at the end is the honest option, but it does mean these
scripts write to production, so read the cleanup block before changing them.
