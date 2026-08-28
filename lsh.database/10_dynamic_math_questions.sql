-- ============================================================
-- Dynamic math questions driven by SQL view / stored procedure
-- ============================================================

USE LittleScholarHub;
GO

CREATE OR ALTER VIEW dbo.vw_DynamicMathQuestionTemplates AS
SELECT 1 AS template_id, 'addition' AS template_name, '+' AS operator_symbol,
       'Add two numbers' AS description,
       'Add {a} and {b}.' AS hint_template,
       0 AS grade_min, 2 AS grade_max
UNION ALL
SELECT 2, 'subtraction', '-', 'Subtract two numbers', 'Start at {a} and count back {b}.', 3, 4
UNION ALL
SELECT 3, 'multiplication', '×', 'Multiply two numbers', 'Think of {b} groups of {a}.', 3, 6;
GO

CREATE OR ALTER PROCEDURE dbo.usp_GetDynamicMathQuestions
    @grade_id TINYINT = 2,
    @count TINYINT = 5
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @rows TABLE (
        rn INT IDENTITY(1,1),
        template_id INT,
        a INT,
        b INT,
        formula_text NVARCHAR(120),
        answer_text NVARCHAR(50),
        hint_text NVARCHAR(200),
        params_json NVARCHAR(200)
    );

    ;WITH seq AS (
        SELECT TOP (CASE WHEN ISNULL(@count, 5) < 1 THEN 5 ELSE @count END) 
               ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS rn
        FROM sys.objects s1 CROSS JOIN sys.objects s2
    )
    INSERT INTO @rows (template_id, a, b, formula_text, answer_text, hint_text, params_json)
    SELECT
        CASE
            WHEN @grade_id <= 2 THEN 1
            WHEN @grade_id BETWEEN 3 AND 4 THEN 2
            ELSE 3
        END + ((seq.rn - 1) % 3),
        ABS(CHECKSUM(NEWID())) % CASE WHEN @grade_id <= 2 THEN 20 ELSE 12 END + 1,
        ABS(CHECKSUM(NEWID())) % CASE WHEN @grade_id <= 2 THEN 20 ELSE 12 END + 1,
        CONCAT(
            CASE WHEN @grade_id <= 2 THEN CONCAT(a, ' + ', b)
                 WHEN @grade_id BETWEEN 3 AND 4 THEN CONCAT(a, ' - ', b)
                 ELSE CONCAT(a, ' × ', b)
            END
        ),
        CASE WHEN @grade_id <= 2 THEN CAST(a + b AS NVARCHAR(50))
             WHEN @grade_id BETWEEN 3 AND 4 THEN CAST(a - b AS NVARCHAR(50))
             ELSE CAST(a * b AS NVARCHAR(50))
        END,
        CASE WHEN @grade_id <= 2 THEN CONCAT('Add ', a, ' and ', b, '.')
             WHEN @grade_id BETWEEN 3 AND 4 THEN CONCAT('Start at ', a, ' and count back ', b, '.')
             ELSE CONCAT('Think of ', b, ' groups of ', a, '.')
        END,
        CONCAT('{"a":', a, ',"b":', b, '}')
    FROM seq
    CROSS APPLY (VALUES (
        CASE WHEN @grade_id <= 2 THEN ABS(CHECKSUM(NEWID())) % 20 + 1
             WHEN @grade_id BETWEEN 3 AND 4 THEN ABS(CHECKSUM(NEWID())) % 20 + 1
             ELSE ABS(CHECKSUM(NEWID())) % 12 + 2 END
    )) v1(a)
    CROSS APPLY (VALUES (
        CASE WHEN @grade_id <= 2 THEN ABS(CHECKSUM(NEWID())) % 20 + 1
             WHEN @grade_id BETWEEN 3 AND 4 THEN ABS(CHECKSUM(NEWID())) % 20 + 1
             ELSE ABS(CHECKSUM(NEWID())) % 12 + 2 END
    )) v2(b);

    SELECT
        template_id,
        CONCAT('What is ', formula_text, '?') AS question_text,
        answer_text AS correct_answer,
        hint_text AS hint,
        NULL AS options_json,
        params_json
    FROM @rows
    ORDER BY rn;
END;
GO
