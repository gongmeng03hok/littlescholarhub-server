-- 43_practice_packets.sql
-- DB-driven "weekly practice packet" system: a question BANK stored in the
-- database (per grade/subject/category), composed into a specific week's
-- packet by a stored procedure, and served to the UI via the API — as
-- opposed to the existing PDF-generator (`worksheet_pdf_generator.py`)
-- weekly-packet feature, which hardcodes/randomizes content in Python.
--
-- This is the pilot for the ABC Unified category-bank approach: Kindergarten,
-- Week 1 only (14 categories / 149 questions), to validate the schema +
-- stored-proc + API + UI pipeline before authoring the remaining ~90
-- categories x 8 grades. See PacketCategories/PacketQuestions for the bank,
-- WeeklyPacketPlan(+Categories/+Questions) for the specific, persisted
-- selection served for a given grade+week (idempotent — re-fetching the same
-- week returns the same composed packet, it does not re-shuffle).

IF OBJECT_ID('dbo.PacketCategories', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.PacketCategories (
        category_id     INT IDENTITY PRIMARY KEY,
        grade_id        TINYINT NOT NULL REFERENCES dbo.Grades(grade_id),
        subject_area    VARCHAR(20) NOT NULL
            CHECK (subject_area IN ('math','ela','writing','science','social_studies','puzzle')),
        category_name   NVARCHAR(200) NOT NULL,
        layout_type     VARCHAR(20) NOT NULL
            CHECK (layout_type IN ('short_answer','space_heavy','puzzle')),
        target_count    TINYINT NOT NULL DEFAULT 10,
        is_active       BIT NOT NULL DEFAULT 1,
        created_at      DATETIME2 DEFAULT SYSUTCDATETIME()
    );
END
GO

IF OBJECT_ID('dbo.PacketQuestions', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.PacketQuestions (
        question_id     INT IDENTITY PRIMARY KEY,
        category_id     INT NOT NULL REFERENCES dbo.PacketCategories(category_id),
        question_type   VARCHAR(20) NOT NULL
            CHECK (question_type IN ('fill_blank','multiple_choice','short_response','matching','word_search')),
        prompt          NVARCHAR(MAX) NOT NULL,
        choices_json    NVARCHAR(MAX) NULL,
        answer_text     NVARCHAR(MAX) NOT NULL,
        sort_order      INT NOT NULL DEFAULT 0,
        is_active       BIT NOT NULL DEFAULT 1
    );
END
GO

IF OBJECT_ID('dbo.WeeklyPacketPlan', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.WeeklyPacketPlan (
        plan_id         INT IDENTITY PRIMARY KEY,
        grade_id        TINYINT NOT NULL REFERENCES dbo.Grades(grade_id),
        week_of         DATE NOT NULL,
        title           NVARCHAR(200) NOT NULL,
        created_at      DATETIME2 DEFAULT SYSUTCDATETIME(),
        CONSTRAINT UQ_WeeklyPacketPlan_GradeWeek UNIQUE (grade_id, week_of)
    );
END
GO

IF OBJECT_ID('dbo.WeeklyPacketPlanCategories', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.WeeklyPacketPlanCategories (
        plan_cat_id     INT IDENTITY PRIMARY KEY,
        plan_id         INT NOT NULL REFERENCES dbo.WeeklyPacketPlan(plan_id) ON DELETE CASCADE,
        category_id     INT NOT NULL REFERENCES dbo.PacketCategories(category_id),
        sort_order      INT NOT NULL
    );
END
GO

IF OBJECT_ID('dbo.WeeklyPacketPlanQuestions', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.WeeklyPacketPlanQuestions (
        plan_q_id       INT IDENTITY PRIMARY KEY,
        plan_cat_id     INT NOT NULL REFERENCES dbo.WeeklyPacketPlanCategories(plan_cat_id) ON DELETE CASCADE,
        question_id     INT NOT NULL REFERENCES dbo.PacketQuestions(question_id),
        sort_order      INT NOT NULL
    );
END
GO


-- ============================================================
--  Stored procedure: get-or-create a grade+week's practice packet
-- ============================================================
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

        -- Balanced-ish category selection: rank categories within each
        -- subject_area randomly so no single subject can dominate the draw,
        -- then take the top N overall.
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

        -- For each selected category, randomly sample up to its target_count
        -- from that category's question bank.
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

    -- Result set 1: plan header
    SELECT plan_id, grade_id, week_of, title
    FROM dbo.WeeklyPacketPlan
    WHERE plan_id = @plan_id;

    -- Result set 2: categories in this plan, in order
    SELECT wpc.plan_cat_id, wpc.sort_order, pc.category_id, pc.category_name,
           pc.subject_area, pc.layout_type
    FROM dbo.WeeklyPacketPlanCategories wpc
    JOIN dbo.PacketCategories pc ON pc.category_id = wpc.category_id
    WHERE wpc.plan_id = @plan_id
    ORDER BY wpc.sort_order;

    -- Result set 3: questions in this plan, in order within each category
    SELECT wpq.plan_cat_id, wpq.sort_order, q.question_id, q.question_type,
           q.prompt, q.choices_json, q.answer_text
    FROM dbo.WeeklyPacketPlanQuestions wpq
    JOIN dbo.PacketQuestions q ON q.question_id = wpq.question_id
    JOIN dbo.WeeklyPacketPlanCategories wpc ON wpc.plan_cat_id = wpq.plan_cat_id
    WHERE wpc.plan_id = @plan_id
    ORDER BY wpq.plan_cat_id, wpq.sort_order;
END
GO


-- ============================================================
--  Kindergarten pilot content bank (14 categories, 149 questions)
-- ============================================================
IF NOT EXISTS (SELECT 1 FROM dbo.PacketCategories WHERE grade_id = 1)
BEGIN
DECLARE @cat1 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count) VALUES (1, 'math', N'Addition within 10', 'short_answer', 10);
SET @cat1 = SCOPE_IDENTITY();

DECLARE @cat2 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count) VALUES (1, 'math', N'Subtraction within 10', 'short_answer', 10);
SET @cat2 = SCOPE_IDENTITY();

DECLARE @cat3 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count) VALUES (1, 'math', N'Comparing Numbers (>, <) within 10', 'short_answer', 10);
SET @cat3 = SCOPE_IDENTITY();

DECLARE @cat4 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count) VALUES (1, 'math', N'Skip Counting by 2s, 5s, 10s', 'short_answer', 8);
SET @cat4 = SCOPE_IDENTITY();

DECLARE @cat5 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count) VALUES (1, 'math', N'Counting to 100 by Ones', 'short_answer', 8);
SET @cat5 = SCOPE_IDENTITY();

DECLARE @cat6 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count) VALUES (1, 'math', N'Telling Time to the Hour', 'short_answer', 8);
SET @cat6 = SCOPE_IDENTITY();

DECLARE @cat7 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count) VALUES (1, 'ela', N'CVC Word Building', 'short_answer', 10);
SET @cat7 = SCOPE_IDENTITY();

DECLARE @cat8 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count) VALUES (1, 'ela', N'Sight Word Recognition', 'short_answer', 10);
SET @cat8 = SCOPE_IDENTITY();

DECLARE @cat9 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count) VALUES (1, 'ela', N'Rhyming Word Identification', 'short_answer', 10);
SET @cat9 = SCOPE_IDENTITY();

DECLARE @cat10 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count) VALUES (1, 'ela', N'Digraphs (sh, ch, th, wh)', 'short_answer', 8);
SET @cat10 = SCOPE_IDENTITY();

DECLARE @cat11 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count) VALUES (1, 'writing', N'Writing Simple Sentences', 'space_heavy', 6);
SET @cat11 = SCOPE_IDENTITY();

DECLARE @cat12 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count) VALUES (1, 'science', N'Weather Patterns', 'space_heavy', 6);
SET @cat12 = SCOPE_IDENTITY();

DECLARE @cat13 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count) VALUES (1, 'social_studies', N'Community Helpers and Jobs', 'space_heavy', 6);
SET @cat13 = SCOPE_IDENTITY();

DECLARE @cat14 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count) VALUES (1, 'puzzle', N'Simple Word Search (CVC Words)', 'puzzle', 1);
SET @cat14 = SCOPE_IDENTITY();

-- Addition within 10 (15 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat1, 'fill_blank', N'2 + 3 = ___', NULL, N'5', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat1, 'fill_blank', N'4 + 1 = ___', NULL, N'5', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat1, 'fill_blank', N'5 + 5 = ___', NULL, N'10', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat1, 'fill_blank', N'3 + 3 = ___', NULL, N'6', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat1, 'fill_blank', N'1 + 6 = ___', NULL, N'7', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat1, 'fill_blank', N'0 + 8 = ___', NULL, N'8', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat1, 'fill_blank', N'4 + 4 = ___', NULL, N'8', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat1, 'fill_blank', N'2 + 7 = ___', NULL, N'9', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat1, 'fill_blank', N'6 + 2 = ___', NULL, N'8', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat1, 'fill_blank', N'3 + 4 = ___', NULL, N'7', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat1, 'fill_blank', N'5 + 2 = ___', NULL, N'7', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat1, 'fill_blank', N'1 + 9 = ___', NULL, N'10', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat1, 'fill_blank', N'4 + 5 = ___', NULL, N'9', 13);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat1, 'fill_blank', N'2 + 2 = ___', NULL, N'4', 14);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat1, 'fill_blank', N'6 + 4 = ___', NULL, N'10', 15);

-- Subtraction within 10 (15 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat2, 'fill_blank', N'5 - 2 = ___', NULL, N'3', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat2, 'fill_blank', N'8 - 3 = ___', NULL, N'5', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat2, 'fill_blank', N'6 - 1 = ___', NULL, N'5', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat2, 'fill_blank', N'9 - 4 = ___', NULL, N'5', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat2, 'fill_blank', N'7 - 2 = ___', NULL, N'5', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat2, 'fill_blank', N'10 - 5 = ___', NULL, N'5', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat2, 'fill_blank', N'4 - 3 = ___', NULL, N'1', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat2, 'fill_blank', N'8 - 6 = ___', NULL, N'2', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat2, 'fill_blank', N'10 - 7 = ___', NULL, N'3', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat2, 'fill_blank', N'6 - 4 = ___', NULL, N'2', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat2, 'fill_blank', N'9 - 9 = ___', NULL, N'0', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat2, 'fill_blank', N'7 - 5 = ___', NULL, N'2', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat2, 'fill_blank', N'10 - 2 = ___', NULL, N'8', 13);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat2, 'fill_blank', N'5 - 5 = ___', NULL, N'0', 14);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat2, 'fill_blank', N'8 - 4 = ___', NULL, N'4', 15);

-- Comparing Numbers (>, <) within 10 (12 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat3, 'fill_blank', N'7 ___ 3', NULL, N'>', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat3, 'fill_blank', N'2 ___ 9', NULL, N'<', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat3, 'fill_blank', N'6 ___ 4', NULL, N'>', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat3, 'fill_blank', N'1 ___ 8', NULL, N'<', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat3, 'fill_blank', N'9 ___ 5', NULL, N'>', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat3, 'fill_blank', N'3 ___ 7', NULL, N'<', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat3, 'fill_blank', N'10 ___ 6', NULL, N'>', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat3, 'fill_blank', N'4 ___ 9', NULL, N'<', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat3, 'fill_blank', N'8 ___ 2', NULL, N'>', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat3, 'fill_blank', N'0 ___ 5', NULL, N'<', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat3, 'fill_blank', N'9 ___ 1', NULL, N'>', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat3, 'fill_blank', N'5 ___ 8', NULL, N'<', 12);

-- Skip Counting by 2s, 5s, 10s (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat4, 'fill_blank', N'2, 4, 6, ___, ___', NULL, N'8, 10', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat4, 'fill_blank', N'5, 10, 15, ___, ___', NULL, N'20, 25', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat4, 'fill_blank', N'10, 20, 30, ___, ___', NULL, N'40, 50', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat4, 'fill_blank', N'2, 4, ___, 8, 10', NULL, N'6', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat4, 'fill_blank', N'5, ___, 15, 20, 25', NULL, N'10', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat4, 'fill_blank', N'10, ___, 30, 40, 50', NULL, N'20', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat4, 'fill_blank', N'4, 6, 8, ___, ___', NULL, N'10, 12', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat4, 'fill_blank', N'15, 20, 25, ___, ___', NULL, N'30, 35', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat4, 'fill_blank', N'40, 50, 60, ___, ___', NULL, N'70, 80', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat4, 'fill_blank', N'6, 8, 10, ___, ___', NULL, N'12, 14', 10);

-- Counting to 100 by Ones (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat5, 'fill_blank', N'What number comes next? 14, 15, ___', NULL, N'16', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat5, 'fill_blank', N'What number comes next? 27, 28, ___', NULL, N'29', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat5, 'fill_blank', N'What number comes next? 39, 40, ___', NULL, N'41', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat5, 'fill_blank', N'What number comes next? 8, 9, ___', NULL, N'10', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat5, 'fill_blank', N'What number comes next? 52, 53, ___', NULL, N'54', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat5, 'fill_blank', N'What number comes next? 65, 66, ___', NULL, N'67', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat5, 'fill_blank', N'What number comes next? 78, 79, ___', NULL, N'80', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat5, 'fill_blank', N'What number comes next? 91, 92, ___', NULL, N'93', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat5, 'fill_blank', N'What number comes next? 19, 20, ___', NULL, N'21', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat5, 'fill_blank', N'What number comes next? 45, 46, ___', NULL, N'47', 10);

-- Telling Time to the Hour (8 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat6, 'fill_blank', N'The hour hand points to 3. The minute hand points to 12. What time is it?', NULL, N'3:00', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat6, 'fill_blank', N'The hour hand points to 7. The minute hand points to 12. What time is it?', NULL, N'7:00', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat6, 'fill_blank', N'The hour hand points to 10. The minute hand points to 12. What time is it?', NULL, N'10:00', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat6, 'fill_blank', N'The hour hand points to 1. The minute hand points to 12. What time is it?', NULL, N'1:00', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat6, 'fill_blank', N'The hour hand points to 5. The minute hand points to 12. What time is it?', NULL, N'5:00', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat6, 'fill_blank', N'The hour hand points to 8. The minute hand points to 12. What time is it?', NULL, N'8:00', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat6, 'fill_blank', N'The hour hand points to 12. The minute hand points to 12. What time is it?', NULL, N'12:00', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat6, 'fill_blank', N'The hour hand points to 6. The minute hand points to 12. What time is it?', NULL, N'6:00', 8);

-- CVC Word Building (15 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat7, 'fill_blank', N'c_t (says "cat") — write the missing letter', NULL, N'a', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat7, 'fill_blank', N'd_g (says "dog") — write the missing letter', NULL, N'o', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat7, 'fill_blank', N'p_g (says "pig") — write the missing letter', NULL, N'i', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat7, 'fill_blank', N's_n (says "sun") — write the missing letter', NULL, N'u', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat7, 'fill_blank', N'b_d (says "bed") — write the missing letter', NULL, N'e', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat7, 'fill_blank', N'h_t (says "hat") — write the missing letter', NULL, N'a', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat7, 'fill_blank', N'm_p (says "map") — write the missing letter', NULL, N'a', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat7, 'fill_blank', N't_p (says "top") — write the missing letter', NULL, N'o', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat7, 'fill_blank', N'c_p (says "cup") — write the missing letter', NULL, N'u', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat7, 'fill_blank', N'n_t (says "net") — write the missing letter', NULL, N'e', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat7, 'fill_blank', N'b_g (says "bug") — write the missing letter', NULL, N'u', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat7, 'fill_blank', N'l_g (says "log") — write the missing letter', NULL, N'o', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat7, 'fill_blank', N'p_n (says "pen") — write the missing letter', NULL, N'e', 13);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat7, 'fill_blank', N'f_n (says "fin") — write the missing letter', NULL, N'i', 14);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat7, 'fill_blank', N'r_g (says "rug") — write the missing letter', NULL, N'u', 15);

-- Sight Word Recognition (15 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat8, 'multiple_choice', N'Which is the word "said"?', N'["said", "siad", "sayd"]', N'said', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat8, 'multiple_choice', N'Which is the word "come"?', N'["comm", "come", "cume"]', N'come', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat8, 'multiple_choice', N'Which is the word "little"?', N'["littel", "little", "litle"]', N'little', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat8, 'multiple_choice', N'Which is the word "funny"?', N'["funy", "funnie", "funny"]', N'funny', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat8, 'multiple_choice', N'Which is the word "where"?', N'["wear", "where", "wher"]', N'where', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat8, 'multiple_choice', N'Which is the word "yellow"?', N'["yello", "yellow", "yelow"]', N'yellow', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat8, 'multiple_choice', N'Which is the word "three"?', N'["three", "tree", "thre"]', N'three', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat8, 'multiple_choice', N'Which is the word "jump"?', N'["jumo", "jump", "jusp"]', N'jump', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat8, 'multiple_choice', N'Which is the word "make"?', N'["maek", "mack", "make"]', N'make', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat8, 'multiple_choice', N'Which is the word "look"?', N'["look", "loo", "lok"]', N'look', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat8, 'multiple_choice', N'Which is the word "help"?', N'["hepl", "help", "helf"]', N'help', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat8, 'multiple_choice', N'Which is the word "down"?', N'["dwon", "down", "doun"]', N'down', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat8, 'multiple_choice', N'Which is the word "away"?', N'["awey", "away", "awya"]', N'away', 13);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat8, 'multiple_choice', N'Which is the word "find"?', N'["fnd", "find", "fined"]', N'find', 14);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat8, 'multiple_choice', N'Which is the word "play"?', N'["play", "plya", "paly"]', N'play', 15);

-- Rhyming Word Identification (12 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat9, 'multiple_choice', N'Which word rhymes with "cat"?', N'["hat", "dog", "cup"]', N'hat', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat9, 'multiple_choice', N'Which word rhymes with "sun"?', N'["run", "cat", "pig"]', N'run', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat9, 'multiple_choice', N'Which word rhymes with "dog"?', N'["log", "sun", "hat"]', N'log', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat9, 'multiple_choice', N'Which word rhymes with "bee"?', N'["tree", "cup", "dog"]', N'tree', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat9, 'multiple_choice', N'Which word rhymes with "pig"?', N'["wig", "sun", "hat"]', N'wig', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat9, 'multiple_choice', N'Which word rhymes with "box"?', N'["fox", "pig", "bee"]', N'fox', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat9, 'multiple_choice', N'Which word rhymes with "red"?', N'["bed", "cup", "log"]', N'bed', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat9, 'multiple_choice', N'Which word rhymes with "cake"?', N'["lake", "dog", "pig"]', N'lake', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat9, 'multiple_choice', N'Which word rhymes with "hen"?', N'["pen", "box", "cat"]', N'pen', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat9, 'multiple_choice', N'Which word rhymes with "mop"?', N'["top", "bee", "red"]', N'top', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat9, 'multiple_choice', N'Which word rhymes with "ball"?', N'["tall", "sun", "pig"]', N'tall', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat9, 'multiple_choice', N'Which word rhymes with "rain"?', N'["train", "box", "hen"]', N'train', 12);

-- Digraphs (sh, ch, th, wh) (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat10, 'multiple_choice', N'___ip (a boat)', N'["sh", "ch", "th", "wh"]', N'sh', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat10, 'multiple_choice', N'___air (you sit on it)', N'["sh", "ch", "th", "wh"]', N'ch', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat10, 'multiple_choice', N'___umb (part of your hand)', N'["sh", "ch", "th", "wh"]', N'th', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat10, 'multiple_choice', N'___ale (a big ocean animal)', N'["sh", "ch", "th", "wh"]', N'wh', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat10, 'multiple_choice', N'___op (you buy things there)', N'["sh", "ch", "th", "wh"]', N'sh', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat10, 'multiple_choice', N'___eese (yellow food from milk)', N'["sh", "ch", "th", "wh"]', N'ch', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat10, 'multiple_choice', N'___in (part of your face)', N'["sh", "ch", "th", "wh"]', N'ch', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat10, 'multiple_choice', N'___ick (a baby chicken)', N'["sh", "ch", "th", "wh"]', N'ch', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat10, 'multiple_choice', N'___eel (round, on a car)', N'["sh", "ch", "th", "wh"]', N'wh', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat10, 'multiple_choice', N'___ree (the number after two)', N'["sh", "ch", "th", "wh"]', N'th', 10);

-- Writing Simple Sentences (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat11, 'short_response', N'Write one sentence about your favorite animal.', NULL, N'Answers will vary — example: "I like dogs."', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat11, 'short_response', N'Write one sentence about the weather today.', NULL, N'Answers will vary — example: "It is sunny today."', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat11, 'short_response', N'Write one sentence about your family.', NULL, N'Answers will vary — example: "I love my mom."', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat11, 'short_response', N'Write one sentence about something you ate today.', NULL, N'Answers will vary — example: "I ate an apple."', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat11, 'short_response', N'Write one sentence about your favorite color.', NULL, N'Answers will vary — example: "I like blue."', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat11, 'short_response', N'Write one sentence about a friend.', NULL, N'Answers will vary — example: "My friend is nice."', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat11, 'short_response', N'Write one sentence about something you can do.', NULL, N'Answers will vary — example: "I can jump high."', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat11, 'short_response', N'Write one sentence about your favorite toy.', NULL, N'Answers will vary — example: "I like my ball."', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat11, 'short_response', N'Write one sentence about school.', NULL, N'Answers will vary — example: "I like school."', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat11, 'short_response', N'Write one sentence about a place you like to go.', NULL, N'Answers will vary — example: "I like the park."', 10);

-- Weather Patterns (8 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat12, 'short_response', N'Look outside. Draw and write about today''s weather.', NULL, N'Answers will vary based on actual weather.', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat12, 'short_response', N'Name two kinds of weather you have seen this year.', NULL, N'Answers will vary — examples: rain, sun, wind, snow.', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat12, 'short_response', N'What do you wear on a cold, snowy day?', NULL, N'Answers will vary — example: a coat, hat, and mittens.', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat12, 'short_response', N'What do you wear on a hot, sunny day?', NULL, N'Answers will vary — example: shorts and a hat.', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat12, 'short_response', N'What happens in the sky before it rains?', NULL, N'Answers will vary — example: dark clouds appear.', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat12, 'short_response', N'Name one thing you like to do on a rainy day.', NULL, N'Answers will vary — example: read a book inside.', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat12, 'short_response', N'Why do we wear a coat in winter?', NULL, N'Answers will vary — example: to stay warm.', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat12, 'short_response', N'Draw a sunny day and a rainy day. How are they different?', NULL, N'Answers will vary — example: sunny has a bright sun, rainy has clouds and rain.', 8);

-- Community Helpers and Jobs (8 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat13, 'short_response', N'Who helps put out fires?', NULL, N'A firefighter.', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat13, 'short_response', N'Who helps you when you are sick?', NULL, N'A doctor or nurse.', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat13, 'short_response', N'Who delivers mail to your house?', NULL, N'A mail carrier.', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat13, 'short_response', N'Who helps keep our streets and neighborhoods safe?', NULL, N'A police officer.', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat13, 'short_response', N'Who teaches you new things at school?', NULL, N'A teacher.', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat13, 'short_response', N'Who cooks food at a restaurant?', NULL, N'A chef or cook.', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat13, 'short_response', N'Who flies the airplane?', NULL, N'A pilot.', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat13, 'short_response', N'Draw a community helper you would like to be. Write their job.', NULL, N'Answers will vary.', 8);

-- Simple Word Search (CVC Words) (1 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cat14, 'word_search', N'Find these words: CAT, DOG, PIG, SUN, HAT, BUG', NULL, N'CAT, DOG, PIG, SUN, HAT, BUG', 1);

END
GO
