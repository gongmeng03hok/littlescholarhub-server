-- 60_remove_archive_org_content.sql
-- Removes all content and references tied to archive.org:
--   1. "iacl_book" worksheets (books a parent assigned via the Story
--      Library's live archive.org browse/search) + their assignments.
--   2. "space_image" worksheets (the Solar System photo set, hotlinked
--      from archive.org's solarsystemcollection) + their assignments,
--      and the now-empty "Solar System" subject itself.
--   3. archive.org attribution fields on the IACL-adapted Stories —
--      the story TEXT is original retelling and stays; only the
--      thumbnail_url/source_url/source_attribution pointing back to
--      archive.org are cleared.
--   4. Narrows the Worksheets.content_type check constraint back down
--      now that 'iacl_book' and 'space_image' are unused.

DELETE sa
FROM dbo.StudentAssignments sa
JOIN dbo.Worksheets w ON sa.worksheet_id = w.worksheet_id
WHERE w.content_type IN ('iacl_book', 'space_image');
GO

DELETE FROM dbo.Worksheets WHERE content_type IN ('iacl_book', 'space_image');
GO

DELETE FROM dbo.Subjects WHERE subject_id = 17 AND slug = 'solar_system';
GO

UPDATE dbo.Stories
SET thumbnail_url = NULL, source_url = NULL, source_attribution = NULL
WHERE source_url LIKE '%archive.org%' OR thumbnail_url LIKE '%archive.org%' OR source_attribution LIKE '%Archive%';
GO

IF EXISTS (SELECT 1 FROM sys.check_constraints WHERE name = 'CK_WS_ContentType')
BEGIN
    ALTER TABLE dbo.Worksheets DROP CONSTRAINT CK_WS_ContentType;
END
GO

ALTER TABLE dbo.Worksheets ADD CONSTRAINT CK_WS_ContentType
    CHECK (content_type IN ('workbook', 'mini_book', 'coloring', 'worksheet', 'weekly_packet', 'game'));
GO
