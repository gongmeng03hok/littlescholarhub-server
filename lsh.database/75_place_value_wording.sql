-- 75_place_value_wording.sql
--
-- "In the number 31, what is the value of the digit in the ones place?"
-- is fourteen words, and place_value is served from 1st grade. The maths
-- is one step; the sentence was the hard part. Now:
--
--     In 31, what is the ones digit worth?
--
-- The place is still named rather than the digit quoted, because with a
-- repeated digit ("the digit 3" in 313) that would be ambiguous.
--
-- Generated from the live definition, so the body is unchanged apart
-- from the one string.


ALTER   PROCEDURE dbo.usp_GenerateMathQuestion
    @grade TINYINT = 2,
    @topic VARCHAR(32) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @topics TABLE (topic VARCHAR(32));
    INSERT INTO @topics VALUES
        ('place_value'), ('rounding'), ('compare_numbers'), ('money_count'),
        ('decimal_add'), ('order_of_operations'), ('factors_primes'), ('elapsed_time');

    IF @topic IS NULL OR @topic NOT IN (SELECT topic FROM @topics)
        SELECT TOP 1 @topic = topic FROM @topics ORDER BY NEWID();

    DECLARE @question NVARCHAR(512), @answer NVARCHAR(64),
            @opt2 NVARCHAR(64), @opt3 NVARCHAR(64), @opt4 NVARCHAR(64),
            @hint NVARCHAR(256);

    DECLARE @lo INT, @hi INT;

    -- place_value ------------------------------------------------
    IF @topic = 'place_value'
    BEGIN
        DECLARE @pv_digits INT = CASE WHEN @grade <= 1 THEN 2 WHEN @grade <= 3 THEN 4 ELSE 6 END;
        DECLARE @pv_num BIGINT = (ABS(CHECKSUM(NEWID())) % CAST(POWER(9.0, 1) * POWER(10, @pv_digits - 1) AS BIGINT))
                                  + CAST(POWER(10, @pv_digits - 1) AS BIGINT);
        DECLARE @pv_str VARCHAR(20) = CAST(@pv_num AS VARCHAR(20));
        DECLARE @pv_pos INT = (ABS(CHECKSUM(NEWID())) % LEN(@pv_str)) + 1;
        DECLARE @pv_digit CHAR(1) = SUBSTRING(@pv_str, @pv_pos, 1);
        DECLARE @pv_place_value BIGINT = CAST(@pv_digit AS BIGINT) * CAST(POWER(10, LEN(@pv_str) - @pv_pos) AS BIGINT);
        -- Name the place explicitly (not "the digit N") so a repeated digit
        -- elsewhere in the number can never make the question ambiguous.
        DECLARE @pv_place_name NVARCHAR(20) = CASE LEN(@pv_str) - @pv_pos
            WHEN 0 THEN N'ones' WHEN 1 THEN N'tens' WHEN 2 THEN N'hundreds'
            WHEN 3 THEN N'thousands' WHEN 4 THEN N'ten-thousands' ELSE N'hundred-thousands' END;

        SET @question = N'In ' + @pv_str + N', what is the ' + @pv_place_name + N' digit worth?';
        SET @answer   = CAST(@pv_place_value AS NVARCHAR(20));
        SET @opt2     = CAST(@pv_place_value / 10 AS NVARCHAR(20));
        SET @opt3     = CAST(@pv_place_value * 10 AS NVARCHAR(20));
        SET @opt4     = CAST(@pv_digit AS NVARCHAR(4));
        SET @hint     = N'Count how many places the digit is from the right: each place is 10x the one before it.';
    END

    -- rounding -----------------------------------------------------
    ELSE IF @topic = 'rounding'
    BEGIN
        DECLARE @rnd_unit INT = CASE WHEN @grade <= 2 THEN 10 WHEN @grade <= 4 THEN 100 ELSE 1000 END;
        DECLARE @rnd_num INT = (ABS(CHECKSUM(NEWID())) % (@rnd_unit * 20)) + @rnd_unit;
        DECLARE @rnd_ans INT = ROUND(@rnd_num, 0 - LEN(CAST(@rnd_unit AS VARCHAR(10))) + 1);

        SET @question = N'Round ' + CAST(@rnd_num AS NVARCHAR(10)) + N' to the nearest ' + CAST(@rnd_unit AS NVARCHAR(10)) + N'.';
        SET @answer   = CAST(@rnd_ans AS NVARCHAR(10));
        SET @opt2     = CAST(@rnd_ans - @rnd_unit AS NVARCHAR(10));
        SET @opt3     = CAST(@rnd_ans + @rnd_unit AS NVARCHAR(10));
        SET @opt4     = CAST(@rnd_num AS NVARCHAR(10));
        SET @hint     = N'Look at the digit to the right of the rounding place: 5 or more rounds up.';
    END

    -- compare_numbers ------------------------------------------------
    ELSE IF @topic = 'compare_numbers'
    BEGIN
        SET @lo = CASE WHEN @grade <= 1 THEN 1 WHEN @grade <= 3 THEN 10 ELSE 1000 END;
        SET @hi = CASE WHEN @grade <= 1 THEN 20 WHEN @grade <= 3 THEN 999 ELSE 99999 END;
        DECLARE @cmp_a INT = (ABS(CHECKSUM(NEWID())) % (@hi - @lo + 1)) + @lo;
        DECLARE @cmp_b INT = (ABS(CHECKSUM(NEWID())) % (@hi - @lo + 1)) + @lo;
        DECLARE @cmp_sym CHAR(1) = CASE WHEN @cmp_a > @cmp_b THEN '>' WHEN @cmp_a < @cmp_b THEN '<' ELSE '=' END;

        SET @question = N'Which symbol makes this true?   ' + CAST(@cmp_a AS NVARCHAR(10)) + N'  ___  ' + CAST(@cmp_b AS NVARCHAR(10));
        SET @answer   = CAST(@cmp_sym AS NVARCHAR(1));
        SET @opt2     = N'<'; SET @opt3 = N'>'; SET @opt4 = N'=';
        SET @hint     = N'Compare the digits from left to right.';
    END

    -- money_count ------------------------------------------------
    ELSE IF @topic = 'money_count'
    BEGIN
        DECLARE @m_q INT = ABS(CHECKSUM(NEWID())) % (CASE WHEN @grade <= 2 THEN 3 ELSE 5 END);
        DECLARE @m_d INT = ABS(CHECKSUM(NEWID())) % 4;
        DECLARE @m_n INT = ABS(CHECKSUM(NEWID())) % 4;
        DECLARE @m_p INT = ABS(CHECKSUM(NEWID())) % 5;
        DECLARE @m_cents INT = @m_q*25 + @m_d*10 + @m_n*5 + @m_p*1;
        IF @m_cents = 0 SET @m_cents = 25; -- avoid a degenerate 0-coin question
        IF @m_cents = 25 AND @m_q = 0 SET @m_q = 1; -- keep the sentence non-empty in that edge case

        DECLARE @parts TABLE (seq INT IDENTITY, txt NVARCHAR(64));
        IF @m_q > 0 INSERT INTO @parts(txt) VALUES (CAST(@m_q AS NVARCHAR(4)) + N' quarter' + CASE WHEN @m_q>1 THEN N's' ELSE N'' END);
        IF @m_d > 0 INSERT INTO @parts(txt) VALUES (CAST(@m_d AS NVARCHAR(4)) + N' dime' + CASE WHEN @m_d>1 THEN N's' ELSE N'' END);
        IF @m_n > 0 INSERT INTO @parts(txt) VALUES (CAST(@m_n AS NVARCHAR(4)) + N' nickel' + CASE WHEN @m_n>1 THEN N's' ELSE N'' END);
        IF @m_p > 0 INSERT INTO @parts(txt) VALUES (CAST(@m_p AS NVARCHAR(4)) + N' penn' + CASE WHEN @m_p>1 THEN N'ies' ELSE N'y' END);

        DECLARE @coin_list NVARCHAR(200);
        SELECT @coin_list = STRING_AGG(txt, N', ') WITHIN GROUP (ORDER BY seq) FROM @parts;

        SET @question = N'You have ' + @coin_list + N'. How much money do you have (in cents)?';
        SET @answer = CAST(@m_cents AS NVARCHAR(10));
        SET @opt2   = CAST(@m_cents + 5 AS NVARCHAR(10));
        SET @opt3   = CAST(CASE WHEN @m_cents > 10 THEN @m_cents - 10 ELSE @m_cents + 10 END AS NVARCHAR(10));
        SET @opt4   = CAST(@m_cents + 25 AS NVARCHAR(10));
        SET @hint   = N'Quarter = 25c, dime = 10c, nickel = 5c, penny = 1c. Add them all up.';
    END

    -- decimal_add ------------------------------------------------
    ELSE IF @topic = 'decimal_add'
    BEGIN
        DECLARE @dec_a DECIMAL(6,2) = (ABS(CHECKSUM(NEWID())) % 5000) / 100.0;
        DECLARE @dec_b DECIMAL(6,2) = (ABS(CHECKSUM(NEWID())) % 5000) / 100.0;
        DECLARE @dec_ans DECIMAL(6,2) = @dec_a + @dec_b;

        SET @question = N'What is ' + CAST(@dec_a AS NVARCHAR(10)) + N' + ' + CAST(@dec_b AS NVARCHAR(10)) + N'?';
        SET @answer   = CAST(@dec_ans AS NVARCHAR(10));
        SET @opt2     = CAST(@dec_ans + 1 AS NVARCHAR(10));
        SET @opt3     = CAST(@dec_ans - 0.1 AS NVARCHAR(10));
        SET @opt4     = CAST(ABS(@dec_a - @dec_b) AS NVARCHAR(10));
        SET @hint     = N'Line up the decimal points, then add each column.';
    END

    -- order_of_operations ------------------------------------------------
    ELSE IF @topic = 'order_of_operations'
    BEGIN
        DECLARE @o_a INT = (ABS(CHECKSUM(NEWID())) % 10) + 1;
        DECLARE @o_b INT = (ABS(CHECKSUM(NEWID())) % 10) + 1;
        DECLARE @o_c INT = (ABS(CHECKSUM(NEWID())) % 10) + 1;
        DECLARE @o_ans INT = @o_a + (@o_b * @o_c);
        DECLARE @o_wrong INT = (@o_a + @o_b) * @o_c; -- the classic left-to-right mistake

        SET @question = N'What is ' + CAST(@o_a AS NVARCHAR(5)) + N' + ' + CAST(@o_b AS NVARCHAR(5)) + N' x ' + CAST(@o_c AS NVARCHAR(5)) + N'?';
        SET @answer   = CAST(@o_ans AS NVARCHAR(10));
        SET @opt2     = CAST(@o_wrong AS NVARCHAR(10));
        SET @opt3     = CAST(@o_ans + 1 AS NVARCHAR(10));
        SET @opt4     = CAST(@o_ans - @o_a AS NVARCHAR(10));
        SET @hint     = N'PEMDAS: multiply before you add.';
    END

    -- factors_primes ------------------------------------------------
    ELSE IF @topic = 'factors_primes'
    BEGIN
        DECLARE @fp_num INT = (ABS(CHECKSUM(NEWID())) % 40) + 2;
        DECLARE @fp_count INT = 0, @fp_i INT = 1;
        WHILE @fp_i <= @fp_num
        BEGIN
            IF @fp_num % @fp_i = 0 SET @fp_count += 1;
            SET @fp_i += 1;
        END

        SET @question = N'Is ' + CAST(@fp_num AS NVARCHAR(5)) + N' a prime number or a composite number?';
        SET @answer   = CASE WHEN @fp_count = 2 THEN N'prime' ELSE N'composite' END;
        SET @opt2     = CASE WHEN @fp_count = 2 THEN N'composite' ELSE N'prime' END;
        SET @opt3     = N'neither';
        SET @opt4     = N'both';
        SET @hint     = N'A prime number has exactly two factors: 1 and itself.';
    END

    -- elapsed_time ------------------------------------------------
    ELSE IF @topic = 'elapsed_time'
    BEGIN
        DECLARE @t_start_min INT = (ABS(CHECKSUM(NEWID())) % 720) + 420; -- 7:00am..6:59pm, in minutes since midnight
        DECLARE @t_dur INT = ((ABS(CHECKSUM(NEWID())) % 12) + 1) * 5;     -- 5..60 min, step 5
        DECLARE @t_end_min INT = @t_start_min + @t_dur;
        DECLARE @t_start_str VARCHAR(10) = RIGHT('0' + CAST((@t_start_min/60)%12 + CASE WHEN (@t_start_min/60)%12=0 THEN 12 ELSE 0 END AS VARCHAR(2)),2)
                                            + ':' + RIGHT('0' + CAST(@t_start_min%60 AS VARCHAR(2)), 2);
        DECLARE @t_end_str VARCHAR(10) = RIGHT('0' + CAST((@t_end_min/60)%12 + CASE WHEN (@t_end_min/60)%12=0 THEN 12 ELSE 0 END AS VARCHAR(2)),2)
                                          + ':' + RIGHT('0' + CAST(@t_end_min%60 AS VARCHAR(2)), 2);

        SET @question = N'A class starts at ' + @t_start_str + N' and lasts ' + CAST(@t_dur AS NVARCHAR(5)) + N' minutes. What time does it end?';
        SET @answer   = @t_end_str;
        SET @opt2     = RIGHT('0' + CAST((@t_end_min/60 + 1)%12 + CASE WHEN (@t_end_min/60+1)%12=0 THEN 12 ELSE 0 END AS VARCHAR(2)),2) + ':' + RIGHT('0' + CAST(@t_end_min%60 AS VARCHAR(2)), 2);
        SET @opt3     = @t_start_str;
        SET @opt4     = RIGHT('0' + CAST((@t_end_min/60)%12 + CASE WHEN (@t_end_min/60)%12=0 THEN 12 ELSE 0 END AS VARCHAR(2)),2) + ':' + RIGHT('0' + CAST((@t_end_min%60 + 10)%60 AS VARCHAR(2)), 2);
        SET @hint     = N'Add the minutes to the start time; if minutes pass 60, add an hour.';
    END

    SELECT
        @topic     AS topic,
        @question  AS question_text,
        @answer    AS correct_answer,
        @opt2      AS option2,
        @opt3      AS option3,
        @opt4      AS option4,
        @hint      AS hint;
END;

