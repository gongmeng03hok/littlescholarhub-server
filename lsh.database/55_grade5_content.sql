-- 55_grade5_content.sql
-- Grade 5, content bank — 30 original categories drawn from the ABC
-- Unified Grade 5 category list. Most categories carry more questions
-- than their target_count so weekly composition genuinely varies.

IF NOT EXISTS (SELECT 1 FROM dbo.PacketCategories WHERE grade_id = 6)
BEGIN
DECLARE @g5cat1 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (6, 'math', N'Multiplying Multi-Digit Numbers', 'short_answer', 10, NULL);
SET @g5cat1 = SCOPE_IDENTITY();

DECLARE @g5cat2 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (6, 'math', N'Dividing Multi-Digit Numbers', 'short_answer', 10, NULL);
SET @g5cat2 = SCOPE_IDENTITY();

DECLARE @g5cat3 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (6, 'math', N'Adding & Subtracting Fractions', 'short_answer', 10, NULL);
SET @g5cat3 = SCOPE_IDENTITY();

DECLARE @g5cat4 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (6, 'math', N'Multiplying Fractions', 'short_answer', 10, NULL);
SET @g5cat4 = SCOPE_IDENTITY();

DECLARE @g5cat5 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (6, 'math', N'Decimal Operations', 'short_answer', 10, NULL);
SET @g5cat5 = SCOPE_IDENTITY();

DECLARE @g5cat6 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (6, 'math', N'Volume of Rectangular Prisms', 'short_answer', 10, NULL);
SET @g5cat6 = SCOPE_IDENTITY();

DECLARE @g5cat7 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (6, 'math', N'Order of Operations', 'short_answer', 10, NULL);
SET @g5cat7 = SCOPE_IDENTITY();

DECLARE @g5cat8 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (6, 'math', N'Coordinate Plane', 'short_answer', 10, NULL);
SET @g5cat8 = SCOPE_IDENTITY();

DECLARE @g5cat9 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (6, 'math', N'Powers of Ten & Simple Exponents', 'short_answer', 10, NULL);
SET @g5cat9 = SCOPE_IDENTITY();

DECLARE @g5cat10 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (6, 'math', N'Multi-Step Word Problems', 'space_heavy', 8, NULL);
SET @g5cat10 = SCOPE_IDENTITY();

DECLARE @g5cat11 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (6, 'math', N'Numerical Patterns & Algebraic Thinking', 'short_answer', 8, NULL);
SET @g5cat11 = SCOPE_IDENTITY();

DECLARE @g5cat12 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (6, 'ela', N'Theme & Central Message', 'short_answer', 8, NULL);
SET @g5cat12 = SCOPE_IDENTITY();

DECLARE @g5cat13 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (6, 'ela', N'Figurative Language', 'short_answer', 10, NULL);
SET @g5cat13 = SCOPE_IDENTITY();

DECLARE @g5cat14 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (6, 'ela', N'Text Structure', 'short_answer', 8, NULL);
SET @g5cat14 = SCOPE_IDENTITY();

DECLARE @g5cat15 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (6, 'ela', N'Author''s Point of View & Bias', 'short_answer', 8, NULL);
SET @g5cat15 = SCOPE_IDENTITY();

DECLARE @g5cat16 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (6, 'ela', N'Context Clues', 'short_answer', 8, NULL);
SET @g5cat16 = SCOPE_IDENTITY();

DECLARE @g5cat17 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (6, 'ela', N'Grammar: Verb Tense Consistency', 'short_answer', 10, NULL);
SET @g5cat17 = SCOPE_IDENTITY();

DECLARE @g5cat18 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (6, 'ela', N'Grammar: Conjunctions & Clause Types', 'short_answer', 10, NULL);
SET @g5cat18 = SCOPE_IDENTITY();

DECLARE @g5cat19 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (6, 'ela', N'Punctuation', 'short_answer', 10, NULL);
SET @g5cat19 = SCOPE_IDENTITY();

DECLARE @g5cat20 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (6, 'ela', N'Synonyms & Antonyms', 'short_answer', 10, NULL);
SET @g5cat20 = SCOPE_IDENTITY();

DECLARE @g5cat21 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (6, 'ela', N'Reading Comprehension', 'space_heavy', 6, N'The Long Journey of the Monarch Butterfly

Every fall, millions of monarch butterflies leave their homes in the United States and Canada and fly all the way to central Mexico. This journey can be more than 2,000 miles long, yet each monarch weighs less than a paperclip. Scientists still marvel at how such a small insect can travel so far.

No single butterfly makes the entire round trip. Instead, it takes three or four generations to complete the journey north again each spring. A monarch that hatches in Mexico might fly partway north, lay eggs, and die, leaving its offspring to continue the trip. Somehow, each new generation knows exactly where to go, even though none of them have ever been there before.

Monarchs rely on milkweed plants for survival. Female monarchs lay their eggs only on milkweed leaves, and caterpillars eat nothing else. Unfortunately, milkweed has become harder to find because of farming and construction. Many communities now plant milkweed gardens to help monarchs survive.

Without milkweed, monarch populations could shrink dramatically. Protecting this one plant could make a tremendous difference for an entire species. Scientists continue to track monarch numbers every year, hoping the population will grow instead of shrink.');
SET @g5cat21 = SCOPE_IDENTITY();

DECLARE @g5cat22 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (6, 'writing', N'Argumentative/Opinion Writing with Evidence', 'space_heavy', 8, N'Plan your argumentative writing below, then write it on a separate sheet or the back of this page.');
SET @g5cat22 = SCOPE_IDENTITY();

DECLARE @g5cat23 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (6, 'writing', N'Narrative Writing with Dialogue', 'space_heavy', 8, N'Plan your narrative below, then write it with dialogue on a separate sheet or the back of this page.');
SET @g5cat23 = SCOPE_IDENTITY();

DECLARE @g5cat24 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (6, 'science', N'Properties & Changes of Matter', 'short_answer', 8, NULL);
SET @g5cat24 = SCOPE_IDENTITY();

DECLARE @g5cat25 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (6, 'science', N'Earth''s Systems & Human Impact on Ecosystems', 'short_answer', 8, NULL);
SET @g5cat25 = SCOPE_IDENTITY();

DECLARE @g5cat26 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (6, 'social_studies', N'Colonial America & the American Revolution', 'short_answer', 8, NULL);
SET @g5cat26 = SCOPE_IDENTITY();

DECLARE @g5cat27 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (6, 'social_studies', N'Branches of Government & the Constitution', 'short_answer', 8, NULL);
SET @g5cat27 = SCOPE_IDENTITY();

DECLARE @g5cat28 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (6, 'social_studies', N'Economics: Producers, Consumers & Scarcity', 'short_answer', 8, NULL);
SET @g5cat28 = SCOPE_IDENTITY();

DECLARE @g5cat29 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (6, 'puzzle', N'Word Search Puzzle', 'puzzle', 1, NULL);
SET @g5cat29 = SCOPE_IDENTITY();

DECLARE @g5cat30 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (6, 'puzzle', N'Logic Grid Puzzle', 'space_heavy', 1, NULL);
SET @g5cat30 = SCOPE_IDENTITY();

-- 1. Multiplying Multi-Digit Numbers (14 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat1, 'fill_blank', N'34 × 26 = ___', NULL, N'884', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat1, 'fill_blank', N'127 × 34 = ___', NULL, N'4318', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat1, 'fill_blank', N'58 × 47 = ___', NULL, N'2726', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat1, 'fill_blank', N'213 × 19 = ___', NULL, N'4047', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat1, 'fill_blank', N'462 × 23 = ___', NULL, N'10626', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat1, 'fill_blank', N'89 × 76 = ___', NULL, N'6764', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat1, 'fill_blank', N'305 × 18 = ___', NULL, N'5490', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat1, 'fill_blank', N'742 × 15 = ___', NULL, N'11130', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat1, 'fill_blank', N'56 × 39 = ___', NULL, N'2184', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat1, 'fill_blank', N'418 × 27 = ___', NULL, N'11286', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat1, 'fill_blank', N'93 × 64 = ___', NULL, N'5952', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat1, 'fill_blank', N'621 × 32 = ___', NULL, N'19872', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat1, 'fill_blank', N'47 × 58 = ___', NULL, N'2726', 13);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat1, 'fill_blank', N'816 × 24 = ___', NULL, N'19584', 14);

-- 2. Dividing Multi-Digit Numbers (14 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat2, 'fill_blank', N'4301 ÷ 23 = ___', NULL, N'187', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat2, 'fill_blank', N'5304 ÷ 34 = ___', NULL, N'156', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat2, 'fill_blank', N'4410 ÷ 18 = ___', NULL, N'245', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat2, 'fill_blank', N'3564 ÷ 27 = ___', NULL, N'132', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat2, 'fill_blank', N'4365 ÷ 45 = ___', NULL, N'97', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat2, 'fill_blank', N'3796 ÷ 52 = ___', NULL, N'73', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat2, 'fill_blank', N'4944 ÷ 16 = ___', NULL, N'309', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat2, 'fill_blank', N'5249 ÷ 29 = ___', NULL, N'181', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat2, 'fill_blank', N'5292 ÷ 63 = ___', NULL, N'84', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat2, 'fill_blank', N'4550 ÷ 14 = ___', NULL, N'325', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat2, 'fill_blank', N'4598 ÷ 38 = ___', NULL, N'121', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat2, 'fill_blank', N'4402 ÷ 71 = ___', NULL, N'62', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat2, 'fill_blank', N'7923 ÷ 19 = ___', NULL, N'417', 13);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat2, 'fill_blank', N'4200 ÷ 25 = ___', NULL, N'168', 14);

-- 3. Adding & Subtracting Fractions (14 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat3, 'fill_blank', N'1/2 + 1/3 = ___', NULL, N'5/6', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat3, 'fill_blank', N'2/3 - 1/4 = ___', NULL, N'5/12', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat3, 'fill_blank', N'3/4 + 1/6 = ___', NULL, N'11/12', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat3, 'fill_blank', N'5/6 - 1/3 = ___', NULL, N'1/2', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat3, 'fill_blank', N'1/4 + 2/5 = ___', NULL, N'13/20', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat3, 'fill_blank', N'3/5 - 1/4 = ___', NULL, N'7/20', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat3, 'fill_blank', N'2/3 + 1/6 = ___', NULL, N'5/6', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat3, 'fill_blank', N'5/8 - 1/4 = ___', NULL, N'3/8', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat3, 'fill_blank', N'1/3 + 1/6 = ___', NULL, N'1/2', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat3, 'fill_blank', N'7/10 - 1/5 = ___', NULL, N'1/2', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat3, 'fill_blank', N'2/5 + 3/10 = ___', NULL, N'7/10', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat3, 'fill_blank', N'5/6 - 1/2 = ___', NULL, N'1/3', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat3, 'fill_blank', N'1/2 + 3/8 = ___', NULL, N'7/8', 13);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat3, 'fill_blank', N'4/5 - 1/3 = ___', NULL, N'7/15', 14);

-- 4. Multiplying Fractions (14 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat4, 'fill_blank', N'1/2 × 2/3 = ___', NULL, N'1/3', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat4, 'fill_blank', N'3/4 × 1/2 = ___', NULL, N'3/8', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat4, 'fill_blank', N'2/3 × 3/5 = ___', NULL, N'2/5', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat4, 'fill_blank', N'5/6 × 2/3 = ___', NULL, N'5/9', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat4, 'fill_blank', N'1/4 × 4/5 = ___', NULL, N'1/5', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat4, 'fill_blank', N'3/8 × 2/3 = ___', NULL, N'1/4', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat4, 'fill_blank', N'2/5 × 5/6 = ___', NULL, N'1/3', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat4, 'fill_blank', N'1/3 × 3/4 = ___', NULL, N'1/4', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat4, 'fill_blank', N'5/8 × 4/5 = ___', NULL, N'1/2', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat4, 'fill_blank', N'2/3 × 1/2 = ___', NULL, N'1/3', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat4, 'fill_blank', N'3/5 × 5/6 = ___', NULL, N'1/2', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat4, 'fill_blank', N'1/6 × 3/4 = ___', NULL, N'1/8', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat4, 'fill_blank', N'4/5 × 5/8 = ___', NULL, N'1/2', 13);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat4, 'fill_blank', N'3/4 × 2/9 = ___', NULL, N'1/6', 14);

-- 5. Decimal Operations (14 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat5, 'fill_blank', N'4.56 + 3.27 = ___', NULL, N'7.83', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat5, 'fill_blank', N'8.9 - 3.45 = ___', NULL, N'5.45', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat5, 'fill_blank', N'12.3 + 5.68 = ___', NULL, N'17.98', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat5, 'fill_blank', N'7.5 - 2.86 = ___', NULL, N'4.64', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat5, 'fill_blank', N'6.4 × 3 = ___', NULL, N'19.2', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat5, 'fill_blank', N'2.5 × 1.2 = ___', NULL, N'3', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat5, 'fill_blank', N'9.05 - 4.7 = ___', NULL, N'4.35', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat5, 'fill_blank', N'3.14 + 2.09 = ___', NULL, N'5.23', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat5, 'fill_blank', N'0.6 × 0.8 = ___', NULL, N'0.48', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat5, 'fill_blank', N'15.75 + 8.5 = ___', NULL, N'24.25', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat5, 'fill_blank', N'20 - 6.35 = ___', NULL, N'13.65', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat5, 'fill_blank', N'4.2 × 5 = ___', NULL, N'21', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat5, 'fill_blank', N'1.5 × 3.3 = ___', NULL, N'4.95', 13);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat5, 'fill_blank', N'9.75 + 0.5 = ___', NULL, N'10.25', 14);

-- 6. Volume of Rectangular Prisms (14 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat6, 'fill_blank', N'A rectangular prism is 4 cm by 3 cm by 5 cm. What is its volume?', NULL, N'60 cu cm', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat6, 'fill_blank', N'A rectangular prism is 6 cm by 2 cm by 7 cm. What is its volume?', NULL, N'84 cu cm', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat6, 'fill_blank', N'A rectangular prism is 5 cm by 5 cm by 4 cm. What is its volume?', NULL, N'100 cu cm', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat6, 'fill_blank', N'A rectangular prism is 8 cm by 3 cm by 2 cm. What is its volume?', NULL, N'48 cu cm', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat6, 'fill_blank', N'A rectangular prism is 10 cm by 4 cm by 3 cm. What is its volume?', NULL, N'120 cu cm', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat6, 'fill_blank', N'A rectangular prism is 6 cm by 6 cm by 2 cm. What is its volume?', NULL, N'72 cu cm', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat6, 'fill_blank', N'A rectangular prism is 9 cm by 2 cm by 5 cm. What is its volume?', NULL, N'90 cu cm', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat6, 'fill_blank', N'A rectangular prism is 7 cm by 4 cm by 4 cm. What is its volume?', NULL, N'112 cu cm', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat6, 'fill_blank', N'A rectangular prism is 3 cm by 3 cm by 3 cm. What is its volume?', NULL, N'27 cu cm', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat6, 'fill_blank', N'A rectangular prism is 12 cm by 2 cm by 4 cm. What is its volume?', NULL, N'96 cu cm', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat6, 'fill_blank', N'A rectangular prism is 5 cm by 7 cm by 2 cm. What is its volume?', NULL, N'70 cu cm', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat6, 'fill_blank', N'A rectangular prism is 8 cm by 5 cm by 2 cm. What is its volume?', NULL, N'80 cu cm', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat6, 'fill_blank', N'A rectangular prism is 4 cm by 4 cm by 9 cm. What is its volume?', NULL, N'144 cu cm', 13);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat6, 'fill_blank', N'A rectangular prism is 6 cm by 3 cm by 7 cm. What is its volume?', NULL, N'126 cu cm', 14);

-- 7. Order of Operations (14 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat7, 'fill_blank', N'(3 + 4) × 2 - 5 = ___', NULL, N'9', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat7, 'fill_blank', N'6 + 3 × (8 - 5) = ___', NULL, N'15', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat7, 'fill_blank', N'(12 - 4) ÷ 2 + 7 = ___', NULL, N'11', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat7, 'fill_blank', N'5 × (6 + 2) - 10 = ___', NULL, N'30', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat7, 'fill_blank', N'(10 - 3) × (2 + 2) = ___', NULL, N'28', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat7, 'fill_blank', N'20 ÷ (2 + 3) × 4 = ___', NULL, N'16', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat7, 'fill_blank', N'8 + 2² - 5 = ___', NULL, N'7', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat7, 'fill_blank', N'3² + 4 × 2 = ___', NULL, N'17', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat7, 'fill_blank', N'(5 + 5)² ÷ 4 = ___', NULL, N'25', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat7, 'fill_blank', N'15 - (2 + 3) × 2 = ___', NULL, N'5', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat7, 'fill_blank', N'(6 × 3) - (4 + 5) = ___', NULL, N'9', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat7, 'fill_blank', N'4 × (9 - 6) + 7 = ___', NULL, N'19', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat7, 'fill_blank', N'18 ÷ 3 + 2 × (5 - 2) = ___', NULL, N'12', 13);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat7, 'fill_blank', N'(8 - 2) × 3 + 4² = ___', NULL, N'34', 14);

-- 8. Coordinate Plane (14 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat8, 'fill_blank', N'What ordered pair names a point that is 4 units right and 2 units up from the origin?', NULL, N'(4, 2)', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat8, 'fill_blank', N'What ordered pair names a point that is 6 units right and 1 unit up from the origin?', NULL, N'(6, 1)', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat8, 'fill_blank', N'In the ordered pair (5, 3), what is the x-coordinate?', NULL, N'5', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat8, 'fill_blank', N'In the ordered pair (5, 3), what is the y-coordinate?', NULL, N'3', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat8, 'fill_blank', N'In the ordered pair (7, 9), what is the x-coordinate?', NULL, N'7', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat8, 'fill_blank', N'In the ordered pair (2, 8), what is the y-coordinate?', NULL, N'8', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat8, 'fill_blank', N'What ordered pair names a point that is 0 units right and 6 units up from the origin?', NULL, N'(0, 6)', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat8, 'fill_blank', N'What ordered pair names a point that is 8 units right and 0 units up from the origin?', NULL, N'(8, 0)', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat8, 'fill_blank', N'Point A is 3 units right and 7 units up from the origin. Write A''s ordered pair.', NULL, N'(3, 7)', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat8, 'fill_blank', N'Point B is 9 units right and 4 units up from the origin. Write B''s ordered pair.', NULL, N'(9, 4)', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat8, 'fill_blank', N'In the ordered pair (1, 10), what is the y-coordinate?', NULL, N'10', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat8, 'fill_blank', N'In the ordered pair (10, 1), what is the x-coordinate?', NULL, N'10', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat8, 'fill_blank', N'On a coordinate grid, which number in an ordered pair tells you how far to move up from the origin?', NULL, N'The second number (the y-coordinate)', 13);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat8, 'fill_blank', N'On a coordinate grid, which number in an ordered pair tells you how far to move right from the origin?', NULL, N'The first number (the x-coordinate)', 14);

-- 9. Powers of Ten & Simple Exponents (14 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat9, 'fill_blank', N'10² = ___', NULL, N'100', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat9, 'fill_blank', N'10³ = ___', NULL, N'1,000', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat9, 'fill_blank', N'10⁴ = ___', NULL, N'10,000', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat9, 'fill_blank', N'4² = ___', NULL, N'16', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat9, 'fill_blank', N'6² = ___', NULL, N'36', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat9, 'fill_blank', N'9² = ___', NULL, N'81', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat9, 'fill_blank', N'2³ = ___', NULL, N'8', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat9, 'fill_blank', N'3³ = ___', NULL, N'27', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat9, 'fill_blank', N'7² = ___', NULL, N'49', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat9, 'fill_blank', N'8² = ___', NULL, N'64', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat9, 'fill_blank', N'4.5 × 10² = ___', NULL, N'450', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat9, 'fill_blank', N'3.2 × 10³ = ___', NULL, N'3,200', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat9, 'fill_blank', N'67 × 10² = ___', NULL, N'6,700', 13);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat9, 'fill_blank', N'5 × 10⁴ = ___', NULL, N'50,000', 14);

-- 10. Multi-Step Word Problems (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat10, 'short_response', N'Ollie the Owl collected 156 acorns on Monday and 289 acorns on Tuesday. He then gave away 175 acorns to his forest friends. How many acorns does Ollie have left?', NULL, N'270 acorns', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat10, 'short_response', N'A school ordered 24 boxes of markers with 18 markers in each box. If the markers are shared equally among 8 classrooms, how many markers does each classroom get?', NULL, N'54 markers', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat10, 'short_response', N'Maria earns $12 per hour babysitting. She babysat 4 hours on Friday and 6 hours on Saturday. She spent $35 on a gift. How much money does she have left?', NULL, N'$85', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat10, 'short_response', N'A theater has 18 rows with 24 seats in each row. If 312 tickets have already been sold, how many seats are still empty?', NULL, N'120 seats', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat10, 'short_response', N'Ollie the Owl is stacking books into equal piles. He has 245 books and then finds 15 more. If he divides all the books evenly into 5 piles, how many books will be in each pile?', NULL, N'52 books', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat10, 'short_response', N'A bakery makes 18 dozen cookies in the morning and 12 dozen in the afternoon. If they sell 276 cookies, how many cookies are left?', NULL, N'84 cookies', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat10, 'short_response', N'Four friends equally split the cost of a $96 video game. Then each friend also pays $7 for a controller. How much does each friend pay in total?', NULL, N'$31', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat10, 'short_response', N'A garden has 14 rows of tomato plants with 9 plants in each row. If each plant produces 6 tomatoes, how many tomatoes are harvested in total?', NULL, N'756 tomatoes', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat10, 'short_response', N'Jayden read 45 pages on Monday, 38 pages on Tuesday, and twice as many pages on Wednesday as he read on Monday. How many pages did he read in all three days?', NULL, N'173 pages', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat10, 'short_response', N'A parking garage has 6 levels with 48 parking spaces on each level. If 3 levels are completely full and the other 3 levels are half full, how many cars are parked in the garage?', NULL, N'216 cars', 10);

-- 11. Numerical Patterns & Algebraic Thinking (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat11, 'short_response', N'Pattern A starts at 0 and follows the rule "add 4." What are the first five terms?', NULL, N'0, 4, 8, 12, 16', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat11, 'short_response', N'Pattern B starts at 0 and follows the rule "add 8." What are the first five terms?', NULL, N'0, 8, 16, 24, 32', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat11, 'short_response', N'Pattern A starts at 0, rule "add 4." Pattern B starts at 0, rule "add 8." How does each term in Pattern B compare to the matching term in Pattern A?', NULL, N'It is twice (2 times) as large', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat11, 'short_response', N'Pattern C starts at 3 and follows the rule "add 5." What are the first five terms?', NULL, N'3, 8, 13, 18, 23', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat11, 'short_response', N'Pattern D starts at 0, rule "add 2." Pattern E starts at 0, rule "add 6." What are the first five terms of Pattern E?', NULL, N'0, 6, 12, 18, 24', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat11, 'short_response', N'Pattern D starts at 0, rule "add 2." Pattern E starts at 0, rule "add 6." How does each term in Pattern E compare to the matching term in Pattern D?', NULL, N'It is 3 times as large', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat11, 'short_response', N'Pattern F starts at 1 and follows the rule "add 3." What are the first six terms?', NULL, N'1, 4, 7, 10, 13, 16', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat11, 'short_response', N'Pattern G starts at 100 and follows the rule "subtract 7." What are the first five terms?', NULL, N'100, 93, 86, 79, 72', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat11, 'short_response', N'Pattern H starts at 0, rule "add 5." Pattern I starts at 0, rule "add 10." Every term in Pattern I is how many times as large as the matching term in Pattern H?', NULL, N'2 times (twice) as large', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat11, 'short_response', N'Pattern J starts at 2, rule "add 4." Pattern K starts at 5, rule "add 4." What is true about each term in Pattern K compared to the matching term in Pattern J?', NULL, N'Each term in K is 3 more than the matching term in J', 10);

-- 12. Theme & Central Message (11 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat12, 'multiple_choice', N'A fable ends with a slow but steady tortoise beating a fast but careless hare in a race. What is the theme?', N'["Slow and steady wins the race", "Speed is the only thing that matters", "Hares make bad friends"]', N'Slow and steady wins the race', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat12, 'multiple_choice', N'A boy shares his lunch with a hungry classmate, and years later that same classmate helps him during a hard time. What is the theme?', N'["Kindness is often returned", "Sharing food is required by law", "Classmates should never talk to strangers"]', N'Kindness is often returned', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat12, 'multiple_choice', N'A girl practices piano every day even when she wants to quit, and eventually she performs beautifully at the recital. What is the theme?', N'["Hard work and persistence pay off", "Piano is easy for everyone", "Recitals are not important"]', N'Hard work and persistence pay off', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat12, 'multiple_choice', N'An ant works all summer storing food while a grasshopper plays; in winter the ant has plenty to eat and the grasshopper has none. What is the theme?', N'["It pays to plan and prepare ahead of time", "Playing is more important than working", "Ants are smarter than grasshoppers"]', N'It pays to plan and prepare ahead of time', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat12, 'multiple_choice', N'A crow wants water from a jug but the water is too low to reach, so it drops in pebbles until the water rises high enough to drink. What is the theme?', N'["Clever thinking can solve a difficult problem", "Birds should not drink water", "Pebbles are useless objects"]', N'Clever thinking can solve a difficult problem', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat12, 'multiple_choice', N'Two brothers argue over an orange and cut it in half, but one only wanted the peel for baking and the other only wanted the juice. What is the theme?', N'["Talking things through can prevent unnecessary conflict", "Oranges should always be shared equally", "Arguments are impossible to avoid"]', N'Talking things through can prevent unnecessary conflict', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat12, 'multiple_choice', N'A shepherd boy jokes about a wolf attacking his sheep so many times that when a real wolf comes, no one believes him. What is the theme?', N'["Lying makes people stop trusting you", "Wolves are dangerous animals", "Shepherds should not tell jokes"]', N'Lying makes people stop trusting you', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat12, 'multiple_choice', N'A young explorer is afraid to try new things, but after her first successful hike she starts trying a new adventure every month. What is the theme?', N'["Facing your fears can open new opportunities", "Hiking is the best form of exercise", "Only experts should go on adventures"]', N'Facing your fears can open new opportunities', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat12, 'multiple_choice', N'A team loses many games before finally winning the championship because they never stopped practicing together. What is the theme?', N'["Teamwork and persistence lead to success", "Winning is the only thing that matters", "Practice is not necessary for success"]', N'Teamwork and persistence lead to success', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat12, 'multiple_choice', N'A wealthy man is unhappy despite his riches, but a poor farmer nearby is happy because of his close family. What is the theme?', N'["Money does not guarantee happiness", "Farmers are always happier than city people", "Wealthy people are never satisfied"]', N'Money does not guarantee happiness', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat12, 'multiple_choice', N'A mouse frees a lion caught in a hunter''s net after the lion had once spared the mouse''s life. What is the theme?', N'["No act of kindness is ever wasted", "Lions are the kings of the jungle", "Small animals cannot help large ones"]', N'No act of kindness is ever wasted', 11);

-- 13. Figurative Language (14 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat13, 'multiple_choice', N'The lake was as smooth as glass.', N'["simile", "metaphor", "idiom", "personification"]', N'simile', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat13, 'multiple_choice', N'He was as quiet as a mouse during the test.', N'["simile", "metaphor", "idiom", "personification"]', N'simile', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat13, 'multiple_choice', N'Her eyes sparkled like diamonds.', N'["simile", "metaphor", "idiom", "personification"]', N'simile', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat13, 'multiple_choice', N'The classroom was a zoo during the fire drill.', N'["simile", "metaphor", "idiom", "personification"]', N'metaphor', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat13, 'multiple_choice', N'His words were daggers that cut deep.', N'["simile", "metaphor", "idiom", "personification"]', N'metaphor', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat13, 'multiple_choice', N'The playground was an oven in the summer heat.', N'["simile", "metaphor", "idiom", "personification"]', N'metaphor', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat13, 'multiple_choice', N'The old house groaned in the wind.', N'["simile", "metaphor", "idiom", "personification"]', N'personification', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat13, 'multiple_choice', N'The stars winked down at the sleepy town.', N'["simile", "metaphor", "idiom", "personification"]', N'personification', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat13, 'multiple_choice', N'The alarm clock screamed at him to wake up.', N'["simile", "metaphor", "idiom", "personification"]', N'personification', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat13, 'multiple_choice', N'Break a leg at your recital tonight!', N'["simile", "metaphor", "idiom", "personification"]', N'idiom', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat13, 'multiple_choice', N'Let''s not spill the beans before the surprise party.', N'["simile", "metaphor", "idiom", "personification"]', N'idiom', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat13, 'multiple_choice', N'It''s time to hit the books before the test.', N'["simile", "metaphor", "idiom", "personification"]', N'idiom', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat13, 'multiple_choice', N'She was on cloud nine after winning first place.', N'["simile", "metaphor", "idiom", "personification"]', N'idiom', 13);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat13, 'multiple_choice', N'Don''t beat around the bush — just tell me the answer.', N'["simile", "metaphor", "idiom", "personification"]', N'idiom', 14);

-- 14. Text Structure (12 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat14, 'multiple_choice', N'First, mix the flour and sugar. Next, add the eggs. Then bake for 20 minutes. Finally, let it cool.', N'["sequence", "compare-contrast", "cause-effect", "problem-solution"]', N'sequence', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat14, 'multiple_choice', N'Dogs and cats are both popular pets, but dogs need more exercise while cats are more independent.', N'["sequence", "compare-contrast", "cause-effect", "problem-solution"]', N'compare-contrast', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat14, 'multiple_choice', N'Because the bridge was damaged, the town built a new one using stronger materials.', N'["sequence", "compare-contrast", "cause-effect", "problem-solution"]', N'problem-solution', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat14, 'multiple_choice', N'Heavy rain caused the river to flood, which forced many families to evacuate.', N'["sequence", "compare-contrast", "cause-effect", "problem-solution"]', N'cause-effect', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat14, 'multiple_choice', N'Basketball and soccer both require teamwork, but basketball is played indoors while soccer is usually played outdoors.', N'["sequence", "compare-contrast", "cause-effect", "problem-solution"]', N'compare-contrast', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat14, 'multiple_choice', N'The library''s shelves were overcrowded, so the staff decided to donate older books to make room.', N'["sequence", "compare-contrast", "cause-effect", "problem-solution"]', N'problem-solution', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat14, 'multiple_choice', N'First you plant the seed, then you water it daily, and eventually a sprout appears.', N'["sequence", "compare-contrast", "cause-effect", "problem-solution"]', N'sequence', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat14, 'multiple_choice', N'Because she forgot her umbrella, she got soaked walking home in the rain.', N'["sequence", "compare-contrast", "cause-effect", "problem-solution"]', N'cause-effect', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat14, 'multiple_choice', N'Whales and fish both live in the ocean, but whales must swim to the surface to breathe air.', N'["sequence", "compare-contrast", "cause-effect", "problem-solution"]', N'compare-contrast', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat14, 'multiple_choice', N'The class was too loud, so the teacher introduced a quiet signal to solve the problem.', N'["sequence", "compare-contrast", "cause-effect", "problem-solution"]', N'problem-solution', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat14, 'multiple_choice', N'Too much trash was piling up in the park, so volunteers organized a weekly cleanup.', N'["sequence", "compare-contrast", "cause-effect", "problem-solution"]', N'problem-solution', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat14, 'multiple_choice', N'The volcano erupted, which buried the nearby village in ash.', N'["sequence", "compare-contrast", "cause-effect", "problem-solution"]', N'cause-effect', 12);

-- 15. Author's Point of View & Bias (11 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat15, 'multiple_choice', N'This restaurant review says: "The best pizza in town, hands down!" Is this statement a fact or an opinion?', N'["Fact", "Opinion"]', N'Opinion', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat15, 'multiple_choice', N'"The recipe requires two cups of flour and one egg." Is this statement a fact or an opinion?', N'["Fact", "Opinion"]', N'Fact', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat15, 'short_response', N'"Video games are a complete waste of time and rot your brain." What is the author''s point of view about video games?', NULL, N'The author is against (negative toward) video games', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat15, 'short_response', N'"Solar power is clearly the greatest invention in human history." Which word in the sentence reveals the author''s opinion?', NULL, N'clearly (or greatest)', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat15, 'short_response', N'An article about a new park says: "This wonderful park will obviously benefit everyone in town." Name one word that reveals the author''s bias.', NULL, N'wonderful (or obviously)', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat15, 'multiple_choice', N'"Cats make better pets than dogs because they are quieter." Is this a fact or an opinion?', N'["Fact", "Opinion"]', N'Opinion', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat15, 'multiple_choice', N'"The Earth orbits the Sun once every 365 days." Is this a fact or an opinion?', N'["Fact", "Opinion"]', N'Fact', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat15, 'short_response', N'An ad for a cereal says: "This is the most delicious breakfast on the planet!" What is the author''s purpose in writing this?', NULL, N'To persuade you to buy the cereal', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat15, 'short_response', N'"Some people say the new law is unfair, while others believe it protects the community." Does this sentence present one point of view or more than one?', NULL, N'More than one point of view (a balanced statement)', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat15, 'multiple_choice', N'"That movie was boring and a total waste of money." Is this a fact or an opinion?', N'["Fact", "Opinion"]', N'Opinion', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat15, 'short_response', N'A news article only says good things about a new mayor and never mentions any criticism. What might this suggest about the author?', NULL, N'The author may be biased in favor of the mayor', 11);

-- 16. Context Clues (12 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat16, 'short_response', N'"The detective scrutinized every clue at the scene, examining each one closely." — What does the word “scrutinized” most likely mean?', NULL, N'examined closely', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat16, 'short_response', N'"Her explanation was so ambiguous that no one understood exactly what she meant." — What does the word “ambiguous” most likely mean?', NULL, N'unclear or open to more than one meaning', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat16, 'short_response', N'"The frigid wind made everyone shiver and pull their coats tighter." — What does the word “frigid” most likely mean?', NULL, N'extremely cold', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat16, 'short_response', N'"He was reluctant to try the spicy food, hesitating before finally taking a bite." — What does the word “reluctant” most likely mean?', NULL, N'unwilling or hesitant', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat16, 'short_response', N'"The scientist''s discovery was so significant that it changed how doctors treat the disease." — What does the word “significant” most likely mean?', NULL, N'important', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat16, 'short_response', N'"The crowd was in awe of the magician''s astonishing tricks." — What does the word “astonishing” most likely mean?', NULL, N'amazing or surprising', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat16, 'short_response', N'"Because the directions were so concise, the students finished the project quickly." — What does the word “concise” most likely mean?', NULL, N'brief and to the point', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat16, 'short_response', N'"The stubborn mule refused to budge no matter how hard they pulled." — What does the word “stubborn” most likely mean?', NULL, N'not willing to change', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat16, 'short_response', N'"The abundant harvest meant the farmers had more than enough food for winter." — What does the word “abundant” most likely mean?', NULL, N'plentiful or more than enough', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat16, 'short_response', N'"Her candid answer surprised everyone because she is usually so private." — What does the word “candid” most likely mean?', NULL, N'honest and straightforward', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat16, 'short_response', N'"The turbulent storm tossed the small boat violently across the waves." — What does the word “turbulent” most likely mean?', NULL, N'violently disturbed or stormy', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat16, 'short_response', N'"The novel''s plot was so intricate that readers had to pay close attention to every detail." — What does the word “intricate” most likely mean?', NULL, N'complex or detailed', 12);

-- 17. Grammar: Verb Tense Consistency (14 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat17, 'short_response', N'Yesterday, she walks to school and then eats breakfast when she got there. Fix the tense error.', NULL, N'Yesterday, she walked to school and then ate breakfast when she got there.', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat17, 'short_response', N'He will finish his homework and then went outside to play. Fix the tense error.', NULL, N'He will finish his homework and then go outside to play.', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat17, 'short_response', N'Last summer, we visit my grandmother and stayed for two weeks. Fix the tense error.', NULL, N'Last summer, we visited my grandmother and stayed for two weeks.', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat17, 'short_response', N'Tomorrow, I clean my room and will do my homework. Fix the tense error.', NULL, N'Tomorrow, I will clean my room and do my homework.', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat17, 'short_response', N'She was baking cookies and burns her hand. Fix the tense error.', NULL, N'She was baking cookies and burned her hand.', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat17, 'short_response', N'They played outside all day and are getting very tired. Fix the tense error.', NULL, N'They played outside all day and got very tired.', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat17, 'short_response', N'He studies hard last night for the big test. Fix the tense error.', NULL, N'He studied hard last night for the big test.', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat17, 'short_response', N'While she was reading, the phone rings loudly. Fix the tense error.', NULL, N'While she was reading, the phone rang loudly.', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat17, 'short_response', N'Next week, we will travel to the beach and swam in the ocean. Fix the tense error.', NULL, N'Next week, we will travel to the beach and swim in the ocean.', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat17, 'short_response', N'The dog barked at the mail carrier and runs down the street. Fix the tense error.', NULL, N'The dog barked at the mail carrier and ran down the street.', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat17, 'short_response', N'I am eating dinner when the lights went out. Fix the tense error.', NULL, N'I was eating dinner when the lights went out.', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat17, 'short_response', N'She finished her book and reads another one right away. Fix the tense error.', NULL, N'She finished her book and read another one right away.', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat17, 'short_response', N'She cooks dinner and then washed the dishes. Fix the tense error.', NULL, N'She cooked dinner and then washed the dishes.', 13);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat17, 'short_response', N'We are walking to the park when it started to rain. Fix the tense error.', NULL, N'We were walking to the park when it started to rain.', 14);

-- 18. Grammar: Conjunctions & Clause Types (14 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat18, 'short_response', N'In the sentence "I wanted to go outside, but it started raining," is "but" a coordinating or subordinating conjunction?', NULL, N'coordinating', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat18, 'short_response', N'In the sentence "She studied hard because she wanted to pass the test," is "because" a coordinating or subordinating conjunction?', NULL, N'subordinating', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat18, 'short_response', N'Name the coordinating conjunction in this sentence: We can walk or we can ride bikes.', NULL, N'or', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat18, 'short_response', N'Name the subordinating conjunction in this sentence: Although it was cold, we went hiking.', NULL, N'although', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat18, 'short_response', N'Is "Although it was cold" an independent clause or a dependent clause?', NULL, N'dependent clause', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat18, 'short_response', N'Is "we went hiking" an independent clause or a dependent clause?', NULL, N'independent clause', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat18, 'multiple_choice', N'Which of these is a coordinating conjunction?', N'["and", "since", "although"]', N'and', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat18, 'multiple_choice', N'Which of these is a subordinating conjunction?', N'["but", "or", "unless"]', N'unless', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat18, 'short_response', N'In the sentence "Since the store was closed, we went home," which clause is the dependent clause?', NULL, N'Since the store was closed', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat18, 'short_response', N'Combine these two sentences using a coordinating conjunction: "I like apples. I like oranges."', NULL, N'I like apples, and I like oranges.', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat18, 'short_response', N'Combine these two sentences using a subordinating conjunction: "It was raining. We stayed inside."', NULL, N'Because it was raining, we stayed inside.', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat18, 'short_response', N'Name the coordinating conjunction in this sentence: She wanted pizza, so she ordered a large one.', NULL, N'so', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat18, 'short_response', N'Name the subordinating conjunction in this sentence: We will leave after the movie ends.', NULL, N'after', 13);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat18, 'short_response', N'Is "after the movie ends" an independent clause or a dependent clause?', NULL, N'dependent clause', 14);

-- 19. Punctuation (14 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat19, 'fill_blank', N'Add commas where needed: I packed shirts pants socks and shoes for the trip.', NULL, N'I packed shirts, pants, socks, and shoes for the trip.', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat19, 'fill_blank', N'Add commas where needed: My favorite subjects are math science and art.', NULL, N'My favorite subjects are math, science, and art.', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat19, 'fill_blank', N'Add quotation marks where needed: Maria said Let''s go to the park.', NULL, N'Maria said, "Let''s go to the park."', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat19, 'fill_blank', N'Add quotation marks where needed: Where are you going asked Tom.', NULL, N'"Where are you going?" asked Tom.', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat19, 'fill_blank', N'Add commas where needed: We need eggs milk butter and flour for the recipe.', NULL, N'We need eggs, milk, butter, and flour for the recipe.', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat19, 'fill_blank', N'Add quotation marks and correct punctuation: The teacher said Please take out your notebooks.', NULL, N'The teacher said, "Please take out your notebooks."', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat19, 'fill_blank', N'Add commas where needed: The dog ran jumped and barked with excitement.', NULL, N'The dog ran, jumped, and barked with excitement.', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat19, 'fill_blank', N'Add quotation marks where needed: I am so excited exclaimed Lily.', NULL, N'"I am so excited!" exclaimed Lily.', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat19, 'fill_blank', N'Add commas where needed: She visited Paris London and Rome last summer.', NULL, N'She visited Paris, London, and Rome last summer.', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat19, 'fill_blank', N'Add quotation marks where needed: Can you help me carry this asked Noah.', NULL, N'"Can you help me carry this?" asked Noah.', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat19, 'fill_blank', N'Add commas where needed: For breakfast he had eggs toast juice and fruit.', NULL, N'For breakfast he had eggs, toast, juice, and fruit.', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat19, 'fill_blank', N'Add quotation marks where needed: Be careful on the ice warned Dad.', NULL, N'"Be careful on the ice," warned Dad.', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat19, 'fill_blank', N'Add commas where needed: We saw lions tigers bears and elephants at the zoo.', NULL, N'We saw lions, tigers, bears, and elephants at the zoo.', 13);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat19, 'fill_blank', N'Add quotation marks where needed: This is the best day ever shouted Emma.', NULL, N'"This is the best day ever!" shouted Emma.', 14);

-- 20. Synonyms & Antonyms (14 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat20, 'fill_blank', N'Give a synonym for "enormous."', NULL, N'huge / gigantic / massive', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat20, 'fill_blank', N'Give an antonym for "enormous."', NULL, N'tiny / small', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat20, 'fill_blank', N'Give a synonym for "furious."', NULL, N'enraged / livid', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat20, 'fill_blank', N'Give an antonym for "furious."', NULL, N'calm / pleased', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat20, 'fill_blank', N'Give a synonym for "ancient."', NULL, N'old / aged', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat20, 'fill_blank', N'Give an antonym for "ancient."', NULL, N'modern / new', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat20, 'fill_blank', N'Give a synonym for "generous."', NULL, N'giving / charitable', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat20, 'fill_blank', N'Give an antonym for "generous."', NULL, N'stingy / selfish', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat20, 'fill_blank', N'Give a synonym for "timid."', NULL, N'shy / fearful', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat20, 'fill_blank', N'Give an antonym for "timid."', NULL, N'bold / confident', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat20, 'fill_blank', N'Give a synonym for "brilliant" (as in intelligent).', NULL, N'smart / clever', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat20, 'fill_blank', N'Give an antonym for "brilliant" (as in intelligent).', NULL, N'dull / unintelligent', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat20, 'fill_blank', N'Give a synonym for "rapid."', NULL, N'fast / swift', 13);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat20, 'fill_blank', N'Give an antonym for "rapid."', NULL, N'slow / sluggish', 14);

-- 21. Reading Comprehension (6 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat21, 'short_response', N'What is the main idea of this passage?', NULL, N'Monarch butterflies make an amazing multi-generation migration, and they depend on milkweed to survive.', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat21, 'short_response', N'About how many miles can a monarch''s migration journey be?', NULL, N'More than 2,000 miles', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat21, 'short_response', N'How many generations does it usually take to complete the full journey north again each spring?', NULL, N'Three or four generations', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat21, 'short_response', N'What does the word “offspring” most likely mean as used in the passage?', NULL, N'A butterfly''s babies or young', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat21, 'short_response', N'Why is milkweed so important to monarch butterflies?', NULL, N'Female monarchs lay their eggs only on milkweed, and caterpillars eat only milkweed leaves', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat21, 'short_response', N'Based on the passage, what could happen if milkweed disappeared?', NULL, N'Monarch populations could shrink dramatically', 6);

-- 22. Argumentative/Opinion Writing with Evidence (8 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat22, 'short_response', N'What is the issue or topic you will write about?', NULL, N'Open response — check for a clear claim, reasons, and evidence.', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat22, 'short_response', N'What is your claim or position on this issue?', NULL, N'Open response — check for a clear claim, reasons, and evidence.', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat22, 'short_response', N'What is your strongest piece of evidence or reason?', NULL, N'Open response — check for a clear claim, reasons, and evidence.', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat22, 'short_response', N'What is a second piece of evidence or reason?', NULL, N'Open response — check for a clear claim, reasons, and evidence.', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat22, 'short_response', N'What is a counterargument someone might make?', NULL, N'Open response — check for a clear claim, reasons, and evidence.', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat22, 'short_response', N'How would you respond to that counterargument?', NULL, N'Open response — check for a clear claim, reasons, and evidence.', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat22, 'short_response', N'What transition words will you use to connect your reasons (for example, furthermore, in addition, however)?', NULL, N'Open response — check for a clear claim, reasons, and evidence.', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat22, 'short_response', N'How will you restate your claim in your conclusion?', NULL, N'Open response — check for a clear claim, reasons, and evidence.', 8);

-- 23. Narrative Writing with Dialogue (8 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat23, 'short_response', N'Who is the main character in your story, and what do they want?', NULL, N'Open response — check for a clear character, setting, dialogue with correct punctuation, and a resolved plot.', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat23, 'short_response', N'Where and when does your story take place (the setting)?', NULL, N'Open response — check for a clear character, setting, dialogue with correct punctuation, and a resolved plot.', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat23, 'short_response', N'What problem or challenge does your character face?', NULL, N'Open response — check for a clear character, setting, dialogue with correct punctuation, and a resolved plot.', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat23, 'short_response', N'Write one line of dialogue your character might say, using correct quotation marks.', NULL, N'Open response — check for a clear character, setting, dialogue with correct punctuation, and a resolved plot.', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat23, 'short_response', N'Write one line of dialogue another character might say in response, using correct quotation marks.', NULL, N'Open response — check for a clear character, setting, dialogue with correct punctuation, and a resolved plot.', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat23, 'short_response', N'What happens at the turning point or climax of your story?', NULL, N'Open response — check for a clear character, setting, dialogue with correct punctuation, and a resolved plot.', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat23, 'short_response', N'How is the problem solved?', NULL, N'Open response — check for a clear character, setting, dialogue with correct punctuation, and a resolved plot.', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat23, 'short_response', N'How does your story end?', NULL, N'Open response — check for a clear character, setting, dialogue with correct punctuation, and a resolved plot.', 8);

-- 24. Properties & Changes of Matter (11 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat24, 'multiple_choice', N'Mixing sand and water so the sand settles at the bottom is an example of a ___.', N'["mixture", "solution", "chemical change"]', N'mixture', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat24, 'multiple_choice', N'Dissolving salt completely into water so you can no longer see it is an example of a ___.', N'["solution", "mixture that separates", "chemical change"]', N'solution', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat24, 'multiple_choice', N'Cutting a piece of paper into smaller pieces is a ___ change.', N'["physical", "chemical", "permanent"]', N'physical', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat24, 'multiple_choice', N'Burning a piece of paper into ash is a ___ change.', N'["chemical", "physical", "reversible"]', N'chemical', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat24, 'multiple_choice', N'Melting an ice cube is a ___ change.', N'["physical", "chemical", "irreversible"]', N'physical', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat24, 'multiple_choice', N'Rusting of an iron nail is a ___ change.', N'["chemical", "physical", "reversible"]', N'chemical', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat24, 'multiple_choice', N'In a solution, the substance that dissolves is called the ___.', N'["solute", "solvent", "mixture"]', N'solute', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat24, 'multiple_choice', N'In a solution, the substance that does the dissolving is called the ___.', N'["solvent", "solute", "compound"]', N'solvent', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat24, 'multiple_choice', N'Mixing oil and water, which do not blend together, is an example of a ___.', N'["mixture", "solution", "chemical reaction"]', N'mixture', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat24, 'multiple_choice', N'Baking a cake, which cannot be undone back into raw ingredients, is a ___ change.', N'["chemical", "physical", "temporary"]', N'chemical', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat24, 'multiple_choice', N'Freezing water into ice is a ___ change.', N'["physical", "chemical", "permanent"]', N'physical', 11);

-- 25. Earth's Systems & Human Impact on Ecosystems (11 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat25, 'fill_blank', N'The four main systems of Earth are the geosphere, hydrosphere, atmosphere, and ___.', NULL, N'biosphere', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat25, 'fill_blank', N'The layer of gases surrounding Earth is called the ___.', NULL, N'atmosphere', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat25, 'fill_blank', N'All the water on Earth — oceans, rivers, lakes, and ice — makes up the ___.', NULL, N'hydrosphere', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat25, 'fill_blank', N'The solid rock and land part of Earth is called the ___.', NULL, N'geosphere', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat25, 'fill_blank', N'All living things on Earth make up the ___.', NULL, N'biosphere', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat25, 'fill_blank', N'Cutting down large areas of forest is called ___.', NULL, N'deforestation', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat25, 'fill_blank', N'Harmful substances released into the air, water, or land are called ___.', NULL, N'pollution', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat25, 'fill_blank', N'Using less of a resource so it lasts longer is called ___.', NULL, N'conservation', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat25, 'fill_blank', N'A resource like wind or sunlight that can be used again and again is a ___ resource.', NULL, N'renewable', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat25, 'fill_blank', N'A resource like coal or oil that cannot be replaced quickly is a ___ resource.', NULL, N'nonrenewable', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat25, 'fill_blank', N'When humans build cities and roads, animal habitats are often ___.', NULL, N'destroyed (lost)', 11);

-- 26. Colonial America & the American Revolution (11 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat26, 'fill_blank', N'The 13 original American colonies were ruled by which country?', NULL, N'Great Britain (England)', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat26, 'fill_blank', N'The tax protest where colonists dumped tea into the harbor was called the ___.', NULL, N'Boston Tea Party', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat26, 'fill_blank', N'The document that announced the colonies'' independence from Britain in 1776 is called the ___.', NULL, N'Declaration of Independence', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat26, 'fill_blank', N'Who was the main author of the Declaration of Independence?', NULL, N'Thomas Jefferson', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat26, 'fill_blank', N'Who led the Continental Army during the American Revolution?', NULL, N'George Washington', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat26, 'fill_blank', N'The phrase “no taxation without representation” expressed the colonists'' anger about being taxed without having a ___ in government.', NULL, N'voice (vote)', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat26, 'fill_blank', N'The war fought between the American colonies and Britain from 1775 to 1783 is called the ___.', NULL, N'American Revolution (Revolutionary War)', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat26, 'fill_blank', N'Colonists who wanted independence from Britain were called ___.', NULL, N'Patriots', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat26, 'fill_blank', N'Colonists who remained loyal to the British king were called ___.', NULL, N'Loyalists', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat26, 'fill_blank', N'Paul Revere is famous for his midnight ride to warn colonists that the ___ were coming.', NULL, N'British (soldiers/redcoats)', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat26, 'fill_blank', N'George Washington became the first ___ of the United States.', NULL, N'President', 11);

-- 27. Branches of Government & the Constitution (11 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat27, 'fill_blank', N'The branch of government that makes laws is called the ___ branch.', NULL, N'legislative', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat27, 'fill_blank', N'The branch of government that carries out laws is called the ___ branch.', NULL, N'executive', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat27, 'fill_blank', N'The branch of government that interprets laws is called the ___ branch.', NULL, N'judicial', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat27, 'fill_blank', N'Congress, which makes laws, is made up of the Senate and the ___.', NULL, N'House of Representatives', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat27, 'fill_blank', N'The head of the executive branch is the ___.', NULL, N'President', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat27, 'fill_blank', N'The highest court in the judicial branch is the ___.', NULL, N'Supreme Court', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat27, 'fill_blank', N'The document that outlines the structure and laws of the U.S. government is called the ___.', NULL, N'Constitution', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat27, 'fill_blank', N'The system where power is divided among three branches so no one branch becomes too powerful is called ___.', NULL, N'checks and balances (separation of powers)', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat27, 'fill_blank', N'The first ten amendments to the Constitution, which protect individual freedoms, are called the ___.', NULL, N'Bill of Rights', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat27, 'fill_blank', N'How many branches does the U.S. federal government have?', NULL, N'three', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat27, 'fill_blank', N'The judicial branch is made up mainly of ___.', NULL, N'courts and judges', 11);

-- 28. Economics: Producers, Consumers & Scarcity (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat28, 'fill_blank', N'A business or person that makes goods or provides services is called a ___.', NULL, N'producer', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat28, 'fill_blank', N'A person who buys and uses goods or services is called a ___.', NULL, N'consumer', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat28, 'fill_blank', N'When there is not enough of a resource to meet everyone''s wants, this is called ___.', NULL, N'scarcity', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat28, 'fill_blank', N'Choosing one thing over another because you cannot have both is called making a ___.', NULL, N'trade-off (choice)', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat28, 'fill_blank', N'The thing you give up when you make a choice is called the ___.', NULL, N'opportunity cost', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat28, 'fill_blank', N'The amount of a good that producers are willing to sell is called the ___.', NULL, N'supply', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat28, 'fill_blank', N'The amount of a good that consumers want to buy is called the ___.', NULL, N'demand', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat28, 'fill_blank', N'When supply is low and demand is high, prices usually ___.', NULL, N'go up (increase)', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat28, 'fill_blank', N'When supply is high and demand is low, prices usually ___.', NULL, N'go down (decrease)', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat28, 'fill_blank', N'Trading goods or services without using money is called ___.', NULL, N'bartering', 10);

-- 29. Word Search Puzzle (1 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat29, 'word_search', N'Find these words: DECIMAL, FRACTION, VOLUME, ECOSYSTEM, PRODUCER, CONSUMER, SCARCITY, PATRIOT', NULL, N'DECIMAL, FRACTION, VOLUME, ECOSYSTEM, PRODUCER, CONSUMER, SCARCITY, PATRIOT', 1);

-- 30. Logic Grid Puzzle (1 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g5cat30, 'short_response', N'Jack, Mia, Theo, and Zara each play a different sport: basketball, soccer, tennis, or swimming. Use the clues to figure out who plays what. Clue 1: Jack''s sport does not take place in water. Clue 2: Mia''s sport is played in a pool. Clue 3: Theo''s sport uses a racket. Clue 4: Zara does not play soccer. Who plays what?', NULL, N'Mia: swimming, Theo: tennis, Zara: basketball, Jack: soccer', 1);

END
GO
