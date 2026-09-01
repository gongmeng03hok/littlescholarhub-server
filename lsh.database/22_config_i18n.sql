-- ============================================================
--  Little Scholars Hub — Migration 022
--  Makes AppConfig language-aware: adds language_id, switches the
--  primary key to (config_key, language_id) so every config value
--  can have an English/Mandarin/Hindi/Spanish variant.
--  Existing rows default to language_id=1 (English) — no data loss.
-- ============================================================

USE LittleScholarHub;
GO

IF NOT EXISTS (
    SELECT 1 FROM sys.columns
    WHERE object_id = OBJECT_ID('dbo.AppConfig') AND name = 'language_id'
)
BEGIN
    ALTER TABLE dbo.AppConfig ADD language_id TINYINT NOT NULL DEFAULT 1;
    PRINT 'Added language_id column to AppConfig';
END
GO

-- Swap the single-column PK for a composite (config_key, language_id) PK
IF EXISTS (
    SELECT 1 FROM sys.key_constraints
    WHERE name = 'PK_AppConfig' AND parent_object_id = OBJECT_ID('dbo.AppConfig')
)
BEGIN
    ALTER TABLE dbo.AppConfig DROP CONSTRAINT PK_AppConfig;
    ALTER TABLE dbo.AppConfig ADD CONSTRAINT PK_AppConfig PRIMARY KEY (config_key, language_id);
    PRINT 'Rebuilt AppConfig primary key as (config_key, language_id)';
END
GO

IF NOT EXISTS (
    SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_Config_Language'
)
BEGIN
    ALTER TABLE dbo.AppConfig ADD CONSTRAINT FK_Config_Language
        FOREIGN KEY (language_id) REFERENCES dbo.Languages(language_id);
    PRINT 'Added FK_Config_Language';
END
GO
