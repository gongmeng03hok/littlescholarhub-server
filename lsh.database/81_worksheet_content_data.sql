-- 42_worksheet_content_data.sql
-- Adds a content_data column to dbo.Worksheets so worksheet content can be
-- stored in SQL and served through the API, instead of being hardcoded in
-- Python functions in services/worksheet_pdf_generator.py.
--
-- This mirrors the existing game_data pattern already on this table
-- (added 42_writing_science_and_games.sql) -- a single JSON blob column,
-- rather than a new child-table schema, since worksheet content shapes
-- (lists of strings, (word, hint) pairs, blocks) don't map cleanly onto
-- fixed columns the way dbo.PacketQuestions does for the Weekly Packets
-- question bank.
--
-- Nullable and purely additive: every existing worksheet keeps rendering
-- exactly as before via pdf_generator_key until its row gets a
-- content_data value. See services/worksheet_pdf_generator.py's
-- render_from_content_data() for the renderer this column feeds, and
-- scratch_tmp/extract_worksheet_content.py + write_worksheet_content.py
-- for how the ~296 eligible rows got their content_data populated (via
-- pyodbc, not this file -- see the note there on why).
--
-- content_data JSON shape:
--   {"renderer": "text_page", "params": {"title": ..., "subtitle": ...,
--    "footer_label": ..., "blocks": [...], "answers": [...]}}
-- "renderer" is one of: build, text_page, tracing_items, checklist,
-- word_match_table, draw_your_own -- the six shared rendering helpers in
-- worksheet_pdf_generator.py.

IF NOT EXISTS (
    SELECT 1 FROM sys.columns
    WHERE object_id = OBJECT_ID('dbo.Worksheets') AND name = 'content_data'
)
BEGIN
    ALTER TABLE dbo.Worksheets ADD content_data NVARCHAR(MAX) NULL;
END
