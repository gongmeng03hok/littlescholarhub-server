-- 62_weekly_min_questions.sql
-- Guarantees every weekly packet has at least @min_questions (default 30)
-- questions. The per-subject rotation from 61_weekly_category_rotation.sql
-- can land a short week (e.g. every subject hitting its smallest/remainder
-- group at once) below a useful floor, especially for grades with fewer,
-- smaller categories (TK/K). After the normal rotation pick, this tops the
-- packet up by pulling in additional rotation groups (cycling forward,
-- deterministically, same idempotent-per-week guarantee as before) from
-- subjects that still have unused categories, until the floor is met.

CREATE OR ALTER PROCEDURE dbo.usp_GetOrCreateWeeklyPacket
    @grade_id               INT,
    @week_of                DATE,
    @categories_per_subject INT = 3,
    @min_questions          INT = 30
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @plan_id INT;

    SELECT @plan_id = plan_id FROM dbo.WeeklyPacketPlan
    WHERE grade_id = @grade_id AND week_of = @week_of;

    IF @plan_id IS NULL
    BEGIN
        DECLARE @title NVARCHAR(200) =
            (SELECT label FROM dbo.Grades WHERE grade_id = @grade_id) + N' Weekly Practice Packet';

        INSERT INTO dbo.WeeklyPacketPlan (grade_id, week_of, title)
        VALUES (@grade_id, @week_of, @title);

        SET @plan_id = SCOPE_IDENTITY();

        DECLARE @week_index INT = DATEDIFF(day, '2020-01-06', @week_of) / 7;

        ;WITH base AS (
            SELECT category_id, subject_area, target_count,
                   ROW_NUMBER() OVER (PARTITION BY subject_area ORDER BY category_id) AS rn,
                   COUNT(*) OVER (PARTITION BY subject_area) AS subj_count
            FROM dbo.PacketCategories
            WHERE grade_id = @grade_id AND is_active = 1
        )
        SELECT category_id, subject_area, target_count, rn,
               CAST(CEILING(subj_count * 1.0 / @categories_per_subject) AS INT) AS num_groups,
               (rn - 1) / @categories_per_subject AS group_index
        INTO #pool
        FROM base;

        CREATE TABLE #picked (category_id INT PRIMARY KEY, target_count INT);

        -- Base pick: this week's rotated group for every subject.
        INSERT INTO #picked (category_id, target_count)
        SELECT category_id, target_count FROM #pool
        WHERE group_index = (@week_index % num_groups);

        -- Top up with additional rotation groups (cycling forward through
        -- each subject's own group list) until the floor is cleared.
        DECLARE @total INT = (SELECT ISNULL(SUM(target_count), 0) FROM #picked);
        DECLARE @extra INT = 1;
        WHILE @total < @min_questions AND @extra <= 20
        BEGIN
            INSERT INTO #picked (category_id, target_count)
            SELECT p.category_id, p.target_count
            FROM #pool p
            WHERE p.num_groups > 1
              AND p.group_index = ((@week_index + @extra) % p.num_groups)
              AND NOT EXISTS (SELECT 1 FROM #picked pk WHERE pk.category_id = p.category_id);

            IF @@ROWCOUNT = 0 AND NOT EXISTS (
                SELECT 1 FROM #pool p WHERE NOT EXISTS (SELECT 1 FROM #picked pk WHERE pk.category_id = p.category_id)
            )
                BREAK; -- every category this grade has is already picked

            SET @total = (SELECT ISNULL(SUM(target_count), 0) FROM #picked);
            SET @extra += 1;
        END

        INSERT INTO dbo.WeeklyPacketPlanCategories (plan_id, category_id, sort_order)
        SELECT @plan_id, category_id, ROW_NUMBER() OVER (ORDER BY category_id)
        FROM #picked;

        ;WITH qranked AS (
            SELECT wpc.plan_cat_id, q.question_id,
                   ROW_NUMBER() OVER (PARTITION BY wpc.plan_cat_id ORDER BY NEWID()) AS rn,
                   pc.target_count
            FROM dbo.WeeklyPacketPlanCategories wpc
            JOIN dbo.PacketCategories pc ON pc.category_id = wpc.category_id
            JOIN dbo.PacketQuestions q ON q.category_id = wpc.category_id AND q.is_active = 1
            WHERE wpc.plan_id = @plan_id
        )
        INSERT INTO dbo.WeeklyPacketPlanQuestions (plan_cat_id, question_id, sort_order)
        SELECT plan_cat_id, question_id, rn
        FROM qranked
        WHERE rn <= target_count;

        DROP TABLE #pool;
        DROP TABLE #picked;
    END

    SELECT plan_id, grade_id, week_of, title
    FROM dbo.WeeklyPacketPlan
    WHERE plan_id = @plan_id;

    SELECT wpc.plan_cat_id, wpc.sort_order, pc.category_id, pc.category_name,
           pc.subject_area, pc.layout_type, pc.intro_text
    FROM dbo.WeeklyPacketPlanCategories wpc
    JOIN dbo.PacketCategories pc ON pc.category_id = wpc.category_id
    WHERE wpc.plan_id = @plan_id
    ORDER BY wpc.sort_order;

    SELECT wpq.plan_cat_id, wpq.sort_order, q.question_id, q.question_type,
           q.prompt, q.choices_json, q.answer_text, q.diagram_type, q.diagram_data
    FROM dbo.WeeklyPacketPlanQuestions wpq
    JOIN dbo.PacketQuestions q ON q.question_id = wpq.question_id
    JOIN dbo.WeeklyPacketPlanCategories wpc ON wpc.plan_cat_id = wpq.plan_cat_id
    WHERE wpc.plan_id = @plan_id
    ORDER BY wpq.plan_cat_id, wpq.sort_order;
END
GO

DELETE FROM dbo.WeeklyPacketPlan;
GO
