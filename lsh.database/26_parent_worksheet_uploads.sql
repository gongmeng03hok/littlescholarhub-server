-- ============================================================
--  Little Scholars Hub — Migration 026
--  Marks a Worksheets row as privately uploaded by a parent
--  (vs. the public, admin-curated catalog). Private rows are
--  always is_published=0 so they never surface in public browsing.
--  Run AFTER 25_parent_assignments.sql
-- ============================================================

USE LittleScholarHub;
GO

IF NOT EXISTS (
    SELECT 1 FROM sys.columns
    WHERE object_id = OBJECT_ID('dbo.Worksheets') AND name = 'owner_family_id'
)
BEGIN
    ALTER TABLE dbo.Worksheets
        ADD owner_family_id INT NULL CONSTRAINT FK_Worksheets_OwnerFamily REFERENCES dbo.Families(family_id);
    PRINT 'Added Worksheets.owner_family_id';
END
GO
