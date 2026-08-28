-- 29_classroom_grade.sql
-- Gives each classroom an explicit grade level (previously only implied by
-- free-text classroom_name, e.g. a classroom literally named "K"), so the
-- teacher UI can sort classrooms by grade and filter worksheets by the
-- selected classroom's grade. Also fixes grade display order to the
-- school's convention: K, TK, 1st, 2nd, 3rd, 4th, 5th, 6th.

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID('dbo.Classrooms') AND name = 'grade_id')
BEGIN
    ALTER TABLE dbo.Classrooms ADD grade_id TINYINT NULL
        CONSTRAINT FK_Classroom_Grade REFERENCES dbo.Grades(grade_id);
    PRINT 'Added Classrooms.grade_id';
END
GO

-- Backfill from existing classroom_name where it matches a grade label exactly
-- (every existing classroom in production is literally named after its grade).
UPDATE c
SET c.grade_id = g.grade_id
FROM dbo.Classrooms c
JOIN dbo.Grades g ON LOWER(LTRIM(RTRIM(c.classroom_name))) = LOWER(g.label)
WHERE c.grade_id IS NULL;
GO

-- Classroom/grade picker order: K, TK, 1st, 2nd, 3rd, 4th, 5th, 6th
UPDATE dbo.Grades SET sort_order = 0 WHERE grade_id = 1; -- K
UPDATE dbo.Grades SET sort_order = 1 WHERE grade_id = 0; -- TK
GO
