-- 53_tk_content.sql
-- TK (Transitional Kindergarten), content bank — 12 categories covering
-- early counting, number and letter recognition, phonics, colors,
-- patterns, and a listening/feelings check-in. Most categories carry
-- more questions than their target_count so weekly composition
-- genuinely varies. Categories 11-12 are fixed 1:1 with target_count
-- (a single passage sequence and a single puzzle) and are not pooled.

IF NOT EXISTS (SELECT 1 FROM dbo.PacketCategories WHERE grade_id = 0)
BEGIN
DECLARE @tkcat1 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (0, 'math', N'Counting Objects 1–10', 'short_answer', 8, NULL);
SET @tkcat1 = SCOPE_IDENTITY();

DECLARE @tkcat2 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (0, 'math', N'Number Recognition 1–10', 'short_answer', 8, NULL);
SET @tkcat2 = SCOPE_IDENTITY();

DECLARE @tkcat3 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (0, 'math', N'Shape Recognition', 'short_answer', 6, NULL);
SET @tkcat3 = SCOPE_IDENTITY();

DECLARE @tkcat4 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (0, 'math', N'More or Less', 'short_answer', 6, NULL);
SET @tkcat4 = SCOPE_IDENTITY();

DECLARE @tkcat5 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (0, 'ela', N'Uppercase Letter Recognition', 'short_answer', 8, NULL);
SET @tkcat5 = SCOPE_IDENTITY();

DECLARE @tkcat6 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (0, 'ela', N'Lowercase Letter Recognition', 'short_answer', 8, NULL);
SET @tkcat6 = SCOPE_IDENTITY();

DECLARE @tkcat7 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (0, 'ela', N'Beginning Sounds', 'short_answer', 8, NULL);
SET @tkcat7 = SCOPE_IDENTITY();

DECLARE @tkcat8 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (0, 'ela', N'Rhyming Pairs', 'short_answer', 8, NULL);
SET @tkcat8 = SCOPE_IDENTITY();

DECLARE @tkcat9 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (0, 'ela', N'Color Words', 'short_answer', 8, NULL);
SET @tkcat9 = SCOPE_IDENTITY();

DECLARE @tkcat10 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (0, 'math', N'AB Patterns', 'short_answer', 6, NULL);
SET @tkcat10 = SCOPE_IDENTITY();

DECLARE @tkcat11 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (0, 'writing', N'Listening & Feelings Check-In', 'space_heavy', 5, N'Max the puppy got lost in the big park and felt very scared. A kind girl named Mia found him and held his paw. She walked him all the way home, and Max wagged his tail happily when he saw his family again.');
SET @tkcat11 = SCOPE_IDENTITY();

DECLARE @tkcat12 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (0, 'puzzle', N'Puzzle: Match the Picture', 'puzzle', 1, NULL);
SET @tkcat12 = SCOPE_IDENTITY();

-- 1. Counting Objects 1–10 (12 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@tkcat1, 'fill_blank', N'How many apples? 🍎🍎🍎', NULL, N'3', 1, 'emoji', N'{"emoji": "🍎"}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@tkcat1, 'fill_blank', N'How many stars? ⭐⭐⭐⭐⭐', NULL, N'5', 2, 'emoji', N'{"emoji": "⭐"}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@tkcat1, 'fill_blank', N'How many balloons? 🎈🎈🎈🎈🎈🎈🎈', NULL, N'7', 3, 'emoji', N'{"emoji": "🎈"}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@tkcat1, 'fill_blank', N'How many fish? 🐟🐟', NULL, N'2', 4, 'emoji', N'{"emoji": "🐟"}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@tkcat1, 'fill_blank', N'How many cupcakes? 🧁🧁🧁🧁🧁🧁🧁🧁🧁', NULL, N'9', 5, 'emoji', N'{"emoji": "🧁"}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@tkcat1, 'fill_blank', N'How many flowers? 🌸🌸🌸🌸', NULL, N'4', 6, 'emoji', N'{"emoji": "🌸"}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@tkcat1, 'fill_blank', N'How many cars? 🚗🚗🚗🚗🚗🚗', NULL, N'6', 7, 'emoji', N'{"emoji": "🚗"}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@tkcat1, 'fill_blank', N'How many cookies? 🍪🍪🍪🍪🍪🍪🍪🍪🍪🍪', NULL, N'10', 8, 'emoji', N'{"emoji": "🍪"}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@tkcat1, 'fill_blank', N'How many ducks? 🦆', NULL, N'1', 9, 'emoji', N'{"emoji": "🦆"}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@tkcat1, 'fill_blank', N'How many books? 📚📚📚📚📚📚📚📚', NULL, N'8', 10, 'emoji', N'{"emoji": "📚"}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@tkcat1, 'fill_blank', N'How many bees? 🐝🐝🐝', NULL, N'3', 11, 'emoji', N'{"emoji": "🐝"}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@tkcat1, 'fill_blank', N'How many balls? ⚽⚽⚽⚽⚽⚽', NULL, N'6', 12, 'emoji', N'{"emoji": "⚽"}');

-- 2. Number Recognition 1–10 (12 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat2, 'multiple_choice', N'Which number is ONE?', N'["1", "3", "5"]', N'1', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat2, 'multiple_choice', N'Which number is TWO?', N'["2", "6", "9"]', N'2', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat2, 'multiple_choice', N'Which number is THREE?', N'["7", "3", "1"]', N'3', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat2, 'multiple_choice', N'Which number is FOUR?', N'["4", "8", "2"]', N'4', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat2, 'multiple_choice', N'Which number is FIVE?', N'["9", "5", "3"]', N'5', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat2, 'multiple_choice', N'Which number is SIX?', N'["6", "2", "10"]', N'6', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat2, 'multiple_choice', N'Which number is SEVEN?', N'["5", "7", "9"]', N'7', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat2, 'multiple_choice', N'Which number is EIGHT?', N'["8", "4", "1"]', N'8', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat2, 'multiple_choice', N'Which number is NINE?', N'["9", "6", "3"]', N'9', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat2, 'multiple_choice', N'Which number is TEN?', N'["10", "7", "4"]', N'10', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat2, 'fill_blank', N'What number comes right after 6? ___', NULL, N'7', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat2, 'fill_blank', N'What number comes right before 10? ___', NULL, N'9', 12);

-- 3. Shape Recognition (9 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@tkcat3, 'fill_blank', N'This shape is a ___.', NULL, N'circle', 1, 'emoji', N'{"emoji": "🔵"}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@tkcat3, 'fill_blank', N'This shape is a ___.', NULL, N'square', 2, 'emoji', N'{"emoji": "⬛"}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@tkcat3, 'fill_blank', N'This shape is a ___.', NULL, N'triangle', 3, 'emoji', N'{"emoji": "🔺"}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@tkcat3, 'fill_blank', N'This shape is a ___.', NULL, N'rectangle', 4, 'emoji', N'{"emoji": "🧱"}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@tkcat3, 'fill_blank', N'This shape is a ___.', NULL, N'star', 5, 'emoji', N'{"emoji": "⭐"}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@tkcat3, 'fill_blank', N'This shape is a ___.', NULL, N'heart', 6, 'emoji', N'{"emoji": "❤️"}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat3, 'multiple_choice', N'Which shape has 3 sides?', N'["circle", "triangle", "square"]', N'triangle', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat3, 'multiple_choice', N'Which shape is round?', N'["circle", "square", "star"]', N'circle', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat3, 'multiple_choice', N'Which shape has 4 equal sides?', N'["rectangle", "square", "triangle"]', N'square', 9);

-- 4. More or Less (9 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat4, 'multiple_choice', N'Which group has MORE? First: 🍎🍎🍎🍎   Second: 🍎🍎', N'["First group", "Second group"]', N'First group', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat4, 'multiple_choice', N'Which group has MORE? First: ⭐⭐   Second: ⭐⭐⭐⭐⭐', N'["First group", "Second group"]', N'Second group', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat4, 'multiple_choice', N'Which group has LESS? First: 🐱🐱🐱   Second: 🐱', N'["First group", "Second group"]', N'Second group', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat4, 'multiple_choice', N'Which group has MORE? First: 🎈🎈🎈   Second: 🎈🎈🎈🎈🎈🎈', N'["First group", "Second group"]', N'Second group', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat4, 'multiple_choice', N'Which group has LESS? First: 🐟🐟🐟🐟   Second: 🐟🐟', N'["First group", "Second group"]', N'Second group', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat4, 'multiple_choice', N'Which group has MORE? First: 🍪🍪🍪🍪🍪   Second: 🍪🍪🍪', N'["First group", "Second group"]', N'First group', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat4, 'multiple_choice', N'Which group has LESS? First: 🌸   Second: 🌸🌸🌸', N'["First group", "Second group"]', N'First group', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat4, 'multiple_choice', N'Which group has MORE? First: 🚗🚗   Second: 🚗🚗🚗🚗', N'["First group", "Second group"]', N'Second group', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat4, 'multiple_choice', N'Which group has LESS? First: 🐝🐝🐝🐝   Second: 🐝🐝🐝', N'["First group", "Second group"]', N'Second group', 9);

-- 5. Uppercase Letter Recognition (12 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat5, 'multiple_choice', N'Which letter is this? B', N'["A", "B", "C"]', N'B', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat5, 'multiple_choice', N'Which letter is this? M', N'["M", "N", "W"]', N'M', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat5, 'multiple_choice', N'Which letter is this? T', N'["F", "T", "L"]', N'T', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat5, 'multiple_choice', N'Which letter is this? S', N'["S", "Z", "E"]', N'S', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat5, 'multiple_choice', N'Which letter is this? K', N'["K", "X", "Y"]', N'K', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat5, 'multiple_choice', N'Which letter is this? R', N'["P", "R", "B"]', N'R', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat5, 'fill_blank', N'What letter comes after A? ___', NULL, N'B', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat5, 'fill_blank', N'What letter comes after C? ___', NULL, N'D', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat5, 'fill_blank', N'What letter comes right before E? ___', NULL, N'D', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat5, 'fill_blank', N'What letter comes after G? ___', NULL, N'H', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat5, 'multiple_choice', N'Which letter is this? D', N'["D", "O", "Q"]', N'D', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat5, 'multiple_choice', N'Which letter is this? H', N'["H", "N", "M"]', N'H', 12);

-- 6. Lowercase Letter Recognition (12 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat6, 'multiple_choice', N'Which letter is this? b', N'["b", "d", "p"]', N'b', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat6, 'multiple_choice', N'Which letter is this? m', N'["m", "n", "w"]', N'm', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat6, 'multiple_choice', N'Which letter is this? t', N'["f", "t", "l"]', N't', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat6, 'multiple_choice', N'Which letter is this? s', N'["s", "z", "e"]', N's', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat6, 'multiple_choice', N'Which letter is this? k', N'["k", "x", "y"]', N'k', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat6, 'multiple_choice', N'Which letter is this? r', N'["p", "r", "b"]', N'r', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat6, 'fill_blank', N'What letter comes after a? ___', NULL, N'b', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat6, 'fill_blank', N'What letter comes after c? ___', NULL, N'd', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat6, 'fill_blank', N'What letter comes right before e? ___', NULL, N'd', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat6, 'fill_blank', N'What letter comes after g? ___', NULL, N'h', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat6, 'multiple_choice', N'Which letter is this? d', N'["d", "q", "g"]', N'd', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat6, 'multiple_choice', N'Which letter is this? h', N'["h", "n", "m"]', N'h', 12);

-- 7. Beginning Sounds (12 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@tkcat7, 'fill_blank', N'What sound does ''ball'' start with? ___', NULL, N'b', 1, 'emoji', N'{"emoji": "⚽"}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@tkcat7, 'fill_blank', N'What sound does ''cat'' start with? ___', NULL, N'c', 2, 'emoji', N'{"emoji": "🐱"}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@tkcat7, 'fill_blank', N'What sound does ''dog'' start with? ___', NULL, N'd', 3, 'emoji', N'{"emoji": "🐶"}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@tkcat7, 'fill_blank', N'What sound does ''sun'' start with? ___', NULL, N's', 4, 'emoji', N'{"emoji": "☀️"}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@tkcat7, 'multiple_choice', N'What sound does ''pig'' start with?', N'["p", "b", "d"]', N'p', 5, 'emoji', N'{"emoji": "🐷"}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@tkcat7, 'multiple_choice', N'What sound does ''hat'' start with?', N'["h", "t", "m"]', N'h', 6, 'emoji', N'{"emoji": "🎩"}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@tkcat7, 'multiple_choice', N'What sound does ''map'' start with?', N'["m", "n", "p"]', N'm', 7, 'emoji', N'{"emoji": "🗺️"}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@tkcat7, 'fill_blank', N'What sound does ''net'' start with? ___', NULL, N'n', 8, 'emoji', N'{"emoji": "🥅"}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@tkcat7, 'fill_blank', N'What sound does ''fan'' start with? ___', NULL, N'f', 9, 'emoji', N'{"emoji": "🌀"}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@tkcat7, 'multiple_choice', N'What sound does ''jet'' start with?', N'["j", "g", "y"]', N'j', 10, 'emoji', N'{"emoji": "✈️"}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@tkcat7, 'multiple_choice', N'What sound does ''van'' start with?', N'["v", "f", "w"]', N'v', 11, 'emoji', N'{"emoji": "🚐"}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@tkcat7, 'fill_blank', N'What sound does ''zip'' start with? ___', NULL, N'z', 12, 'emoji', N'{"emoji": "🤐"}');

-- 8. Rhyming Pairs (12 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat8, 'multiple_choice', N'Does ''cat'' rhyme with ''hat''?', N'["Yes", "No"]', N'Yes', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat8, 'multiple_choice', N'Does ''dog'' rhyme with ''log''?', N'["Yes", "No"]', N'Yes', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat8, 'multiple_choice', N'Does ''sun'' rhyme with ''fun''?', N'["Yes", "No"]', N'Yes', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat8, 'multiple_choice', N'Does ''pig'' rhyme with ''cow''?', N'["Yes", "No"]', N'No', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat8, 'multiple_choice', N'Does ''bear'' rhyme with ''chair''?', N'["Yes", "No"]', N'Yes', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat8, 'multiple_choice', N'Does ''mouse'' rhyme with ''dog''?', N'["Yes", "No"]', N'No', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat8, 'multiple_choice', N'Does ''cake'' rhyme with ''lake''?', N'["Yes", "No"]', N'Yes', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat8, 'multiple_choice', N'Does ''tree'' rhyme with ''car''?', N'["Yes", "No"]', N'No', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat8, 'multiple_choice', N'Does ''cat'' rhyme with ''dog''?', N'["Yes", "No"]', N'No', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat8, 'multiple_choice', N'Does ''sun'' rhyme with ''moon''?', N'["Yes", "No"]', N'No', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat8, 'multiple_choice', N'Does ''star'' rhyme with ''car''?', N'["Yes", "No"]', N'Yes', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat8, 'multiple_choice', N'Does ''ball'' rhyme with ''wall''?', N'["Yes", "No"]', N'Yes', 12);

-- 9. Color Words (12 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@tkcat9, 'fill_blank', N'What color is this? 🍎', NULL, N'red', 1, 'emoji', N'{"emoji": "🍎"}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@tkcat9, 'fill_blank', N'What color is this? 🍊', NULL, N'orange', 2, 'emoji', N'{"emoji": "🍊"}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@tkcat9, 'fill_blank', N'What color is this? 🍌', NULL, N'yellow', 3, 'emoji', N'{"emoji": "🍌"}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@tkcat9, 'fill_blank', N'What color is this? 🥦', NULL, N'green', 4, 'emoji', N'{"emoji": "🥦"}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@tkcat9, 'fill_blank', N'What color is this? 🫐', NULL, N'blue', 5, 'emoji', N'{"emoji": "🫐"}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@tkcat9, 'fill_blank', N'What color is this? 🍇', NULL, N'purple', 6, 'emoji', N'{"emoji": "🍇"}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@tkcat9, 'fill_blank', N'What color is this? 🎀', NULL, N'pink', 7, 'emoji', N'{"emoji": "🎀"}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@tkcat9, 'fill_blank', N'What color is this? 🐻', NULL, N'brown', 8, 'emoji', N'{"emoji": "🐻"}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@tkcat9, 'fill_blank', N'What color is this? ⚫', NULL, N'black', 9, 'emoji', N'{"emoji": "⚫"}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@tkcat9, 'fill_blank', N'What color is this? ⚪', NULL, N'white', 10, 'emoji', N'{"emoji": "⚪"}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@tkcat9, 'fill_blank', N'What color is this? 🍓', NULL, N'red', 11, 'emoji', N'{"emoji": "🍓"}');
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES (@tkcat9, 'fill_blank', N'What color is this? 🍋', NULL, N'yellow', 12, 'emoji', N'{"emoji": "🍋"}');

-- 10. AB Patterns (9 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat10, 'fill_blank', N'🔴🔵🔴🔵🔴 ___', NULL, N'🔵 (blue circle)', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat10, 'fill_blank', N'⭐🌙⭐🌙⭐ ___', NULL, N'🌙 (moon)', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat10, 'fill_blank', N'🐱🐶🐱🐶🐱 ___', NULL, N'🐶 (dog)', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat10, 'fill_blank', N'🍎🍌🍎🍌🍎 ___', NULL, N'🍌 (banana)', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat10, 'fill_blank', N'🟦🟨🟦🟨🟦 ___', NULL, N'🟨 (yellow square)', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat10, 'fill_blank', N'🎈🎉🎈🎉🎈 ___', NULL, N'🎉 (party popper)', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat10, 'fill_blank', N'🐝🌸🐝🌸🐝 ___', NULL, N'🌸 (flower)', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat10, 'fill_blank', N'⚽🏀⚽🏀⚽ ___', NULL, N'🏀 (basketball)', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat10, 'fill_blank', N'🔺🔵🔺🔵🔺 ___', NULL, N'🔵 (blue circle)', 9);

-- 11. Listening & Feelings Check-In (5 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat11, 'short_response', N'How do you think Max felt when he was lost in the park?', NULL, N'Answers will vary (e.g., scared, sad, worried).', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat11, 'short_response', N'Who helped Max find his way home?', NULL, N'Mia', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat11, 'short_response', N'How do you think Max felt when he saw his family again?', NULL, N'Answers will vary (e.g., happy, excited, relieved).', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat11, 'short_response', N'What was your favorite part of the story?', NULL, N'Answers will vary.', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat11, 'short_response', N'Have you ever felt lost or scared? Tell a grown-up about it.', NULL, N'Answers will vary.', 5);

-- 12. Puzzle: Match the Picture (1 question)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@tkcat12, 'word_search', N'Find these words: CAT, DOG, SUN, HAT, RUN, BIG', NULL, N'CAT, DOG, SUN, HAT, RUN, BIG', 1);

END
GO
