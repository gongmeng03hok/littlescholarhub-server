-- 63_whole_child_rotation.sql
-- Whole-Child Curriculum expansion, part 1: schema + rotation logic only
-- (no content rows here — see 64_sel_cognitive_content.sql).
--
-- Adds a second rotation tier on top of the existing per-subject category
-- rotation (61_weekly_category_rotation.sql / 62_weekly_min_questions.sql),
-- because the existing proc fires EVERY subject_area's rotation every
-- single week — fine for 6 subjects, but would balloon a packet past 200
-- questions once ~16 subject_areas exist. New tiers:
--
--   Tier A (unchanged): the original 6 subjects ('math','ela','writing',
--     'science','social_studies','puzzle') stay "always-on" and rotate
--     their own categories exactly as before.
--   is_core (new): categories flagged is_core=1 are included in EVERY
--     week for their grade, bypassing rotation entirely — a "mastery
--     anchor". Because target_count stays below the category's total
--     question pool, ORDER BY NEWID() still draws a different subset
--     each week, so the category repeats (mastery) while the specific
--     questions vary (stays fresh).
--   Tier B (new): the newer, non-always-on subject_areas get their own
--     block rotation (keyed off week_index like tier A, but partitioned
--     by subject_area instead of category_id, so the two naturally
--     decorrelate) — only @groups_per_week of them are "active" in any
--     given week.
--   Ceiling (new): after the existing top-up-to-floor loop, a trim pass
--     removes the most-recently-added top-up/tier-B categories (never
--     tier-A or is_core) until total <= @max_questions, so a future
--     content-authoring miscalibration degrades gracefully instead of
--     silently shipping 70+-question weeks.
--
-- New dbo.PacketSubjectAreas lookup table replaces the old unnamed CHECK
-- constraint on PacketCategories.subject_area as the single source of
-- truth for which subject_areas exist and whether they're always-on —
-- adding a future subject_area group becomes an INSERT, not a 4-file
-- constraint-hunting exercise. (The old CHECK was unnamed; migration 58
-- already had to hardcode a SQL-Server-generated constraint name for a
-- sibling column and noted that name isn't guaranteed portable across
-- environments — this migration drops the subject_area CHECK dynamically
-- by lookup instead of repeating that fragility.)

-- ── 1. PacketSubjectAreas lookup table ──────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'PacketSubjectAreas' AND type = 'U')
BEGIN
    CREATE TABLE dbo.PacketSubjectAreas (
        subject_area   VARCHAR(20)  NOT NULL PRIMARY KEY,
        label          NVARCHAR(50) NOT NULL,
        color          CHAR(7)      NOT NULL,
        tint           CHAR(7)      NOT NULL,
        is_always_on   BIT          NOT NULL DEFAULT 0,
        sort_order     INT          NOT NULL
    );
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.PacketSubjectAreas WHERE subject_area = 'math')
BEGIN
    INSERT INTO dbo.PacketSubjectAreas (subject_area, label, color, tint, is_always_on, sort_order) VALUES
    ('math',           N'Math',                    '#2E7DD1', '#EAF2FC', 1, 1),
    ('ela',            N'Reading & Writing',        '#D1662E', '#FCEEE7', 1, 2),
    ('writing',        N'Writing',                  '#8A4FD1', '#F1E9FC', 1, 3),
    ('science',        N'Science',                  '#2EA37A', '#E7F7F1', 1, 4),
    ('social_studies', N'Social Studies',           '#C9A227', '#FBF5E3', 1, 5),
    ('puzzle',         N'Puzzles & Games',          '#D14F8A', '#FCE8F1', 1, 6),
    ('sel',            N'Feelings & Friendship',    '#3FAF9E', '#E5F7F4', 0, 7),
    ('cognitive_skills', N'Thinking & Problem-Solving', '#5B7FD1', '#EAEFFC', 0, 8),
    ('life_skills',    N'Life Skills',              '#B0782E', '#F7ECDF', 0, 9),
    ('stem_engineering', N'STEM & Engineering',     '#2E76A6', '#E5F0F6', 0, 10),
    ('arts',           N'Arts',                     '#B04FA6', '#F6E7F4', 0, 11),
    ('civic',          N'Community & Civics',       '#4F7A3F', '#EBF3E7', 0, 12),
    ('health',         N'Health & Fitness',         '#D14F4F', '#FCE7E7', 0, 13),
    ('humor_play',     N'Humor & Play',             '#D1A62E', '#FBF3E0', 0, 14),
    ('character',      N'Character & Values',       '#6B5FC9', '#ECEAF9', 0, 15),
    ('culture',        N'Culture & Language',       '#2EA3A0', '#E5F6F5', 0, 16);
END
GO

-- ── 2. is_core column ───────────────────────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID('dbo.PacketCategories') AND name = 'is_core')
BEGIN
    ALTER TABLE dbo.PacketCategories ADD is_core BIT NOT NULL DEFAULT 0;
END
GO

-- ── 3. Widen subject_area from CHECK to FK against PacketSubjectAreas ───
-- (EXEC(literal + QUOTENAME(...)) is rejected by the parser as a syntax
-- error — QUOTENAME can't appear inline in an EXEC string-expression
-- argument; the string has to be built into a variable first, then
-- EXEC(@variable). Learned the hard way running this against production.)
DECLARE @subjConstraint SYSNAME;
DECLARE @subjDropSql NVARCHAR(400);
SELECT @subjConstraint = cc.name
FROM sys.check_constraints cc
WHERE cc.parent_object_id = OBJECT_ID('dbo.PacketCategories')
  AND cc.definition LIKE '%subject_area%';
IF @subjConstraint IS NOT NULL
BEGIN
    SET @subjDropSql = 'ALTER TABLE dbo.PacketCategories DROP CONSTRAINT ' + QUOTENAME(@subjConstraint);
    EXEC(@subjDropSql);
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_PacketCategories_SubjectArea')
BEGIN
    ALTER TABLE dbo.PacketCategories
        ADD CONSTRAINT FK_PacketCategories_SubjectArea
        FOREIGN KEY (subject_area) REFERENCES dbo.PacketSubjectAreas(subject_area);
END
GO

-- ── 4. Widen diagram_type CHECK to add 'sequence_steps' ─────────────────
DECLARE @diagConstraint SYSNAME;
DECLARE @diagDropSql NVARCHAR(400);
SELECT @diagConstraint = cc.name
FROM sys.check_constraints cc
WHERE cc.parent_object_id = OBJECT_ID('dbo.PacketQuestions')
  AND cc.definition LIKE '%diagram_type%'
  AND cc.name <> 'CK_PacketQuestions_diagram_type_v2';
IF @diagConstraint IS NOT NULL
BEGIN
    SET @diagDropSql = 'ALTER TABLE dbo.PacketQuestions DROP CONSTRAINT ' + QUOTENAME(@diagConstraint);
    EXEC(@diagDropSql);
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.check_constraints WHERE name = 'CK_PacketQuestions_diagram_type_v2')
BEGIN
    ALTER TABLE dbo.PacketQuestions ADD CONSTRAINT CK_PacketQuestions_diagram_type_v2
        CHECK (diagram_type IN ('emoji', 'clock', 'ten_frame', 'angle', 'rectangle_dims', 'coordinate_point', 'sequence_steps'));
END
GO

-- ── 5. Widen question_type CHECK — 'matching' already legal (unused since
--      2023's original CHECK), no ALTER needed; documenting the data shape
--      here since it's new to actually be used starting with migration 64:
--        choices_json = {"left": [...], "right": [...]}
--        answer_text   = JSON array of correct left-index->right-index pairs,
--                         e.g. [[0,2],[1,0],[2,1]]

-- ── 6. usp_GetOrCreateWeeklyPacket v4 — two-tier rotation ───────────────
CREATE OR ALTER PROCEDURE dbo.usp_GetOrCreateWeeklyPacket
    @grade_id               INT,
    @week_of                DATE,
    @categories_per_subject INT = 3,
    @min_questions          INT = 30,
    @groups_per_week        INT = 3,
    @max_questions          INT = 50
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

        CREATE TABLE #picked (category_id INT PRIMARY KEY, target_count INT, tier VARCHAR(10));

        -- is_core: unconditional, every week, regardless of subject_area.
        INSERT INTO #picked (category_id, target_count, tier)
        SELECT category_id, target_count, 'core'
        FROM dbo.PacketCategories
        WHERE grade_id = @grade_id AND is_active = 1 AND is_core = 1;

        -- Tier A: always-on subject_areas, rotated at the category level
        -- (unchanged logic from migration 62), excluding anything already
        -- picked via is_core.
        ;WITH tierA_base AS (
            SELECT pc.category_id, pc.subject_area, pc.target_count,
                   ROW_NUMBER() OVER (PARTITION BY pc.subject_area ORDER BY pc.category_id) AS rn,
                   COUNT(*) OVER (PARTITION BY pc.subject_area) AS subj_count
            FROM dbo.PacketCategories pc
            JOIN dbo.PacketSubjectAreas sa ON sa.subject_area = pc.subject_area AND sa.is_always_on = 1
            WHERE pc.grade_id = @grade_id AND pc.is_active = 1
              AND pc.category_id NOT IN (SELECT category_id FROM #picked)
        )
        SELECT category_id, subject_area, target_count, rn,
               CAST(CEILING(subj_count * 1.0 / @categories_per_subject) AS INT) AS num_groups,
               (rn - 1) / @categories_per_subject AS group_index
        INTO #poolA
        FROM tierA_base;

        INSERT INTO #picked (category_id, target_count, tier)
        SELECT category_id, target_count, 'tierA'
        FROM #poolA
        WHERE group_index = (@week_index % num_groups);

        -- Tier B: rotated subject_areas — pick @groups_per_week of them
        -- for this week (block rotation over subject_area, decorrelated
        -- from tier A's per-category rotation since it partitions on a
        -- different key), then within each active group run the same
        -- category-level rotation as tier A.
        ;WITH tierB_groups AS (
            SELECT subject_area, sort_order,
                   ROW_NUMBER() OVER (ORDER BY sort_order) AS rn,
                   COUNT(*) OVER () AS total_groups
            FROM dbo.PacketSubjectAreas
            WHERE is_always_on = 0
              AND EXISTS (
                  SELECT 1 FROM dbo.PacketCategories pc
                  WHERE pc.subject_area = PacketSubjectAreas.subject_area
                    AND pc.grade_id = @grade_id AND pc.is_active = 1
              )
        ),
        tierB_blocked AS (
            SELECT subject_area,
                   CAST(CEILING(total_groups * 1.0 / @groups_per_week) AS INT) AS num_blocks,
                   (rn - 1) / @groups_per_week AS block_index
            FROM tierB_groups
        ),
        active_subjects AS (
            SELECT subject_area, num_blocks AS outer_num_blocks FROM tierB_blocked
            WHERE block_index = (@week_index % num_blocks)
        ),
        tierB_base AS (
            SELECT pc.category_id, pc.subject_area, pc.target_count, act.outer_num_blocks,
                   ROW_NUMBER() OVER (PARTITION BY pc.subject_area ORDER BY pc.category_id) AS rn,
                   COUNT(*) OVER (PARTITION BY pc.subject_area) AS subj_count
            FROM dbo.PacketCategories pc
            JOIN active_subjects act ON act.subject_area = pc.subject_area
            WHERE pc.grade_id = @grade_id AND pc.is_active = 1
              AND pc.category_id NOT IN (SELECT category_id FROM #picked)
        )
        SELECT category_id, subject_area, target_count, rn, outer_num_blocks,
               CAST(CEILING(subj_count * 1.0 / @categories_per_subject) AS INT) AS num_groups,
               (rn - 1) / @categories_per_subject AS group_index
        INTO #poolB
        FROM tierB_base;

        -- A subject_area only activates once every `outer_num_blocks` weeks
        -- (tier-B's own outer rotation), so picking its inner category group
        -- via plain `@week_index % num_groups` aliases whenever num_groups
        -- divides outer_num_blocks (e.g. num_groups=2, outer_num_blocks=4 —
        -- every activation lands on the exact same phase, permanently
        -- hiding the other group). Dividing by outer_num_blocks first turns
        -- consecutive *activations* of this subject into consecutive
        -- integers (0,1,2,3,...) regardless of the outer cycle length, so
        -- the inner rotation actually advances each time the subject comes
        -- up — confirmed via a live production bug where several subjects'
        -- second category-group had literally never been shown to a single
        -- user since they shipped.
        INSERT INTO #picked (category_id, target_count, tier)
        SELECT category_id, target_count, 'tierB'
        FROM #poolB
        WHERE group_index = ((@week_index / outer_num_blocks) % num_groups);

        -- Top up (existing behavior from migration 62): if still under the
        -- floor, cycle forward through extra rotation blocks — tier A first,
        -- then tier B — until the floor is cleared.
        DECLARE @total INT = (SELECT ISNULL(SUM(target_count), 0) FROM #picked);
        DECLARE @extra INT = 1;
        WHILE @total < @min_questions AND @extra <= 20
        BEGIN
            INSERT INTO #picked (category_id, target_count, tier)
            SELECT category_id, target_count, 'topupA'
            FROM #poolA p
            WHERE p.num_groups > 1
              AND p.group_index = ((@week_index + @extra) % p.num_groups)
              AND NOT EXISTS (SELECT 1 FROM #picked pk WHERE pk.category_id = p.category_id);

            IF @@ROWCOUNT = 0
            BEGIN
                INSERT INTO #picked (category_id, target_count, tier)
                SELECT category_id, target_count, 'topupB'
                FROM #poolB p
                WHERE p.num_groups > 1
                  AND p.group_index = ((@week_index + @extra) % p.num_groups)
                  AND NOT EXISTS (SELECT 1 FROM #picked pk WHERE pk.category_id = p.category_id);
            END

            IF @@ROWCOUNT = 0 AND NOT EXISTS (
                SELECT 1 FROM (SELECT category_id FROM #poolA UNION SELECT category_id FROM #poolB) allpool
                WHERE NOT EXISTS (SELECT 1 FROM #picked pk WHERE pk.category_id = allpool.category_id)
            )
                BREAK; -- every category this grade has is already picked

            SET @total = (SELECT ISNULL(SUM(target_count), 0) FROM #picked);
            SET @extra += 1;
        END

        -- Ceiling: trim top-up rows (the old floor-chasing mechanism from
        -- migration 62 — it can overshoot once more subject_areas exist)
        -- until at/under @max_questions. Deliberately NEVER trims 'core',
        -- 'tierA', or 'tierB' — tierB is the entire point of this feature
        -- (the newer, rotated subject_areas), and tierA/core are the
        -- established always-on baseline. An earlier version of this loop
        -- trimmed tierB too, which meant grades where tierA+core alone
        -- already exceed @max_questions (common — some grades' original 6
        -- subjects alone run well past 50) silently ate 100% of the new
        -- content every single week trying to reach a ceiling that was
        -- never reachable, defeating the feature. Better to occasionally
        -- run over @max_questions than to always discard the new variety.
        -- Bounded the same way the top-up loop above is bounded (@extra
        -- <= 20) — every WHILE loop that isn't provably bounded by a
        -- shrinking finite set on its own needs an explicit iteration cap,
        -- learned the hard way when an earlier version of this loop hung
        -- indefinitely in production.
        DECLARE @trim_category_id INT;
        DECLARE @trimIterations INT = 0;
        WHILE (SELECT ISNULL(SUM(target_count), 0) FROM #picked) > @max_questions
              AND @trimIterations <= 50
        BEGIN
            SET @trimIterations += 1;
            SET @trim_category_id = NULL;
            SELECT TOP 1 @trim_category_id = category_id
            FROM #picked
            WHERE tier IN ('topupB', 'topupA')
            ORDER BY
                CASE tier WHEN 'topupB' THEN 0 WHEN 'topupA' THEN 1 END DESC,
                category_id DESC;

            IF @trim_category_id IS NULL BREAK; -- nothing left that's safe to trim

            DELETE FROM #picked WHERE category_id = @trim_category_id;
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

        DROP TABLE #poolA;
        DROP TABLE #poolB;
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
