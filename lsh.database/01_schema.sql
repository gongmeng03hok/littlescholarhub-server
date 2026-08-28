-- ============================================================
--  Little Scholars Hub  —  SQL Server Schema
--  Run against SQL Server 2019+ or Azure SQL
-- ============================================================

USE master;
GO
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'LittleScholarHub')
    CREATE DATABASE LittleScholarHub;
GO
USE LittleScholarHub;
GO

-- ─── LOOKUP TABLES ──────────────────────────────────────────────────────────

CREATE TABLE dbo.Languages (
    language_id TINYINT      NOT NULL CONSTRAINT PK_Languages PRIMARY KEY,
    code        CHAR(5)      NOT NULL,
    label       NVARCHAR(32) NOT NULL
);

CREATE TABLE dbo.Grades (
    grade_id   TINYINT      NOT NULL CONSTRAINT PK_Grades PRIMARY KEY,
    label      NVARCHAR(16) NOT NULL,
    sort_order TINYINT      NOT NULL
);

CREATE TABLE dbo.Subjects (
    subject_id  TINYINT      NOT NULL CONSTRAINT PK_Subjects PRIMARY KEY,
    slug        VARCHAR(32)  NOT NULL CONSTRAINT UQ_Subject_Slug UNIQUE,
    label       NVARCHAR(64) NOT NULL,
    icon        NVARCHAR(8)  NOT NULL,
    is_cultural BIT          NOT NULL DEFAULT 0
);

CREATE TABLE dbo.DifficultyLevels (
    level_id TINYINT     NOT NULL CONSTRAINT PK_Difficulty PRIMARY KEY,
    label    VARCHAR(16) NOT NULL
);

-- ─── FAMILY / USER ──────────────────────────────────────────────────────────

CREATE TABLE dbo.Families (
    family_id      INT           NOT NULL CONSTRAINT PK_Families PRIMARY KEY IDENTITY,
    email          NVARCHAR(256) NOT NULL CONSTRAINT UQ_Family_Email UNIQUE,
    password_hash  VARCHAR(256)  NOT NULL,
    plann           VARCHAR(16)   NOT NULL DEFAULT 'explorer'
                       CHECK (plann IN ('explorer','family','shipped')),
    language_id    TINYINT       NOT NULL DEFAULT 1
                       CONSTRAINT FK_Families_Lang REFERENCES dbo.Languages(language_id),
    referral_code  CHAR(16)      NOT NULL,
    stripe_cust_id VARCHAR(64)   NULL,
    trial_ends_at  DATETIME2     NULL,
    created_at     DATETIME2     NOT NULL DEFAULT SYSUTCDATETIME(),
    updated_at     DATETIME2     NOT NULL DEFAULT SYSUTCDATETIME()
);

CREATE TABLE dbo.Children (
    child_id   INT           NOT NULL CONSTRAINT PK_Children PRIMARY KEY IDENTITY,
    family_id  INT           NOT NULL CONSTRAINT FK_Child_Family
                                 REFERENCES dbo.Families(family_id) ON DELETE CASCADE,
    nickname   NVARCHAR(64)  NOT NULL,
    grade_id   TINYINT       NOT NULL CONSTRAINT FK_Child_Grade REFERENCES dbo.Grades(grade_id),
    birth_year SMALLINT      NULL,
    avatar_url NVARCHAR(512) NULL,
    created_at DATETIME2     NOT NULL DEFAULT SYSUTCDATETIME()
);

-- ─── ASSESSMENT ─────────────────────────────────────────────────────────────

CREATE TABLE dbo.AssessmentSessions (
    session_id   INT       NOT NULL CONSTRAINT PK_AssessmentSessions PRIMARY KEY IDENTITY,
    child_id     INT       NOT NULL CONSTRAINT FK_AS_Child
                               REFERENCES dbo.Children(child_id) ON DELETE CASCADE,
    started_at   DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    completed_at DATETIME2 NULL,
    total_q      TINYINT   NOT NULL DEFAULT 15
);

CREATE TABLE dbo.AssessmentAnswers (
    answer_id    INT           NOT NULL CONSTRAINT PK_AA PRIMARY KEY IDENTITY,
    session_id   INT           NOT NULL CONSTRAINT FK_AA_Sess
                                   REFERENCES dbo.AssessmentSessions(session_id) ON DELETE CASCADE,
    step_key     VARCHAR(32)   NOT NULL,
    answer_value NVARCHAR(MAX) NULL
);

-- ─── CONTENT LIBRARY ────────────────────────────────────────────────────────

CREATE TABLE dbo.Worksheets (
    worksheet_id  INT            NOT NULL CONSTRAINT PK_Worksheets PRIMARY KEY IDENTITY,
    subject_id    TINYINT        NOT NULL CONSTRAINT FK_WS_Subj REFERENCES dbo.Subjects(subject_id),
    grade_id      TINYINT        NOT NULL CONSTRAINT FK_WS_Grade REFERENCES dbo.Grades(grade_id),
    language_id   TINYINT        NOT NULL DEFAULT 1
                      CONSTRAINT FK_WS_Lang REFERENCES dbo.Languages(language_id),
    difficulty_id TINYINT        NOT NULL DEFAULT 2
                      CONSTRAINT FK_WS_Diff REFERENCES dbo.DifficultyLevels(level_id),
    title         NVARCHAR(256)  NOT NULL,
    description   NVARCHAR(1024) NULL,
    pdf_url       NVARCHAR(512)  NULL,
    thumbnail_url NVARCHAR(512)  NULL,
    estimated_min TINYINT        NULL,
    teacher_name  NVARCHAR(128)  NULL,
    is_published  BIT            NOT NULL DEFAULT 1,
    created_at    DATETIME2      NOT NULL DEFAULT SYSUTCDATETIME()
);
CREATE INDEX IX_WS_SubjGrade ON dbo.Worksheets(subject_id, grade_id);
CREATE INDEX IX_WS_Lang      ON dbo.Worksheets(language_id);

CREATE TABLE dbo.Stories (
    story_id     INT            NOT NULL CONSTRAINT PK_Stories PRIMARY KEY IDENTITY,
    grade_id     TINYINT        NOT NULL CONSTRAINT FK_St_Grade REFERENCES dbo.Grades(grade_id),
    language_id  TINYINT        NOT NULL DEFAULT 1
                     CONSTRAINT FK_St_Lang REFERENCES dbo.Languages(language_id),
    title        NVARCHAR(256)  NOT NULL,
    body_text    NVARCHAR(MAX)  NOT NULL,
    audio_url    NVARCHAR(512)  NULL,
    read_min     TINYINT        NOT NULL DEFAULT 5,
    theme_tag    NVARCHAR(64)   NULL,
    vocab_json   NVARCHAR(MAX)  NULL,
    is_published BIT            NOT NULL DEFAULT 1,
    publish_date DATE           NOT NULL DEFAULT CAST(SYSUTCDATETIME() AS DATE),
    created_at   DATETIME2      NOT NULL DEFAULT SYSUTCDATETIME()
);

CREATE TABLE dbo.DailyWisdom (
    wisdom_id      INT           NOT NULL CONSTRAINT PK_Wisdom PRIMARY KEY IDENTITY,
    language_id    TINYINT       NOT NULL CONSTRAINT FK_DW_Lang REFERENCES dbo.Languages(language_id),
    source_track   VARCHAR(16)   NOT NULL CHECK (source_track IN ('gita','chinese','hispanic','universal')),
    text_original  NVARCHAR(512) NOT NULL,
    text_english   NVARCHAR(512) NULL,
    author         NVARCHAR(128) NULL,
    active_date    DATE          NULL
);

-- ─── QUESTION BANK ──────────────────────────────────────────────────────────

CREATE TABLE dbo.QuestionTemplates (
    template_id    INT            NOT NULL CONSTRAINT PK_QT PRIMARY KEY IDENTITY,
    subject_id     TINYINT        NOT NULL CONSTRAINT FK_QT_Subj REFERENCES dbo.Subjects(subject_id),
    grade_id       TINYINT        NOT NULL CONSTRAINT FK_QT_Grade REFERENCES dbo.Grades(grade_id),
    difficulty_id  TINYINT        NOT NULL CONSTRAINT FK_QT_Diff REFERENCES dbo.DifficultyLevels(level_id),
    template_type  VARCHAR(16)    NOT NULL CHECK (template_type IN ('static','algorithmic','fill_blank','mcq')),
    template_text  NVARCHAR(1024) NOT NULL,
    params_json    NVARCHAR(MAX)  NULL,
    answer_expr    NVARCHAR(256)  NULL,
    options_json   NVARCHAR(MAX)  NULL,
    is_active      BIT            NOT NULL DEFAULT 1,
    created_at     DATETIME2      NOT NULL DEFAULT SYSUTCDATETIME()
);
CREATE INDEX IX_QT_SubjGrade ON dbo.QuestionTemplates(subject_id, grade_id, difficulty_id);

CREATE TABLE dbo.GeneratedQuestions (
    gq_id          BIGINT         NOT NULL CONSTRAINT PK_GQ PRIMARY KEY IDENTITY,
    template_id    INT            NOT NULL CONSTRAINT FK_GQ_Tmpl REFERENCES dbo.QuestionTemplates(template_id),
    child_id       INT            NULL CONSTRAINT FK_GQ_Child REFERENCES dbo.Children(child_id),
    question_text  NVARCHAR(1024) NOT NULL,
    correct_answer NVARCHAR(256)  NOT NULL,
    options_json   NVARCHAR(MAX)  NULL,
    params_json    NVARCHAR(MAX)  NULL,
    generated_at   DATETIME2      NOT NULL DEFAULT SYSUTCDATETIME()
);

CREATE TABLE dbo.QuestionAttempts (
    attempt_id   BIGINT    NOT NULL CONSTRAINT PK_QAttempt PRIMARY KEY IDENTITY,
    child_id     INT       NOT NULL CONSTRAINT FK_QA_Child
                               REFERENCES dbo.Children(child_id) ON DELETE CASCADE,
    gq_id        BIGINT    NOT NULL CONSTRAINT FK_QA_GQ REFERENCES dbo.GeneratedQuestions(gq_id),
    given_answer NVARCHAR(256) NULL,
    is_correct   BIT       NOT NULL,
    time_sec     SMALLINT  NULL,
    attempted_at DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);

-- ─── WEEKLY PLANS ────────────────────────────────────────────────────────────

CREATE TABLE dbo.WeeklyPlans (
    plan_id      INT       NOT NULL CONSTRAINT PK_Plans PRIMARY KEY IDENTITY,
    child_id     INT       NOT NULL CONSTRAINT FK_Plan_Child
                               REFERENCES dbo.Children(child_id) ON DELETE CASCADE,
    week_start   DATE      NOT NULL,
    daily_min    TINYINT   NOT NULL DEFAULT 30,
    sessions_day TINYINT   NOT NULL DEFAULT 3,
    study_days   TINYINT   NOT NULL DEFAULT 5,
    plan_json    NVARCHAR(MAX) NULL,
    generated_at DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    CONSTRAINT UQ_Plan_ChildWeek UNIQUE (child_id, week_start)
);

CREATE TABLE dbo.PlanSubjectAlloc (
    alloc_id   INT     NOT NULL CONSTRAINT PK_Alloc PRIMARY KEY IDENTITY,
    plan_id    INT     NOT NULL CONSTRAINT FK_Alloc_Plan
                           REFERENCES dbo.WeeklyPlans(plan_id) ON DELETE CASCADE,
    subject_id TINYINT NOT NULL CONSTRAINT FK_Alloc_Subj REFERENCES dbo.Subjects(subject_id),
    minutes_wk SMALLINT NOT NULL
);

-- ─── PROGRESS / SESSIONS ─────────────────────────────────────────────────────

CREATE TABLE dbo.SessionLogs (
    log_id       BIGINT    NOT NULL CONSTRAINT PK_SL PRIMARY KEY IDENTITY,
    child_id     INT       NOT NULL CONSTRAINT FK_SL_Child
                               REFERENCES dbo.Children(child_id) ON DELETE CASCADE,
    plan_id      INT       NULL CONSTRAINT FK_SL_Plan REFERENCES dbo.WeeklyPlans(plan_id),
    subject_id   TINYINT   NOT NULL CONSTRAINT FK_SL_Subj REFERENCES dbo.Subjects(subject_id),
    worksheet_id INT       NULL CONSTRAINT FK_SL_WS REFERENCES dbo.Worksheets(worksheet_id),
    story_id     INT       NULL CONSTRAINT FK_SL_St REFERENCES dbo.Stories(story_id),
    session_date DATE      NOT NULL DEFAULT CAST(SYSUTCDATETIME() AS DATE),
    duration_min TINYINT   NOT NULL,
    completed    BIT       NOT NULL DEFAULT 1,
    logged_at    DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);
CREATE INDEX IX_SL_ChildDate ON dbo.SessionLogs(child_id, session_date);

CREATE TABLE dbo.Streaks (
    streak_id      INT          NOT NULL CONSTRAINT PK_Streaks PRIMARY KEY IDENTITY,
    child_id       INT          NOT NULL CONSTRAINT FK_Str_Child
                                    REFERENCES dbo.Children(child_id) ON DELETE CASCADE,
    current_streak INT          NOT NULL DEFAULT 0,
    longest_streak INT          NOT NULL DEFAULT 0,
    last_active    DATE         NULL,
    total_hours    DECIMAL(6,2) NOT NULL DEFAULT 0,
    updated_at     DATETIME2    NOT NULL DEFAULT SYSUTCDATETIME(),
    CONSTRAINT UQ_Streaks_Child UNIQUE (child_id)
);
GO
