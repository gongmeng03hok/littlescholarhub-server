"""
regen_filler_worksheets.py — One-off maintenance script.

Regenerates every Worksheets row that was seeded pre-generator (pdf_generator_key
IS NULL, pdf_url points at an UploadedFiles blob) by re-running it through
services/interest_worksheet_generator.py and overwriting the stored blob in
place, so the fixed grammar/grade-label templates reach files that already
have real students/parents pointing at their existing file_id/pdf_url.

Usage (from lsh.api/app, inside the venv):
  python regen_filler_worksheets.py --dry-run   # generate + print, no DB writes
  python regen_filler_worksheets.py             # generate and overwrite blobs
"""
import os
import re
import sys

import pyodbc
from dotenv import load_dotenv

load_dotenv()

sys.path.insert(0, os.path.dirname(__file__))

from services.interest_worksheet_generator import THEMES, generate  # noqa: E402

LABEL_TO_SLUG = {theme["label"]: slug for slug, theme in THEMES.items()}
FILE_ID_RE = re.compile(r"/files/(\d+)")


def main():
    dry_run = "--dry-run" in sys.argv
    conn = pyodbc.connect(os.getenv("DB_CONN", ""), autocommit=False)
    cur = conn.cursor()

    cur.execute(
        "SELECT w.worksheet_id, w.title, w.pdf_url, s.slug AS topic, w.grade_id "
        "FROM dbo.Worksheets w "
        "JOIN dbo.Subjects s ON w.subject_id = s.subject_id "
        "WHERE w.pdf_generator_key IS NULL AND w.pdf_url LIKE '%/content/files/%' "
        "ORDER BY w.worksheet_id"
    )
    rows = cur.fetchall()
    columns = [c[0] for c in cur.description]
    rows = [dict(zip(columns, r)) for r in rows]
    print(f"Found {len(rows)} filler worksheets to regenerate.")

    done, skipped = 0, 0
    for row in rows:
        title = row["title"]
        theme_label = next((lbl for lbl in LABEL_TO_SLUG if title.startswith(lbl + " ")), None)
        file_id_match = FILE_ID_RE.search(row["pdf_url"] or "")
        if not theme_label or not file_id_match:
            print(f"  SKIP worksheet_id={row['worksheet_id']} title={title!r} — couldn't parse theme/file_id")
            skipped += 1
            continue

        interest_slug = LABEL_TO_SLUG[theme_label]
        file_id = int(file_id_match.group(1))

        try:
            pdf_bytes = generate(row["topic"], row["grade_id"], interest_slug)
        except Exception as exc:
            print(f"  FAIL worksheet_id={row['worksheet_id']} topic={row['topic']} slug={interest_slug}: {exc}")
            skipped += 1
            continue

        if not dry_run:
            cur.execute(
                "UPDATE dbo.UploadedFiles SET data=?, file_size=? WHERE file_id=?",
                (pdf_bytes, len(pdf_bytes), file_id)
            )
        done += 1
        tag = "DRY" if dry_run else "OK"
        print(f"  {tag} worksheet_id={row['worksheet_id']} file_id={file_id} "
              f"topic={row['topic']} theme={interest_slug} grade={row['grade_id']} ({len(pdf_bytes)} bytes)")

    if dry_run:
        conn.rollback()
        print(f"\nDry run — no writes committed. Would regenerate {done}, skipped {skipped}.")
    else:
        conn.commit()
        print(f"\nDone. Regenerated {done}, skipped {skipped}.")


if __name__ == "__main__":
    main()
