-- 61_weekly_category_rotation.sql
-- Replaces the "show every category every week" behavior (categories were
-- selected via a TOP(999) sentinel, so a grade's full category list showed
-- up unchanged week after week, with only the individual questions inside
-- each category varying) with a deterministic weekly rotation:
--
--   For each subject_area, categories are split into fixed groups of
--   @categories_per_subject (default 3), ordered by category_id. Which
--   group shows in a given week is picked by a continuously-incrementing
--   week index (weeks since 2020-01-06, a Monday) modulo the subject's
--   group count — so week N always yields the same group (reproducible),
--   consecutive weeks show non-overlapping categories, and the full set
--   cycles back around after group_count weeks. Subjects with
--   @categories_per_subject or fewer total categories (writing, science,
--   social_studies, puzzle today) have only one group and so show
--   everything every week, same as before — there's nothing to rotate.
--
-- Also clears every existing WeeklyPacketPlan so the new rotation applies
-- retroactively to weeks already generated under the old "everything"
-- logic (cascades to WeeklyPacketPlanCategories / WeeklyPacketPlanQuestions).

CREATE OR ALTER PROCEDURE dbo.usp_GetOrCreateWeeklyPacket
    @grade_id             INT,
    @week_of              DATE,
    @categories_per_subject INT = 3
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

        ;WITH ranked AS (
            SELECT category_id, subject_area,
                   ROW_NUMBER() OVER (PARTITION BY subject_area ORDER BY category_id) AS rn,
                   COUNT(*) OVER (PARTITION BY subject_area) AS subj_count
            FROM dbo.PacketCategories
            WHERE grade_id = @grade_id AND is_active = 1
        ),
        grouped AS (
            SELECT category_id,
                   CAST(CEILING(subj_count * 1.0 / @categories_per_subject) AS INT) AS num_groups,
                   (rn - 1) / @categories_per_subject AS group_index
            FROM ranked
        ),
        picked AS (
            SELECT category_id
            FROM grouped
            WHERE group_index = (@week_index % num_groups)
        )
        INSERT INTO dbo.WeeklyPacketPlanCategories (plan_id, category_id, sort_order)
        SELECT @plan_id, category_id, ROW_NUMBER() OVER (ORDER BY category_id)
        FROM picked;

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
