-- ============================================================
--  Little Scholars Hub  —  Migration: Add Indexes & Constraints
--  Run AFTER 01_schema.sql and 02_seed.sql
-- ============================================================

USE LittleScholarHub;
GO

-- Full-text search on Stories (if FTS feature is installed)
-- CREATE FULLTEXT CATALOG lsh_ft AS DEFAULT;
-- CREATE FULLTEXT INDEX ON dbo.Stories(title,body_text) KEY INDEX PK_Stories;

-- Composite index for assessment lookups
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name='IX_AS_ChildCompleted')
    CREATE INDEX IX_AS_ChildCompleted
        ON dbo.AssessmentSessions(child_id, completed_at DESC);

-- Index on QuestionAttempts for analytics
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name='IX_QAttempt_ChildDate')
    CREATE INDEX IX_QAttempt_ChildDate
        ON dbo.QuestionAttempts(child_id, attempted_at DESC);

-- Index on Stories by publish date
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name='IX_Stories_Publish')
    CREATE INDEX IX_Stories_Publish
        ON dbo.Stories(publish_date DESC, is_published);

-- Index on DailyWisdom for random rotation
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name='IX_Wisdom_Lang')
    CREATE INDEX IX_Wisdom_Lang
        ON dbo.DailyWisdom(language_id, active_date);

-- Computed column: child age estimate from birth_year
IF NOT EXISTS (
    SELECT 1 FROM sys.columns
    WHERE object_id=OBJECT_ID('dbo.Children') AND name='age_estimate'
)
ALTER TABLE dbo.Children
    ADD age_estimate AS (YEAR(GETDATE()) - birth_year);

-- Default avatar patterns view
CREATE OR ALTER VIEW dbo.vw_ChildAvatars AS
SELECT
    child_id,
    nickname,
    ISNULL(avatar_url,
        'https://ui-avatars.com/api/?name=' +
        REPLACE(nickname,' ','+') +
        '&background=5b4fcf&color=fff&size=128'
    ) AS avatar_url
FROM dbo.Children;
GO

-- ── Useful reporting queries ─────────────────────────────────────────────────

-- Daily active learners (last 7 days)
CREATE OR ALTER VIEW dbo.vw_DailyActiveLearners AS
SELECT
    session_date,
    COUNT(DISTINCT child_id) AS active_children,
    SUM(duration_min)        AS total_minutes
FROM dbo.SessionLogs
WHERE session_date >= CAST(DATEADD(day, -7, GETDATE()) AS DATE)
GROUP BY session_date;
GO

-- Top subjects by total time
CREATE OR ALTER VIEW dbo.vw_TopSubjects AS
SELECT TOP 10
    s.slug,
    s.label,
    s.icon,
    SUM(sl.duration_min) AS total_minutes,
    COUNT(*)             AS session_count
FROM dbo.SessionLogs sl
JOIN dbo.Subjects s ON sl.subject_id = s.subject_id
GROUP BY s.slug, s.label, s.icon
ORDER BY total_minutes DESC;
GO
