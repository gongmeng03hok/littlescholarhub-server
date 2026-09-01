-- ============================================================
--  Little Scholars Hub — Migration 10  (schema catch-up)
-- ============================================================
--  WHY THIS EXISTS
--  The live production database contains objects that the API code
--  (routes/content.py, routes/admin.py, services/dynamic_math.py) uses
--  but which were never committed to 01_schema.sql .. 09. As a result a
--  FRESH rebuild from the tracked .sql files crashes on:
--     • worksheet open            → UPDATE dbo.Worksheets SET view_count ...
--     • admin PDF upload / serve  → dbo.UploadedFiles
--     • featured collections CRUD → dbo.FeaturedCollections
--     • admin worksheet edit      → extra Worksheets columns
--
--  This migration reconstructs those objects (guarded by IF NOT EXISTS /
--  COL_LENGTH checks, so it is safe to run against the live DB, where it
--  will simply skip anything that already exists).
--
--  ⚠ Column TYPES below are reconstructed from how the code uses them plus
--  the live API responses. Sathya: please diff against production and adjust
--  any types you defined differently, then keep this file as the source of
--  truth so the repo can be rebuilt from scratch.
-- ============================================================

USE LittleScholarHub;
GO

-- ─── 1. Missing dbo.Worksheets columns ──────────────────────────────────────
IF COL_LENGTH('dbo.Worksheets','content_type') IS NULL
    ALTER TABLE dbo.Worksheets ADD content_type NVARCHAR(32)  NOT NULL DEFAULT 'worksheet';
GO
IF COL_LENGTH('dbo.Worksheets','interest_tag') IS NULL
    ALTER TABLE dbo.Worksheets ADD interest_tag NVARCHAR(64)  NULL;
GO
IF COL_LENGTH('dbo.Worksheets','page_count') IS NULL
    ALTER TABLE dbo.Worksheets ADD page_count   INT           NULL;
GO
IF COL_LENGTH('dbo.Worksheets','social_badge') IS NULL
    ALTER TABLE dbo.Worksheets ADD social_badge NVARCHAR(64)  NULL;
GO
IF COL_LENGTH('dbo.Worksheets','is_trending') IS NULL
    ALTER TABLE dbo.Worksheets ADD is_trending  BIT           NOT NULL DEFAULT 0;
GO
IF COL_LENGTH('dbo.Worksheets','rating_avg') IS NULL
    ALTER TABLE dbo.Worksheets ADD rating_avg   DECIMAL(3,2)  NULL;
GO
IF COL_LENGTH('dbo.Worksheets','rating_count') IS NULL
    ALTER TABLE dbo.Worksheets ADD rating_count INT           NOT NULL DEFAULT 0;
GO
IF COL_LENGTH('dbo.Worksheets','view_count') IS NULL
    ALTER TABLE dbo.Worksheets ADD view_count   INT           NOT NULL DEFAULT 0;
GO

-- ─── 2. dbo.UploadedFiles (admin PDF uploads, stored as VARBINARY) ───────────
IF OBJECT_ID('dbo.UploadedFiles','U') IS NULL
BEGIN
    CREATE TABLE dbo.UploadedFiles (
        file_id     INT            NOT NULL CONSTRAINT PK_UploadedFiles PRIMARY KEY IDENTITY,
        filename    NVARCHAR(256)  NOT NULL,
        mime_type   NVARCHAR(128)  NOT NULL,
        file_size   INT            NOT NULL,
        data        VARBINARY(MAX) NOT NULL,
        uploaded_by INT            NULL
                        CONSTRAINT FK_UploadedFiles_Family REFERENCES dbo.Families(family_id),
        created_at  DATETIME2      NOT NULL DEFAULT SYSUTCDATETIME()
    );
END;
GO

-- ─── 3. dbo.FeaturedCollections (admin "featured worksheets" CRUD) ───────────
IF OBJECT_ID('dbo.FeaturedCollections','U') IS NULL
BEGIN
    CREATE TABLE dbo.FeaturedCollections (
        featured_id      INT           NOT NULL CONSTRAINT PK_FeaturedCollections PRIMARY KEY IDENTITY,
        worksheet_id     INT           NOT NULL
                             CONSTRAINT FK_Featured_Worksheet REFERENCES dbo.Worksheets(worksheet_id),
        subtitle_override NVARCHAR(256) NULL,
        sort_order       INT           NOT NULL DEFAULT 0,
        is_active        BIT           NOT NULL DEFAULT 1,
        starts_at        DATETIME2      NULL,
        ends_at          DATETIME2      NULL,
        created_at       DATETIME2      NOT NULL DEFAULT SYSUTCDATETIME()
    );
END;
GO

-- ─── 4. Correct the assessment question count (18, not 15) ───────────────────
--  The assessment seeds 18 questions (09_assessment_questions.sql) and the
--  subtitle already reads "18 short questions", but this counter was left at 15.
UPDATE dbo.AppConfig
   SET config_value = '18'
 WHERE config_key = 'assessment.total_questions'
   AND config_value <> '18';
GO

-- ─── 5. TODO — usp_GetDynamicMathQuestions ──────────────────────────────────
--  services/dynamic_math.py calls  EXEC dbo.usp_GetDynamicMathQuestions
--  @grade_id=?, @count=?  but no .sql defines it, so the DB-backed math path
--  silently falls back to hard-coded templates (the error is swallowed by a
--  bare except). This is non-fatal, so no stub is created here to avoid
--  guessing its result-set shape. Sathya: either ship the real proc (scripted
--  from production if it exists there) or remove the DB path in dynamic_math.py.
GO
