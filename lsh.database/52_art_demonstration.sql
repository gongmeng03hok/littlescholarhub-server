-- 52_art_demonstration.sql
-- Art worksheets are demonstrations, not quizzes.
--
-- Until now an art worksheet opened the question player, and because
-- QuestionGenerator.GENERATORS has no "art" entry it silently served MATH —
-- so "Animals Art - Grade 2nd" asked a child to count dimes. All 28 art
-- worksheets already carry a real printable sheet (via pdf_url); what was
-- missing was somewhere to put the demonstration itself.
--
-- Adds three nullable columns. Nullable on purpose: a row with no steps and no
-- video still renders a valid demonstration (sheet + description), so this is
-- safe to apply before any content is authored.

IF NOT EXISTS (SELECT 1 FROM sys.columns
               WHERE object_id = OBJECT_ID('dbo.Worksheets') AND name = 'video_url')
BEGIN
    ALTER TABLE dbo.Worksheets ADD video_url NVARCHAR(512) NULL;
    PRINT 'Added Worksheets.video_url';
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns
               WHERE object_id = OBJECT_ID('dbo.Worksheets') AND name = 'steps_json')
BEGIN
    -- JSON array of strings, e.g. N'["Fold the paper in half.","Cut slits..."]'
    ALTER TABLE dbo.Worksheets ADD steps_json NVARCHAR(MAX) NULL;
    PRINT 'Added Worksheets.steps_json';
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns
               WHERE object_id = OBJECT_ID('dbo.Worksheets') AND name = 'materials')
BEGIN
    ALTER TABLE dbo.Worksheets ADD materials NVARCHAR(512) NULL;
    PRINT 'Added Worksheets.materials';
END
GO

-- ── Seeded steps ─────────────────────────────────────────────────────────────
-- Only for the crafts whose steps already exist elsewhere in this repo, so the
-- wording stays consistent with what the site already shows parents:
-- Rangoli and Papel Picado are lifted from the culture-track projects in
-- 14_culture_detail_config.sql. Every other art row is left NULL rather than
-- invented — a coloring page needs the sheet, not instructions.
--
-- video_url is deliberately left NULL everywhere. Attaching a guessed YouTube
-- id would point children at an unverified video; these must be filled in
-- deliberately (admin > Content > Worksheets).

UPDATE dbo.Worksheets
SET steps_json = N'["Mark the center of a paper plate or square of card.",
                    "Draw 8 light pencil lines so the circle is split into equal slices.",
                    "Place colored dots along each line, repeating the same pattern in every slice.",
                    "Add a flower motif in the middle, then go over the pencil lines in color."]',
    materials  = N'Paper plate or card · colored dot stickers or markers · pencil'
WHERE pdf_generator_key = 'rangoli_geometry' AND steps_json IS NULL;
GO

UPDATE dbo.Worksheets
SET steps_json = N'["Fold a sheet of tissue paper in half the long way, then in half again.",
                    "Cut small shapes in from the folded edges — stop before the far side.",
                    "Cut a row of triangles along the bottom edge to make the fringe.",
                    "Unfold gently and glue the top edge over a long piece of string.",
                    "Repeat in three colors and hang the banner across a doorway."]',
    materials  = N'Tissue paper in 3 colors · scissors · glue stick · string'
WHERE pdf_generator_key = 'papel_picado' AND steps_json IS NULL;
GO

UPDATE dbo.Worksheets
SET steps_json = N'["Draw a horizon line across the page and mark one dot on it — the vanishing point.",
                    "Draw a simple rectangle anywhere off to one side.",
                    "Join each corner of the rectangle to the vanishing point with a light line.",
                    "Draw a second rectangle between those lines to close off the back of the shape.",
                    "Erase the guide lines beyond the box, then shade one side darker."]',
    materials  = N'Paper · pencil · ruler · eraser'
WHERE pdf_generator_key = 'one_point_perspective' AND steps_json IS NULL;
GO

SELECT worksheet_id, title,
       CASE WHEN steps_json IS NULL THEN 'no steps' ELSE 'has steps' END AS steps,
       CASE WHEN video_url  IS NULL THEN 'no video' ELSE video_url     END AS video
FROM dbo.Worksheets
WHERE subject_id = 4
ORDER BY grade_id, worksheet_id;
GO
