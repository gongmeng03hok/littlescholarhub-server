-- ============================================================
--  Little Scholars Hub — Migration 021
--  Adds: Worksheets.is_free (free-tier/print-without-signup flag),
--        Worksheets.pdf_generator_key (built-in generator id for
--        catalog worksheets that don't have a real uploaded PDF)
-- ============================================================

USE LittleScholarHub;
GO

IF NOT EXISTS (
    SELECT 1 FROM sys.columns
    WHERE object_id = OBJECT_ID('dbo.Worksheets') AND name = 'is_free'
)
BEGIN
    ALTER TABLE dbo.Worksheets ADD is_free BIT NOT NULL DEFAULT 0;
    PRINT 'Added is_free column to Worksheets';
END
GO

IF NOT EXISTS (
    SELECT 1 FROM sys.columns
    WHERE object_id = OBJECT_ID('dbo.Worksheets') AND name = 'pdf_generator_key'
)
BEGIN
    ALTER TABLE dbo.Worksheets ADD pdf_generator_key VARCHAR(64) NULL;
    PRINT 'Added pdf_generator_key column to Worksheets';
END
GO
