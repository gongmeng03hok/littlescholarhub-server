-- 34_worksheet_content_type_space_image.sql
-- Extends the Worksheets.content_type CHECK constraint to allow
-- 'space_image', used by the Solar System subject's NASA image content
-- (see 33_solar_system_content.sql).

IF EXISTS (SELECT 1 FROM sys.check_constraints WHERE name = 'CK_WS_ContentType')
BEGIN
    ALTER TABLE dbo.Worksheets DROP CONSTRAINT CK_WS_ContentType;
END
GO

ALTER TABLE dbo.Worksheets ADD CONSTRAINT CK_WS_ContentType
    CHECK (content_type IN ('workbook', 'mini_book', 'coloring', 'worksheet', 'space_image'));
GO
