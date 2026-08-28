-- 47_grade2_week1_content.sql
-- Grade 2, Week 1 practice-packet content bank — transcribed from the
-- "Little Scholar Hub" template (30 categories, 273 questions), matching
-- the ABC Unified Grade 2 category list. See gen_grade2_seed.py for the
-- generator source used to produce the INSERTs below.

IF NOT EXISTS (SELECT 1 FROM dbo.PacketCategories WHERE grade_id = 3)
BEGIN
DECLARE @g2cat1 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (3, 'math', N'Addition Within 100 (Regrouping)', 'short_answer', 10, NULL);
SET @g2cat1 = SCOPE_IDENTITY();

DECLARE @g2cat2 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (3, 'math', N'Subtraction Within 100 (Regrouping)', 'short_answer', 10, NULL);
SET @g2cat2 = SCOPE_IDENTITY();

DECLARE @g2cat3 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (3, 'math', N'Skip Counting Patterns', 'short_answer', 10, NULL);
SET @g2cat3 = SCOPE_IDENTITY();

DECLARE @g2cat4 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (3, 'math', N'Odd and Even Numbers', 'short_answer', 10, NULL);
SET @g2cat4 = SCOPE_IDENTITY();

DECLARE @g2cat5 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (3, 'math', N'Fact Families', 'space_heavy', 10, NULL);
SET @g2cat5 = SCOPE_IDENTITY();

DECLARE @g2cat6 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (3, 'math', N'Comparing 3-Digit Numbers', 'short_answer', 10, NULL);
SET @g2cat6 = SCOPE_IDENTITY();

DECLARE @g2cat7 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (3, 'math', N'Rounding to the Nearest Ten', 'short_answer', 10, NULL);
SET @g2cat7 = SCOPE_IDENTITY();

DECLARE @g2cat8 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (3, 'math', N'Number Patterns', 'short_answer', 10, NULL);
SET @g2cat8 = SCOPE_IDENTITY();

DECLARE @g2cat9 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (3, 'math', N'Ordering Numbers', 'short_answer', 10, NULL);
SET @g2cat9 = SCOPE_IDENTITY();

DECLARE @g2cat10 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (3, 'ela', N'Vocabulary in Context', 'short_answer', 10, N'Word Bank: harvest, shelter, journey, brittle, gather, shimmer, burrow, cautious, enormous, bundle');
SET @g2cat10 = SCOPE_IDENTITY();

DECLARE @g2cat11 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (3, 'ela', N'Synonyms & Antonyms', 'short_answer', 10, NULL);
SET @g2cat11 = SCOPE_IDENTITY();

DECLARE @g2cat12 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (3, 'ela', N'Homophones', 'short_answer', 10, NULL);
SET @g2cat12 = SCOPE_IDENTITY();

DECLARE @g2cat13 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (3, 'ela', N'Prefixes & Suffixes', 'short_answer', 10, NULL);
SET @g2cat13 = SCOPE_IDENTITY();

DECLARE @g2cat14 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (3, 'ela', N'Compound Words', 'short_answer', 10, NULL);
SET @g2cat14 = SCOPE_IDENTITY();

DECLARE @g2cat15 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (3, 'ela', N'Contractions', 'short_answer', 10, NULL);
SET @g2cat15 = SCOPE_IDENTITY();

DECLARE @g2cat16 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (3, 'ela', N'Possessive Nouns', 'short_answer', 10, NULL);
SET @g2cat16 = SCOPE_IDENTITY();

DECLARE @g2cat17 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (3, 'ela', N'Multiple-Meaning Words', 'space_heavy', 10, N'Write one sentence using each word below (use the back of the page if needed).');
SET @g2cat17 = SCOPE_IDENTITY();

DECLARE @g2cat18 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (3, 'science', N'Matter: Solids, Liquids & Gases', 'short_answer', 10, NULL);
SET @g2cat18 = SCOPE_IDENTITY();

DECLARE @g2cat19 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (3, 'science', N'The Water Cycle', 'short_answer', 10, NULL);
SET @g2cat19 = SCOPE_IDENTITY();

DECLARE @g2cat20 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (3, 'social_studies', N'Map Skills', 'short_answer', 10, NULL);
SET @g2cat20 = SCOPE_IDENTITY();

DECLARE @g2cat21 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (3, 'social_studies', N'Goods and Services', 'short_answer', 10, NULL);
SET @g2cat21 = SCOPE_IDENTITY();

DECLARE @g2cat22 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (3, 'math', N'Money Word Problems', 'space_heavy', 8, NULL);
SET @g2cat22 = SCOPE_IDENTITY();

DECLARE @g2cat23 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (3, 'math', N'Two-Step Word Problems', 'space_heavy', 6, NULL);
SET @g2cat23 = SCOPE_IDENTITY();

DECLARE @g2cat24 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (3, 'ela', N'Reading Comprehension: Main Idea & Details', 'space_heavy', 6, N'The Busy Beaver Family

Beavers are excellent builders. A beaver family works together to build a dam across a stream using sticks, mud, and rocks. The dam creates a pond of calm water where the beavers can build their home, called a lodge. The lodge has an underwater entrance so predators cannot easily get inside.

Beavers are most active at night and at dawn. During the day, they usually rest inside their lodge. In the fall, beavers work extra hard to store branches underwater near their lodge. This food supply helps the family survive through the cold winter months when the pond freezes over and they cannot leave to find food.

A beaver''s front teeth never stop growing. This is helpful because beavers wear their teeth down constantly by chewing through wood. Without this constant growth, a beaver''s teeth would wear away completely!');
SET @g2cat24 = SCOPE_IDENTITY();

DECLARE @g2cat25 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (3, 'ela', N'Cause and Effect', 'space_heavy', 6, N'A Change in the Weather

On Saturday morning, the sky was bright blue and the sun felt warm on Mia''s shoulders. She and her brother Leo decided to ride their bikes to the park. Halfway there, dark clouds rolled in quickly. The wind picked up, and the temperature dropped. Because the sky had turned so dark, Mia and Leo turned their bikes around and pedaled home as fast as they could. Just as they reached their front door, big raindrops began to fall. They made it inside just in time, laughing and a little out of breath.');
SET @g2cat25 = SCOPE_IDENTITY();

DECLARE @g2cat26 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (3, 'writing', N'Narrative Writing', 'space_heavy', 10, N'Plan your story below, then write it on a separate sheet or the back of this page.');
SET @g2cat26 = SCOPE_IDENTITY();

DECLARE @g2cat27 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (3, 'writing', N'Opinion Writing', 'space_heavy', 10, N'Plan your opinion piece below, then write it on a separate sheet or the back of this page.');
SET @g2cat27 = SCOPE_IDENTITY();

DECLARE @g2cat28 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (3, 'social_studies', N'Government Roles: Local, State & National', 'space_heavy', 6, N'Answer in complete sentences.');
SET @g2cat28 = SCOPE_IDENTITY();

DECLARE @g2cat29 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (3, 'puzzle', N'Word Search Puzzle', 'puzzle', 1, NULL);
SET @g2cat29 = SCOPE_IDENTITY();

DECLARE @g2cat30 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (3, 'puzzle', N'Brain Teaser Riddles', 'short_answer', 10, NULL);
SET @g2cat30 = SCOPE_IDENTITY();

-- 1. Addition Within 100 (Regrouping) (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat1, 'fill_blank', N'26
+19', NULL, N'45', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat1, 'fill_blank', N'31
+52', NULL, N'83', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat1, 'fill_blank', N'64
+32', NULL, N'96', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat1, 'fill_blank', N'57
+21', NULL, N'78', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat1, 'fill_blank', N'82
+11', NULL, N'93', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat1, 'fill_blank', N'34
+58', NULL, N'92', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat1, 'fill_blank', N'69
+27', NULL, N'96', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat1, 'fill_blank', N'57
+25', NULL, N'82', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat1, 'fill_blank', N'80
+12', NULL, N'92', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat1, 'fill_blank', N'35
+55', NULL, N'90', 10);

-- 2. Subtraction Within 100 (Regrouping) (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat2, 'fill_blank', N'60
-35', NULL, N'25', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat2, 'fill_blank', N'75
-28', NULL, N'47', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat2, 'fill_blank', N'89
-66', NULL, N'23', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat2, 'fill_blank', N'33
-29', NULL, N'4', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat2, 'fill_blank', N'79
-33', NULL, N'46', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat2, 'fill_blank', N'80
-75', NULL, N'5', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat2, 'fill_blank', N'36
-25', NULL, N'11', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat2, 'fill_blank', N'65
-35', NULL, N'30', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat2, 'fill_blank', N'62
-55', NULL, N'7', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat2, 'fill_blank', N'82
-70', NULL, N'12', 10);

-- 3. Skip Counting Patterns (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat3, 'fill_blank', N'170, 180, ___, 200, 210', NULL, N'190', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat3, 'fill_blank', N'14, 16, 18, ___, 22', NULL, N'20', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat3, 'fill_blank', N'60, 65, 70, ___, 80', NULL, N'75', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat3, 'fill_blank', N'0, 100, ___, 300, 400', NULL, N'200', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat3, 'fill_blank', N'300, 400, 500, ___, 700', NULL, N'600', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat3, 'fill_blank', N'15, ___, 25, 30, 35', NULL, N'20', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat3, 'fill_blank', N'100, 200, 300, ___, 500', NULL, N'400', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat3, 'fill_blank', N'100, ___, 300, 400, 500', NULL, N'200', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat3, 'fill_blank', N'100, 200, ___, 400, 500', NULL, N'300', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat3, 'fill_blank', N'75, 80, 85, ___, 95', NULL, N'90', 10);

-- 4. Odd and Even Numbers (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat4, 'multiple_choice', N'151', N'["Odd", "Even"]', N'Odd', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat4, 'multiple_choice', N'18', N'["Odd", "Even"]', N'Even', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat4, 'multiple_choice', N'637', N'["Odd", "Even"]', N'Odd', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat4, 'multiple_choice', N'704', N'["Odd", "Even"]', N'Even', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat4, 'multiple_choice', N'454', N'["Odd", "Even"]', N'Even', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat4, 'multiple_choice', N'503', N'["Odd", "Even"]', N'Odd', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat4, 'multiple_choice', N'269', N'["Odd", "Even"]', N'Odd', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat4, 'multiple_choice', N'535', N'["Odd", "Even"]', N'Odd', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat4, 'multiple_choice', N'589', N'["Odd", "Even"]', N'Odd', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat4, 'multiple_choice', N'187', N'["Odd", "Even"]', N'Odd', 10);

-- 5. Fact Families (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat5, 'short_response', N'Numbers: 31, 15, 46 → write the four related addition/subtraction facts.', NULL, N'31+15=46, 15+31=46, 46-31=15, 46-15=31', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat5, 'short_response', N'Numbers: 6, 24, 30 → write the four related addition/subtraction facts.', NULL, N'6+24=30, 24+6=30, 30-6=24, 30-24=6', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat5, 'short_response', N'Numbers: 2, 33, 35 → write the four related addition/subtraction facts.', NULL, N'2+33=35, 33+2=35, 35-2=33, 35-33=2', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat5, 'short_response', N'Numbers: 36, 6, 42 → write the four related addition/subtraction facts.', NULL, N'36+6=42, 6+36=42, 42-36=6, 42-6=36', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat5, 'short_response', N'Numbers: 39, 33, 72 → write the four related addition/subtraction facts.', NULL, N'39+33=72, 33+39=72, 72-39=33, 72-33=39', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat5, 'short_response', N'Numbers: 23, 31, 54 → write the four related addition/subtraction facts.', NULL, N'23+31=54, 31+23=54, 54-23=31, 54-31=23', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat5, 'short_response', N'Numbers: 19, 34, 53 → write the four related addition/subtraction facts.', NULL, N'19+34=53, 34+19=53, 53-19=34, 53-34=19', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat5, 'short_response', N'Numbers: 31, 3, 34 → write the four related addition/subtraction facts.', NULL, N'31+3=34, 3+31=34, 34-31=3, 34-3=31', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat5, 'short_response', N'Numbers: 7, 24, 31 → write the four related addition/subtraction facts.', NULL, N'7+24=31, 24+7=31, 31-7=24, 31-24=7', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat5, 'short_response', N'Numbers: 13, 27, 40 → write the four related addition/subtraction facts.', NULL, N'13+27=40, 27+13=40, 40-13=27, 40-27=13', 10);

-- 6. Comparing 3-Digit Numbers (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat6, 'fill_blank', N'361 ___ 791', NULL, N'<', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat6, 'fill_blank', N'740 ___ 906', NULL, N'<', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat6, 'fill_blank', N'953 ___ 984', NULL, N'<', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat6, 'fill_blank', N'836 ___ 238', NULL, N'>', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat6, 'fill_blank', N'155 ___ 266', NULL, N'<', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat6, 'fill_blank', N'611 ___ 490', NULL, N'>', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat6, 'fill_blank', N'575 ___ 791', NULL, N'<', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat6, 'fill_blank', N'401 ___ 259', NULL, N'>', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat6, 'fill_blank', N'110 ___ 389', NULL, N'<', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat6, 'fill_blank', N'670 ___ 578', NULL, N'>', 10);

-- 7. Rounding to the Nearest Ten (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat7, 'fill_blank', N'Round 12 to the nearest ten:', NULL, N'10', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat7, 'fill_blank', N'Round 386 to the nearest ten:', NULL, N'390', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat7, 'fill_blank', N'Round 45 to the nearest ten:', NULL, N'40', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat7, 'fill_blank', N'Round 561 to the nearest ten:', NULL, N'560', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat7, 'fill_blank', N'Round 881 to the nearest ten:', NULL, N'880', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat7, 'fill_blank', N'Round 402 to the nearest ten:', NULL, N'400', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat7, 'fill_blank', N'Round 588 to the nearest ten:', NULL, N'590', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat7, 'fill_blank', N'Round 464 to the nearest ten:', NULL, N'460', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat7, 'fill_blank', N'Round 220 to the nearest ten:', NULL, N'220', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat7, 'fill_blank', N'Round 902 to the nearest ten:', NULL, N'900', 10);

-- 8. Number Patterns (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat8, 'fill_blank', N'24, 22, 20, 18, ___', NULL, N'16', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat8, 'fill_blank', N'46, 56, 66, 76, ___', NULL, N'86', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat8, 'fill_blank', N'35, 37, 39, 41, ___', NULL, N'43', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat8, 'fill_blank', N'39, 37, 35, 33, ___', NULL, N'31', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat8, 'fill_blank', N'24, 22, 20, 18, ___', NULL, N'16', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat8, 'fill_blank', N'21, 22, 23, 24, ___', NULL, N'25', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat8, 'fill_blank', N'24, 29, 34, 39, ___', NULL, N'44', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat8, 'fill_blank', N'46, 51, 56, 61, ___', NULL, N'66', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat8, 'fill_blank', N'46, 51, 56, 61, ___', NULL, N'66', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat8, 'fill_blank', N'30, 28, 26, 24, ___', NULL, N'22', 10);

-- 9. Ordering Numbers (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat9, 'short_response', N'540, 870, 952, 105 → least to greatest:', NULL, N'105, 540, 870, 952', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat9, 'short_response', N'530, 658, 225, 410 → least to greatest:', NULL, N'225, 410, 530, 658', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat9, 'short_response', N'620, 553, 878, 881 → least to greatest:', NULL, N'553, 620, 878, 881', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat9, 'short_response', N'163, 827, 526, 653 → least to greatest:', NULL, N'163, 526, 653, 827', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat9, 'short_response', N'101, 325, 51, 248 → least to greatest:', NULL, N'51, 101, 248, 325', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat9, 'short_response', N'982, 478, 584, 247 → least to greatest:', NULL, N'247, 478, 584, 982', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat9, 'short_response', N'545, 294, 72, 990 → least to greatest:', NULL, N'72, 294, 545, 990', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat9, 'short_response', N'124, 701, 848, 816 → least to greatest:', NULL, N'124, 701, 816, 848', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat9, 'short_response', N'398, 887, 383, 228 → least to greatest:', NULL, N'228, 383, 398, 887', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat9, 'short_response', N'336, 374, 89, 352 → least to greatest:', NULL, N'89, 336, 352, 374', 10);

-- 10. Vocabulary in Context (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat10, 'fill_blank', N'The farmers began the ___ once the corn turned golden.', NULL, N'harvest', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat10, 'fill_blank', N'The old dry leaves felt ___ and crumbled in her hand.', NULL, N'brittle', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat10, 'fill_blank', N'The rabbit dug a cozy ___ under the tree roots.', NULL, N'burrow', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat10, 'fill_blank', N'We packed a ___ of blankets to keep warm at the campsite.', NULL, N'bundle', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat10, 'fill_blank', N'The lake began to ___ as the sun rose over it.', NULL, N'shimmer', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat10, 'fill_blank', N'Dad built a small ___ to protect us from the rain.', NULL, N'shelter', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat10, 'fill_blank', N'The hikers were ___ as they crossed the narrow bridge.', NULL, N'cautious', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat10, 'fill_blank', N'It was an ___ elephant, much bigger than any I''d seen.', NULL, N'enormous', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat10, 'fill_blank', N'Our ___ to grandma''s house took almost five hours.', NULL, N'journey', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat10, 'fill_blank', N'Please help me ___ the toys before dinner.', NULL, N'gather', 10);

-- 11. Synonyms & Antonyms (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat11, 'short_response', N'happy (SYN)', NULL, N'joyful (sample answer)', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat11, 'short_response', N'large (SYN)', NULL, N'huge (sample answer)', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat11, 'short_response', N'fast (ANT)', NULL, N'slow (sample answer)', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat11, 'short_response', N'begin (ANT)', NULL, N'end (sample answer)', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat11, 'short_response', N'quiet (SYN)', NULL, N'silent (sample answer)', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat11, 'short_response', N'difficult (SYN)', NULL, N'hard (sample answer)', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat11, 'short_response', N'night (ANT)', NULL, N'day (sample answer)', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat11, 'short_response', N'wet (ANT)', NULL, N'dry (sample answer)', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat11, 'short_response', N'small (SYN)', NULL, N'tiny (sample answer)', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat11, 'short_response', N'brave (SYN)', NULL, N'courageous (sample answer)', 10);

-- 12. Homophones (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat12, 'multiple_choice', N'I can ___ the birds singing.', N'["here", "hear"]', N'hear', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat12, 'multiple_choice', N'Put the book over ___.', N'["their", "there"]', N'there', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat12, 'multiple_choice', N'The ___ is blowing hard today.', N'["wind", "wined"]', N'wind', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat12, 'multiple_choice', N'She ate a ___ pie for dessert.', N'["peace", "piece"]', N'piece', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat12, 'multiple_choice', N'We saw a ___ at the zoo.', N'["bear", "bare"]', N'bear', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat12, 'multiple_choice', N'Can you ___ me the salt?', N'["pass", "past"]', N'pass', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat12, 'multiple_choice', N'They went to the beach to ___ in the ocean.', N'["sea", "see"]', N'sea', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat12, 'multiple_choice', N'The ___ blew our hats off.', N'["wind", "whined"]', N'wind', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat12, 'multiple_choice', N'I have ___ dollars.', N'["to", "two", "too"]', N'two', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat12, 'multiple_choice', N'Is this book ___?', N'["yours", "your''s"]', N'yours', 10);

-- 13. Prefixes & Suffixes (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat13, 'fill_blank', N'un + happy =', NULL, N'unhappy', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat13, 'fill_blank', N're + play =', NULL, N'replay', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat13, 'fill_blank', N'care + ful =', NULL, N'careful', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat13, 'fill_blank', N'teach + er =', NULL, N'teacher', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat13, 'fill_blank', N'pre + view =', NULL, N'preview', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat13, 'fill_blank', N'help + less =', NULL, N'helpless', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat13, 'fill_blank', N'un + kind =', NULL, N'unkind', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat13, 'fill_blank', N'jump + ing =', NULL, N'jumping', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat13, 'fill_blank', N'dis + like =', NULL, N'dislike', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat13, 'fill_blank', N'quick + ly =', NULL, N'quickly', 10);

-- 14. Compound Words (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat14, 'fill_blank', N'sun + flower =', NULL, N'sunflower', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat14, 'fill_blank', N'rain + bow =', NULL, N'rainbow', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat14, 'fill_blank', N'back + pack =', NULL, N'backpack', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat14, 'fill_blank', N'butter + fly =', NULL, N'butterfly', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat14, 'fill_blank', N'foot + ball =', NULL, N'football', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat14, 'fill_blank', N'day + light =', NULL, N'daylight', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat14, 'fill_blank', N'snow + man =', NULL, N'snowman', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat14, 'fill_blank', N'star + fish =', NULL, N'starfish', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat14, 'fill_blank', N'basket + ball =', NULL, N'basketball', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat14, 'fill_blank', N'tooth + brush =', NULL, N'toothbrush', 10);

-- 15. Contractions (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat15, 'fill_blank', N'do not', NULL, N'don''t', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat15, 'fill_blank', N'I am', NULL, N'I''m', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat15, 'fill_blank', N'she will', NULL, N'she''ll', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat15, 'fill_blank', N'cannot', NULL, N'can''t', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat15, 'fill_blank', N'they are', NULL, N'they''re', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat15, 'fill_blank', N'we have', NULL, N'we''ve', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat15, 'fill_blank', N'is not', NULL, N'isn''t', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat15, 'fill_blank', N'you are', NULL, N'you''re', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat15, 'fill_blank', N'did not', NULL, N'didn''t', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat15, 'fill_blank', N'it is', NULL, N'it''s', 10);

-- 16. Possessive Nouns (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat16, 'short_response', N'Rewrite using a possessive noun: the toy that belongs to the dog', NULL, N'the dog''s toy', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat16, 'short_response', N'Rewrite using a possessive noun: the hat that belongs to Sam', NULL, N'Sam''s hat', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat16, 'short_response', N'Rewrite using a possessive noun: the tails of the two cats', NULL, N'the cats'' tails', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat16, 'short_response', N'Rewrite using a possessive noun: the bike that belongs to my sister', NULL, N'my sister''s bike', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat16, 'short_response', N'Rewrite using a possessive noun: the nest that belongs to the bird', NULL, N'the bird''s nest', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat16, 'short_response', N'Rewrite using a possessive noun: the shoes that belong to the boys', NULL, N'the boys'' shoes', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat16, 'short_response', N'Rewrite using a possessive noun: the car that belongs to Mr. Lee', NULL, N'Mr. Lee''s car', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat16, 'short_response', N'Rewrite using a possessive noun: the pencils that belong to the students', NULL, N'the students'' pencils', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat16, 'short_response', N'Rewrite using a possessive noun: the collar that belongs to the puppy', NULL, N'the puppy''s collar', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat16, 'short_response', N'Rewrite using a possessive noun: the office that belongs to the teacher', NULL, N'the teacher''s office', 10);

-- 17. Multiple-Meaning Words (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat17, 'short_response', N'bat — an animal that flies at night / equipment used to hit a ball', NULL, N'Answers will vary — check that each meaning is used correctly.', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat17, 'short_response', N'bark — the sound a dog makes / the outer covering of a tree', NULL, N'Answers will vary — check that each meaning is used correctly.', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat17, 'short_response', N'light — not heavy / something that helps you see', NULL, N'Answers will vary — check that each meaning is used correctly.', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat17, 'short_response', N'watch — to look at something / a device you wear to tell time', NULL, N'Answers will vary — check that each meaning is used correctly.', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat17, 'short_response', N'bank — a place that keeps money / the side of a river', NULL, N'Answers will vary — check that each meaning is used correctly.', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat17, 'short_response', N'ring — a piece of jewelry / the sound a bell makes', NULL, N'Answers will vary — check that each meaning is used correctly.', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat17, 'short_response', N'trunk — part of an elephant / part of a tree / storage in a car', NULL, N'Answers will vary — check that each meaning is used correctly.', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat17, 'short_response', N'spring — a season / to jump / a coiled piece of metal', NULL, N'Answers will vary — check that each meaning is used correctly.', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat17, 'short_response', N'bat (as a verb) — try a new sentence using this word as a verb', NULL, N'Answers will vary — check that each meaning is used correctly.', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat17, 'short_response', N'fair — not stormy weather / an event with rides and games / treating people equally', NULL, N'Answers will vary — check that each meaning is used correctly.', 10);

-- 18. Matter: Solids, Liquids & Gases (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat18, 'multiple_choice', N'A solid has a shape that does not change on its own.', N'["True", "False"]', N'True', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat18, 'multiple_choice', N'A liquid takes the shape of its container.', N'["True", "False"]', N'True', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat18, 'multiple_choice', N'A gas has a definite shape and size.', N'["True", "False"]', N'False', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat18, 'multiple_choice', N'Ice is an example of a liquid.', N'["True", "False"]', N'False', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat18, 'multiple_choice', N'Water can be a solid, liquid, and gas.', N'["True", "False"]', N'True', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat18, 'multiple_choice', N'Melting is when a solid changes into a liquid.', N'["True", "False"]', N'True', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat18, 'multiple_choice', N'Freezing is when a liquid changes into a gas.', N'["True", "False"]', N'False', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat18, 'multiple_choice', N'Steam is an example of a gas.', N'["True", "False"]', N'True', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat18, 'multiple_choice', N'A rock is an example of a liquid.', N'["True", "False"]', N'False', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat18, 'multiple_choice', N'Evaporation is when a liquid changes into a gas.', N'["True", "False"]', N'True', 10);

-- 19. The Water Cycle (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat19, 'fill_blank', N'The sun heats water and turns it into vapor. This step is called ___.', NULL, N'evaporation', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat19, 'fill_blank', N'Water vapor cools and forms clouds. This step is called ___.', NULL, N'condensation', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat19, 'fill_blank', N'Water falls from clouds as rain or snow. This step is called ___.', NULL, N'precipitation', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat19, 'fill_blank', N'Water flows across the land back into rivers and lakes. This is called ___.', NULL, N'collection / runoff', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat19, 'fill_blank', N'The four main steps of the water cycle are evaporation, condensation, ___, and collection.', NULL, N'precipitation', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat19, 'fill_blank', N'Water vapor is water in its ___ state.', NULL, N'gas', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat19, 'fill_blank', N'Clouds are made of tiny drops of ___.', NULL, N'water', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat19, 'fill_blank', N'The water cycle repeats over and over — this is called a ___.', NULL, N'cycle', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat19, 'fill_blank', N'Plants release water vapor into the air through a process called ___.', NULL, N'transpiration', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat19, 'fill_blank', N'Where does most of Earth''s evaporation come from?', NULL, N'oceans', 10);

-- 20. Map Skills (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat20, 'fill_blank', N'A ___ shows what symbols on a map mean.', NULL, N'map key / legend', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat20, 'fill_blank', N'The ___ shows directions: north, south, east, west.', NULL, N'compass rose', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat20, 'fill_blank', N'The ___ tells you how map distance compares to real distance.', NULL, N'scale', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat20, 'fill_blank', N'A map that shows roads and cities is called a ___ map.', NULL, N'political / road', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat20, 'fill_blank', N'A map that shows mountains and rivers is called a ___ map.', NULL, N'physical', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat20, 'fill_blank', N'On most maps, north is at the ___ of the page.', NULL, N'top', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat20, 'fill_blank', N'A body of water is often shown in the color ___.', NULL, N'blue', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat20, 'fill_blank', N'The symbol for a capital city is often a ___.', NULL, N'star', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat20, 'fill_blank', N'If you are facing north, east is to your ___.', NULL, N'right', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat20, 'fill_blank', N'A globe is a model of the ___.', NULL, N'Earth', 10);

-- 21. Goods and Services (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat21, 'multiple_choice', N'A haircut', N'["Good", "Service"]', N'Service', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat21, 'multiple_choice', N'A loaf of bread', N'["Good", "Service"]', N'Good', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat21, 'multiple_choice', N'A dentist checking your teeth', N'["Good", "Service"]', N'Service', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat21, 'multiple_choice', N'A bicycle', N'["Good", "Service"]', N'Good', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat21, 'multiple_choice', N'A teacher giving a lesson', N'["Good", "Service"]', N'Service', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat21, 'multiple_choice', N'A backpack', N'["Good", "Service"]', N'Good', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat21, 'multiple_choice', N'A mail carrier delivering letters', N'["Good", "Service"]', N'Service', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat21, 'multiple_choice', N'An apple', N'["Good", "Service"]', N'Good', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat21, 'multiple_choice', N'A mechanic fixing a car', N'["Good", "Service"]', N'Service', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat21, 'multiple_choice', N'A toy truck', N'["Good", "Service"]', N'Good', 10);

-- 22. Money Word Problems (8 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat22, 'short_response', N'Maria has 3 quarters, 2 dimes, and 1 nickel. How much money does she have in all?', NULL, N'$1.00', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat22, 'short_response', N'A pencil costs 45 cents. Ben pays with a dollar. How much change should he get back?', NULL, N'$0.55', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat22, 'short_response', N'Josh has 4 dimes and 6 pennies. How much money does he have?', NULL, N'$0.46', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat22, 'short_response', N'A sticker costs 25 cents. How many stickers can you buy with $1.00?', NULL, N'4 stickers', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat22, 'short_response', N'Ana saved $2.35 last week and $1.50 this week. How much has she saved in all?', NULL, N'$3.85', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat22, 'short_response', N'A toy car costs $3.75. You give the cashier a $5 bill. How much change do you get?', NULL, N'$1.25', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat22, 'short_response', N'Sam has 2 quarters and 3 nickels. How much money does he have?', NULL, N'$0.65', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat22, 'short_response', N'Lily wants to buy a book for $6.20. She has $4.85. How much more does she need?', NULL, N'$1.35', 8);

-- 23. Two-Step Word Problems (6 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat23, 'short_response', N'There were 48 apples in a basket. The store sold 19 in the morning and 12 in the afternoon. How many apples are left?', NULL, N'17', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat23, 'short_response', N'A class has 24 students. 8 students went on a field trip and 5 more stayed home sick. How many students are in class today?', NULL, N'11', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat23, 'short_response', N'Ravi read 15 pages on Monday and 23 pages on Tuesday. He needs to read 50 pages total. How many more pages does he need to read?', NULL, N'12', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat23, 'short_response', N'A farmer had 65 eggs. He sold 28 in the morning and collected 14 more in the afternoon. How many eggs does he have now?', NULL, N'51', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat23, 'short_response', N'There were 37 birds in a tree. 9 flew away, then 16 more landed in the tree. How many birds are in the tree now?', NULL, N'44', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat23, 'short_response', N'Emma has 52 stickers. She gives 18 to her sister and buys 20 more. How many stickers does she have now?', NULL, N'54', 6);

-- 24. Reading Comprehension: Main Idea & Details (6 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat24, 'short_response', N'What is the main idea of this passage?', NULL, N'How beavers build and live in their homes', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat24, 'short_response', N'What materials do beavers use to build a dam?', NULL, N'Sticks, mud, and rocks', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat24, 'short_response', N'Why does the lodge have an underwater entrance?', NULL, N'So predators cannot easily get inside', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat24, 'short_response', N'When are beavers most active?', NULL, N'At night and at dawn', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat24, 'short_response', N'Why do beavers store branches underwater in the fall?', NULL, N'To have food for winter when the pond freezes', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat24, 'short_response', N'Why don''t a beaver''s teeth wear away completely?', NULL, N'Because their front teeth never stop growing', 6);

-- 25. Cause and Effect (6 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat25, 'short_response', N'What caused Mia and Leo to turn their bikes around?', NULL, N'The dark clouds rolling in / the sky turning dark', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat25, 'short_response', N'What effect did the dropping temperature have on the story?', NULL, N'It signaled a storm was coming', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat25, 'short_response', N'What happened right after they reached their front door?', NULL, N'Big raindrops began to fall', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat25, 'short_response', N'Why were Mia and Leo laughing at the end?', NULL, N'Because they made it inside just in time / out of breath from running', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat25, 'short_response', N'What effect did the wind picking up have on the children?', NULL, N'It warned them a change in weather was happening', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat25, 'short_response', N'What was the cause of Mia and Leo feeling out of breath?', NULL, N'Pedaling home as fast as they could', 6);

-- 26. Narrative Writing (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat26, 'short_response', N'Who is the main character in your story?', NULL, N'Open response — check story has character, setting, problem, and solution.', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat26, 'short_response', N'Where does your story take place?', NULL, N'Open response — check story has character, setting, problem, and solution.', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat26, 'short_response', N'When does your story happen (day, season, time)?', NULL, N'Open response — check story has character, setting, problem, and solution.', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat26, 'short_response', N'What problem does your character face?', NULL, N'Open response — check story has character, setting, problem, and solution.', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat26, 'short_response', N'Who else is in your story with your character?', NULL, N'Open response — check story has character, setting, problem, and solution.', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat26, 'short_response', N'What happens first in your story?', NULL, N'Open response — check story has character, setting, problem, and solution.', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat26, 'short_response', N'What happens next?', NULL, N'Open response — check story has character, setting, problem, and solution.', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat26, 'short_response', N'How does your character solve the problem?', NULL, N'Open response — check story has character, setting, problem, and solution.', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat26, 'short_response', N'How does your story end?', NULL, N'Open response — check story has character, setting, problem, and solution.', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat26, 'short_response', N'What is one describing word (adjective) you will use in your story?', NULL, N'Open response — check story has character, setting, problem, and solution.', 10);

-- 27. Opinion Writing (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat27, 'short_response', N'What is your opinion? (Example: My favorite season is...)', NULL, N'Open response — check for a clear opinion, reasons, and examples.', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat27, 'short_response', N'What is your first reason for this opinion?', NULL, N'Open response — check for a clear opinion, reasons, and examples.', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat27, 'short_response', N'Can you give an example that supports your first reason?', NULL, N'Open response — check for a clear opinion, reasons, and examples.', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat27, 'short_response', N'What is your second reason for this opinion?', NULL, N'Open response — check for a clear opinion, reasons, and examples.', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat27, 'short_response', N'Can you give an example that supports your second reason?', NULL, N'Open response — check for a clear opinion, reasons, and examples.', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat27, 'short_response', N'What is your third reason for this opinion?', NULL, N'Open response — check for a clear opinion, reasons, and examples.', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat27, 'short_response', N'What word can you use to introduce your reasons (First, Also, Finally)?', NULL, N'Open response — check for a clear opinion, reasons, and examples.', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat27, 'short_response', N'How could you restate your opinion in your closing sentence?', NULL, N'Open response — check for a clear opinion, reasons, and examples.', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat27, 'short_response', N'Who is your audience for this writing (who will read it)?', NULL, N'Open response — check for a clear opinion, reasons, and examples.', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat27, 'short_response', N'What is the title of your opinion piece?', NULL, N'Open response — check for a clear opinion, reasons, and examples.', 10);

-- 28. Government Roles: Local, State & National (6 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat28, 'short_response', N'What is one job of a mayor in a city?', NULL, N'Open response — check for accurate role descriptions (mayor: city leader; governor: state leader; President: national leader).', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat28, 'short_response', N'What is one job of the governor of a state?', NULL, N'Open response — check for accurate role descriptions (mayor: city leader; governor: state leader; President: national leader).', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat28, 'short_response', N'What is one job of the President of the United States?', NULL, N'Open response — check for accurate role descriptions (mayor: city leader; governor: state leader; President: national leader).', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat28, 'short_response', N'Why do communities need rules and laws?', NULL, N'Open response — check for accurate role descriptions (mayor: city leader; governor: state leader; President: national leader).', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat28, 'short_response', N'Name one way local government helps your neighborhood.', NULL, N'Open response — check for accurate role descriptions (mayor: city leader; governor: state leader; President: national leader).', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat28, 'short_response', N'What is the difference between local and national government?', NULL, N'Open response — check for accurate role descriptions (mayor: city leader; governor: state leader; President: national leader).', 6);

-- 29. Word Search Puzzle (1 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat29, 'word_search', N'Find these words: HARVEST, SHELTER, JOURNEY, BRITTLE, GATHER, SHIMMER, BURROW, CAUTIOUS, ENORMOUS, BUNDLE', NULL, N'HARVEST, SHELTER, JOURNEY, BRITTLE, GATHER, SHIMMER, BURROW, CAUTIOUS, ENORMOUS, BUNDLE', 1);

-- 30. Brain Teaser Riddles (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat30, 'fill_blank', N'I have hands but cannot clap. What am I?', NULL, N'A clock', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat30, 'fill_blank', N'What has to be broken before you can use it?', NULL, N'An egg', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat30, 'fill_blank', N'The more you take, the more you leave behind. What am I?', NULL, N'Footsteps', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat30, 'fill_blank', N'What has a head and a tail but no body?', NULL, N'A coin', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat30, 'fill_blank', N'What gets wetter the more it dries?', NULL, N'A towel', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat30, 'fill_blank', N'What has many keys but can''t open a single door?', NULL, N'A piano', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat30, 'fill_blank', N'What month of the year has 28 days?', NULL, N'All of them', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat30, 'fill_blank', N'What goes up but never comes down?', NULL, N'Your age', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat30, 'fill_blank', N'What has one eye but cannot see?', NULL, N'A needle', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g2cat30, 'fill_blank', N'What can you catch but not throw?', NULL, N'A cold', 10);

END
GO
