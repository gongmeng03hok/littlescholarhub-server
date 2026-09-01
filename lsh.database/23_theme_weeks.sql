-- ============================================================
--  Little Scholars Hub — Migration 023
--  "Weekly Story Packs" (market research report, Section 4 & 7.2):
--  a themed bundle = one read-aloud story + a set of worksheets
--  (vocab / math / art / workbook) + a journal prompt, all on one
--  theme (e.g. "Ocean Week"). Curated by admins from existing
--  Stories/Worksheets content — no new content types needed.
-- ============================================================

USE LittleScholarHub;
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'ThemeWeeks' AND type = 'U')
BEGIN
    CREATE TABLE dbo.ThemeWeeks (
        theme_week_id  INT           NOT NULL CONSTRAINT PK_ThemeWeeks PRIMARY KEY IDENTITY,
        title          NVARCHAR(128) NOT NULL,
        theme_slug     VARCHAR(64)   NOT NULL CONSTRAINT UQ_ThemeWeek_Slug UNIQUE,
        description    NVARCHAR(512) NULL,
        grade_id       TINYINT       NULL CONSTRAINT FK_ThemeWeek_Grade REFERENCES dbo.Grades(grade_id),
        story_id       INT           NULL CONSTRAINT FK_ThemeWeek_Story REFERENCES dbo.Stories(story_id),
        journal_prompt NVARCHAR(512) NULL,
        is_published   BIT           NOT NULL DEFAULT 1,
        sort_order     INT           NOT NULL DEFAULT 0,
        created_at     DATETIME2     NOT NULL DEFAULT SYSUTCDATETIME()
    );
    PRINT 'Created ThemeWeeks table';
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'ThemeWeekWorksheets' AND type = 'U')
BEGIN
    CREATE TABLE dbo.ThemeWeekWorksheets (
        link_id       INT          NOT NULL CONSTRAINT PK_ThemeWeekWorksheets PRIMARY KEY IDENTITY,
        theme_week_id INT          NOT NULL CONSTRAINT FK_TWW_ThemeWeek
                                       REFERENCES dbo.ThemeWeeks(theme_week_id) ON DELETE CASCADE,
        worksheet_id  INT          NOT NULL CONSTRAINT FK_TWW_Worksheet
                                       REFERENCES dbo.Worksheets(worksheet_id),
        role          VARCHAR(32)  NOT NULL DEFAULT 'worksheet'
                                       CONSTRAINT CK_TWW_Role CHECK (role IN ('vocab','math','art','workbook','worksheet')),
        sort_order    INT          NOT NULL DEFAULT 0,
        CONSTRAINT UQ_TWW_WeekWorksheet UNIQUE (theme_week_id, worksheet_id)
    );
    PRINT 'Created ThemeWeekWorksheets table';
END
GO
