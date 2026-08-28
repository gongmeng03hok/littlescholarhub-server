-- ============================================================
--  Little Scholars Hub  —  Math Weekly Worksheet Schema
--  Run AFTER 01_schema.sql
-- ============================================================

USE LittleScholarHub;
GO

-- ── Math attempts tracking ────────────────────────────────────────────────────

CREATE TABLE dbo.MathAttempts (
    attempt_id    BIGINT        NOT NULL CONSTRAINT PK_MathAttempts PRIMARY KEY IDENTITY,
    child_id      INT           NOT NULL CONSTRAINT FK_MA_Child
                                    REFERENCES dbo.Children(child_id) ON DELETE CASCADE,
    topic_slug    VARCHAR(48)   NOT NULL,
    week_num      TINYINT       NOT NULL,   -- ISO week 1-52
    year_num      SMALLINT      NOT NULL DEFAULT YEAR(GETDATE()),
    section_type  VARCHAR(16)   NOT NULL DEFAULT 'skill_focus'
                                    CHECK (section_type IN
                                        ('warm_up','skill_focus','spiral_review',
                                         'word_problems','friday_assessment','timed_drill')),
    question_text NVARCHAR(512) NOT NULL,
    given_answer  NVARCHAR(128) NULL,
    correct_answer NVARCHAR(128) NOT NULL,
    is_correct    BIT           NOT NULL,
    time_sec      SMALLINT      NULL,
    xp_earned     TINYINT       NOT NULL DEFAULT 0,
    attempted_at  DATETIME2     NOT NULL DEFAULT SYSUTCDATETIME()
);
CREATE INDEX IX_MA_ChildWeek  ON dbo.MathAttempts(child_id, week_num, year_num);
CREATE INDEX IX_MA_TopicSlug  ON dbo.MathAttempts(topic_slug);

-- ── Weekly XP / badge totals (materialised summary) ──────────────────────────

CREATE TABLE dbo.MathWeeklyXP (
    xp_id         INT     NOT NULL CONSTRAINT PK_MathXP PRIMARY KEY IDENTITY,
    child_id      INT     NOT NULL CONSTRAINT FK_MXP_Child
                              REFERENCES dbo.Children(child_id) ON DELETE CASCADE,
    week_num      TINYINT NOT NULL,
    year_num      SMALLINT NOT NULL,
    total_xp      INT     NOT NULL DEFAULT 0,
    total_correct INT     NOT NULL DEFAULT 0,
    total_attempts INT    NOT NULL DEFAULT 0,
    badges_json   NVARCHAR(MAX) NULL,   -- ["perfect_week","speed_star",...]
    updated_at    DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    CONSTRAINT UQ_MXP_ChildWeek UNIQUE (child_id, week_num, year_num)
);

-- ── Topic mastery per child ──────────────────────────────────────────────────

CREATE TABLE dbo.TopicMastery (
    mastery_id    INT          NOT NULL CONSTRAINT PK_Mastery PRIMARY KEY IDENTITY,
    child_id      INT          NOT NULL CONSTRAINT FK_TM_Child
                                   REFERENCES dbo.Children(child_id) ON DELETE CASCADE,
    topic_slug    VARCHAR(48)  NOT NULL,
    attempts      INT          NOT NULL DEFAULT 0,
    correct       INT          NOT NULL DEFAULT 0,
    mastery_pct   AS (CASE WHEN attempts=0 THEN 0
                     ELSE CAST(correct*100/attempts AS INT) END) PERSISTED,
    last_seen     DATE         NULL,
    CONSTRAINT UQ_TM_ChildSlug UNIQUE (child_id, topic_slug)
);
CREATE INDEX IX_TM_Child ON dbo.TopicMastery(child_id);

-- ── Stored procedure: upsert topic mastery after each attempt ─────────────────

CREATE OR ALTER PROCEDURE dbo.usp_UpdateTopicMastery
    @child_id   INT,
    @topic_slug VARCHAR(48),
    @is_correct BIT
AS
BEGIN
    SET NOCOUNT ON;
    MERGE dbo.TopicMastery AS tgt
    USING (SELECT @child_id AS cid, @topic_slug AS slug) AS src
       ON tgt.child_id = src.cid AND tgt.topic_slug = src.slug
    WHEN MATCHED THEN UPDATE SET
        attempts  = attempts + 1,
        correct   = correct + @is_correct,
        last_seen = CAST(GETDATE() AS DATE)
    WHEN NOT MATCHED THEN INSERT
        (child_id, topic_slug, attempts, correct, last_seen)
        VALUES (@child_id, @topic_slug, 1, @is_correct, CAST(GETDATE() AS DATE));
END;
GO

-- ── Stored procedure: upsert weekly XP ──────────────────────────────────────

CREATE OR ALTER PROCEDURE dbo.usp_UpsertWeeklyXP
    @child_id   INT,
    @week_num   TINYINT,
    @year_num   SMALLINT,
    @xp         TINYINT,
    @is_correct BIT
AS
BEGIN
    SET NOCOUNT ON;
    MERGE dbo.MathWeeklyXP AS tgt
    USING (SELECT @child_id AS cid, @week_num AS wk, @year_num AS yr) AS src
       ON tgt.child_id=src.cid AND tgt.week_num=src.wk AND tgt.year_num=src.yr
    WHEN MATCHED THEN UPDATE SET
        total_xp       = total_xp + @xp,
        total_correct  = total_correct + @is_correct,
        total_attempts = total_attempts + 1,
        updated_at     = GETDATE()
    WHEN NOT MATCHED THEN INSERT
        (child_id, week_num, year_num, total_xp, total_correct, total_attempts)
        VALUES (@child_id, @week_num, @year_num, @xp, @is_correct, 1);
END;
GO

-- ── View: child math dashboard ────────────────────────────────────────────────

CREATE OR ALTER VIEW dbo.vw_MathDashboard AS
SELECT
    c.child_id,
    c.nickname,
    g.label                               AS grade,
    ISNULL(SUM(x.total_xp),       0)      AS lifetime_xp,
    ISNULL(SUM(x.total_correct),  0)      AS lifetime_correct,
    ISNULL(SUM(x.total_attempts), 0)      AS lifetime_attempts,
    (SELECT COUNT(*) FROM dbo.TopicMastery tm
     WHERE tm.child_id=c.child_id AND tm.mastery_pct>=80) AS topics_mastered,
    (SELECT TOP 1 topic_slug FROM dbo.TopicMastery tm2
     WHERE tm2.child_id=c.child_id
     ORDER BY tm2.mastery_pct DESC)       AS strongest_topic
FROM dbo.Children c
JOIN dbo.Grades   g ON c.grade_id=g.grade_id
LEFT JOIN dbo.MathWeeklyXP x ON c.child_id=x.child_id
GROUP BY c.child_id, c.nickname, g.label;
GO

-- ── Seed: sample badge definitions (stored as reference data) ─────────────────

CREATE TABLE dbo.Badges (
    badge_id    INT          NOT NULL CONSTRAINT PK_Badges PRIMARY KEY IDENTITY,
    slug        VARCHAR(32)  NOT NULL CONSTRAINT UQ_Badge_Slug UNIQUE,
    label       NVARCHAR(64) NOT NULL,
    icon        NVARCHAR(8)  NOT NULL,
    description NVARCHAR(256) NULL,
    xp_value    TINYINT      NOT NULL DEFAULT 10
);

INSERT INTO dbo.Badges (slug,label,icon,description,xp_value) VALUES
('first_sheet',    'First Worksheet!',     '📄','Complete your first daily worksheet.',     10),
('perfect_day',    'Perfect Day',          '⭐','Get every question right in one day.',      25),
('speed_star',     'Speed Star',           '⚡','Answer 5 questions in under 10 seconds each.',20),
('drill_master',   'Drill Master',         '🎯','Complete a 30-fact drill with 100% accuracy.',30),
('week_warrior',   'Week Warrior',         '🏆','Complete all 5 days in a week.',            50),
('topic_mastered', 'Topic Mastered',       '🎓','Reach 80% accuracy on any topic.',         40),
('streak_3',       '3-Day Streak',         '🔥','Study 3 days in a row.',                   15),
('streak_7',       '7-Day Streak',         '🔥','Study 7 days in a row.',                   35),
('xp_100',         '100 XP Club',          '💎','Earn 100 XP total.',                        20),
('xp_500',         '500 XP Legend',        '👑','Earn 500 XP total.',                        50);
GO
