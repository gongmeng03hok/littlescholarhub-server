-- 49_grade1_content.sql
-- Grade 1, content bank — 30 original categories drawn from the ABC
-- Unified Grade 1 category list (Math/ELA/Writing/Science/Social
-- Studies/Puzzle). Most categories carry more questions than their
-- target_count so usp_GetOrCreateWeeklyPacket's random sampling actually
-- varies week to week. See gen_grade1_seed.py for the generator source.

IF NOT EXISTS (SELECT 1 FROM dbo.PacketCategories WHERE grade_id = 2)
BEGIN
DECLARE @g1cat1 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (2, 'math', N'Addition Within 20', 'short_answer', 10, NULL);
SET @g1cat1 = SCOPE_IDENTITY();

DECLARE @g1cat2 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (2, 'math', N'Subtraction Within 20', 'short_answer', 10, NULL);
SET @g1cat2 = SCOPE_IDENTITY();

DECLARE @g1cat3 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (2, 'math', N'Fact Families', 'space_heavy', 8, NULL);
SET @g1cat3 = SCOPE_IDENTITY();

DECLARE @g1cat4 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (2, 'math', N'Doubles Facts', 'short_answer', 10, NULL);
SET @g1cat4 = SCOPE_IDENTITY();

DECLARE @g1cat5 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (2, 'math', N'Place Value: Tens and Ones', 'short_answer', 10, NULL);
SET @g1cat5 = SCOPE_IDENTITY();

DECLARE @g1cat6 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (2, 'math', N'Comparing Two-Digit Numbers', 'short_answer', 10, NULL);
SET @g1cat6 = SCOPE_IDENTITY();

DECLARE @g1cat7 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (2, 'math', N'Skip Counting by 2s, 5s, 10s', 'short_answer', 8, NULL);
SET @g1cat7 = SCOPE_IDENTITY();

DECLARE @g1cat8 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (2, 'math', N'Telling Time to the Hour/Half Hour', 'short_answer', 8, NULL);
SET @g1cat8 = SCOPE_IDENTITY();

DECLARE @g1cat9 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (2, 'math', N'Counting Money (Pennies, Nickels, Dimes)', 'short_answer', 8, NULL);
SET @g1cat9 = SCOPE_IDENTITY();

DECLARE @g1cat10 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (2, 'math', N'Number and Shape Patterns', 'short_answer', 10, NULL);
SET @g1cat10 = SCOPE_IDENTITY();

DECLARE @g1cat11 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (2, 'math', N'Word Problems (Addition/Subtraction Within 20)', 'space_heavy', 6, NULL);
SET @g1cat11 = SCOPE_IDENTITY();

DECLARE @g1cat12 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (2, 'ela', N'Short Vowel Words', 'short_answer', 10, NULL);
SET @g1cat12 = SCOPE_IDENTITY();

DECLARE @g1cat13 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (2, 'ela', N'Long Vowel Words (Silent E)', 'short_answer', 8, NULL);
SET @g1cat13 = SCOPE_IDENTITY();

DECLARE @g1cat14 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (2, 'ela', N'Consonant Blends', 'short_answer', 8, NULL);
SET @g1cat14 = SCOPE_IDENTITY();

DECLARE @g1cat15 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (2, 'ela', N'Sight Word Fluency', 'short_answer', 10, NULL);
SET @g1cat15 = SCOPE_IDENTITY();

DECLARE @g1cat16 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (2, 'ela', N'Compound Words', 'short_answer', 10, NULL);
SET @g1cat16 = SCOPE_IDENTITY();

DECLARE @g1cat17 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (2, 'ela', N'Contractions', 'short_answer', 10, NULL);
SET @g1cat17 = SCOPE_IDENTITY();

DECLARE @g1cat18 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (2, 'ela', N'Synonyms and Antonyms', 'short_answer', 10, NULL);
SET @g1cat18 = SCOPE_IDENTITY();

DECLARE @g1cat19 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (2, 'ela', N'Common and Proper Nouns', 'short_answer', 10, NULL);
SET @g1cat19 = SCOPE_IDENTITY();

DECLARE @g1cat20 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (2, 'ela', N'Action Verbs', 'short_answer', 10, NULL);
SET @g1cat20 = SCOPE_IDENTITY();

DECLARE @g1cat21 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (2, 'ela', N'Reading Comprehension: Main Idea & Details', 'space_heavy', 5, N'The Lost Mitten

Ben lost his blue mitten on the walk to school. First, he checked his backpack, but it wasn''t there. Next, he asked his friend Mia if she''d seen it. Then, Mia remembered seeing it fall near the big oak tree. Finally, they walked back together and found the mitten sitting right on a root, waiting for him.');
SET @g1cat21 = SCOPE_IDENTITY();

DECLARE @g1cat22 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (2, 'writing', N'Narrative Writing', 'space_heavy', 8, N'Plan your story below, then write it on a separate sheet or the back of this page.');
SET @g1cat22 = SCOPE_IDENTITY();

DECLARE @g1cat23 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (2, 'writing', N'Opinion Writing', 'space_heavy', 8, N'Plan your opinion piece below, then write it on a separate sheet or the back of this page.');
SET @g1cat23 = SCOPE_IDENTITY();

DECLARE @g1cat24 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (2, 'science', N'Plant Life Cycle', 'short_answer', 8, NULL);
SET @g1cat24 = SCOPE_IDENTITY();

DECLARE @g1cat25 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (2, 'science', N'Weather and Seasons', 'short_answer', 8, NULL);
SET @g1cat25 = SCOPE_IDENTITY();

DECLARE @g1cat26 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (2, 'social_studies', N'Map Symbols and Keys', 'short_answer', 8, NULL);
SET @g1cat26 = SCOPE_IDENTITY();

DECLARE @g1cat27 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (2, 'social_studies', N'Needs vs. Wants', 'short_answer', 10, NULL);
SET @g1cat27 = SCOPE_IDENTITY();

DECLARE @g1cat28 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (2, 'social_studies', N'Rules and Responsibilities', 'space_heavy', 5, NULL);
SET @g1cat28 = SCOPE_IDENTITY();

DECLARE @g1cat29 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (2, 'puzzle', N'Word Search Puzzle', 'puzzle', 1, NULL);
SET @g1cat29 = SCOPE_IDENTITY();

DECLARE @g1cat30 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (2, 'puzzle', N'Brain Teaser Riddles', 'short_answer', 8, NULL);
SET @g1cat30 = SCOPE_IDENTITY();

-- 1. Addition Within 20 (14 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat1, 'fill_blank', N'4 + 15 = ___', NULL, N'19', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat1, 'fill_blank', N'6 + 8 = ___', NULL, N'14', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat1, 'fill_blank', N'1 + 11 = ___', NULL, N'12', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat1, 'fill_blank', N'9 + 4 = ___', NULL, N'13', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat1, 'fill_blank', N'10 + 4 = ___', NULL, N'14', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat1, 'fill_blank', N'15 + 5 = ___', NULL, N'20', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat1, 'fill_blank', N'8 + 12 = ___', NULL, N'20', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat1, 'fill_blank', N'13 + 4 = ___', NULL, N'17', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat1, 'fill_blank', N'6 + 8 = ___', NULL, N'14', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat1, 'fill_blank', N'2 + 5 = ___', NULL, N'7', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat1, 'fill_blank', N'4 + 3 = ___', NULL, N'7', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat1, 'fill_blank', N'2 + 8 = ___', NULL, N'10', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat1, 'fill_blank', N'6 + 4 = ___', NULL, N'10', 13);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat1, 'fill_blank', N'6 + 4 = ___', NULL, N'10', 14);

-- 2. Subtraction Within 20 (14 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat2, 'fill_blank', N'17 - 13 = ___', NULL, N'4', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat2, 'fill_blank', N'11 - 1 = ___', NULL, N'10', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat2, 'fill_blank', N'18 - 14 = ___', NULL, N'4', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat2, 'fill_blank', N'14 - 3 = ___', NULL, N'11', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat2, 'fill_blank', N'8 - 5 = ___', NULL, N'3', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat2, 'fill_blank', N'13 - 6 = ___', NULL, N'7', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat2, 'fill_blank', N'17 - 7 = ___', NULL, N'10', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat2, 'fill_blank', N'18 - 2 = ___', NULL, N'16', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat2, 'fill_blank', N'17 - 13 = ___', NULL, N'4', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat2, 'fill_blank', N'5 - 3 = ___', NULL, N'2', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat2, 'fill_blank', N'11 - 8 = ___', NULL, N'3', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat2, 'fill_blank', N'8 - 5 = ___', NULL, N'3', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat2, 'fill_blank', N'5 - 2 = ___', NULL, N'3', 13);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat2, 'fill_blank', N'16 - 0 = ___', NULL, N'16', 14);

-- 3. Fact Families (8 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat3, 'short_response', N'Numbers: 6, 11, 17 → write the four related addition/subtraction facts.', NULL, N'6+11=17, 11+6=17, 17-6=11, 17-11=6', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat3, 'short_response', N'Numbers: 4, 2, 6 → write the four related addition/subtraction facts.', NULL, N'4+2=6, 2+4=6, 6-4=2, 6-2=4', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat3, 'short_response', N'Numbers: 8, 4, 12 → write the four related addition/subtraction facts.', NULL, N'8+4=12, 4+8=12, 12-8=4, 12-4=8', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat3, 'short_response', N'Numbers: 6, 3, 9 → write the four related addition/subtraction facts.', NULL, N'6+3=9, 3+6=9, 9-6=3, 9-3=6', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat3, 'short_response', N'Numbers: 4, 8, 12 → write the four related addition/subtraction facts.', NULL, N'4+8=12, 8+4=12, 12-4=8, 12-8=4', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat3, 'short_response', N'Numbers: 12, 7, 19 → write the four related addition/subtraction facts.', NULL, N'12+7=19, 7+12=19, 19-12=7, 19-7=12', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat3, 'short_response', N'Numbers: 12, 11, 23 → write the four related addition/subtraction facts.', NULL, N'12+11=23, 11+12=23, 23-12=11, 23-11=12', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat3, 'short_response', N'Numbers: 9, 4, 13 → write the four related addition/subtraction facts.', NULL, N'9+4=13, 4+9=13, 13-9=4, 13-4=9', 8);

-- 4. Doubles Facts (12 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat4, 'fill_blank', N'9 + 9 = ___ (a doubles fact)', NULL, N'18', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat4, 'fill_blank', N'10 + 10 = ___ (a doubles fact)', NULL, N'20', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat4, 'fill_blank', N'6 + 6 = ___ (a doubles fact)', NULL, N'12', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat4, 'fill_blank', N'4 + 4 = ___ (a doubles fact)', NULL, N'8', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat4, 'fill_blank', N'10 + 10 = ___ (a doubles fact)', NULL, N'20', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat4, 'fill_blank', N'2 + 2 = ___ (a doubles fact)', NULL, N'4', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat4, 'fill_blank', N'3 + 3 = ___ (a doubles fact)', NULL, N'6', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat4, 'fill_blank', N'3 + 3 = ___ (a doubles fact)', NULL, N'6', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat4, 'fill_blank', N'2 + 2 = ___ (a doubles fact)', NULL, N'4', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat4, 'fill_blank', N'7 + 7 = ___ (a doubles fact)', NULL, N'14', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat4, 'fill_blank', N'10 + 10 = ___ (a doubles fact)', NULL, N'20', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat4, 'fill_blank', N'9 + 9 = ___ (a doubles fact)', NULL, N'18', 12);

-- 5. Place Value: Tens and Ones (12 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat5, 'fill_blank', N'26 = ___ tens and ___ ones', NULL, N'2 tens, 6 ones', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat5, 'fill_blank', N'97 = ___ tens and ___ ones', NULL, N'9 tens, 7 ones', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat5, 'fill_blank', N'89 = ___ tens and ___ ones', NULL, N'8 tens, 9 ones', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat5, 'fill_blank', N'88 = ___ tens and ___ ones', NULL, N'8 tens, 8 ones', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat5, 'fill_blank', N'69 = ___ tens and ___ ones', NULL, N'6 tens, 9 ones', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat5, 'fill_blank', N'92 = ___ tens and ___ ones', NULL, N'9 tens, 2 ones', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat5, 'fill_blank', N'28 = ___ tens and ___ ones', NULL, N'2 tens, 8 ones', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat5, 'fill_blank', N'98 = ___ tens and ___ ones', NULL, N'9 tens, 8 ones', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat5, 'fill_blank', N'33 = ___ tens and ___ ones', NULL, N'3 tens, 3 ones', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat5, 'fill_blank', N'36 = ___ tens and ___ ones', NULL, N'3 tens, 6 ones', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat5, 'fill_blank', N'81 = ___ tens and ___ ones', NULL, N'8 tens, 1 ones', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat5, 'fill_blank', N'68 = ___ tens and ___ ones', NULL, N'6 tens, 8 ones', 12);

-- 6. Comparing Two-Digit Numbers (12 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat6, 'fill_blank', N'27 ___ 20', NULL, N'>', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat6, 'fill_blank', N'29 ___ 49', NULL, N'<', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat6, 'fill_blank', N'53 ___ 58', NULL, N'<', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat6, 'fill_blank', N'18 ___ 17', NULL, N'>', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat6, 'fill_blank', N'80 ___ 98', NULL, N'<', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat6, 'fill_blank', N'54 ___ 69', NULL, N'<', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat6, 'fill_blank', N'17 ___ 34', NULL, N'<', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat6, 'fill_blank', N'45 ___ 96', NULL, N'<', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat6, 'fill_blank', N'51 ___ 21', NULL, N'>', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat6, 'fill_blank', N'45 ___ 29', NULL, N'>', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat6, 'fill_blank', N'42 ___ 69', NULL, N'<', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat6, 'fill_blank', N'36 ___ 64', NULL, N'<', 12);

-- 7. Skip Counting by 2s, 5s, 10s (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat7, 'fill_blank', N'2, 4, 6, ___, ___', NULL, N'8, 10', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat7, 'fill_blank', N'5, 10, 15, ___, ___', NULL, N'20, 25', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat7, 'fill_blank', N'10, 20, 30, ___, ___', NULL, N'40, 50', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat7, 'fill_blank', N'2, 4, ___, 8, ___', NULL, N'6, 10', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat7, 'fill_blank', N'5, ___, 15, ___, 25', NULL, N'10, 20', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat7, 'fill_blank', N'10, ___, 30, ___, 50', NULL, N'20, 40', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat7, 'fill_blank', N'6, 8, 10, ___, ___', NULL, N'12, 14', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat7, 'fill_blank', N'15, 20, 25, ___, ___', NULL, N'30, 35', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat7, 'fill_blank', N'40, 50, 60, ___, ___', NULL, N'70, 80', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat7, 'fill_blank', N'70, 75, 80, ___, ___', NULL, N'85, 90', 10);

-- 8. Telling Time to the Hour/Half Hour (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@g1cat8, 'fill_blank', N'What time does the clock show?', NULL, N'2:30', 1, 'clock', N'{"hour": 2, "minute": 30}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@g1cat8, 'fill_blank', N'What time does the clock show?', NULL, N'4:00', 2, 'clock', N'{"hour": 4, "minute": 0}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@g1cat8, 'fill_blank', N'What time does the clock show?', NULL, N'5:00', 3, 'clock', N'{"hour": 5, "minute": 0}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@g1cat8, 'fill_blank', N'What time does the clock show?', NULL, N'1:00', 4, 'clock', N'{"hour": 1, "minute": 0}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@g1cat8, 'fill_blank', N'What time does the clock show?', NULL, N'11:30', 5, 'clock', N'{"hour": 11, "minute": 30}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@g1cat8, 'fill_blank', N'What time does the clock show?', NULL, N'10:30', 6, 'clock', N'{"hour": 10, "minute": 30}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@g1cat8, 'fill_blank', N'What time does the clock show?', NULL, N'11:00', 7, 'clock', N'{"hour": 11, "minute": 0}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@g1cat8, 'fill_blank', N'What time does the clock show?', NULL, N'6:00', 8, 'clock', N'{"hour": 6, "minute": 0}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@g1cat8, 'fill_blank', N'What time does the clock show?', NULL, N'5:30', 9, 'clock', N'{"hour": 5, "minute": 30}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@g1cat8, 'fill_blank', N'What time does the clock show?', NULL, N'11:00', 10, 'clock', N'{"hour": 11, "minute": 0}');

-- 9. Counting Money (Pennies, Nickels, Dimes) (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat9, 'fill_blank', N'You have 2 dimes, 2 nickels. How much money in all?', NULL, N'30¢', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat9, 'fill_blank', N'You have 1 penny, 1 nickel. How much money in all?', NULL, N'6¢', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat9, 'fill_blank', N'You have 1 dime, 2 nickels. How much money in all?', NULL, N'20¢', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat9, 'fill_blank', N'You have 2 dimes, 1 penny. How much money in all?', NULL, N'21¢', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat9, 'fill_blank', N'You have 1 dime, 1 penny. How much money in all?', NULL, N'11¢', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat9, 'fill_blank', N'You have 1 penny, 1 dime. How much money in all?', NULL, N'11¢', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat9, 'fill_blank', N'You have 1 penny, 1 nickel. How much money in all?', NULL, N'6¢', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat9, 'fill_blank', N'You have 1 nickel, 1 penny. How much money in all?', NULL, N'6¢', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat9, 'fill_blank', N'You have 2 dimes, 1 penny. How much money in all?', NULL, N'21¢', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat9, 'fill_blank', N'You have 3 dimes, 1 nickel. How much money in all?', NULL, N'35¢', 10);

-- 10. Number and Shape Patterns (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat10, 'fill_blank', N'3, 6, 9, ___, ___', NULL, N'12, 15', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat10, 'fill_blank', N'20, 18, 16, ___, ___', NULL, N'14, 12', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat10, 'fill_blank', N'circle, square, circle, square, ___', NULL, N'circle', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat10, 'fill_blank', N'triangle, triangle, square, triangle, triangle, ___', NULL, N'square', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat10, 'fill_blank', N'1, 3, 5, 7, ___, ___', NULL, N'9, 11', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat10, 'fill_blank', N'30, 25, 20, ___, ___', NULL, N'15, 10', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat10, 'fill_blank', N'AB AB AB ___ ___', NULL, N'A B', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat10, 'fill_blank', N'2, 4, 6, 8, ___, ___', NULL, N'10, 12', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat10, 'fill_blank', N'red, blue, red, blue, ___', NULL, N'red', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat10, 'fill_blank', N'50, 40, 30, ___, ___', NULL, N'20, 10', 10);

-- 11. Word Problems (Addition/Subtraction Within 20) (6 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat11, 'short_response', N'Sam had 10 stickers. Sam gave away 6. How many stickers does Sam have left?', NULL, N'4', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat11, 'short_response', N'Elena had 7 balloons. Elena gave away 7. How many balloons does Elena have left?', NULL, N'0', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat11, 'short_response', N'Sam had 6 crayons. Sam gave away 5. How many crayons does Sam have left?', NULL, N'1', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat11, 'short_response', N'Josie had 3 stickers. Josie gave away 3. How many stickers does Josie have left?', NULL, N'0', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat11, 'short_response', N'Luna had 3 crayons. Then Luna got 4 more. How many crayons does Luna have now?', NULL, N'7', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat11, 'short_response', N'Josie had 12 crayons. Then Josie got 8 more. How many crayons does Josie have now?', NULL, N'20', 6);

-- 12. Short Vowel Words (14 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat12, 'fill_blank', N'cat — vowel sound: ___', NULL, N'a', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat12, 'fill_blank', N'bed — vowel sound: ___', NULL, N'e', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat12, 'fill_blank', N'pig — vowel sound: ___', NULL, N'i', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat12, 'fill_blank', N'dog — vowel sound: ___', NULL, N'o', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat12, 'fill_blank', N'cup — vowel sound: ___', NULL, N'u', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat12, 'fill_blank', N'hat — vowel sound: ___', NULL, N'a', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat12, 'fill_blank', N'net — vowel sound: ___', NULL, N'e', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat12, 'fill_blank', N'sit — vowel sound: ___', NULL, N'i', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat12, 'fill_blank', N'log — vowel sound: ___', NULL, N'o', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat12, 'fill_blank', N'bug — vowel sound: ___', NULL, N'u', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat12, 'fill_blank', N'map — vowel sound: ___', NULL, N'a', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat12, 'fill_blank', N'hen — vowel sound: ___', NULL, N'e', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat12, 'fill_blank', N'fin — vowel sound: ___', NULL, N'i', 13);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat12, 'fill_blank', N'hop — vowel sound: ___', NULL, N'o', 14);

-- 13. Long Vowel Words (Silent E) (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat13, 'fill_blank', N'Add a silent e: cap → ___', NULL, N'cape', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat13, 'fill_blank', N'Add a silent e: kit → ___', NULL, N'kite', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat13, 'fill_blank', N'Add a silent e: hop → ___', NULL, N'hope', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat13, 'fill_blank', N'Add a silent e: cut → ___', NULL, N'cute', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat13, 'fill_blank', N'Add a silent e: pin → ___', NULL, N'pine', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat13, 'fill_blank', N'Add a silent e: plan → ___', NULL, N'plane', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat13, 'fill_blank', N'Add a silent e: man → ___', NULL, N'mane', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat13, 'fill_blank', N'Add a silent e: tap → ___', NULL, N'tape', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat13, 'fill_blank', N'Add a silent e: rid → ___', NULL, N'ride', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat13, 'fill_blank', N'Add a silent e: cub → ___', NULL, N'cube', 10);

-- 14. Consonant Blends (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat14, 'fill_blank', N'___ock (a toy building piece)', NULL, N'block', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat14, 'fill_blank', N'___ab (a sea creature with claws)', NULL, N'crab', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat14, 'fill_blank', N'___ar (you see it in the night sky)', NULL, N'star', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat14, 'fill_blank', N'___ag (waves on a pole)', NULL, N'flag', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat14, 'fill_blank', N'___ass (green, grows in a yard)', NULL, N'grass', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat14, 'fill_blank', N'___ide (you go down it at the playground)', NULL, N'slide', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat14, 'fill_blank', N'___im (move through water)', NULL, N'swim', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat14, 'fill_blank', N'___uck (a big vehicle)', NULL, N'truck', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat14, 'fill_blank', N'___ant (grows in the garden)', NULL, N'plant', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat14, 'fill_blank', N'___um (you hit it to make music)', NULL, N'drum', 10);

-- 15. Sight Word Fluency (14 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat15, 'short_response', N'Write a sentence using the word “and”.', NULL, N'Answers will vary — check the word is used correctly.', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat15, 'short_response', N'Write a sentence using the word “for”.', NULL, N'Answers will vary — check the word is used correctly.', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat15, 'short_response', N'Write a sentence using the word “not”.', NULL, N'Answers will vary — check the word is used correctly.', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat15, 'short_response', N'Write a sentence using the word “with”.', NULL, N'Answers will vary — check the word is used correctly.', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat15, 'short_response', N'Write a sentence using the word “they”.', NULL, N'Answers will vary — check the word is used correctly.', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat15, 'short_response', N'Write a sentence using the word “said”.', NULL, N'Answers will vary — check the word is used correctly.', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat15, 'short_response', N'Write a sentence using the word “was”.', NULL, N'Answers will vary — check the word is used correctly.', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat15, 'short_response', N'Write a sentence using the word “have”.', NULL, N'Answers will vary — check the word is used correctly.', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat15, 'short_response', N'Write a sentence using the word “from”.', NULL, N'Answers will vary — check the word is used correctly.', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat15, 'short_response', N'Write a sentence using the word “were”.', NULL, N'Answers will vary — check the word is used correctly.', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat15, 'short_response', N'Write a sentence using the word “what”.', NULL, N'Answers will vary — check the word is used correctly.', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat15, 'short_response', N'Write a sentence using the word “when”.', NULL, N'Answers will vary — check the word is used correctly.', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat15, 'short_response', N'Write a sentence using the word “little”.', NULL, N'Answers will vary — check the word is used correctly.', 13);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat15, 'short_response', N'Write a sentence using the word “would”.', NULL, N'Answers will vary — check the word is used correctly.', 14);

-- 16. Compound Words (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat16, 'fill_blank', N'sun + shine =', NULL, N'sunshine', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat16, 'fill_blank', N'play + ground =', NULL, N'playground', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat16, 'fill_blank', N'rain + coat =', NULL, N'raincoat', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat16, 'fill_blank', N'bed + room =', NULL, N'bedroom', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat16, 'fill_blank', N'cup + cake =', NULL, N'cupcake', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat16, 'fill_blank', N'home + work =', NULL, N'homework', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat16, 'fill_blank', N'pop + corn =', NULL, N'popcorn', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat16, 'fill_blank', N'side + walk =', NULL, N'sidewalk', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat16, 'fill_blank', N'air + plane =', NULL, N'airplane', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat16, 'fill_blank', N'in + side =', NULL, N'inside', 10);

-- 17. Contractions (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat17, 'fill_blank', N'is not', NULL, N'isn''t', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat17, 'fill_blank', N'are not', NULL, N'aren''t', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat17, 'fill_blank', N'can not', NULL, N'can''t', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat17, 'fill_blank', N'did not', NULL, N'didn''t', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat17, 'fill_blank', N'do not', NULL, N'don''t', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat17, 'fill_blank', N'I will', NULL, N'I''ll', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat17, 'fill_blank', N'she is', NULL, N'she''s', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat17, 'fill_blank', N'that is', NULL, N'that''s', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat17, 'fill_blank', N'we are', NULL, N'we''re', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat17, 'fill_blank', N'you will', NULL, N'you''ll', 10);

-- 18. Synonyms and Antonyms (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat18, 'short_response', N'big (SYN)', NULL, N'large (sample answer)', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat18, 'short_response', N'happy (SYN)', NULL, N'glad (sample answer)', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat18, 'short_response', N'cold (ANT)', NULL, N'hot (sample answer)', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat18, 'short_response', N'up (ANT)', NULL, N'down (sample answer)', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat18, 'short_response', N'fast (SYN)', NULL, N'quick (sample answer)', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat18, 'short_response', N'small (SYN)', NULL, N'tiny (sample answer)', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat18, 'short_response', N'day (ANT)', NULL, N'night (sample answer)', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat18, 'short_response', N'loud (ANT)', NULL, N'quiet (sample answer)', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat18, 'short_response', N'nice (SYN)', NULL, N'kind (sample answer)', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat18, 'short_response', N'old (ANT)', NULL, N'new (sample answer)', 10);

-- 19. Common and Proper Nouns (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat19, 'fill_blank', N'The DOG ran fast. — is the bold word a common or proper noun?', NULL, N'common noun', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat19, 'fill_blank', N'MRS. LEE teaches us. — is the bold word a common or proper noun?', NULL, N'proper noun', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat19, 'fill_blank', N'I have a NEW BALL. — is the bold word a common or proper noun?', NULL, N'common noun', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat19, 'fill_blank', N'We live in TEXAS. — is the bold word a common or proper noun?', NULL, N'proper noun', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat19, 'fill_blank', N'The BIRD flew away. — is the bold word a common or proper noun?', NULL, N'common noun', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat19, 'fill_blank', N'My friend is SAM. — is the bold word a common or proper noun?', NULL, N'proper noun', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat19, 'fill_blank', N'She read a BOOK. — is the bold word a common or proper noun?', NULL, N'common noun', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat19, 'fill_blank', N'We visited PARIS. — is the bold word a common or proper noun?', NULL, N'proper noun', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat19, 'fill_blank', N'The CAT slept all day. — is the bold word a common or proper noun?', NULL, N'common noun', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat19, 'fill_blank', N'Today is MONDAY. — is the bold word a common or proper noun?', NULL, N'proper noun', 10);

-- 20. Action Verbs (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat20, 'short_response', N'Write a sentence using the action verb “jump”.', NULL, N'Answers will vary — check the verb shows an action.', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat20, 'short_response', N'Write a sentence using the action verb “run”.', NULL, N'Answers will vary — check the verb shows an action.', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat20, 'short_response', N'Write a sentence using the action verb “sing”.', NULL, N'Answers will vary — check the verb shows an action.', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat20, 'short_response', N'Write a sentence using the action verb “laugh”.', NULL, N'Answers will vary — check the verb shows an action.', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat20, 'short_response', N'Write a sentence using the action verb “climb”.', NULL, N'Answers will vary — check the verb shows an action.', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat20, 'short_response', N'Write a sentence using the action verb “swim”.', NULL, N'Answers will vary — check the verb shows an action.', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat20, 'short_response', N'Write a sentence using the action verb “dance”.', NULL, N'Answers will vary — check the verb shows an action.', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat20, 'short_response', N'Write a sentence using the action verb “write”.', NULL, N'Answers will vary — check the verb shows an action.', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat20, 'short_response', N'Write a sentence using the action verb “read”.', NULL, N'Answers will vary — check the verb shows an action.', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat20, 'short_response', N'Write a sentence using the action verb “paint”.', NULL, N'Answers will vary — check the verb shows an action.', 10);

-- 21. Reading Comprehension: Main Idea & Details (5 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat21, 'short_response', N'What is the main idea of this story?', NULL, N'Ben loses his mitten and finds it again with his friend''s help', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat21, 'short_response', N'What did Ben check first?', NULL, N'His backpack', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat21, 'short_response', N'Who helped Ben find his mitten?', NULL, N'Mia', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat21, 'short_response', N'Where did Mia remember seeing the mitten?', NULL, N'Near the big oak tree', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat21, 'short_response', N'How do you think Ben felt when they found the mitten?', NULL, N'Answers will vary — example: happy or relieved', 5);

-- 22. Narrative Writing (8 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat22, 'short_response', N'Who is the main character in your story?', NULL, N'Open response — check for a clear character, setting, and event.', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat22, 'short_response', N'Where does your story take place?', NULL, N'Open response — check for a clear character, setting, and event.', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat22, 'short_response', N'What happens first?', NULL, N'Open response — check for a clear character, setting, and event.', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat22, 'short_response', N'What happens next?', NULL, N'Open response — check for a clear character, setting, and event.', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat22, 'short_response', N'How does your story end?', NULL, N'Open response — check for a clear character, setting, and event.', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat22, 'short_response', N'What is one word that describes how your character feels?', NULL, N'Open response — check for a clear character, setting, and event.', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat22, 'short_response', N'Draw a picture to go with your story.', NULL, N'Open response — check for a clear character, setting, and event.', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat22, 'short_response', N'Give your story a title.', NULL, N'Open response — check for a clear character, setting, and event.', 8);

-- 23. Opinion Writing (8 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat23, 'short_response', N'What is your opinion? (Example: My favorite animal is...)', NULL, N'Open response — check for a clear opinion and a reason.', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat23, 'short_response', N'What is one reason for your opinion?', NULL, N'Open response — check for a clear opinion and a reason.', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat23, 'short_response', N'Can you give an example that supports your reason?', NULL, N'Open response — check for a clear opinion and a reason.', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat23, 'short_response', N'What is a second reason for your opinion?', NULL, N'Open response — check for a clear opinion and a reason.', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat23, 'short_response', N'How could you end your writing?', NULL, N'Open response — check for a clear opinion and a reason.', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat23, 'short_response', N'Who will read your opinion piece?', NULL, N'Open response — check for a clear opinion and a reason.', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat23, 'short_response', N'What is the title of your opinion piece?', NULL, N'Open response — check for a clear opinion and a reason.', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat23, 'short_response', N'Draw a picture that matches your opinion.', NULL, N'Open response — check for a clear opinion and a reason.', 8);

-- 24. Plant Life Cycle (8 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat24, 'multiple_choice', N'A plant begins its life as a ___.', N'["seed", "flower", "root"]', N'seed', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat24, 'multiple_choice', N'A seed needs water, sunlight, and ___ to grow.', N'["soil", "sand", "glass"]', N'soil', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat24, 'multiple_choice', N'The first part of a plant to grow from a seed is the ___.', N'["root", "flower", "fruit"]', N'root', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat24, 'multiple_choice', N'Plants make their own food using sunlight in a process called ___.', N'["photosynthesis", "evaporation", "germination"]', N'photosynthesis', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat24, 'multiple_choice', N'After a plant grows, it often produces ___ to make new seeds.', N'["flowers", "rocks", "bark"]', N'flowers', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat24, 'multiple_choice', N'A young plant that has just sprouted is called a ___.', N'["seedling", "sapling", "stem"]', N'seedling', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat24, 'multiple_choice', N'Which part of the plant takes in water from the soil?', N'["roots", "leaves", "petals"]', N'roots', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat24, 'multiple_choice', N'Which part of the plant makes food from sunlight?', N'["leaves", "roots", "seeds"]', N'leaves', 8);

-- 25. Weather and Seasons (8 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat25, 'fill_blank', N'The season after winter is ___.', NULL, N'spring', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat25, 'fill_blank', N'The season after summer is ___.', NULL, N'fall (autumn)', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat25, 'fill_blank', N'Snow usually falls in the season called ___.', NULL, N'winter', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat25, 'fill_blank', N'Leaves often change color and fall in ___.', NULL, N'fall (autumn)', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat25, 'fill_blank', N'The hottest season is usually ___.', NULL, N'summer', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat25, 'fill_blank', N'Flowers often bloom in ___.', NULL, N'spring', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat25, 'fill_blank', N'You would wear a heavy coat in ___.', NULL, N'winter', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat25, 'fill_blank', N'School often starts in the season of ___.', NULL, N'fall (autumn)', 8);

-- 26. Map Symbols and Keys (8 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat26, 'fill_blank', N'A map key (or legend) tells you what the ___ on a map mean.', NULL, N'symbols', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat26, 'fill_blank', N'A blue line or shape on a map usually means ___.', NULL, N'water', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat26, 'fill_blank', N'A green shape on a map often means ___.', NULL, N'park or forest', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat26, 'fill_blank', N'A star on a map often marks the ___ city.', NULL, N'capital', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat26, 'fill_blank', N'The compass rose shows the directions north, south, east, and ___.', NULL, N'west', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat26, 'fill_blank', N'A dotted or solid line on a map often shows a ___.', NULL, N'road or border', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat26, 'fill_blank', N'On most maps, ___ is at the top of the page.', NULL, N'north', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat26, 'fill_blank', N'A map is a drawing that shows a place from ___.', NULL, N'above', 8);

-- 27. Needs vs. Wants (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat27, 'multiple_choice', N'food', N'["Need", "Want"]', N'Need', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat27, 'multiple_choice', N'a video game', N'["Need", "Want"]', N'Want', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat27, 'multiple_choice', N'water', N'["Need", "Want"]', N'Need', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat27, 'multiple_choice', N'a new toy', N'["Need", "Want"]', N'Want', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat27, 'multiple_choice', N'shelter (a home)', N'["Need", "Want"]', N'Need', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat27, 'multiple_choice', N'candy', N'["Need", "Want"]', N'Want', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat27, 'multiple_choice', N'clothing', N'["Need", "Want"]', N'Need', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat27, 'multiple_choice', N'a trip to the amusement park', N'["Need", "Want"]', N'Want', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat27, 'multiple_choice', N'medicine when you''re sick', N'["Need", "Want"]', N'Need', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat27, 'multiple_choice', N'the newest video game', N'["Need", "Want"]', N'Want', 10);

-- 28. Rules and Responsibilities (5 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat28, 'short_response', N'Why do classrooms have rules?', NULL, N'Open response — example: to keep everyone safe and learning.', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat28, 'short_response', N'Name one rule you follow at school.', NULL, N'Answers will vary.', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat28, 'short_response', N'What is one responsibility you have at home?', NULL, N'Answers will vary.', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat28, 'short_response', N'What could happen if there were no rules?', NULL, N'Open response — example: things could be unsafe or unfair.', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat28, 'short_response', N'Name one way you can help your community.', NULL, N'Answers will vary.', 5);

-- 29. Word Search Puzzle (1 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat29, 'word_search', N'Find these words: BLOCK, CRAB, STAR, FLAG, GRASS, SLIDE, SWIM, TRUCK', NULL, N'BLOCK, CRAB, STAR, FLAG, GRASS, SLIDE, SWIM, TRUCK', 1);

-- 30. Brain Teaser Riddles (8 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat30, 'fill_blank', N'What has to be broken before you can use it?', NULL, N'An egg', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat30, 'fill_blank', N'What has a face and two hands but no arms or legs?', NULL, N'A clock', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat30, 'fill_blank', N'What gets bigger the more you take away from it?', NULL, N'A hole', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat30, 'fill_blank', N'What has one eye but cannot see?', NULL, N'A needle', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat30, 'fill_blank', N'I have keys but no locks. What am I?', NULL, N'A piano', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat30, 'fill_blank', N'What kind of coat is always wet when you put it on?', NULL, N'A coat of paint', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat30, 'fill_blank', N'What can you catch but not throw?', NULL, N'A cold', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g1cat30, 'fill_blank', N'What has hands but cannot clap?', NULL, N'A clock', 8);

END
GO
