-- 51_grade2_pool_expansion.sql
-- Adds extra questions to Grade 2's existing fact/skill categories so the
-- weekly random-pick sampling (dbo.usp_GetOrCreateWeeklyPacket) has a real
-- pool to draw from, matching the variety already present for K/1st/3rd.
-- Skips categories tied to a fixed passage/prompt sequence (Reading
-- Comprehension passages, Narrative/Opinion Writing planning steps,
-- Government Roles, Word Search) since those aren't meaningfully poolable.

IF NOT EXISTS (
    SELECT 1 FROM dbo.PacketQuestions q
    JOIN dbo.PacketCategories c ON q.category_id = c.category_id
    WHERE c.grade_id = 3 AND c.category_name = N'Addition Within 100 (Regrouping)' AND q.sort_order = 11
)
BEGIN

DECLARE @cAdd INT = (SELECT category_id FROM dbo.PacketCategories WHERE grade_id = 3 AND category_name = N'Addition Within 100 (Regrouping)');
DECLARE @cSub INT = (SELECT category_id FROM dbo.PacketCategories WHERE grade_id = 3 AND category_name = N'Subtraction Within 100 (Regrouping)');
DECLARE @cSkip INT = (SELECT category_id FROM dbo.PacketCategories WHERE grade_id = 3 AND category_name = N'Skip Counting Patterns');
DECLARE @cOddEven INT = (SELECT category_id FROM dbo.PacketCategories WHERE grade_id = 3 AND category_name = N'Odd and Even Numbers');
DECLARE @cFact INT = (SELECT category_id FROM dbo.PacketCategories WHERE grade_id = 3 AND category_name = N'Fact Families');
DECLARE @cCompare INT = (SELECT category_id FROM dbo.PacketCategories WHERE grade_id = 3 AND category_name = N'Comparing 3-Digit Numbers');
DECLARE @cRound INT = (SELECT category_id FROM dbo.PacketCategories WHERE grade_id = 3 AND category_name = N'Rounding to the Nearest Ten');
DECLARE @cPattern INT = (SELECT category_id FROM dbo.PacketCategories WHERE grade_id = 3 AND category_name = N'Number Patterns');
DECLARE @cOrder INT = (SELECT category_id FROM dbo.PacketCategories WHERE grade_id = 3 AND category_name = N'Ordering Numbers');
DECLARE @cVocab INT = (SELECT category_id FROM dbo.PacketCategories WHERE grade_id = 3 AND category_name = N'Vocabulary in Context');
DECLARE @cSynAnt INT = (SELECT category_id FROM dbo.PacketCategories WHERE grade_id = 3 AND category_name = N'Synonyms & Antonyms');
DECLARE @cHomo INT = (SELECT category_id FROM dbo.PacketCategories WHERE grade_id = 3 AND category_name = N'Homophones');
DECLARE @cPreSuf INT = (SELECT category_id FROM dbo.PacketCategories WHERE grade_id = 3 AND category_name = N'Prefixes & Suffixes');
DECLARE @cCompound INT = (SELECT category_id FROM dbo.PacketCategories WHERE grade_id = 3 AND category_name = N'Compound Words');
DECLARE @cContraction INT = (SELECT category_id FROM dbo.PacketCategories WHERE grade_id = 3 AND category_name = N'Contractions');
DECLARE @cPossessive INT = (SELECT category_id FROM dbo.PacketCategories WHERE grade_id = 3 AND category_name = N'Possessive Nouns');
DECLARE @cMultiMean INT = (SELECT category_id FROM dbo.PacketCategories WHERE grade_id = 3 AND category_name = N'Multiple-Meaning Words');
DECLARE @cMatter INT = (SELECT category_id FROM dbo.PacketCategories WHERE grade_id = 3 AND category_name = N'Matter: Solids, Liquids & Gases');
DECLARE @cWater INT = (SELECT category_id FROM dbo.PacketCategories WHERE grade_id = 3 AND category_name = N'The Water Cycle');
DECLARE @cMap INT = (SELECT category_id FROM dbo.PacketCategories WHERE grade_id = 3 AND category_name = N'Map Skills');
DECLARE @cGoods INT = (SELECT category_id FROM dbo.PacketCategories WHERE grade_id = 3 AND category_name = N'Goods and Services');
DECLARE @cMoney INT = (SELECT category_id FROM dbo.PacketCategories WHERE grade_id = 3 AND category_name = N'Money Word Problems');
DECLARE @cTwoStep INT = (SELECT category_id FROM dbo.PacketCategories WHERE grade_id = 3 AND category_name = N'Two-Step Word Problems');
DECLARE @cRiddle INT = (SELECT category_id FROM dbo.PacketCategories WHERE grade_id = 3 AND category_name = N'Brain Teaser Riddles');

-- Addition Within 100 (Regrouping)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cAdd, 'fill_blank', N'47
+38', NULL, N'85', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cAdd, 'fill_blank', N'29
+46', NULL, N'75', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cAdd, 'fill_blank', N'53
+19', NULL, N'72', 13);

-- Subtraction Within 100 (Regrouping)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cSub, 'fill_blank', N'91
-47', NULL, N'44', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cSub, 'fill_blank', N'53
-28', NULL, N'25', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cSub, 'fill_blank', N'70
-24', NULL, N'46', 13);

-- Skip Counting Patterns
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cSkip, 'fill_blank', N'5, 10, 15, ___, 25', NULL, N'20', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cSkip, 'fill_blank', N'40, 50, ___, 70, 80', NULL, N'60', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cSkip, 'fill_blank', N'88, 90, 92, ___, 96', NULL, N'94', 13);

-- Odd and Even Numbers
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cOddEven, 'multiple_choice', N'246', N'["Odd", "Even"]', N'Even', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cOddEven, 'multiple_choice', N'913', N'["Odd", "Even"]', N'Odd', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cOddEven, 'multiple_choice', N'800', N'["Odd", "Even"]', N'Even', 13);

-- Fact Families
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cFact, 'short_response', N'Numbers: 18, 25, 43 → write the four related addition/subtraction facts.', NULL, N'18+25=43, 25+18=43, 43-18=25, 43-25=18', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cFact, 'short_response', N'Numbers: 9, 47, 56 → write the four related addition/subtraction facts.', NULL, N'9+47=56, 47+9=56, 56-9=47, 56-47=9', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cFact, 'short_response', N'Numbers: 22, 19, 41 → write the four related addition/subtraction facts.', NULL, N'22+19=41, 19+22=41, 41-22=19, 41-19=22', 13);

-- Comparing 3-Digit Numbers
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cCompare, 'fill_blank', N'482 ___ 291', NULL, N'>', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cCompare, 'fill_blank', N'305 ___ 350', NULL, N'<', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cCompare, 'fill_blank', N'640 ___ 604', NULL, N'>', 13);

-- Rounding to the Nearest Ten
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cRound, 'fill_blank', N'Round 27 to the nearest ten:', NULL, N'30', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cRound, 'fill_blank', N'Round 674 to the nearest ten:', NULL, N'670', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cRound, 'fill_blank', N'Round 815 to the nearest ten:', NULL, N'820', 13);

-- Number Patterns
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cPattern, 'fill_blank', N'12, 17, 22, 27, ___', NULL, N'32', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cPattern, 'fill_blank', N'90, 80, 70, 60, ___', NULL, N'50', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cPattern, 'fill_blank', N'8, 11, 14, 17, ___', NULL, N'20', 13);

-- Ordering Numbers
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cOrder, 'short_response', N'412, 199, 733, 288 → least to greatest:', NULL, N'199, 288, 412, 733', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cOrder, 'short_response', N'607, 76, 670, 706 → least to greatest:', NULL, N'76, 607, 670, 706', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cOrder, 'short_response', N'955, 459, 549, 945 → least to greatest:', NULL, N'459, 549, 945, 955', 13);

-- Vocabulary in Context
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cVocab, 'fill_blank', N'The scouts began their long ___ through the forest.', NULL, N'journey', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cVocab, 'fill_blank', N'She wrapped the gift in a ___ of colorful paper.', NULL, N'bundle', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cVocab, 'fill_blank', N'Please be ___ when crossing the busy street.', NULL, N'cautious', 13);

-- Synonyms & Antonyms
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cSynAnt, 'short_response', N'cold (ANT)', NULL, N'hot (sample answer)', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cSynAnt, 'short_response', N'loud (ANT)', NULL, N'quiet (sample answer)', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cSynAnt, 'short_response', N'smart (SYN)', NULL, N'clever (sample answer)', 13);

-- Homophones
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cHomo, 'multiple_choice', N'Mom used ___ to bake the bread.', N'["flower", "flour"]', N'flour', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cHomo, 'multiple_choice', N'He is my sister''s ___.', N'["sun", "son"]', N'son', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cHomo, 'multiple_choice', N'I ___ my breakfast this morning.', N'["eight", "ate"]', N'ate', 13);

-- Prefixes & Suffixes
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cPreSuf, 'fill_blank', N'un + fair =', NULL, N'unfair', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cPreSuf, 'fill_blank', N'play + ful =', NULL, N'playful', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cPreSuf, 'fill_blank', N're + build =', NULL, N'rebuild', 13);

-- Compound Words
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cCompound, 'fill_blank', N'book + shelf =', NULL, N'bookshelf', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cCompound, 'fill_blank', N'sand + box =', NULL, N'sandbox', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cCompound, 'fill_blank', N'fire + fly =', NULL, N'firefly', 13);

-- Contractions
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cContraction, 'fill_blank', N'would not', NULL, N'wouldn''t', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cContraction, 'fill_blank', N'has not', NULL, N'hasn''t', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cContraction, 'fill_blank', N'who is', NULL, N'who''s', 13);

-- Possessive Nouns
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cPossessive, 'short_response', N'Rewrite using a possessive noun: the leash that belongs to the dog', NULL, N'the dog''s leash', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cPossessive, 'short_response', N'Rewrite using a possessive noun: the crayons that belong to the children', NULL, N'the children''s crayons', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cPossessive, 'short_response', N'Rewrite using a possessive noun: the desk that belongs to Ms. Cruz', NULL, N'Ms. Cruz''s desk', 13);

-- Multiple-Meaning Words
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cMultiMean, 'short_response', N'pool — a place to swim / to combine resources', NULL, N'Answers will vary — check that each meaning is used correctly.', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cMultiMean, 'short_response', N'yard — a unit of measurement / the area around a house', NULL, N'Answers will vary — check that each meaning is used correctly.', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cMultiMean, 'short_response', N'match — a game or competition / a small stick that makes fire', NULL, N'Answers will vary — check that each meaning is used correctly.', 13);

-- Matter: Solids, Liquids & Gases
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cMatter, 'multiple_choice', N'Boiling is when a liquid changes into a gas.', N'["True", "False"]', N'True', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cMatter, 'multiple_choice', N'A gas can be poured like a liquid.', N'["True", "False"]', N'False', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cMatter, 'multiple_choice', N'Milk is an example of a solid.', N'["True", "False"]', N'False', 13);

-- The Water Cycle
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cWater, 'fill_blank', N'Rain, snow, and hail are all types of ___.', NULL, N'precipitation', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cWater, 'fill_blank', N'Rivers and lakes are places where water is ___ before evaporating again.', NULL, N'collected', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cWater, 'fill_blank', N'The water cycle is powered mainly by energy from the ___.', NULL, N'sun', 13);

-- Map Skills
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cMap, 'fill_blank', N'If you are facing north, west is to your ___.', NULL, N'left', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cMap, 'fill_blank', N'A ___ line divides the Earth into the Northern and Southern Hemispheres.', NULL, N'equator', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cMap, 'fill_blank', N'Mountains are often shown in the color ___.', NULL, N'brown', 13);

-- Goods and Services
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cGoods, 'multiple_choice', N'A firefighter putting out a fire', N'["Good", "Service"]', N'Service', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cGoods, 'multiple_choice', N'A pair of shoes', N'["Good", "Service"]', N'Good', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cGoods, 'multiple_choice', N'A babysitter watching children', N'["Good", "Service"]', N'Service', 13);

-- Money Word Problems
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cMoney, 'short_response', N'Ollie the Owl has 2 quarters, 4 dimes, and 3 pennies. How much money does he have?', NULL, N'$0.93', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cMoney, 'short_response', N'A juice box costs 60 cents. You pay with a $1 bill. How much change do you get?', NULL, N'$0.40', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cMoney, 'short_response', N'Grace has 3 quarters, 2 nickels, and 4 pennies. How much money does she have?', NULL, N'$0.89', 11);

-- Two-Step Word Problems
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cTwoStep, 'short_response', N'Ollie the Owl counted 56 birds in the park. 17 flew away in the morning and 14 more flew away in the afternoon. How many birds are left?', NULL, N'25', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cTwoStep, 'short_response', N'A baker made 40 muffins. She sold 15 in the morning and 9 more in the afternoon. How many muffins are left?', NULL, N'16', 8);

-- Brain Teaser Riddles
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cRiddle, 'fill_blank', N'What has a neck but no head?', NULL, N'A bottle', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cRiddle, 'fill_blank', N'I''m tall when I''m young and short when I''m old. What am I?', NULL, N'A candle', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@cRiddle, 'fill_blank', N'What has legs but doesn''t walk?', NULL, N'A table', 13);

END
GO
