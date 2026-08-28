-- 54_grade4_content.sql
-- Grade 4, content bank — 30 original categories drawn from the ABC
-- Unified Grade 4 category list. Most categories carry more questions
-- than their target_count so weekly composition genuinely varies.

IF NOT EXISTS (SELECT 1 FROM dbo.PacketCategories WHERE grade_id = 5)
BEGIN
DECLARE @g4cat1 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (5, 'math', N'Multi-Digit Multiplication', 'short_answer', 10, NULL);
SET @g4cat1 = SCOPE_IDENTITY();

DECLARE @g4cat2 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (5, 'math', N'Long Division', 'short_answer', 10, NULL);
SET @g4cat2 = SCOPE_IDENTITY();

DECLARE @g4cat3 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (5, 'math', N'Adding & Subtracting Fractions (Like Denominators)', 'short_answer', 10, NULL);
SET @g4cat3 = SCOPE_IDENTITY();

DECLARE @g4cat4 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (5, 'math', N'Comparing Fractions & Decimals', 'short_answer', 10, NULL);
SET @g4cat4 = SCOPE_IDENTITY();

DECLARE @g4cat5 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (5, 'math', N'Decimal Place Value', 'short_answer', 10, NULL);
SET @g4cat5 = SCOPE_IDENTITY();

DECLARE @g4cat6 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (5, 'math', N'Area & Perimeter (Rectangles & Composite Shapes)', 'short_answer', 10, NULL);
SET @g4cat6 = SCOPE_IDENTITY();

DECLARE @g4cat7 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (5, 'math', N'Angles & Angle Measurement', 'short_answer', 10, NULL);
SET @g4cat7 = SCOPE_IDENTITY();

DECLARE @g4cat8 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (5, 'math', N'Factors & Multiples', 'short_answer', 10, NULL);
SET @g4cat8 = SCOPE_IDENTITY();

DECLARE @g4cat9 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (5, 'math', N'Elapsed Time', 'short_answer', 8, NULL);
SET @g4cat9 = SCOPE_IDENTITY();

DECLARE @g4cat10 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (5, 'math', N'Multi-Step Word Problems', 'space_heavy', 8, NULL);
SET @g4cat10 = SCOPE_IDENTITY();

DECLARE @g4cat11 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (5, 'math', N'Number Patterns & Input-Output Tables', 'short_answer', 4, NULL);
SET @g4cat11 = SCOPE_IDENTITY();

DECLARE @g4cat12 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (5, 'ela', N'Context Clues', 'short_answer', 10, NULL);
SET @g4cat12 = SCOPE_IDENTITY();

DECLARE @g4cat13 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (5, 'ela', N'Figurative Language (Simile, Metaphor, Idiom)', 'short_answer', 10, NULL);
SET @g4cat13 = SCOPE_IDENTITY();

DECLARE @g4cat14 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (5, 'ela', N'Prefixes, Suffixes & Roots', 'short_answer', 10, NULL);
SET @g4cat14 = SCOPE_IDENTITY();

DECLARE @g4cat15 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (5, 'ela', N'Main Idea & Theme', 'short_answer', 10, NULL);
SET @g4cat15 = SCOPE_IDENTITY();

DECLARE @g4cat16 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (5, 'ela', N'Compare & Contrast Two Texts', 'short_answer', 10, NULL);
SET @g4cat16 = SCOPE_IDENTITY();

DECLARE @g4cat17 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (5, 'ela', N'Author''s Purpose & Point of View', 'short_answer', 10, NULL);
SET @g4cat17 = SCOPE_IDENTITY();

DECLARE @g4cat18 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (5, 'ela', N'Grammar: Prepositional Phrases', 'short_answer', 10, NULL);
SET @g4cat18 = SCOPE_IDENTITY();

DECLARE @g4cat19 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (5, 'ela', N'Grammar: Relative Pronouns & Clauses', 'short_answer', 10, NULL);
SET @g4cat19 = SCOPE_IDENTITY();

DECLARE @g4cat20 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (5, 'ela', N'Vocabulary in Context', 'short_answer', 10, N'Word Bank: brilliant, cautious, drowsy, eager, faint, gather, mimic, nimble, sturdy, vast, weary, ancient, feeble, glisten

Choose the word from the bank that best completes each sentence.');
SET @g4cat20 = SCOPE_IDENTITY();

DECLARE @g4cat21 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (5, 'ela', N'Reading Comprehension: The Monarch Butterfly Migration', 'space_heavy', 6, N'Every fall, millions of monarch butterflies begin one of the longest journeys in the insect world. These orange and black butterflies fly from Canada and the United States all the way to the mountains of central Mexico, a trip of up to 3,000 miles. What makes this journey even more amazing is that no single butterfly completes the whole trip. It can take three or four generations of monarchs to finish the round trip north in the spring.

Monarchs rely on a keen sense of direction, even though scientists are still studying exactly how they navigate. Many researchers believe the butterflies use the position of the sun and an internal compass to stay on course. Along the way, monarchs need milkweed plants, which are the only food their caterpillars can eat. Without milkweed, monarch caterpillars cannot survive.

In recent years, the number of milkweed plants has dropped because of farming and construction, so people have started planting milkweed gardens to help. Protecting monarch habitats gives these incredible travelers a better chance to complete their remarkable journey each year.');
SET @g4cat21 = SCOPE_IDENTITY();

DECLARE @g4cat22 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (5, 'writing', N'Informative/Explanatory Writing', 'space_heavy', 8, N'Plan your informative/explanatory writing below, then write it on a separate sheet or the back of this page.');
SET @g4cat22 = SCOPE_IDENTITY();

DECLARE @g4cat23 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (5, 'writing', N'Narrative Writing', 'space_heavy', 8, N'Plan your narrative writing below, then write it on a separate sheet or the back of this page.');
SET @g4cat23 = SCOPE_IDENTITY();

DECLARE @g4cat24 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (5, 'science', N'Energy & Forces', 'short_answer', 8, NULL);
SET @g4cat24 = SCOPE_IDENTITY();

DECLARE @g4cat25 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (5, 'science', N'Ecosystems & Adaptations', 'short_answer', 8, NULL);
SET @g4cat25 = SCOPE_IDENTITY();

DECLARE @g4cat26 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (5, 'social_studies', N'US Regions & Geography', 'short_answer', 8, NULL);
SET @g4cat26 = SCOPE_IDENTITY();

DECLARE @g4cat27 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (5, 'social_studies', N'Branches of Government', 'short_answer', 6, NULL);
SET @g4cat27 = SCOPE_IDENTITY();

DECLARE @g4cat28 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (5, 'social_studies', N'Economics: Supply & Demand', 'short_answer', 6, NULL);
SET @g4cat28 = SCOPE_IDENTITY();

DECLARE @g4cat29 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (5, 'puzzle', N'Word Search Puzzle', 'puzzle', 1, NULL);
SET @g4cat29 = SCOPE_IDENTITY();

DECLARE @g4cat30 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (5, 'puzzle', N'Logic Grid Puzzle', 'space_heavy', 1, NULL);
SET @g4cat30 = SCOPE_IDENTITY();

-- 1. Multi-Digit Multiplication (14 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat1, 'fill_blank', N'23 × 4 = ___', NULL, N'92', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat1, 'fill_blank', N'56 × 3 = ___', NULL, N'168', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat1, 'fill_blank', N'47 × 6 = ___', NULL, N'282', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat1, 'fill_blank', N'82 × 5 = ___', NULL, N'410', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat1, 'fill_blank', N'39 × 7 = ___', NULL, N'273', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat1, 'fill_blank', N'64 × 8 = ___', NULL, N'512', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat1, 'fill_blank', N'91 × 4 = ___', NULL, N'364', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat1, 'fill_blank', N'23 × 14 = ___', NULL, N'322', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat1, 'fill_blank', N'36 × 25 = ___', NULL, N'900', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat1, 'fill_blank', N'42 × 18 = ___', NULL, N'756', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat1, 'fill_blank', N'57 × 23 = ___', NULL, N'1311', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat1, 'fill_blank', N'64 × 32 = ___', NULL, N'2048', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat1, 'fill_blank', N'19 × 46 = ___', NULL, N'874', 13);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat1, 'fill_blank', N'38 × 27 = ___', NULL, N'1026', 14);

-- 2. Long Division (14 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat2, 'fill_blank', N'144 ÷ 4 = ___', NULL, N'36', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat2, 'fill_blank', N'392 ÷ 7 = ___', NULL, N'56', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat2, 'fill_blank', N'215 ÷ 5 = ___', NULL, N'43', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat2, 'fill_blank', N'408 ÷ 6 = ___', NULL, N'68', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat2, 'fill_blank', N'486 ÷ 9 = ___', NULL, N'54', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat2, 'fill_blank', N'252 ÷ 3 = ___', NULL, N'84', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat2, 'fill_blank', N'552 ÷ 8 = ___', NULL, N'69', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat2, 'fill_blank', N'348 ÷ 4 = ___', NULL, N'87', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat2, 'fill_blank', N'558 ÷ 6 = ___', NULL, N'93', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat2, 'fill_blank', N'336 ÷ 7 = ___', NULL, N'48', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat2, 'fill_blank', N'173 ÷ 5 = ___ (write as a quotient and remainder)', NULL, N'34 R3', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat2, 'fill_blank', N'245 ÷ 6 = ___ (write as a quotient and remainder)', NULL, N'40 R5', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat2, 'fill_blank', N'317 ÷ 4 = ___ (write as a quotient and remainder)', NULL, N'79 R1', 13);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat2, 'fill_blank', N'158 ÷ 3 = ___ (write as a quotient and remainder)', NULL, N'52 R2', 14);

-- 3. Adding & Subtracting Fractions (Like Denominators) (14 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat3, 'fill_blank', N'1/5 + 2/5 = ___', NULL, N'3/5', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat3, 'fill_blank', N'3/8 + 4/8 = ___', NULL, N'7/8', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat3, 'fill_blank', N'5/6 - 2/6 = ___', NULL, N'1/2', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat3, 'fill_blank', N'7/9 - 4/9 = ___', NULL, N'1/3', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat3, 'fill_blank', N'2/7 + 3/7 = ___', NULL, N'5/7', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat3, 'fill_blank', N'5/12 + 4/12 = ___', NULL, N'3/4', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat3, 'fill_blank', N'8/10 - 3/10 = ___', NULL, N'1/2', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat3, 'fill_blank', N'1/4 + 2/4 = ___', NULL, N'3/4', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat3, 'fill_blank', N'7/8 - 3/8 = ___', NULL, N'1/2', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat3, 'fill_blank', N'3/6 + 2/6 = ___', NULL, N'5/6', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat3, 'fill_blank', N'9/11 - 5/11 = ___', NULL, N'4/11', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat3, 'fill_blank', N'4/9 + 4/9 = ___', NULL, N'8/9', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat3, 'fill_blank', N'11/12 - 7/12 = ___', NULL, N'1/3', 13);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat3, 'fill_blank', N'2/5 + 2/5 = ___', NULL, N'4/5', 14);

-- 4. Comparing Fractions & Decimals (14 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat4, 'fill_blank', N'0.4 ___ 0.25', NULL, N'>', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat4, 'fill_blank', N'3/4 ___ 0.5', NULL, N'>', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat4, 'fill_blank', N'0.6 ___ 3/5', NULL, N'=', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat4, 'fill_blank', N'1/2 ___ 0.4', NULL, N'>', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat4, 'fill_blank', N'0.35 ___ 0.53', NULL, N'<', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat4, 'fill_blank', N'2/5 ___ 1/4', NULL, N'>', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat4, 'fill_blank', N'0.7 ___ 7/10', NULL, N'=', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat4, 'fill_blank', N'3/10 ___ 0.35', NULL, N'<', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat4, 'fill_blank', N'0.9 ___ 4/5', NULL, N'>', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat4, 'fill_blank', N'1/8 ___ 0.2', NULL, N'<', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat4, 'fill_blank', N'0.45 ___ 9/20', NULL, N'=', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat4, 'fill_blank', N'5/8 ___ 0.6', NULL, N'>', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat4, 'fill_blank', N'0.15 ___ 1/5', NULL, N'<', 13);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat4, 'fill_blank', N'0.55 ___ 11/20', NULL, N'=', 14);

-- 5. Decimal Place Value (14 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat5, 'fill_blank', N'In 4.7, what digit is in the tenths place?', NULL, N'7', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat5, 'fill_blank', N'In 3.25, what digit is in the hundredths place?', NULL, N'5', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat5, 'fill_blank', N'In 6.19, what digit is in the tenths place?', NULL, N'1', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat5, 'fill_blank', N'Write “five and two tenths” as a decimal.', NULL, N'5.2', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat5, 'fill_blank', N'Write “three and forty-six hundredths” as a decimal.', NULL, N'3.46', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat5, 'fill_blank', N'In 8.04, what digit is in the hundredths place?', NULL, N'4', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat5, 'fill_blank', N'What is 0.5 written as a fraction?', NULL, N'1/2', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat5, 'fill_blank', N'What is 0.25 written as a fraction?', NULL, N'1/4', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat5, 'fill_blank', N'In 12.63, what digit is in the ones place?', NULL, N'2', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat5, 'fill_blank', N'Round 3.68 to the nearest tenth.', NULL, N'3.7', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat5, 'fill_blank', N'Round 5.42 to the nearest tenth.', NULL, N'5.4', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat5, 'fill_blank', N'In 9.7, what digit is in the tenths place?', NULL, N'7', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat5, 'fill_blank', N'Write “seven and eight hundredths” as a decimal.', NULL, N'7.08', 13);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat5, 'fill_blank', N'Which has a greater value: the 4 in 4.5, or the 4 in 0.4?', NULL, N'the 4 in 4.5', 14);

-- 6. Area & Perimeter (Rectangles & Composite Shapes) (14 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat6, 'short_response', N'A rectangle is 12 cm by 7 cm. What is its perimeter?', NULL, N'38 cm', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat6, 'short_response', N'A rectangle is 9 cm by 6 cm. What is its area?', NULL, N'54 sq cm', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat6, 'short_response', N'A rectangle is 15 cm by 4 cm. What is its perimeter?', NULL, N'38 cm', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat6, 'short_response', N'A rectangle is 11 cm by 8 cm. What is its area?', NULL, N'88 sq cm', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat6, 'short_response', N'A rectangle is 13 cm by 9 cm. What is its perimeter?', NULL, N'44 cm', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat6, 'short_response', N'A rectangle is 7 cm by 7 cm. What is its area?', NULL, N'49 sq cm', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat6, 'short_response', N'A rectangle is 10 cm by 6 cm. What is its perimeter?', NULL, N'32 cm', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat6, 'short_response', N'A rectangle is 14 cm by 5 cm. What is its area?', NULL, N'70 sq cm', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat6, 'short_response', N'A rectangle is 16 cm by 9 cm. What is its perimeter?', NULL, N'50 cm', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat6, 'short_response', N'A rectangle is 12 cm by 12 cm. What is its area?', NULL, N'144 sq cm', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat6, 'short_response', N'An L-shaped room is a 10 ft by 6 ft rectangle with a 4 ft by 3 ft rectangle cut out of one corner. What is the area of the room?', NULL, N'48 sq ft', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat6, 'short_response', N'A garden is shaped like an L: an 8 m by 5 m rectangle with a 3 m by 4 m rectangle attached to one side. What is the total area?', NULL, N'52 sq m', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat6, 'short_response', N'A patio is a 9 ft by 6 ft rectangle with a 2 ft by 5 ft rectangle removed from a corner. What is the area of the patio?', NULL, N'44 sq ft', 13);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat6, 'short_response', N'A room is shaped like an L: a 7 m by 4 m rectangle with a 3 m by 2 m rectangle attached. What is the total area?', NULL, N'34 sq m', 14);

-- 7. Angles & Angle Measurement (14 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat7, 'multiple_choice', N'A right angle measures ___.', N'["90°", "180°", "45°"]', N'90°', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat7, 'multiple_choice', N'An angle that measures less than 90° is a(n) ___ angle.', N'["acute", "right", "obtuse"]', N'acute', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat7, 'multiple_choice', N'An angle that measures more than 90° but less than 180° is a(n) ___ angle.', N'["acute", "right", "obtuse"]', N'obtuse', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat7, 'multiple_choice', N'An angle that measures exactly 180° is called a ___ angle.', N'["straight", "acute", "right"]', N'straight', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat7, 'multiple_choice', N'Classify this angle: 45°', N'["acute", "right", "obtuse"]', N'acute', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat7, 'multiple_choice', N'Classify this angle: 120°', N'["acute", "right", "obtuse"]', N'obtuse', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat7, 'multiple_choice', N'Classify this angle: 90°', N'["acute", "right", "obtuse"]', N'right', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat7, 'multiple_choice', N'Classify this angle: 160°', N'["acute", "right", "obtuse"]', N'obtuse', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat7, 'multiple_choice', N'Classify this angle: 30°', N'["acute", "right", "obtuse"]', N'acute', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat7, 'multiple_choice', N'Classify this angle: 75°', N'["acute", "right", "obtuse"]', N'acute', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat7, 'multiple_choice', N'Classify this angle: 100°', N'["acute", "right", "obtuse"]', N'obtuse', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat7, 'multiple_choice', N'Classify this angle: 179°', N'["acute", "right", "obtuse"]', N'obtuse', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat7, 'multiple_choice', N'A straight angle measures ___.', N'["180°", "90°", "270°"]', N'180°', 13);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat7, 'multiple_choice', N'A straight line measures 180°. If one angle on the line measures 110°, what does the other angle measure?', N'["70°", "80°", "110°"]', N'70°', 14);

-- 8. Factors & Multiples (14 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat8, 'short_response', N'List all factors of 12.', NULL, N'1, 2, 3, 4, 6, 12', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat8, 'short_response', N'List all factors of 18.', NULL, N'1, 2, 3, 6, 9, 18', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat8, 'short_response', N'List all factors of 20.', NULL, N'1, 2, 4, 5, 10, 20', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat8, 'short_response', N'What are the first 5 multiples of 4?', NULL, N'4, 8, 12, 16, 20', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat8, 'short_response', N'What are the first 5 multiples of 6?', NULL, N'6, 12, 18, 24, 30', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat8, 'short_response', N'Is 7 a factor of 42?', NULL, N'Yes', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat8, 'short_response', N'Is 9 a factor of 42?', NULL, N'No', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat8, 'short_response', N'What is the greatest common factor of 12 and 18?', NULL, N'6', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat8, 'short_response', N'What is the greatest common factor of 16 and 24?', NULL, N'8', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat8, 'short_response', N'What is the least common multiple of 3 and 4?', NULL, N'12', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat8, 'short_response', N'What is the least common multiple of 4 and 6?', NULL, N'12', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat8, 'short_response', N'List all factors of 24.', NULL, N'1, 2, 3, 4, 6, 8, 12, 24', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat8, 'short_response', N'Is 45 a multiple of 5?', NULL, N'Yes', 13);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat8, 'short_response', N'Is 32 a multiple of 6?', NULL, N'No', 14);

-- 9. Elapsed Time (12 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat9, 'short_response', N'A movie starts at 3:15 PM and ends at 5:00 PM. How long is the movie?', NULL, N'1 hour 45 minutes', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat9, 'short_response', N'School starts at 8:30 AM and ends at 3:00 PM. How long is the school day?', NULL, N'6 hours 30 minutes', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat9, 'short_response', N'A train leaves at 9:45 AM and arrives at 11:15 AM. How long is the trip?', NULL, N'1 hour 30 minutes', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat9, 'short_response', N'Practice starts at 4:00 PM and ends at 5:20 PM. How long is practice?', NULL, N'1 hour 20 minutes', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat9, 'short_response', N'A flight departs at 10:20 AM and lands at 1:05 PM. How long is the flight?', NULL, N'2 hours 45 minutes', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat9, 'short_response', N'Recess starts at 10:10 AM and ends at 10:30 AM. How long is recess?', NULL, N'20 minutes', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat9, 'short_response', N'A show starts at 7:40 PM and ends at 9:15 PM. How long is the show?', NULL, N'1 hour 35 minutes', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat9, 'short_response', N'Homework starts at 4:50 PM and ends at 5:35 PM. How long does homework take?', NULL, N'45 minutes', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat9, 'short_response', N'A road trip starts at 6:15 AM and ends at 12:00 PM. How long is the trip?', NULL, N'5 hours 45 minutes', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat9, 'short_response', N'A test starts at 9:05 AM and ends at 10:00 AM. How long is the test?', NULL, N'55 minutes', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat9, 'short_response', N'A hike starts at 8:00 AM and ends at 11:40 AM. How long is the hike?', NULL, N'3 hours 40 minutes', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat9, 'short_response', N'Lunch starts at 12:05 PM and ends at 12:50 PM. How long is lunch?', NULL, N'45 minutes', 12);

-- 10. Multi-Step Word Problems (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat10, 'short_response', N'Ollie the Owl collected 24 acorns on Monday and 18 acorns on Tuesday. He gave 15 acorns to his friends. How many acorns does Ollie have left?', NULL, N'27', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat10, 'short_response', N'A bakery made 8 trays of muffins with 12 muffins on each tray. They sold 63 muffins. How many muffins are left?', NULL, N'33', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat10, 'short_response', N'Maria had $45. She earned $20 more from chores, then spent $18 on a book. How much money does she have now?', NULL, N'$47', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat10, 'short_response', N'A school ordered 6 boxes of pencils with 24 pencils in each box. They gave away 90 pencils. How many pencils are left?', NULL, N'54', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat10, 'short_response', N'Ollie the Owl flew 12 miles on Monday, 15 miles on Tuesday, and 9 miles on Wednesday. How many miles did he fly in all three days?', NULL, N'36 miles', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat10, 'short_response', N'A farmer picked 156 apples and put them equally into 4 baskets. Then he sold 2 of the baskets. How many apples did he sell?', NULL, N'78', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat10, 'short_response', N'Liam saved $12 a week for 5 weeks. Then he spent $25 on a game. How much money does he have left?', NULL, N'$35', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat10, 'short_response', N'A theater has 8 rows with 15 seats in each row. If 97 seats are filled, how many seats are empty?', NULL, N'23', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat10, 'short_response', N'A library had 215 books. They donated 45 books and then received a new shipment of 60 books. How many books does the library have now?', NULL, N'230', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat10, 'short_response', N'A team scored 14 points in the first half and 21 points in the second half. The other team scored 28 points total. By how many points did the team win?', NULL, N'7 points', 10);

-- 11. Number Patterns & Input-Output Tables (6 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat11, 'short_response', N'Input: 1, 2, 3, 4  Output: 4, 8, 12, 16  → what is the rule?', NULL, N'multiply by 4', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat11, 'short_response', N'Input: 2, 4, 6, 8  Output: 7, 9, 11, 13  → what is the rule?', NULL, N'add 5', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat11, 'short_response', N'Input: 3, 6, 9, 12  Output: 1, 2, 3, 4  → what is the rule?', NULL, N'divide by 3', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat11, 'short_response', N'Input: 1, 2, 3, 4  Output: 6, 12, 18, 24  → what is the rule?', NULL, N'multiply by 6', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat11, 'short_response', N'Input: 4, 8, 12, 16  Output: 2, 4, 6, 8  → what is the rule?', NULL, N'divide by 2', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat11, 'short_response', N'Input: 2, 3, 4, 5  Output: 9, 14, 19, 24  → what is the rule?', NULL, N'multiply by 5, then subtract 1', 6);

-- 12. Context Clues (14 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat12, 'short_response', N'“The reluctant puppy refused to walk into the vet''s office.” What does “reluctant” most likely mean?', NULL, N'unwilling / hesitant', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat12, 'short_response', N'“The abundant harvest filled every basket in the barn.” What does “abundant” most likely mean?', NULL, N'plentiful / a large amount', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat12, 'short_response', N'“He was furious when he saw the broken window.” What does “furious” most likely mean?', NULL, N'very angry', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat12, 'short_response', N'“The timid mouse hid behind the couch.” What does “timid” most likely mean?', NULL, N'shy / easily scared', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat12, 'short_response', N'“The scorching sun made the pavement too hot to touch.” What does “scorching” most likely mean?', NULL, N'extremely hot', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat12, 'short_response', N'“She felt triumphant after winning first place.” What does “triumphant” most likely mean?', NULL, N'feeling like a winner / very proud', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat12, 'short_response', N'“The ancient ruins were thousands of years old.” What does “ancient” most likely mean?', NULL, N'very old', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat12, 'short_response', N'“The gloomy sky made everyone feel a little sad.” What does “gloomy” most likely mean?', NULL, N'dark and dreary', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat12, 'short_response', N'“He was so exhausted that he fell asleep in his chair.” What does “exhausted” most likely mean?', NULL, N'very tired', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat12, 'short_response', N'“The fragile vase shattered when it hit the floor.” What does “fragile” most likely mean?', NULL, N'easily broken', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat12, 'short_response', N'“The generous donor gave thousands of dollars to the school.” What does “generous” most likely mean?', NULL, N'giving freely', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat12, 'short_response', N'“The narrow path barely fit one person.” What does “narrow” most likely mean?', NULL, N'very thin / not wide', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat12, 'short_response', N'“The curious cat explored every corner of the house.” What does “curious” most likely mean?', NULL, N'eager to learn or know', 13);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat12, 'short_response', N'“The enormous whale surfaced next to the boat.” What does “enormous” most likely mean?', NULL, N'huge', 14);

-- 13. Figurative Language (Simile, Metaphor, Idiom) (14 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat13, 'multiple_choice', N'The kite danced like a leaf in the wind.', N'["simile", "metaphor", "idiom"]', N'simile', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat13, 'multiple_choice', N'Her room is a disaster zone.', N'["simile", "metaphor", "idiom"]', N'metaphor', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat13, 'multiple_choice', N'It''s raining cats and dogs outside.', N'["simile", "metaphor", "idiom"]', N'idiom', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat13, 'multiple_choice', N'The moon was a silver coin in the sky.', N'["simile", "metaphor", "idiom"]', N'metaphor', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat13, 'multiple_choice', N'He runs as quick as lightning.', N'["simile", "metaphor", "idiom"]', N'simile', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat13, 'multiple_choice', N'Break a leg at your performance tonight!', N'["simile", "metaphor", "idiom"]', N'idiom', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat13, 'multiple_choice', N'The classroom buzzed like a beehive.', N'["simile", "metaphor", "idiom"]', N'simile', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat13, 'multiple_choice', N'The world is a stage.', N'["simile", "metaphor", "idiom"]', N'metaphor', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat13, 'multiple_choice', N'She let the cat out of the bag.', N'["simile", "metaphor", "idiom"]', N'idiom', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat13, 'multiple_choice', N'The waves crashed like thunder.', N'["simile", "metaphor", "idiom"]', N'simile', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat13, 'multiple_choice', N'His heart is made of stone.', N'["simile", "metaphor", "idiom"]', N'metaphor', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat13, 'multiple_choice', N'It cost an arm and a leg.', N'["simile", "metaphor", "idiom"]', N'idiom', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat13, 'multiple_choice', N'The snow was a white blanket over the town.', N'["simile", "metaphor", "idiom"]', N'metaphor', 13);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat13, 'multiple_choice', N'The children were as quiet as mice.', N'["simile", "metaphor", "idiom"]', N'simile', 14);

-- 14. Prefixes, Suffixes & Roots (14 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat14, 'fill_blank', N're + play =', NULL, N'replay', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat14, 'fill_blank', N'un + kind =', NULL, N'unkind', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat14, 'fill_blank', N'mis + spell =', NULL, N'misspell', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat14, 'fill_blank', N'dis + connect =', NULL, N'disconnect', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat14, 'fill_blank', N'pre + view =', NULL, N'preview', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat14, 'fill_blank', N'non + fiction =', NULL, N'nonfiction', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat14, 'fill_blank', N'bi + cycle =', NULL, N'bicycle', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat14, 'fill_blank', N'tri + angle =', NULL, N'triangle', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat14, 'fill_blank', N'The root “aud” means to hear. Which word means “to listen to something”?', NULL, N'audio (or audible)', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat14, 'fill_blank', N'The root “port” means to carry. Which word means “to carry across”?', NULL, N'transport', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat14, 'fill_blank', N'The suffix “-ful” means full of. What does “joyful” mean?', NULL, N'full of joy', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat14, 'fill_blank', N'The suffix “-less” means without. What does “fearless” mean?', NULL, N'without fear', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat14, 'fill_blank', N'The prefix “sub-” means under. What does “submarine” mean?', NULL, N'under the sea/water', 13);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat14, 'fill_blank', N'The prefix “over-” means too much. What does “overcooked” mean?', NULL, N'cooked too much', 14);

-- 15. Main Idea & Theme (14 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat15, 'short_response', N'A paragraph describes different kinds of clouds and what weather each predicts. What is the main idea?', NULL, N'Different clouds signal different weather', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat15, 'short_response', N'A story tells how a boy overcomes his fear of the dark by being brave. What is the theme?', NULL, N'Courage helps you overcome your fears', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat15, 'short_response', N'A passage explains three steps to plant a garden: dig, plant seeds, water. What is the main idea?', NULL, N'How to plant a garden', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat15, 'short_response', N'A fable ends with “slow and steady wins the race.” What is the theme?', NULL, N'Patience and persistence pay off', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat15, 'short_response', N'An article lists facts about recycling and why it helps the Earth. What is the main idea?', NULL, N'Recycling helps protect the environment', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat15, 'short_response', N'A story shows two rival teams learning to work together to win a contest. What is the theme?', NULL, N'Teamwork leads to success', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat15, 'short_response', N'A paragraph describes how bees make honey step by step. What is the main idea?', NULL, N'How bees make honey', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat15, 'short_response', N'A story follows a girl who shares her lunch with a new student. What is the theme?', NULL, N'Kindness makes a difference', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat15, 'short_response', N'An article explains the water cycle: evaporation, condensation, precipitation. What is the main idea?', NULL, N'How the water cycle works', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat15, 'short_response', N'A story is about a boy who keeps trying until he learns to ride his bike. What is the theme?', NULL, N'Hard work and persistence lead to success', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat15, 'short_response', N'A passage compares the life cycles of frogs and butterflies. What is the main idea?', NULL, N'Frogs and butterflies go through different life cycle stages', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat15, 'short_response', N'A fable is about a fox who loses a prize by bragging. What is the theme?', NULL, N'Pride can lead to a downfall', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat15, 'short_response', N'An article describes the parts of a plant and their jobs. What is the main idea?', NULL, N'Different plant parts have different jobs', 13);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat15, 'short_response', N'A story is about siblings who stop arguing after realizing they need each other. What is the theme?', NULL, N'Family should support one another', 14);

-- 16. Compare & Contrast Two Texts (14 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat16, 'short_response', N'Text A says dogs are loyal pets. Text B says cats are independent pets. What is one way these texts are different?', NULL, N'They describe different traits of pets (loyal vs. independent)', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat16, 'short_response', N'Text A is a fiction story about a dragon. Text B is a nonfiction article about lizards. Which text is meant to entertain?', NULL, N'Text A', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat16, 'short_response', N'Text A describes the life cycle of a frog. Text B describes the life cycle of a butterfly. What do both texts have in common?', NULL, N'Both describe an animal''s life cycle', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat16, 'short_response', N'Text A is written as a poem. Text B is written as a news report. Which text is more likely to use rhyme?', NULL, N'Text A', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat16, 'short_response', N'Text A explains how volcanoes erupt. Text B explains how earthquakes happen. What topic do both texts share?', NULL, N'Natural disasters / Earth science', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat16, 'short_response', N'Text A is a biography of an inventor. Text B is a fictional story about a robot. Which text is based on real events?', NULL, N'Text A', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat16, 'short_response', N'Text A lists steps to bake bread. Text B lists steps to build a birdhouse. What text feature do both share?', NULL, N'Numbered steps/instructions', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat16, 'short_response', N'Text A argues kids should have less homework. Text B argues kids should have more recess. What do both texts have in common?', NULL, N'Both are persuasive/opinion texts about school', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat16, 'short_response', N'Text A is about the solar system. Text B is about ocean animals. Which text would you read to learn about planets?', NULL, N'Text A', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat16, 'short_response', N'Text A describes a rainforest habitat. Text B describes a desert habitat. What is one difference between them?', NULL, N'One is wet with lots of plants; the other is dry with little rain', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat16, 'short_response', N'Text A is a fairy tale with a happy ending. Text B is a true story about a real explorer. Which text is nonfiction?', NULL, N'Text B', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat16, 'short_response', N'Text A explains photosynthesis. Text B explains the water cycle. What subject do both texts belong to?', NULL, N'Science', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat16, 'short_response', N'Text A is told from a dog''s point of view. Text B is told from the owner''s point of view. What is different between the texts?', NULL, N'They have different narrators/points of view', 13);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat16, 'short_response', N'Text A gives directions to the zoo. Text B gives a review of the zoo. Which text would help you find your way there?', NULL, N'Text A', 14);

-- 17. Author's Purpose & Point of View (14 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat17, 'multiple_choice', N'Recycling saves natural resources for future generations.', N'["Persuade", "Inform", "Entertain"]', N'Inform', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat17, 'multiple_choice', N'Once upon a time, in a kingdom far away...', N'["Persuade", "Inform", "Entertain"]', N'Entertain', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat17, 'multiple_choice', N'Please donate to help animals in shelters!', N'["Persuade", "Inform", "Entertain"]', N'Persuade', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat17, 'multiple_choice', N'The average rainfall in the rainforest is 100 inches per year.', N'["Persuade", "Inform", "Entertain"]', N'Inform', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat17, 'multiple_choice', N'The brave knight battled the fierce dragon.', N'["Persuade", "Inform", "Entertain"]', N'Entertain', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat17, 'multiple_choice', N'Everyone should wear a helmet while biking to stay safe.', N'["Persuade", "Inform", "Entertain"]', N'Persuade', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat17, 'multiple_choice', N'“I looked out my window and saw the sunrise,” Sam said. Is this told in first person or third person?', N'["First person", "Third person"]', N'First person', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat17, 'multiple_choice', N'Maria walked to school and saw her friend waving. Is this told in first person or third person?', N'["First person", "Third person"]', N'Third person', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat17, 'multiple_choice', N'“I could not believe my eyes when I opened the box,” wrote Jake. Is this told in first person or third person?', N'["First person", "Third person"]', N'First person', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat17, 'multiple_choice', N'The dog ran across the yard and barked at the mailman. Is this told in first person or third person?', N'["First person", "Third person"]', N'Third person', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat17, 'multiple_choice', N'Vote for cleaner air in our city!', N'["Persuade", "Inform", "Entertain"]', N'Persuade', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat17, 'multiple_choice', N'The Earth orbits the sun once every 365 days.', N'["Persuade", "Inform", "Entertain"]', N'Inform', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat17, 'multiple_choice', N'The tiny mouse tiptoed past the sleeping cat.', N'["Persuade", "Inform", "Entertain"]', N'Entertain', 13);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat17, 'multiple_choice', N'You should read for 20 minutes every night.', N'["Persuade", "Inform", "Entertain"]', N'Persuade', 14);

-- 18. Grammar: Prepositional Phrases (14 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat18, 'short_response', N'The cat slept under the table. — What is the prepositional phrase?', NULL, N'under the table', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat18, 'short_response', N'She walked to the store. — What is the prepositional phrase?', NULL, N'to the store', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat18, 'short_response', N'The book is on the shelf. — What is the prepositional phrase?', NULL, N'on the shelf', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat18, 'short_response', N'He ran through the park. — What is the prepositional phrase?', NULL, N'through the park', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat18, 'short_response', N'They hid behind the curtain. — What is the prepositional phrase?', NULL, N'behind the curtain', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat18, 'short_response', N'The bird flew over the house. — What is the prepositional phrase?', NULL, N'over the house', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat18, 'short_response', N'We waited inside the classroom. — What is the prepositional phrase?', NULL, N'inside the classroom', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat18, 'short_response', N'The keys are in my pocket. — What is the prepositional phrase?', NULL, N'in my pocket', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat18, 'short_response', N'She jumped off the diving board. — What is the prepositional phrase?', NULL, N'off the diving board', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat18, 'short_response', N'The dog barked at the mailman. — What is the prepositional phrase?', NULL, N'at the mailman', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat18, 'short_response', N'He placed the vase beside the window. — What is the prepositional phrase?', NULL, N'beside the window', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat18, 'short_response', N'The children played near the lake. — What is the prepositional phrase?', NULL, N'near the lake', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat18, 'short_response', N'The letter was written by my grandmother. — What is the prepositional phrase?', NULL, N'by my grandmother', 13);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat18, 'short_response', N'They walked along the beach. — What is the prepositional phrase?', NULL, N'along the beach', 14);

-- 19. Grammar: Relative Pronouns & Clauses (14 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat19, 'fill_blank', N'The dog ___ barked all night belongs to my neighbor.', NULL, N'that', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat19, 'fill_blank', N'My teacher, ___ is very kind, helped me with my project.', NULL, N'who', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat19, 'fill_blank', N'The book ___ I borrowed from the library is due tomorrow.', NULL, N'that', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat19, 'fill_blank', N'She is the girl ___ won the spelling bee.', NULL, N'who', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat19, 'fill_blank', N'The car, ___ was parked outside, got a flat tire.', NULL, N'which', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat19, 'fill_blank', N'I like the shoes ___ have stripes.', NULL, N'that', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat19, 'fill_blank', N'My uncle, ___ lives in Texas, is visiting this weekend.', NULL, N'who', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat19, 'fill_blank', N'The movie ___ we watched last night was scary.', NULL, N'that', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat19, 'fill_blank', N'The scientist ___ discovered the vaccine won an award.', NULL, N'who', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat19, 'fill_blank', N'The house, ___ was built in 1920, needs new paint.', NULL, N'which', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat19, 'fill_blank', N'The students ___ finished early can read quietly.', NULL, N'who', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat19, 'fill_blank', N'The backpack ___ I lost has been found.', NULL, N'that', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat19, 'fill_blank', N'My cousin, ___ plays the violin, is very talented.', NULL, N'who', 13);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat19, 'fill_blank', N'The recipe ___ she used calls for three eggs.', NULL, N'that', 14);

-- 20. Vocabulary in Context (14 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat20, 'fill_blank', N'The scientist made a ___ discovery that amazed everyone.', NULL, N'brilliant', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat20, 'fill_blank', N'Please be ___ when crossing the busy street.', NULL, N'cautious', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat20, 'fill_blank', N'After staying up late, Mia felt ___ during class.', NULL, N'drowsy', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat20, 'fill_blank', N'The puppy was ___ to go outside and play.', NULL, N'eager', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat20, 'fill_blank', N'We could hear only a ___ sound coming from the other room.', NULL, N'faint', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat20, 'fill_blank', N'The class had to ___ their supplies before the art project.', NULL, N'gather', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat20, 'fill_blank', N'Parrots can ___ the sounds they hear, including human speech.', NULL, N'mimic', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat20, 'fill_blank', N'The gymnast was ___ enough to land the difficult jump.', NULL, N'nimble', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat20, 'fill_blank', N'They built a ___ fence that could survive strong winds.', NULL, N'sturdy', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat20, 'fill_blank', N'The desert stretched out into a ___, empty land.', NULL, N'vast', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat20, 'fill_blank', N'After the long hike, the campers were ___ and ready for bed.', NULL, N'weary', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat20, 'fill_blank', N'The museum displayed ___ pottery from thousands of years ago.', NULL, N'ancient', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat20, 'fill_blank', N'The kitten was too ___ to climb onto the couch.', NULL, N'feeble', 13);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat20, 'fill_blank', N'The stars seemed to ___ brightly in the night sky.', NULL, N'glisten', 14);

-- 21. Reading Comprehension: The Monarch Butterfly Migration (6 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat21, 'short_response', N'How far can a monarch butterfly''s migration journey be?', NULL, N'Up to 3,000 miles', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat21, 'short_response', N'Why does it take multiple generations of monarchs to complete the round trip?', NULL, N'Because no single butterfly completes the whole journey; it can take three or four generations', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat21, 'short_response', N'What do many researchers believe monarchs use to navigate?', NULL, N'The position of the sun and an internal compass', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat21, 'short_response', N'Why is milkweed important to monarch butterflies?', NULL, N'It is the only food monarch caterpillars can eat', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat21, 'short_response', N'Why has the amount of milkweed decreased in recent years?', NULL, N'Because of farming and construction', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat21, 'short_response', N'What is the main idea of this passage?', NULL, N'Monarch butterflies make an incredible long-distance migration that depends on milkweed and needs protection', 6);

-- 22. Informative/Explanatory Writing (8 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat22, 'short_response', N'What topic will you explain or inform your reader about?', NULL, N'Open response — check for a clear topic and supporting facts.', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat22, 'short_response', N'What is your topic sentence or main idea?', NULL, N'Open response — check for a clear topic and supporting facts.', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat22, 'short_response', N'What is your first fact or detail?', NULL, N'Open response — check for a clear topic and supporting facts.', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat22, 'short_response', N'What is your second fact or detail?', NULL, N'Open response — check for a clear topic and supporting facts.', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat22, 'short_response', N'What is your third fact or detail?', NULL, N'Open response — check for a clear topic and supporting facts.', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat22, 'short_response', N'What transition words will you use (For example, Also, In addition)?', NULL, N'Open response — check for a clear topic and supporting facts.', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat22, 'short_response', N'Will you include any diagrams, definitions, or examples to help explain your topic?', NULL, N'Open response — check for a clear topic and supporting facts.', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat22, 'short_response', N'How will you conclude your informative piece?', NULL, N'Open response — check for a clear topic and supporting facts.', 8);

-- 23. Narrative Writing (8 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat23, 'short_response', N'Who is the main character in your story?', NULL, N'Open response — check for characters, setting, and a clear sequence of events.', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat23, 'short_response', N'Where and when does your story take place?', NULL, N'Open response — check for characters, setting, and a clear sequence of events.', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat23, 'short_response', N'What problem or event starts your story?', NULL, N'Open response — check for characters, setting, and a clear sequence of events.', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat23, 'short_response', N'What happens next in your story?', NULL, N'Open response — check for characters, setting, and a clear sequence of events.', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat23, 'short_response', N'What is the most exciting part (climax) of your story?', NULL, N'Open response — check for characters, setting, and a clear sequence of events.', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat23, 'short_response', N'How does your character solve the problem?', NULL, N'Open response — check for characters, setting, and a clear sequence of events.', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat23, 'short_response', N'What dialogue could you add to bring your characters to life?', NULL, N'Open response — check for characters, setting, and a clear sequence of events.', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat23, 'short_response', N'How does your story end?', NULL, N'Open response — check for characters, setting, and a clear sequence of events.', 8);

-- 24. Energy & Forces (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat24, 'multiple_choice', N'A ball rolling to a stop on the ground is being slowed mostly by ___.', N'["friction", "magnetism", "light"]', N'friction', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat24, 'multiple_choice', N'The force that pulls objects toward the Earth is called ___.', N'["gravity", "friction", "energy"]', N'gravity', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat24, 'multiple_choice', N'A lever, a wheel and axle, and a pulley are all examples of ___.', N'["simple machines", "chemical reactions", "electric circuits"]', N'simple machines', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat24, 'multiple_choice', N'Pushing a swing forward is an example of what kind of force?', N'["push", "pull", "gravity"]', N'push', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat24, 'multiple_choice', N'Pulling a wagon toward you is an example of what kind of force?', N'["pull", "push", "friction"]', N'pull', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat24, 'multiple_choice', N'The energy of motion is called ___ energy.', N'["kinetic", "potential", "chemical"]', N'kinetic', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat24, 'multiple_choice', N'Stored energy, like in a stretched rubber band, is called ___ energy.', N'["potential", "kinetic", "thermal"]', N'potential', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat24, 'multiple_choice', N'A ramp that helps move objects up or down is called a(n) ___.', N'["inclined plane", "lever", "pulley"]', N'inclined plane', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat24, 'multiple_choice', N'Sound, light, and heat are all forms of ___.', N'["energy", "matter", "gravity"]', N'energy', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat24, 'multiple_choice', N'A seesaw is an example of which simple machine?', N'["lever", "wheel and axle", "screw"]', N'lever', 10);

-- 25. Ecosystems & Adaptations (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat25, 'fill_blank', N'A physical feature that helps an animal survive in its environment is called an ___.', NULL, N'adaptation', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat25, 'fill_blank', N'A polar bear''s thick fur is an adaptation for ___.', NULL, N'staying warm in the cold', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat25, 'fill_blank', N'A cactus stores water in its stem, which is an adaptation for living in the ___.', NULL, N'desert', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat25, 'fill_blank', N'Camouflage helps animals ___.', NULL, N'hide from predators (blend into their surroundings)', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat25, 'fill_blank', N'A duck''s webbed feet are an adaptation for ___.', NULL, N'swimming', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat25, 'fill_blank', N'Animals that migrate move to a new place to find ___.', NULL, N'food, warmth, or a better place to raise young', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat25, 'fill_blank', N'A giraffe''s long neck is an adaptation that helps it ___.', NULL, N'reach leaves high in trees', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat25, 'fill_blank', N'Animals that are active at night are called ___.', NULL, N'nocturnal', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat25, 'fill_blank', N'A behavior, like hibernation, that helps an animal survive is called a ___ adaptation.', NULL, N'behavioral', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat25, 'fill_blank', N'When a species can no longer be found anywhere on Earth, it is called ___.', NULL, N'extinct', 10);

-- 26. US Regions & Geography (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat26, 'short_response', N'The five Great Lakes are located mostly in which US region?', NULL, N'the Midwest', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat26, 'short_response', N'Which US region is known for its warm climate and includes Florida?', NULL, N'the Southeast', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat26, 'short_response', N'The Rocky Mountains run through which US region?', NULL, N'the West', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat26, 'short_response', N'Which US region includes New York, Massachusetts, and Maine?', NULL, N'the Northeast', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat26, 'short_response', N'Which major river flows through the middle of the US and empties into the Gulf of Mexico?', NULL, N'the Mississippi River', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat26, 'short_response', N'Which US region is known for its wide-open plains and farmland?', NULL, N'the Midwest', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat26, 'short_response', N'Death Valley, one of the hottest and driest places in the US, is located in which region?', NULL, N'the West', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat26, 'short_response', N'Which US region borders Canada and includes states like Michigan and Wisconsin?', NULL, N'the Midwest', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat26, 'short_response', N'The Appalachian Mountains run mostly through which region of the US?', NULL, N'the East (Southeast/Appalachia)', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat26, 'short_response', N'Which US region is closest to the Atlantic Ocean and was home to the original 13 colonies?', NULL, N'the Northeast', 10);

-- 27. Branches of Government (8 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat27, 'fill_blank', N'The three branches of the US government are executive, legislative, and ___.', NULL, N'judicial', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat27, 'fill_blank', N'The President is the head of the ___ branch.', NULL, N'executive', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat27, 'fill_blank', N'Congress, which makes the laws, is part of the ___ branch.', NULL, N'legislative', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat27, 'fill_blank', N'The Supreme Court is part of the ___ branch.', NULL, N'judicial', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat27, 'fill_blank', N'The branch that decides if a law is constitutional (fair under the law) is the ___ branch.', NULL, N'judicial', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat27, 'fill_blank', N'The branch responsible for enforcing the laws is the ___ branch.', NULL, N'executive', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat27, 'fill_blank', N'The two parts of Congress are the House of Representatives and the ___.', NULL, N'Senate', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat27, 'fill_blank', N'The system that gives each branch some control over the others is called ___.', NULL, N'checks and balances', 8);

-- 28. Economics: Supply & Demand (8 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat28, 'fill_blank', N'When there is a lot of a product and few people want it, prices usually go ___.', NULL, N'down', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat28, 'fill_blank', N'When a product is rare and many people want it, prices usually go ___.', NULL, N'up', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat28, 'fill_blank', N'The amount of a good that is available to sell is called the ___.', NULL, N'supply', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat28, 'fill_blank', N'The amount of a good that people want to buy is called the ___.', NULL, N'demand', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat28, 'fill_blank', N'If a toy becomes very popular and stores run low on it, ___ for the toy goes up.', NULL, N'demand', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat28, 'fill_blank', N'If a farmer grows more corn than usual, the ___ of corn goes up.', NULL, N'supply', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat28, 'fill_blank', N'When supply is high and demand is low, prices tend to be ___.', NULL, N'low', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat28, 'fill_blank', N'When supply is low and demand is high, prices tend to be ___.', NULL, N'high', 8);

-- 29. Word Search Puzzle (1 question)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat29, 'word_search', N'Find these words: FRACTION, DECIMAL, PERIMETER, ADAPTATION, ECOSYSTEM, GOVERNMENT, SUPPLY, DEMAND', NULL, N'FRACTION, DECIMAL, PERIMETER, ADAPTATION, ECOSYSTEM, GOVERNMENT, SUPPLY, DEMAND', 1);

-- 30. Logic Grid Puzzle (1 question)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g4cat30, 'short_response', N'Noah, Zoe, and Priya each have a different pet: a dog, a fish, or a bird. Noah''s pet does not have fur. Zoe''s pet does not live in water. Priya''s pet can fly. Who has which pet?', NULL, N'Priya: bird, Noah: fish, Zoe: dog', 1);

END
GO
