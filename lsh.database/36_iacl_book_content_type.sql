-- 36_iacl_book_content_type.sql
-- Extends Worksheets.content_type to allow 'iacl_book' — used when a parent
-- assigns a specific book from Archive.org's IACL (Internet Archive
-- Children's Library) collection to their child. Books are NOT bulk
-- imported; a Worksheets row is created lazily, only for a book a parent
-- actually chose, the first time it's assigned (see POST /content/iacl/assign).
-- pdf_url for these rows is the archive.org details page; the reader itself
-- is archive.org's own embedded BookReader (page-turning + native
-- read-aloud), not content we rehost.

IF EXISTS (SELECT 1 FROM sys.check_constraints WHERE name = 'CK_WS_ContentType')
BEGIN
    ALTER TABLE dbo.Worksheets DROP CONSTRAINT CK_WS_ContentType;
END
GO

ALTER TABLE dbo.Worksheets ADD CONSTRAINT CK_WS_ContentType
    CHECK (content_type IN ('workbook', 'mini_book', 'coloring', 'worksheet', 'space_image', 'iacl_book'));
GO
