-- 55_title_content_fixes.sql
-- Two data mismatches found by the title-vs-content audit.
--
-- C) Eleven rows are titled "... Workbooks - Grade N" but stored as
--    content_type 'worksheet'. The title says workbook, so the card, the verb
--    on the open button, and the cover art were all wrong for them.
-- D) One row names its theme in the title but has no interest_tag, so it could
--    never receive themed questions.

SET NOCOUNT ON;

UPDATE dbo.Worksheets
SET content_type = 'workbook'
WHERE title LIKE '%Workbooks - Grade%' AND content_type = 'worksheet';
GO

UPDATE dbo.Worksheets
SET interest_tag = 'space'
WHERE worksheet_id = 224 AND interest_tag IS NULL;
GO

SELECT content_type, COUNT(*) AS n
FROM dbo.Worksheets
WHERE title LIKE '%Workbooks - Grade%'
GROUP BY content_type;
GO
