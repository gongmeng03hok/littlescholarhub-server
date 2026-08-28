-- ============================================================
--  Little Scholars Hub  —  Views & Stored Procedures
-- ============================================================

USE LittleScholarHub;
GO

-- ─── VIEW: Child dashboard summary ──────────────────────────────────────────
CREATE OR ALTER VIEW dbo.vw_ChildDashboard AS
SELECT
    c.child_id,
    c.nickname,
    g.label                        AS grade,
    ISNULL(st.current_streak, 0)   AS current_streak,
    ISNULL(st.longest_streak, 0)   AS longest_streak,
    ISNULL(st.total_hours, 0)      AS total_hours,
    st.last_active,
    (SELECT COUNT(*)
     FROM dbo.SessionLogs sl
     WHERE sl.child_id = c.child_id
       AND sl.session_date >= CAST(DATEADD(day,-7,GETDATE()) AS DATE)) AS sessions_this_week,
    (SELECT ISNULL(SUM(sl.duration_min),0)
     FROM dbo.SessionLogs sl
     WHERE sl.child_id = c.child_id
       AND sl.session_date >= CAST(DATEADD(day,-7,GETDATE()) AS DATE)) AS minutes_this_week
FROM dbo.Children c
JOIN dbo.Grades   g  ON c.grade_id   = g.grade_id
LEFT JOIN dbo.Streaks st ON c.child_id = st.child_id;
GO

-- ─── VIEW: Subject progress last 30 days ────────────────────────────────────
CREATE OR ALTER VIEW dbo.vw_SubjectProgress AS
SELECT
    sl.child_id,
    s.slug,
    s.label,
    s.icon,
    SUM(sl.duration_min)  AS total_min,
    COUNT(*)              AS session_count,
    MAX(sl.session_date)  AS last_studied
FROM dbo.SessionLogs sl
JOIN dbo.Subjects s ON sl.subject_id = s.subject_id
WHERE sl.session_date >= CAST(DATEADD(day,-30,GETDATE()) AS DATE)
GROUP BY sl.child_id, s.slug, s.label, s.icon;
GO

-- ─── VIEW: Weekly plan with subject names ────────────────────────────────────
CREATE OR ALTER VIEW dbo.vw_WeeklyPlanAlloc AS
SELECT
    wp.plan_id,
    wp.child_id,
    wp.week_start,
    wp.daily_min,
    s.slug,
    s.label,
    s.icon,
    psa.minutes_wk
FROM dbo.WeeklyPlans wp
JOIN dbo.PlanSubjectAlloc psa ON wp.plan_id   = psa.plan_id
JOIN dbo.Subjects         s   ON psa.subject_id = s.subject_id;
GO

-- ─── PROC: Get today's story for a child ────────────────────────────────────
CREATE OR ALTER PROCEDURE dbo.usp_GetTodayStory
    @child_id   INT,
    @language_id TINYINT = 1
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @grade_id TINYINT;
    SELECT @grade_id = grade_id FROM dbo.Children WHERE child_id = @child_id;

    SELECT TOP 1
        story_id, title, body_text, read_min, theme_tag, vocab_json, audio_url
    FROM dbo.Stories
    WHERE grade_id   <= @grade_id
      AND language_id = @language_id
      AND is_published = 1
    ORDER BY NEWID();
END;
GO

-- ─── PROC: Log session + update streak ──────────────────────────────────────
CREATE OR ALTER PROCEDURE dbo.usp_LogSession
    @child_id    INT,
    @subject_id  TINYINT,
    @duration_min TINYINT,
    @plan_id     INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.SessionLogs (child_id, subject_id, duration_min, completed, plan_id)
    VALUES (@child_id, @subject_id, @duration_min, 1, @plan_id);

    MERGE dbo.Streaks AS tgt
    USING (SELECT @child_id AS cid) AS src ON tgt.child_id = src.cid
    WHEN MATCHED THEN UPDATE SET
        current_streak = CASE
            WHEN last_active = CAST(DATEADD(day,-1,GETDATE()) AS DATE) THEN current_streak + 1
            WHEN last_active = CAST(GETDATE() AS DATE)                 THEN current_streak
            ELSE 1 END,
        longest_streak = CASE
            WHEN current_streak + 1 > longest_streak THEN current_streak + 1
            ELSE longest_streak END,
        last_active  = CAST(GETDATE() AS DATE),
        total_hours  = total_hours + @duration_min / 60.0,
        updated_at   = GETDATE()
    WHEN NOT MATCHED THEN INSERT
        (child_id, current_streak, longest_streak, last_active, total_hours)
        VALUES (@child_id, 1, 1, CAST(GETDATE() AS DATE), @duration_min / 60.0);
END;
GO

-- ─── PROC: Generate weekly plan allocation rows ──────────────────────────────
CREATE OR ALTER PROCEDURE dbo.usp_SavePlanAlloc
    @plan_id   INT,
    @alloc_json NVARCHAR(MAX)   -- JSON: [{"subject_id":3,"minutes_wk":45}, ...]
AS
BEGIN
    SET NOCOUNT ON;
    DELETE FROM dbo.PlanSubjectAlloc WHERE plan_id = @plan_id;

    INSERT INTO dbo.PlanSubjectAlloc (plan_id, subject_id, minutes_wk)
    SELECT @plan_id, subject_id, minutes_wk
    FROM OPENJSON(@alloc_json)
    WITH (subject_id TINYINT '$.subject_id', minutes_wk SMALLINT '$.minutes_wk');
END;
GO

-- ─── PROC: Admin stats ───────────────────────────────────────────────────────
CREATE OR ALTER PROCEDURE dbo.usp_AdminStats
AS
BEGIN
    SET NOCOUNT ON;
    SELECT
        (SELECT COUNT(*) FROM dbo.Families)    AS total_families,
        (SELECT COUNT(*) FROM dbo.Children)    AS total_children,
        (SELECT COUNT(*) FROM dbo.SessionLogs) AS total_sessions,
        (SELECT COUNT(*) FROM dbo.Worksheets WHERE is_published=1) AS published_worksheets,
        (SELECT COUNT(*) FROM dbo.Stories     WHERE is_published=1) AS published_stories,
        (SELECT ISNULL(SUM(duration_min),0)/60.0
         FROM dbo.SessionLogs)                 AS total_learning_hours;
END;
GO
