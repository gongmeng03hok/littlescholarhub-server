-- 48_practice_packet_intro_proc.sql
-- Updates usp_GetOrCreateWeeklyPacket's category result set to also return
-- intro_text (added in 46_practice_packet_passages.sql) so the UI can show
-- a reading passage above a category's questions when one exists.

CREATE OR ALTER PROCEDURE dbo.usp_GetOrCreateWeeklyPacket
    @grade_id       INT,
    @week_of        DATE,
    @category_count INT = 14
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

        ;WITH ranked AS (
            SELECT category_id, subject_area,
                   ROW_NUMBER() OVER (PARTITION BY subject_area ORDER BY NEWID()) AS rn
            FROM dbo.PacketCategories
            WHERE grade_id = @grade_id AND is_active = 1
        ),
        picked AS (
            SELECT TOP (@category_count) category_id
            FROM ranked
            ORDER BY rn, NEWID()
        )
        INSERT INTO dbo.WeeklyPacketPlanCategories (plan_id, category_id, sort_order)
        SELECT @plan_id, category_id, ROW_NUMBER() OVER (ORDER BY NEWID())
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
