-- 37_story_assignments.sql
-- Lets a parent assign one of our own authored mini-stories (dbo.Stories)
-- directly to a child, reusing the existing StudentAssignments pipeline
-- (same table used for worksheet assignments) rather than a parallel one.
-- worksheet_id becomes nullable; story_id is the alternative reference.
-- Exactly one of the two must be set.

IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID('dbo.StudentAssignments') AND name = 'worksheet_id' AND is_nullable = 0)
BEGIN
    ALTER TABLE dbo.StudentAssignments ALTER COLUMN worksheet_id INT NULL;
    PRINT 'StudentAssignments.worksheet_id is now nullable';
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID('dbo.StudentAssignments') AND name = 'story_id')
BEGIN
    ALTER TABLE dbo.StudentAssignments ADD story_id INT NULL
        CONSTRAINT FK_SA_Story REFERENCES dbo.Stories(story_id);
    PRINT 'Added StudentAssignments.story_id';
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.check_constraints WHERE name = 'CK_SA_OneContentRef')
BEGIN
    ALTER TABLE dbo.StudentAssignments ADD CONSTRAINT CK_SA_OneContentRef
        CHECK (
            (worksheet_id IS NOT NULL AND story_id IS NULL) OR
            (worksheet_id IS NULL AND story_id IS NOT NULL)
        );
    PRINT 'Added CK_SA_OneContentRef';
END
GO
