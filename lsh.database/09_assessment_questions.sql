-- ============================================================
--  Migration 09: AssessmentQuestions table
--  18 questions synced from the reference portal.
--  Options stored as JSON objects: {v, label, emo?}
-- ============================================================

USE LittleScholarHub;
GO

IF NOT EXISTS (
    SELECT 1 FROM sys.tables WHERE name = 'AssessmentQuestions' AND schema_id = SCHEMA_ID('dbo')
)
BEGIN
    CREATE TABLE dbo.AssessmentQuestions (
        question_id   INT           NOT NULL IDENTITY(1,1) CONSTRAINT PK_AQ PRIMARY KEY,
        step_key      VARCHAR(50)   NOT NULL CONSTRAINT UQ_AQ_Step UNIQUE,
        subject       VARCHAR(50)   NULL,
        question_text NVARCHAR(500) NOT NULL,
        sub_text      NVARCHAR(500) NOT NULL DEFAULT '',
        input_type    VARCHAR(20)   NOT NULL
                          CHECK (input_type IN ('select','multiselect','text')),
        options_json  NVARCHAR(MAX) NOT NULL DEFAULT '[]',
        sort_order    TINYINT       NOT NULL DEFAULT 0,
        is_active     BIT           NOT NULL DEFAULT 1,
        created_at    DATETIME2     NOT NULL DEFAULT SYSUTCDATETIME()
    );
END
ELSE
BEGIN
    -- Add sub_text column if upgrading from earlier version of this migration
    IF NOT EXISTS (
        SELECT 1 FROM sys.columns
        WHERE object_id = OBJECT_ID('dbo.AssessmentQuestions') AND name = 'sub_text'
    )
        ALTER TABLE dbo.AssessmentQuestions ADD sub_text NVARCHAR(500) NOT NULL DEFAULT '';
END
GO

IF OBJECT_ID('dbo.DynamicMathQuestionTemplates', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.DynamicMathQuestionTemplates (
        template_id INT NOT NULL CONSTRAINT PK_DynamicMathQuestionTemplates PRIMARY KEY IDENTITY,
        formula_template NVARCHAR(200) NOT NULL,
        answer_expression NVARCHAR(200) NOT NULL,
        description NVARCHAR(200) NOT NULL,
        grade_min TINYINT NOT NULL DEFAULT 0,
        grade_max TINYINT NOT NULL DEFAULT 6,
        is_active BIT NOT NULL DEFAULT 1,
        created_at DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
    );
END

MERGE dbo.DynamicMathQuestionTemplates AS t
USING (
    VALUES
        (N'{a} + {b}', N'a + b', N'Add two numbers', 0, 2, 1),
        (N'{a} - {b}', N'a - b', N'Subtract two numbers', 0, 4, 1),
        (N'{a} × {b}', N'a * b', N'Multiply two numbers', 3, 6, 1)
) AS s(formula_template, answer_expression, description, grade_min, grade_max, is_active)
ON t.formula_template = s.formula_template AND t.answer_expression = s.answer_expression
WHEN MATCHED THEN
    UPDATE SET description = s.description,
               grade_min = s.grade_min,
               grade_max = s.grade_max,
               is_active = s.is_active
WHEN NOT MATCHED THEN
    INSERT (formula_template, answer_expression, description, grade_min, grade_max, is_active)
    VALUES (s.formula_template, s.answer_expression, s.description, s.grade_min, s.grade_max, s.is_active);

-- Seed / update all 18 questions (idempotent MERGE)
MERGE dbo.AssessmentQuestions AS t
USING (VALUES
  ( 1, 'age',      NULL,       'How old is your child?',
    'We''ll use this to calibrate the plan.', 'select',
    '[{"v":"4","label":"4 years old","emo":"🧸"},{"v":"5","label":"5 years old","emo":"🎈"},{"v":"6","label":"6 years old","emo":"🪁"},{"v":"7","label":"7 years old","emo":"🚲"},{"v":"8","label":"8 years old","emo":"⚽"},{"v":"9","label":"9 years old","emo":"🎸"},{"v":"10","label":"10 years old","emo":"🔬"},{"v":"11","label":"11 years old","emo":"🎨"},{"v":"12","label":"12 years old","emo":"📚"}]' ),

  ( 2, 'grade',    NULL,       'What grade are they in?',
    'Or the grade they''re about to enter.', 'select',
    '[{"v":"TK","label":"Transitional Kindergarten"},{"v":"K","label":"Kindergarten"},{"v":"1","label":"1st grade"},{"v":"2","label":"2nd grade"},{"v":"3","label":"3rd grade"},{"v":"4","label":"4th grade"},{"v":"5","label":"5th grade"},{"v":"6","label":"6th grade"}]' ),

  ( 3, 'program',  NULL,       'Afterschool or homeschool?',
    'This changes how much time we recommend.', 'select',
    '[{"v":"afterschool","label":"Afterschool enrichment","emo":"🌇"},{"v":"homeschool","label":"Homeschool (main curriculum)","emo":"🏠"},{"v":"explore","label":"Just exploring for now","emo":"🔍"}]' ),

  ( 4, 'math',     'math',     'How is math going?',
    'Parent''s sense of it is fine — no tests involved.', 'select',
    '[{"v":"struggling","label":"Struggling — needs to build confidence","emo":"🌱"},{"v":"onlevel","label":"Right on grade level","emo":"✅"},{"v":"ahead","label":"Ahead — ready for more challenge","emo":"🚀"}]' ),

  ( 5, 'spelling', 'phonics',  'How is spelling?',
    '', 'select',
    '[{"v":"struggling","label":"Reverses letters or guesses at words","emo":"🌱"},{"v":"onlevel","label":"Spells most grade-level words","emo":"✅"},{"v":"ahead","label":"Spells accurately beyond grade","emo":"🚀"}]' ),

  ( 6, 'reading',  'reading',  'How about reading?',
    'Pick what describes them best.', 'select',
    '[{"v":"pre","label":"Pre-reader — knows some letters","emo":"🔤"},{"v":"early","label":"Reads short sentences / sight words","emo":"📖"},{"v":"chapter","label":"Reads early chapter books","emo":"📚"},{"v":"novel","label":"Reads novels independently","emo":"📕"}]' ),

  ( 7, 'science',  NULL,       'Do they ask science questions?',
    'How curious are they about how things work?', 'select',
    '[{"v":"sparingly","label":"Not really — not their thing yet","emo":"💭"},{"v":"sometimes","label":"Sometimes — sparks of curiosity","emo":"🔎"},{"v":"constantly","label":"Constantly asks ''why'' about everything","emo":"🔬"}]' ),

  ( 8, 'art',      'art',      'How do they feel about art?',
    'Drawing, crafts, making things.', 'select',
    '[{"v":"avoids","label":"Avoids it","emo":"🎭"},{"v":"okay","label":"Enjoys it sometimes","emo":"🖍️"},{"v":"loves","label":"Draws or builds daily","emo":"🎨"}]' ),

  ( 9, 'logic',    'logic',    'How are they with logic puzzles?',
    'Sudoku, pattern grids, riddles, chess — screen-free thinking practice.', 'select',
    '[{"v":"new","label":"Haven''t tried much","emo":"🌱"},{"v":"enjoys","label":"Enjoys a good puzzle","emo":"🧩"},{"v":"loves","label":"Loves them — give more challenge","emo":"♟️"}]' ),

  (10, 'emotions', 'feelings', 'How does your child handle big emotions?',
    'No judgment — this helps us dose the SEL content.', 'select',
    '[{"v":"overwhelmed","label":"Gets overwhelmed often","emo":"🌧️"},{"v":"learning","label":"Learning to name feelings","emo":"💛"},{"v":"confident","label":"Calm and articulate","emo":"🌈"}]' ),

  (11, 'manners',  'manners',  'Where is character & manners practice right now?',
    'Kindness, table manners, friendship, family values.', 'select',
    '[{"v":"foundational","label":"We''re building the basics","emo":"🌱"},{"v":"growing","label":"Going well — keep reinforcing","emo":"🌿"},{"v":"strong","label":"Strong — ready for deeper values","emo":"🌳"}]' ),

  (12, 'interest', NULL,       'What lights them up the most?',
    'We''ll pick daily stories in this world.', 'select',
    '[{"v":"animals","label":"Animals & pets","emo":"🐶"},{"v":"space","label":"Space & planets","emo":"🚀"},{"v":"ocean","label":"Ocean & sea creatures","emo":"🐙"},{"v":"building","label":"Building & inventing","emo":"🔧"},{"v":"sports","label":"Sports & movement","emo":"⚽"},{"v":"art","label":"Art & music","emo":"🎨"},{"v":"mystery","label":"Mysteries & puzzles","emo":"🔎"},{"v":"nature","label":"Nature & plants","emo":"🌿"},{"v":"food","label":"Food & cooking","emo":"🍪"},{"v":"dragons","label":"Dragons & magic","emo":"🐉"}]' ),

  (13, 'style',    NULL,       'How do they learn best?',
    '', 'select',
    '[{"v":"video","label":"Short videos & demos","emo":"▶️"},{"v":"print","label":"Worksheets & books","emo":"📝"},{"v":"story","label":"Hearing stories","emo":"📖"},{"v":"hands","label":"Hands-on projects","emo":"🧩"}]' ),

  (14, 'time',     NULL,       'How much time each day can you commit?',
    'Honest answer wins. We''ll split this into short sessions.', 'select',
    '[{"v":"15","label":"15 minutes","emo":"⏱️"},{"v":"30","label":"30 minutes","emo":"⏰"},{"v":"45","label":"45 minutes","emo":"📘"},{"v":"60","label":"1 hour","emo":"📚"},{"v":"120","label":"2+ hours (homeschool)","emo":"🎓"}]' ),

  (15, 'days',     NULL,       'How many days a week?',
    '', 'select',
    '[{"v":"3","label":"3 days"},{"v":"5","label":"5 days (weekdays)"},{"v":"6","label":"6 days"},{"v":"7","label":"Every day"}]' ),

  (16, 'language', NULL,       'Any home languages we should include?',
    'Your child will see their work in both English and the chosen language.', 'select',
    '[{"v":"en","label":"English only","emo":"🇺🇸"},{"v":"zh","label":"Mandarin (中文)","emo":"🇨🇳"},{"v":"hi","label":"Hindi (हिन्दी)","emo":"🇮🇳"},{"v":"es","label":"Spanish (Español)","emo":"🇪🇸"}]' ),

  (17, 'goal',     NULL,       'What''s your biggest goal?',
    'Pick the one that matters most right now.', 'select',
    '[{"v":"catchup","label":"Catch up to grade level","emo":"🏁"},{"v":"enrich","label":"Enrich & keep curious","emo":"✨"},{"v":"accelerate","label":"Accelerate beyond grade","emo":"🚀"},{"v":"confidence","label":"Build confidence & love of learning","emo":"💛"}]' ),

  (18, 'focus',    NULL,       'Anywhere you want to focus extra?',
    'We''ll weight the plan toward this.', 'select',
    '[{"v":"reading","label":"Reading & phonics","emo":"📖"},{"v":"math","label":"Math","emo":"🧮"},{"v":"logic","label":"Logic & critical thinking","emo":"🧩"},{"v":"emotions","label":"Feelings & emotional SEL","emo":"💛"},{"v":"manners","label":"Character & manners","emo":"🌱"},{"v":"art","label":"Art & creativity","emo":"🎨"}]' )

) AS s (sort_order, step_key, subject, question_text, sub_text, input_type, options_json)
ON t.step_key = s.step_key
WHEN MATCHED THEN
    UPDATE SET
        subject       = s.subject,
        question_text = s.question_text,
        sub_text      = s.sub_text,
        input_type    = s.input_type,
        options_json  = s.options_json,
        sort_order    = s.sort_order
WHEN NOT MATCHED THEN
    INSERT (step_key, subject, question_text, sub_text, input_type, options_json, sort_order)
    VALUES (s.step_key, s.subject, s.question_text, s.sub_text, s.input_type, s.options_json, s.sort_order);
GO
