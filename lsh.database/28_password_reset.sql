-- ============================================================
--  Little Scholars Hub — Migration 028
--  Forgot-password support: a one-time, time-limited reset token
--  stored per family.
-- ============================================================

USE LittleScholarHub;
GO

IF COL_LENGTH('dbo.Families','reset_token') IS NULL
BEGIN
    ALTER TABLE dbo.Families ADD reset_token VARCHAR(64) NULL;
    PRINT 'Added Families.reset_token';
END
GO

IF COL_LENGTH('dbo.Families','reset_token_expires') IS NULL
BEGIN
    ALTER TABLE dbo.Families ADD reset_token_expires DATETIME2 NULL;
    PRINT 'Added Families.reset_token_expires';
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_Families_ResetToken')
BEGIN
    CREATE INDEX IX_Families_ResetToken ON dbo.Families(reset_token) WHERE reset_token IS NOT NULL;
    PRINT 'Added IX_Families_ResetToken';
END
GO
