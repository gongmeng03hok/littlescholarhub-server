-- ============================================================
--  Little Scholars Hub — Migration 025
--  Allows a parent to directly assign a worksheet to their own
--  child, independent of any teacher/classroom.
--  Run AFTER 17_student_assignments.sql
-- ============================================================

USE LittleScholarHub;
GO

-- classroom_id was NOT NULL (teacher-only assignments). Relax it so a
-- parent-direct assignment (no classroom) can be stored in the same table.
IF EXISTS (
    SELECT 1 FROM sys.columns
    WHERE object_id = OBJECT_ID('dbo.StudentAssignments')
      AND name = 'classroom_id' AND is_nullable = 0
)
BEGIN
    ALTER TABLE dbo.StudentAssignments ALTER COLUMN classroom_id INT NULL;
    PRINT 'StudentAssignments.classroom_id is now nullable';
END
GO

IF NOT EXISTS (
    SELECT 1 FROM sys.columns
    WHERE object_id = OBJECT_ID('dbo.StudentAssignments') AND name = 'family_id'
)
BEGIN
    ALTER TABLE dbo.StudentAssignments
        ADD family_id INT NULL CONSTRAINT FK_SA_Family REFERENCES dbo.Families(family_id);
    PRINT 'Added StudentAssignments.family_id';
END
GO

IF NOT EXISTS (
    SELECT 1 FROM sys.check_constraints WHERE name = 'CK_SA_Source'
)
BEGIN
    ALTER TABLE dbo.StudentAssignments
        ADD CONSTRAINT CK_SA_Source CHECK (classroom_id IS NOT NULL OR family_id IS NOT NULL);
    PRINT 'Added CK_SA_Source check constraint';
END
GO
