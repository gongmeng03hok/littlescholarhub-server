-- 50_grade3_content.sql
-- Grade 3, content bank — 30 original categories drawn from the ABC
-- Unified Grade 3 category list. Most categories carry more questions
-- than their target_count so weekly composition genuinely varies. See
-- gen_grade3_seed.py for the generator source.

IF NOT EXISTS (SELECT 1 FROM dbo.PacketCategories WHERE grade_id = 4)
BEGIN
DECLARE @g3cat1 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (4, 'math', N'Multiplication Facts (0-10)', 'short_answer', 10, NULL);
SET @g3cat1 = SCOPE_IDENTITY();

DECLARE @g3cat2 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (4, 'math', N'Division Facts (0-10)', 'short_answer', 10, NULL);
SET @g3cat2 = SCOPE_IDENTITY();

DECLARE @g3cat3 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (4, 'math', N'Multiplication Word Problems', 'space_heavy', 6, NULL);
SET @g3cat3 = SCOPE_IDENTITY();

DECLARE @g3cat4 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (4, 'math', N'Rounding to Nearest Ten/Hundred', 'short_answer', 10, NULL);
SET @g3cat4 = SCOPE_IDENTITY();

DECLARE @g3cat5 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (4, 'math', N'Equivalent Fractions', 'short_answer', 8, NULL);
SET @g3cat5 = SCOPE_IDENTITY();

DECLARE @g3cat6 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (4, 'math', N'Comparing Fractions', 'short_answer', 8, NULL);
SET @g3cat6 = SCOPE_IDENTITY();

DECLARE @g3cat7 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (4, 'math', N'Area and Perimeter', 'short_answer', 8, NULL);
SET @g3cat7 = SCOPE_IDENTITY();

DECLARE @g3cat8 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (4, 'math', N'Telling Time to the Minute', 'short_answer', 8, NULL);
SET @g3cat8 = SCOPE_IDENTITY();

DECLARE @g3cat9 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (4, 'math', N'Multi-Digit Addition/Subtraction', 'short_answer', 10, NULL);
SET @g3cat9 = SCOPE_IDENTITY();

DECLARE @g3cat10 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (4, 'math', N'Two-Step Word Problems', 'space_heavy', 6, NULL);
SET @g3cat10 = SCOPE_IDENTITY();

DECLARE @g3cat11 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (4, 'math', N'Number Patterns (Input/Output Tables)', 'short_answer', 4, NULL);
SET @g3cat11 = SCOPE_IDENTITY();

DECLARE @g3cat12 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (4, 'ela', N'Prefixes, Suffixes, Root Words', 'short_answer', 8, NULL);
SET @g3cat12 = SCOPE_IDENTITY();

DECLARE @g3cat13 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (4, 'ela', N'Synonyms, Antonyms, Homophones', 'short_answer', 10, NULL);
SET @g3cat13 = SCOPE_IDENTITY();

DECLARE @g3cat14 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (4, 'ela', N'Figurative Language (Simile, Metaphor, Personification)', 'short_answer', 8, NULL);
SET @g3cat14 = SCOPE_IDENTITY();

DECLARE @g3cat15 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (4, 'ela', N'Compound and Complex Sentences', 'short_answer', 8, NULL);
SET @g3cat15 = SCOPE_IDENTITY();

DECLARE @g3cat16 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (4, 'ela', N'Apostrophes (Possessives & Contractions)', 'short_answer', 10, NULL);
SET @g3cat16 = SCOPE_IDENTITY();

DECLARE @g3cat17 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (4, 'ela', N'Context Clues Vocabulary', 'space_heavy', 6, NULL);
SET @g3cat17 = SCOPE_IDENTITY();

DECLARE @g3cat18 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (4, 'ela', N'Author''s Purpose', 'short_answer', 6, NULL);
SET @g3cat18 = SCOPE_IDENTITY();

DECLARE @g3cat19 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (4, 'ela', N'Cause and Effect', 'short_answer', 6, NULL);
SET @g3cat19 = SCOPE_IDENTITY();

DECLARE @g3cat20 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (4, 'ela', N'Fiction vs. Nonfiction Text Features', 'short_answer', 8, NULL);
SET @g3cat20 = SCOPE_IDENTITY();

DECLARE @g3cat21 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (4, 'ela', N'Reading Comprehension: Main Idea & Theme', 'space_heavy', 6, N'Owls of the Night

Owls are birds that are famous for being active at night. Their large eyes let in plenty of light, which helps them see well in the dark. Because owl eyes don''t move in their sockets, an owl must turn its whole head to look around — and it can turn its head almost all the way around!

An owl''s feathers are specially shaped to muffle sound, so it can fly almost silently. This helps the owl sneak up on mice and other small animals without being heard. Once an owl spots its prey, it swoops down and catches it with its sharp talons.

Different kinds of owls live in different places — forests, deserts, and even barns. No matter where they live, all owls share these same clever adaptations for hunting at night.');
SET @g3cat21 = SCOPE_IDENTITY();

DECLARE @g3cat22 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (4, 'writing', N'Persuasive Writing', 'space_heavy', 7, N'Plan your persuasive writing below, then write it on a separate sheet or the back of this page.');
SET @g3cat22 = SCOPE_IDENTITY();

DECLARE @g3cat23 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (4, 'writing', N'Opinion Writing with Evidence', 'space_heavy', 7, N'Plan your opinion piece below, then write it with reasons and evidence on a separate sheet.');
SET @g3cat23 = SCOPE_IDENTITY();

DECLARE @g3cat24 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (4, 'science', N'States of Matter and Changes', 'short_answer', 8, NULL);
SET @g3cat24 = SCOPE_IDENTITY();

DECLARE @g3cat25 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (4, 'science', N'Ecosystems and Food Webs', 'short_answer', 8, NULL);
SET @g3cat25 = SCOPE_IDENTITY();

DECLARE @g3cat26 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (4, 'social_studies', N'Map/Globe Skills', 'short_answer', 8, NULL);
SET @g3cat26 = SCOPE_IDENTITY();

DECLARE @g3cat27 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (4, 'social_studies', N'Government Structure (Local, State, Federal)', 'short_answer', 6, NULL);
SET @g3cat27 = SCOPE_IDENTITY();

DECLARE @g3cat28 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (4, 'social_studies', N'Economics: Production, Distribution, Consumption', 'short_answer', 6, NULL);
SET @g3cat28 = SCOPE_IDENTITY();

DECLARE @g3cat29 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (4, 'puzzle', N'Word Search Puzzle', 'puzzle', 1, NULL);
SET @g3cat29 = SCOPE_IDENTITY();

DECLARE @g3cat30 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (4, 'puzzle', N'Logic Grid Puzzle', 'space_heavy', 1, NULL);
SET @g3cat30 = SCOPE_IDENTITY();

-- 1. Multiplication Facts (0-10) (14 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat1, 'fill_blank', N'2 × 5 = ___', NULL, N'10', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat1, 'fill_blank', N'5 × 3 = ___', NULL, N'15', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat1, 'fill_blank', N'6 × 10 = ___', NULL, N'60', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat1, 'fill_blank', N'8 × 4 = ___', NULL, N'32', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat1, 'fill_blank', N'8 × 9 = ___', NULL, N'72', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat1, 'fill_blank', N'3 × 6 = ___', NULL, N'18', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat1, 'fill_blank', N'10 × 10 = ___', NULL, N'100', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat1, 'fill_blank', N'2 × 3 = ___', NULL, N'6', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat1, 'fill_blank', N'8 × 4 = ___', NULL, N'32', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat1, 'fill_blank', N'9 × 6 = ___', NULL, N'54', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat1, 'fill_blank', N'2 × 8 = ___', NULL, N'16', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat1, 'fill_blank', N'6 × 2 = ___', NULL, N'12', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat1, 'fill_blank', N'5 × 5 = ___', NULL, N'25', 13);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat1, 'fill_blank', N'7 × 4 = ___', NULL, N'28', 14);

-- 2. Division Facts (0-10) (14 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat2, 'fill_blank', N'20 ÷ 4 = ___', NULL, N'5', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat2, 'fill_blank', N'18 ÷ 6 = ___', NULL, N'3', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat2, 'fill_blank', N'50 ÷ 5 = ___', NULL, N'10', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat2, 'fill_blank', N'60 ÷ 6 = ___', NULL, N'10', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat2, 'fill_blank', N'10 ÷ 5 = ___', NULL, N'2', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat2, 'fill_blank', N'36 ÷ 6 = ___', NULL, N'6', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat2, 'fill_blank', N'28 ÷ 4 = ___', NULL, N'7', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat2, 'fill_blank', N'27 ÷ 3 = ___', NULL, N'9', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat2, 'fill_blank', N'24 ÷ 4 = ___', NULL, N'6', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat2, 'fill_blank', N'40 ÷ 10 = ___', NULL, N'4', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat2, 'fill_blank', N'12 ÷ 3 = ___', NULL, N'4', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat2, 'fill_blank', N'27 ÷ 9 = ___', NULL, N'3', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat2, 'fill_blank', N'32 ÷ 4 = ___', NULL, N'8', 13);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat2, 'fill_blank', N'14 ÷ 2 = ___', NULL, N'7', 14);

-- 3. Multiplication Word Problems (6 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat3, 'short_response', N'Elena has 4 bags of apples, with 8 in each. How many are there in all?', NULL, N'32', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat3, 'short_response', N'Devon has 8 boxes of pencils, with 6 in each. How many are there in all?', NULL, N'48', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat3, 'short_response', N'Josie has 5 boxes of pencils, with 4 in each. How many are there in all?', NULL, N'20', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat3, 'short_response', N'Mateo has 4 rows of desks, with 8 in each. How many are there in all?', NULL, N'32', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat3, 'short_response', N'Devon has 7 boxes of pencils, with 9 in each. How many are there in all?', NULL, N'63', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat3, 'short_response', N'Elena has 5 boxes of pencils, with 7 in each. How many are there in all?', NULL, N'35', 6);

-- 4. Rounding to Nearest Ten/Hundred (14 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat4, 'fill_blank', N'Round 75 to the nearest ten:', NULL, N'80', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat4, 'fill_blank', N'Round 297 to the nearest hundred:', NULL, N'300', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat4, 'fill_blank', N'Round 702 to the nearest ten:', NULL, N'700', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat4, 'fill_blank', N'Round 140 to the nearest hundred:', NULL, N'100', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat4, 'fill_blank', N'Round 612 to the nearest hundred:', NULL, N'600', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat4, 'fill_blank', N'Round 602 to the nearest ten:', NULL, N'600', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat4, 'fill_blank', N'Round 678 to the nearest ten:', NULL, N'680', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat4, 'fill_blank', N'Round 83 to the nearest ten:', NULL, N'80', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat4, 'fill_blank', N'Round 520 to the nearest hundred:', NULL, N'500', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat4, 'fill_blank', N'Round 227 to the nearest ten:', NULL, N'230', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat4, 'fill_blank', N'Round 786 to the nearest hundred:', NULL, N'800', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat4, 'fill_blank', N'Round 613 to the nearest hundred:', NULL, N'600', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat4, 'fill_blank', N'Round 990 to the nearest hundred:', NULL, N'1000', 13);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat4, 'fill_blank', N'Round 139 to the nearest hundred:', NULL, N'100', 14);

-- 5. Equivalent Fractions (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat5, 'fill_blank', N'1/2 = ___/4', NULL, N'2', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat5, 'fill_blank', N'1/3 = ___/6', NULL, N'2', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat5, 'fill_blank', N'2/3 = ___/6', NULL, N'4', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat5, 'fill_blank', N'1/4 = ___/8', NULL, N'2', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat5, 'fill_blank', N'1/2 = ___/6', NULL, N'3', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat5, 'fill_blank', N'2/5 = ___/10', NULL, N'4', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat5, 'fill_blank', N'3/4 = ___/8', NULL, N'6', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat5, 'fill_blank', N'1/5 = ___/10', NULL, N'2', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat5, 'fill_blank', N'3/5 = ___/10', NULL, N'6', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat5, 'fill_blank', N'1/6 = ___/12', NULL, N'2', 10);

-- 6. Comparing Fractions (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat6, 'fill_blank', N'1/2 ___ 1/4', NULL, N'>', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat6, 'fill_blank', N'1/3 ___ 1/2', NULL, N'<', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat6, 'fill_blank', N'2/3 ___ 1/3', NULL, N'>', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat6, 'fill_blank', N'1/4 ___ 1/3', NULL, N'<', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat6, 'fill_blank', N'3/4 ___ 1/2', NULL, N'>', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat6, 'fill_blank', N'1/5 ___ 1/2', NULL, N'<', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat6, 'fill_blank', N'2/4 ___ 1/2', NULL, N'=', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat6, 'fill_blank', N'3/6 ___ 1/2', NULL, N'=', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat6, 'fill_blank', N'1/8 ___ 1/4', NULL, N'<', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat6, 'fill_blank', N'5/6 ___ 1/2', NULL, N'>', 10);

-- 7. Area and Perimeter (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat7, 'fill_blank', N'A rectangle is 10 cm by 9 cm. What is its perimeter?', NULL, N'38 cm', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat7, 'fill_blank', N'A rectangle is 3 cm by 10 cm. What is its perimeter?', NULL, N'26 cm', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat7, 'fill_blank', N'A rectangle is 9 cm by 8 cm. What is its area?', NULL, N'72 sq cm', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat7, 'fill_blank', N'A rectangle is 6 cm by 9 cm. What is its area?', NULL, N'54 sq cm', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat7, 'fill_blank', N'A rectangle is 8 cm by 10 cm. What is its perimeter?', NULL, N'36 cm', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat7, 'fill_blank', N'A rectangle is 11 cm by 3 cm. What is its perimeter?', NULL, N'28 cm', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat7, 'fill_blank', N'A rectangle is 5 cm by 4 cm. What is its perimeter?', NULL, N'18 cm', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat7, 'fill_blank', N'A rectangle is 7 cm by 7 cm. What is its area?', NULL, N'49 sq cm', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat7, 'fill_blank', N'A rectangle is 8 cm by 9 cm. What is its perimeter?', NULL, N'34 cm', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat7, 'fill_blank', N'A rectangle is 3 cm by 6 cm. What is its area?', NULL, N'18 sq cm', 10);

-- 8. Telling Time to the Minute (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@g3cat8, 'fill_blank', N'What time does the clock show?', NULL, N'6:25', 1, 'clock', N'{"hour": 6, "minute": 25}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@g3cat8, 'fill_blank', N'What time does the clock show?', NULL, N'9:15', 2, 'clock', N'{"hour": 9, "minute": 15}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@g3cat8, 'fill_blank', N'What time does the clock show?', NULL, N'9:35', 3, 'clock', N'{"hour": 9, "minute": 35}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@g3cat8, 'fill_blank', N'What time does the clock show?', NULL, N'5:40', 4, 'clock', N'{"hour": 5, "minute": 40}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@g3cat8, 'fill_blank', N'What time does the clock show?', NULL, N'9:05', 5, 'clock', N'{"hour": 9, "minute": 5}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@g3cat8, 'fill_blank', N'What time does the clock show?', NULL, N'3:05', 6, 'clock', N'{"hour": 3, "minute": 5}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@g3cat8, 'fill_blank', N'What time does the clock show?', NULL, N'11:10', 7, 'clock', N'{"hour": 11, "minute": 10}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@g3cat8, 'fill_blank', N'What time does the clock show?', NULL, N'5:25', 8, 'clock', N'{"hour": 5, "minute": 25}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@g3cat8, 'fill_blank', N'What time does the clock show?', NULL, N'10:05', 9, 'clock', N'{"hour": 10, "minute": 5}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@g3cat8, 'fill_blank', N'What time does the clock show?', NULL, N'7:40', 10, 'clock', N'{"hour": 7, "minute": 40}');

-- 9. Multi-Digit Addition/Subtraction (14 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat9, 'fill_blank', N'915 + 299 = ___', NULL, N'1214', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat9, 'fill_blank', N'408 - 267 = ___', NULL, N'141', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat9, 'fill_blank', N'979 + 632 = ___', NULL, N'1611', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat9, 'fill_blank', N'512 + 425 = ___', NULL, N'937', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat9, 'fill_blank', N'782 - 264 = ___', NULL, N'518', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat9, 'fill_blank', N'835 - 767 = ___', NULL, N'68', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat9, 'fill_blank', N'616 + 471 = ___', NULL, N'1087', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat9, 'fill_blank', N'831 - 533 = ___', NULL, N'298', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat9, 'fill_blank', N'662 - 289 = ___', NULL, N'373', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat9, 'fill_blank', N'172 + 120 = ___', NULL, N'292', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat9, 'fill_blank', N'597 - 341 = ___', NULL, N'256', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat9, 'fill_blank', N'822 + 486 = ___', NULL, N'1308', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat9, 'fill_blank', N'560 + 891 = ___', NULL, N'1451', 13);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat9, 'fill_blank', N'574 - 418 = ___', NULL, N'156', 14);

-- 10. Two-Step Word Problems (6 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat10, 'short_response', N'Emma had 65 baseball cards. Emma traded away 19 and then bought 19 more. How many cards does Emma have now?', NULL, N'65', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat10, 'short_response', N'Sam had 48 baseball cards. Sam traded away 9 and then bought 12 more. How many cards does Sam have now?', NULL, N'51', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat10, 'short_response', N'Ravi had 85 baseball cards. Ravi traded away 8 and then bought 20 more. How many cards does Ravi have now?', NULL, N'97', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat10, 'short_response', N'Emma had 47 baseball cards. Emma traded away 8 and then bought 19 more. How many cards does Emma have now?', NULL, N'58', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat10, 'short_response', N'Noah had 76 baseball cards. Noah traded away 18 and then bought 15 more. How many cards does Noah have now?', NULL, N'73', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat10, 'short_response', N'Ravi had 44 baseball cards. Ravi traded away 8 and then bought 13 more. How many cards does Ravi have now?', NULL, N'49', 6);

-- 11. Number Patterns (Input/Output Tables) (4 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat11, 'short_response', N'Input: 1, 2, 3, 4  Output: 3, 6, 9, 12  → what is the rule?', NULL, N'multiply by 3', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat11, 'short_response', N'Input: 2, 4, 6, 8  Output: 5, 9, 13, 17  → what is the rule?', NULL, N'double, then add 1', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat11, 'short_response', N'Input: 1, 2, 3, 4  Output: 10, 20, 30, 40  → what is the rule?', NULL, N'multiply by 10', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat11, 'short_response', N'Input: 5, 6, 7, 8  Output: 15, 18, 21, 24  → what is the rule?', NULL, N'multiply by 3', 4);

-- 12. Prefixes, Suffixes, Root Words (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat12, 'fill_blank', N'un + happy =', NULL, N'unhappy', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat12, 'fill_blank', N're + build =', NULL, N'rebuild', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat12, 'fill_blank', N'pre + heat =', NULL, N'preheat', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat12, 'fill_blank', N'dis + agree =', NULL, N'disagree', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat12, 'fill_blank', N'care + less =', NULL, N'careless', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat12, 'fill_blank', N'help + ful =', NULL, N'helpful', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat12, 'fill_blank', N'teach + er =', NULL, N'teacher', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat12, 'fill_blank', N'hope + less =', NULL, N'hopeless', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat12, 'fill_blank', N'kind + ness =', NULL, N'kindness', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat12, 'fill_blank', N'act + ion =', NULL, N'action', 10);

-- 13. Synonyms, Antonyms, Homophones (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat13, 'short_response', N'Choose the correct word: Their / There / They''re — the dog wagged ___ tail', NULL, N'Answers will vary — check the correct homophone is used.', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat13, 'short_response', N'Choose the correct word: To / Too / Two — she has ___ cats', NULL, N'Answers will vary — check the correct homophone is used.', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat13, 'short_response', N'Choose the correct word: Your / You''re — ___ going to love this book', NULL, N'Answers will vary — check the correct homophone is used.', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat13, 'short_response', N'Choose the correct word: Its / It''s — ___ raining outside', NULL, N'Answers will vary — check the correct homophone is used.', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat13, 'short_response', N'Choose the correct word: Whose / Who''s — ___ backpack is this?', NULL, N'Answers will vary — check the correct homophone is used.', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat13, 'short_response', N'Choose the correct word: Here / Hear — I can ___ the music', NULL, N'Answers will vary — check the correct homophone is used.', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat13, 'short_response', N'Choose the correct word: Write / Right — turn ___ at the corner', NULL, N'Answers will vary — check the correct homophone is used.', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat13, 'short_response', N'Choose the correct word: Peace / Piece — may I have a ___ of cake', NULL, N'Answers will vary — check the correct homophone is used.', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat13, 'short_response', N'Choose the correct word: Sea / See — can you ___ the ocean', NULL, N'Answers will vary — check the correct homophone is used.', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat13, 'short_response', N'Choose the correct word: Blew / Blue — the sky is ___', NULL, N'Answers will vary — check the correct homophone is used.', 10);

-- 14. Figurative Language (Simile, Metaphor, Personification) (8 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat14, 'multiple_choice', N'The classroom was as quiet as a library.', N'["simile", "metaphor", "personification"]', N'simile', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat14, 'multiple_choice', N'Her smile was sunshine on a cloudy day.', N'["simile", "metaphor", "personification"]', N'metaphor', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat14, 'multiple_choice', N'The wind whispered through the trees.', N'["simile", "metaphor", "personification"]', N'personification', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat14, 'multiple_choice', N'He ran as fast as a cheetah.', N'["simile", "metaphor", "personification"]', N'simile', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat14, 'multiple_choice', N'The stars were diamonds scattered across the sky.', N'["simile", "metaphor", "personification"]', N'metaphor', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat14, 'multiple_choice', N'The old car groaned as it climbed the hill.', N'["simile", "metaphor", "personification"]', N'personification', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat14, 'multiple_choice', N'She was as brave as a lion.', N'["simile", "metaphor", "personification"]', N'simile', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat14, 'multiple_choice', N'Time is a thief.', N'["simile", "metaphor", "personification"]', N'metaphor', 8);

-- 15. Compound and Complex Sentences (8 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat15, 'multiple_choice', N'I like pizza, and I like pasta. — is this sentence compound or complex?', N'["compound", "complex"]', N'compound', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat15, 'multiple_choice', N'Because it was raining, we stayed inside. — is this sentence compound or complex?', N'["compound", "complex"]', N'complex', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat15, 'multiple_choice', N'She sings, and she dances. — is this sentence compound or complex?', N'["compound", "complex"]', N'compound', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat15, 'multiple_choice', N'Although he was tired, he finished his homework. — is this sentence compound or complex?', N'["compound", "complex"]', N'complex', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat15, 'multiple_choice', N'We packed our bags, and we left early. — is this sentence compound or complex?', N'["compound", "complex"]', N'compound', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat15, 'multiple_choice', N'When the bell rang, everyone lined up. — is this sentence compound or complex?', N'["compound", "complex"]', N'complex', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat15, 'multiple_choice', N'The dog barked, but the cat ignored it. — is this sentence compound or complex?', N'["compound", "complex"]', N'compound', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat15, 'multiple_choice', N'Since it was late, we went home. — is this sentence compound or complex?', N'["compound", "complex"]', N'complex', 8);

-- 16. Apostrophes (Possessives & Contractions) (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat16, 'fill_blank', N'the dog that belongs to Sam', NULL, N'Sam''s dog', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat16, 'fill_blank', N'they are', NULL, N'they''re', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat16, 'fill_blank', N'the toys that belong to the boys', NULL, N'the boys'' toys', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat16, 'fill_blank', N'she is', NULL, N'she''s', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat16, 'fill_blank', N'the tail of the cat', NULL, N'the cat''s tail', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat16, 'fill_blank', N'it is', NULL, N'it''s', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat16, 'fill_blank', N'the pencils that belong to the students', NULL, N'the students'' pencils', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat16, 'fill_blank', N'we have', NULL, N'we''ve', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat16, 'fill_blank', N'the bike that belongs to my sister', NULL, N'my sister''s bike', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat16, 'fill_blank', N'do not', NULL, N'don''t', 10);

-- 17. Context Clues Vocabulary (6 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat17, 'short_response', N'“The famished dog hadn''t eaten in two days.” — What does the word “famished” most likely mean?', NULL, N'very hungry', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat17, 'short_response', N'“She was ecstatic when she won the prize.” — What does the word “ecstatic” most likely mean?', NULL, N'extremely happy', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat17, 'short_response', N'“The ancient castle was hundreds of years old.” — What does the word “ancient” most likely mean?', NULL, N'very old', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat17, 'short_response', N'“He was exhausted after the long hike.” — What does the word “exhausted” most likely mean?', NULL, N'very tired', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat17, 'short_response', N'“The enormous elephant towered over the zookeeper.” — What does the word “enormous” most likely mean?', NULL, N'huge', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat17, 'short_response', N'“She whispered so no one else would hear.” — What does the word “whispered” most likely mean?', NULL, N'spoke very quietly', 6);

-- 18. Author's Purpose (6 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat18, 'multiple_choice', N'Studies show kids who read daily score higher on tests.', N'["Persuade", "Inform", "Entertain"]', N'Inform', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat18, 'multiple_choice', N'Once upon a time, a dragon lived in a cold cave.', N'["Persuade", "Inform", "Entertain"]', N'Entertain', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat18, 'multiple_choice', N'You should recycle to help the planet!', N'["Persuade", "Inform", "Entertain"]', N'Persuade', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat18, 'multiple_choice', N'The recipe calls for two cups of flour.', N'["Persuade", "Inform", "Entertain"]', N'Inform', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat18, 'multiple_choice', N'Suddenly, the pirate ship appeared on the horizon.', N'["Persuade", "Inform", "Entertain"]', N'Entertain', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat18, 'multiple_choice', N'Please vote for cleaner parks in our town.', N'["Persuade", "Inform", "Entertain"]', N'Persuade', 6);

-- 19. Cause and Effect (6 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat19, 'short_response', N'The rain flooded the streets, so school was cancelled. What is the effect?', NULL, N'School was cancelled', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat19, 'short_response', N'She forgot her umbrella, so she got soaked in the rain. What is the effect?', NULL, N'She got soaked in the rain', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat19, 'short_response', N'He practiced every day, so he won the race. What is the effect?', NULL, N'He won the race', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat19, 'short_response', N'The power went out, so we lit candles. What is the effect?', NULL, N'We lit candles', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat19, 'short_response', N'She studied hard, so she passed the test. What is the effect?', NULL, N'She passed the test', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat19, 'short_response', N'The ice melted, so the pond overflowed. What is the effect?', NULL, N'The pond overflowed', 6);

-- 20. Fiction vs. Nonfiction Text Features (8 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat20, 'multiple_choice', N'A table of contents', N'["Fiction", "Nonfiction"]', N'Nonfiction', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat20, 'multiple_choice', N'A made-up talking animal', N'["Fiction", "Nonfiction"]', N'Fiction', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat20, 'multiple_choice', N'A glossary of terms', N'["Fiction", "Nonfiction"]', N'Nonfiction', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat20, 'multiple_choice', N'A dragon and a castle', N'["Fiction", "Nonfiction"]', N'Fiction', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat20, 'multiple_choice', N'Photographs with captions', N'["Fiction", "Nonfiction"]', N'Nonfiction', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat20, 'multiple_choice', N'A fairy godmother', N'["Fiction", "Nonfiction"]', N'Fiction', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat20, 'multiple_choice', N'Headings and subheadings', N'["Fiction", "Nonfiction"]', N'Nonfiction', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat20, 'multiple_choice', N'A superhero with special powers', N'["Fiction", "Nonfiction"]', N'Fiction', 8);

-- 21. Reading Comprehension: Main Idea & Theme (6 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat21, 'short_response', N'What is the main idea of this passage?', NULL, N'Owls have special features that help them hunt at night', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat21, 'short_response', N'Why must an owl turn its whole head to look around?', NULL, N'Because its eyes don''t move in their sockets', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat21, 'short_response', N'How do an owl''s feathers help it hunt?', NULL, N'They muffle sound so the owl can fly almost silently', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat21, 'short_response', N'What does an owl use to catch its prey?', NULL, N'Its sharp talons', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat21, 'short_response', N'Name two different places owls can live.', NULL, N'Any two of: forests, deserts, barns', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat21, 'short_response', N'What is the theme or lesson of this passage?', NULL, N'Open response — example: animals have special adaptations suited to their environment', 6);

-- 22. Persuasive Writing (7 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat22, 'short_response', N'What are you trying to persuade your reader to think or do?', NULL, N'Open response — check for a clear position and supporting reasons.', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat22, 'short_response', N'What is your strongest reason?', NULL, N'Open response — check for a clear position and supporting reasons.', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat22, 'short_response', N'What evidence or example supports that reason?', NULL, N'Open response — check for a clear position and supporting reasons.', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat22, 'short_response', N'What is a second reason?', NULL, N'Open response — check for a clear position and supporting reasons.', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat22, 'short_response', N'What might someone who disagrees say?', NULL, N'Open response — check for a clear position and supporting reasons.', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat22, 'short_response', N'How would you respond to that disagreement?', NULL, N'Open response — check for a clear position and supporting reasons.', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat22, 'short_response', N'How will you end your persuasive piece?', NULL, N'Open response — check for a clear position and supporting reasons.', 7);

-- 23. Opinion Writing with Evidence (7 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat23, 'short_response', N'What is your opinion?', NULL, N'Open response — check for opinion, reasons, and evidence.', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat23, 'short_response', N'What is your first reason, with evidence to support it?', NULL, N'Open response — check for opinion, reasons, and evidence.', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat23, 'short_response', N'What is your second reason, with evidence to support it?', NULL, N'Open response — check for opinion, reasons, and evidence.', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat23, 'short_response', N'What is your third reason, with evidence to support it?', NULL, N'Open response — check for opinion, reasons, and evidence.', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat23, 'short_response', N'What transition words will you use (First, Also, In addition)?', NULL, N'Open response — check for opinion, reasons, and evidence.', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat23, 'short_response', N'How will you restate your opinion in your conclusion?', NULL, N'Open response — check for opinion, reasons, and evidence.', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat23, 'short_response', N'Who is the audience for this piece?', NULL, N'Open response — check for opinion, reasons, and evidence.', 7);

-- 24. States of Matter and Changes (8 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat24, 'multiple_choice', N'Ice melting into water is an example of ___.', N'["melting", "freezing", "evaporation"]', N'melting', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat24, 'multiple_choice', N'Water boiling into steam is an example of ___.', N'["evaporation", "condensation", "freezing"]', N'evaporation', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat24, 'multiple_choice', N'Water vapor turning into dew on grass is an example of ___.', N'["condensation", "melting", "evaporation"]', N'condensation', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat24, 'multiple_choice', N'Water turning into ice is an example of ___.', N'["freezing", "melting", "evaporation"]', N'freezing', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat24, 'multiple_choice', N'A solid has a definite ___ and volume.', N'["shape", "smell", "color"]', N'shape', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat24, 'multiple_choice', N'A liquid takes the shape of its ___.', N'["container", "color", "weight"]', N'container', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat24, 'multiple_choice', N'A gas will spread out to fill its ___.', N'["container", "shadow", "shape"]', N'container', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat24, 'multiple_choice', N'Changing state (like melting or freezing) is a ___ change, not a chemical one.', N'["physical", "permanent", "chemical"]', N'physical', 8);

-- 25. Ecosystems and Food Webs (8 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat25, 'fill_blank', N'An animal that eats only plants is called a ___.', NULL, N'herbivore', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat25, 'fill_blank', N'An animal that eats only other animals is called a ___.', NULL, N'carnivore', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat25, 'fill_blank', N'An animal that eats both plants and animals is called a ___.', NULL, N'omnivore', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat25, 'fill_blank', N'Plants are called ___ because they make their own food from sunlight.', NULL, N'producers', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat25, 'fill_blank', N'Animals are called ___ because they must eat other living things for energy.', NULL, N'consumers', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat25, 'fill_blank', N'An organism that breaks down dead plants and animals is called a ___.', NULL, N'decomposer', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat25, 'fill_blank', N'A community of living and nonliving things working together is called an ___.', NULL, N'ecosystem', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat25, 'fill_blank', N'The path of who-eats-whom in an ecosystem is called a food ___.', NULL, N'chain (or web)', 8);

-- 26. Map/Globe Skills (8 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat26, 'fill_blank', N'A globe is a model of the ___.', NULL, N'Earth', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat26, 'fill_blank', N'The imaginary line around the middle of the Earth is called the ___.', NULL, N'equator', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat26, 'fill_blank', N'Lines that run north to south on a map are called lines of ___.', NULL, N'longitude', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat26, 'fill_blank', N'Lines that run east to west on a map are called lines of ___.', NULL, N'latitude', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat26, 'fill_blank', N'A map''s ___ tells you how map distance compares to real distance.', NULL, N'scale', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat26, 'fill_blank', N'The compass rose shows the four main directions: N, S, E, and ___.', NULL, N'W', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat26, 'fill_blank', N'A map that shows only roads and cities is a ___ map.', NULL, N'political (road)', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat26, 'fill_blank', N'A map that shows mountains and rivers is a ___ map.', NULL, N'physical', 8);

-- 27. Government Structure (Local, State, Federal) (6 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat27, 'fill_blank', N'The leader of a city is usually called the ___.', NULL, N'mayor', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat27, 'fill_blank', N'The leader of a state is called the ___.', NULL, N'governor', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat27, 'fill_blank', N'The leader of the whole country is called the ___.', NULL, N'President', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat27, 'fill_blank', N'Laws for the entire country are made by the ___ government.', NULL, N'federal (national)', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat27, 'fill_blank', N'Laws for just your city are made by the ___ government.', NULL, N'local', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat27, 'fill_blank', N'The building where a state''s laws are made is called the state ___.', NULL, N'capitol', 6);

-- 28. Economics: Production, Distribution, Consumption (6 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat28, 'fill_blank', N'Making goods, like building a chair, is called ___.', NULL, N'production', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat28, 'fill_blank', N'Moving goods from the factory to the store is called ___.', NULL, N'distribution', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat28, 'fill_blank', N'Buying and using a good, like eating an apple, is called ___.', NULL, N'consumption', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat28, 'fill_blank', N'A person who buys goods and services is called a ___.', NULL, N'consumer', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat28, 'fill_blank', N'A business that makes goods is called a ___.', NULL, N'producer', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat28, 'fill_blank', N'The place where goods are bought and sold is called the ___.', NULL, N'market', 6);

-- 29. Word Search Puzzle (1 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat29, 'word_search', N'Find these words: HERBIVORE, CARNIVORE, PRODUCER, CONSUMER, ECOSYSTEM, EQUATOR, MAYOR, GOVERNOR', NULL, N'HERBIVORE, CARNIVORE, PRODUCER, CONSUMER, ECOSYSTEM, EQUATOR, MAYOR, GOVERNOR', 1);

-- 30. Logic Grid Puzzle (1 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g3cat30, 'short_response', N'Mia, Sam, and Priya each play one sport: soccer, tennis, or swimming. Mia doesn''t play a sport with a net. Sam doesn''t swim. Priya''s sport uses a racket. Who plays what?', NULL, N'Priya: tennis, Sam: soccer, Mia: swimming', 1);

END
GO
