-- 56_grade6_content.sql
-- Grade 6, content bank — 30 original categories drawn from the ABC
-- Unified Grade 6 category list. Most categories carry more questions
-- than their target_count so weekly composition genuinely varies.

IF NOT EXISTS (SELECT 1 FROM dbo.PacketCategories WHERE grade_id = 7)
BEGIN
DECLARE @g6cat1 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (7, 'math', N'Ratios & Rates', 'short_answer', 10, NULL);
SET @g6cat1 = SCOPE_IDENTITY();

DECLARE @g6cat2 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (7, 'math', N'Percentages', 'short_answer', 10, NULL);
SET @g6cat2 = SCOPE_IDENTITY();

DECLARE @g6cat3 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (7, 'math', N'Integer Operations', 'short_answer', 10, NULL);
SET @g6cat3 = SCOPE_IDENTITY();

DECLARE @g6cat4 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (7, 'math', N'Order of Operations with Exponents', 'short_answer', 10, NULL);
SET @g6cat4 = SCOPE_IDENTITY();

DECLARE @g6cat5 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (7, 'math', N'One-Step & Two-Step Equations', 'short_answer', 10, NULL);
SET @g6cat5 = SCOPE_IDENTITY();

DECLARE @g6cat6 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (7, 'math', N'Evaluating Expressions with Variables', 'short_answer', 10, NULL);
SET @g6cat6 = SCOPE_IDENTITY();

DECLARE @g6cat7 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (7, 'math', N'Area of Triangles, Parallelograms & Composite Figures', 'short_answer', 10, NULL);
SET @g6cat7 = SCOPE_IDENTITY();

DECLARE @g6cat8 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (7, 'math', N'Surface Area & Volume of Rectangular Prisms', 'short_answer', 10, NULL);
SET @g6cat8 = SCOPE_IDENTITY();

DECLARE @g6cat9 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (7, 'math', N'Statistics: Mean, Median, Mode & Range', 'short_answer', 10, NULL);
SET @g6cat9 = SCOPE_IDENTITY();

DECLARE @g6cat10 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (7, 'math', N'Coordinate Plane (All Four Quadrants)', 'short_answer', 10, NULL);
SET @g6cat10 = SCOPE_IDENTITY();

DECLARE @g6cat11 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (7, 'math', N'Proportional Reasoning Word Problems', 'space_heavy', 8, NULL);
SET @g6cat11 = SCOPE_IDENTITY();

DECLARE @g6cat12 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (7, 'ela', N'Theme & Central Idea (Advanced Text)', 'short_answer', 10, NULL);
SET @g6cat12 = SCOPE_IDENTITY();

DECLARE @g6cat13 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (7, 'ela', N'Figurative Language & Tone', 'short_answer', 10, NULL);
SET @g6cat13 = SCOPE_IDENTITY();

DECLARE @g6cat14 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (7, 'ela', N'Text Structure & Organization', 'short_answer', 10, NULL);
SET @g6cat14 = SCOPE_IDENTITY();

DECLARE @g6cat15 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (7, 'ela', N'Author''s Craft & Word Choice', 'short_answer', 10, NULL);
SET @g6cat15 = SCOPE_IDENTITY();

DECLARE @g6cat16 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (7, 'ela', N'Evaluating Arguments & Claims', 'short_answer', 10, NULL);
SET @g6cat16 = SCOPE_IDENTITY();

DECLARE @g6cat17 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (7, 'ela', N'Grammar: Active & Passive Voice', 'short_answer', 10, NULL);
SET @g6cat17 = SCOPE_IDENTITY();

DECLARE @g6cat18 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (7, 'ela', N'Grammar: Pronoun-Antecedent Agreement', 'short_answer', 10, NULL);
SET @g6cat18 = SCOPE_IDENTITY();

DECLARE @g6cat19 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (7, 'ela', N'Vocabulary: Greek & Latin Roots', 'short_answer', 10, NULL);
SET @g6cat19 = SCOPE_IDENTITY();

DECLARE @g6cat20 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (7, 'ela', N'Context Clues (Advanced)', 'short_answer', 10, NULL);
SET @g6cat20 = SCOPE_IDENTITY();

DECLARE @g6cat21 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (7, 'ela', N'Reading Comprehension', 'space_heavy', 6, N'The Great Migration of the Monarch Butterfly

Every autumn, millions of monarch butterflies begin one of the most remarkable journeys in the animal kingdom. These small orange-and-black insects, weighing less than a paperclip, travel up to 3,000 miles from the northern United States and Canada to the forests of central Mexico. What makes this migration even more astonishing is that no single butterfly completes the entire round trip. It takes four or five generations of monarchs to finish one full migration cycle.

Scientists have long wondered how monarchs find their way to the same mountain forests their great-great-grandparents visited, even though they have never been there before. Researchers believe monarchs use a combination of the sun''s position and an internal magnetic compass to navigate. This allows them to stay on course even on cloudy days when the sun isn''t visible.

The monarchs'' journey isn''t just impressive — it''s essential. Along the way, they pollinate flowers and serve as food for birds and other predators, playing an important role in many ecosystems. Sadly, monarch populations have declined sharply in recent decades due to habitat loss and the disappearance of milkweed, the only plant monarch caterpillars eat.

Conservationists are now working to plant milkweed gardens along the monarchs'' migration route to help reverse this decline. By protecting the plants monarchs depend on, people hope to ensure that this incredible journey continues for generations to come.');
SET @g6cat21 = SCOPE_IDENTITY();

DECLARE @g6cat22 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (7, 'writing', N'Argumentative Essay Planning', 'space_heavy', 8, N'Plan your argumentative essay below, then write it on a separate sheet or the back of this page.');
SET @g6cat22 = SCOPE_IDENTITY();

DECLARE @g6cat23 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (7, 'writing', N'Narrative/Personal Essay Planning (With Literary Devices)', 'space_heavy', 8, N'Plan your narrative or personal essay below, then write it on a separate sheet or the back of this page.');
SET @g6cat23 = SCOPE_IDENTITY();

DECLARE @g6cat24 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (7, 'science', N'Cells & Body Systems', 'short_answer', 10, NULL);
SET @g6cat24 = SCOPE_IDENTITY();

DECLARE @g6cat25 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (7, 'science', N'Earth''s Structure, Plate Tectonics & Weathering', 'short_answer', 10, NULL);
SET @g6cat25 = SCOPE_IDENTITY();

DECLARE @g6cat26 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (7, 'social_studies', N'Ancient Civilizations Survey', 'short_answer', 10, NULL);
SET @g6cat26 = SCOPE_IDENTITY();

DECLARE @g6cat27 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (7, 'social_studies', N'Comparing Government Systems', 'short_answer', 8, NULL);
SET @g6cat27 = SCOPE_IDENTITY();

DECLARE @g6cat28 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (7, 'social_studies', N'Economics: Global Trade & Personal Finance Basics', 'short_answer', 8, NULL);
SET @g6cat28 = SCOPE_IDENTITY();

DECLARE @g6cat29 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (7, 'puzzle', N'Word Search Puzzle', 'puzzle', 1, NULL);
SET @g6cat29 = SCOPE_IDENTITY();

DECLARE @g6cat30 INT;
INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text) VALUES (7, 'puzzle', N'Logic Grid Puzzle', 'space_heavy', 1, NULL);
SET @g6cat30 = SCOPE_IDENTITY();

-- 1. Ratios & Rates (13 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat1, 'fill_blank', N'Simplify the ratio 12:18 to simplest form.', NULL, N'2:3', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat1, 'fill_blank', N'Simplify the ratio 15:25 to simplest form.', NULL, N'3:5', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat1, 'fill_blank', N'Simplify the ratio 8:20 to simplest form.', NULL, N'2:5', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat1, 'fill_blank', N'Simplify the ratio 21:14 to simplest form.', NULL, N'3:2', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat1, 'fill_blank', N'Simplify the ratio 16:24 to simplest form.', NULL, N'2:3', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat1, 'short_response', N'A car travels 240 miles in 4 hours. What is its speed in miles per hour?', NULL, N'60 mph', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat1, 'short_response', N'If 5 pencils cost $2, what is the unit cost of 1 pencil?', NULL, N'$0.40', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat1, 'fill_blank', N'A recipe uses 3 cups of flour for every 2 cups of sugar. Write this as a ratio.', NULL, N'3:2', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat1, 'short_response', N'A printer prints 45 pages in 9 minutes. What is its rate in pages per minute?', NULL, N'5 pages per minute', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat1, 'fill_blank', N'Simplify the ratio 45:60 to simplest form.', NULL, N'3:4', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat1, 'fill_blank', N'There are 18 boys and 24 girls in a class. Write the ratio of boys to girls in simplest form.', NULL, N'3:4', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat1, 'short_response', N'A car uses 6 gallons of gas to travel 210 miles. What is its rate in miles per gallon?', NULL, N'35 miles per gallon', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat1, 'fill_blank', N'Simplify the ratio 27:9 to simplest form.', NULL, N'3:1', 13);

-- 2. Percentages (13 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat2, 'fill_blank', N'What is 25% of 80?', NULL, N'20', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat2, 'fill_blank', N'What is 10% of 150?', NULL, N'15', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat2, 'fill_blank', N'What is 50% of 64?', NULL, N'32', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat2, 'fill_blank', N'What is 20% of 45?', NULL, N'9', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat2, 'fill_blank', N'What is 75% of 120?', NULL, N'90', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat2, 'fill_blank', N'What is 15% of 200?', NULL, N'30', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat2, 'fill_blank', N'What is 5% of 60?', NULL, N'3', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat2, 'short_response', N'A shirt costs $40. It goes on sale for 25% off. What is the new price?', NULL, N'$30', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat2, 'short_response', N'A $50 jacket increases in price by 20%. What is the new price?', NULL, N'$60', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat2, 'short_response', N'A book priced at $20 is discounted 30%. What is the sale price?', NULL, N'$14', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat2, 'short_response', N'Last year 40 students joined the chess club. This year 50 joined. What is the percent increase?', NULL, N'25%', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat2, 'short_response', N'A population of 200 animals dropped to 150. What is the percent decrease?', NULL, N'25%', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat2, 'fill_blank', N'What is 40% of 90?', NULL, N'36', 13);

-- 3. Integer Operations (13 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat3, 'fill_blank', N'-8 + 5 = ___', NULL, N'-3', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat3, 'fill_blank', N'7 - (-4) = ___', NULL, N'11', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat3, 'fill_blank', N'-6 - 9 = ___', NULL, N'-15', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat3, 'fill_blank', N'-3 × 4 = ___', NULL, N'-12', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat3, 'fill_blank', N'-9 × -6 = ___', NULL, N'54', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat3, 'fill_blank', N'24 ÷ -6 = ___', NULL, N'-4', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat3, 'fill_blank', N'-35 ÷ -7 = ___', NULL, N'5', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat3, 'fill_blank', N'12 + (-15) = ___', NULL, N'-3', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat3, 'fill_blank', N'-20 + 8 = ___', NULL, N'-12', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat3, 'fill_blank', N'-14 - (-6) = ___', NULL, N'-8', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat3, 'fill_blank', N'8 × -7 = ___', NULL, N'-56', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat3, 'fill_blank', N'-45 ÷ 9 = ___', NULL, N'-5', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat3, 'fill_blank', N'-11 + (-13) = ___', NULL, N'-24', 13);

-- 4. Order of Operations with Exponents (13 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat4, 'fill_blank', N'3 + 2² × 4 = ___', NULL, N'19', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat4, 'fill_blank', N'(5 - 2)² + 6 = ___', NULL, N'15', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat4, 'fill_blank', N'2³ + 3 × 5 = ___', NULL, N'23', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat4, 'fill_blank', N'20 - 3² × 2 = ___', NULL, N'2', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat4, 'fill_blank', N'4² ÷ 2 + 6 = ___', NULL, N'14', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat4, 'fill_blank', N'(4 + 1)² - 10 = ___', NULL, N'15', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat4, 'fill_blank', N'6 + 2 × 3² = ___', NULL, N'24', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat4, 'fill_blank', N'50 - 4² × 3 = ___', NULL, N'2', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat4, 'fill_blank', N'3² + 4² = ___', NULL, N'25', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat4, 'fill_blank', N'(8 - 5)³ = ___', NULL, N'27', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat4, 'fill_blank', N'10 + 5² - 8 = ___', NULL, N'27', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat4, 'fill_blank', N'2 × (3 + 4)² = ___', NULL, N'98', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat4, 'fill_blank', N'100 ÷ 5² = ___', NULL, N'4', 13);

-- 5. One-Step & Two-Step Equations (13 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat5, 'fill_blank', N'x + 7 = 15. Solve for x.', NULL, N'x = 8', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat5, 'fill_blank', N'x - 9 = 4. Solve for x.', NULL, N'x = 13', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat5, 'fill_blank', N'5x = 35. Solve for x.', NULL, N'x = 7', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat5, 'fill_blank', N'x/4 = 6. Solve for x.', NULL, N'x = 24', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat5, 'fill_blank', N'2x + 3 = 11. Solve for x.', NULL, N'x = 4', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat5, 'fill_blank', N'3x - 5 = 16. Solve for x.', NULL, N'x = 7', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat5, 'fill_blank', N'4x + 6 = 30. Solve for x.', NULL, N'x = 6', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat5, 'fill_blank', N'x/3 + 2 = 9. Solve for x.', NULL, N'x = 21', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat5, 'fill_blank', N'6x - 4 = 20. Solve for x.', NULL, N'x = 4', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat5, 'fill_blank', N'2x - 7 = 9. Solve for x.', NULL, N'x = 8', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat5, 'fill_blank', N'x + 15 = 22. Solve for x.', NULL, N'x = 7', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat5, 'fill_blank', N'5x + 2 = 27. Solve for x.', NULL, N'x = 5', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat5, 'fill_blank', N'3x + 8 = 29. Solve for x.', NULL, N'x = 7', 13);

-- 6. Evaluating Expressions with Variables (13 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat6, 'fill_blank', N'Evaluate 3x + 4 when x = 5.', NULL, N'19', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat6, 'fill_blank', N'Evaluate 2x - 7 when x = 6.', NULL, N'5', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat6, 'fill_blank', N'Evaluate x² + 1 when x = 4.', NULL, N'17', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat6, 'fill_blank', N'Evaluate 5x - y when x = 4 and y = 3.', NULL, N'17', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat6, 'fill_blank', N'Evaluate x + 2y when x = 6 and y = 4.', NULL, N'14', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat6, 'fill_blank', N'Evaluate 4(x + 3) when x = 2.', NULL, N'20', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat6, 'fill_blank', N'Evaluate xy - 3 when x = 5 and y = 2.', NULL, N'7', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat6, 'fill_blank', N'Evaluate 2x² when x = 3.', NULL, N'18', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat6, 'fill_blank', N'Evaluate (x + y) ÷ 2 when x = 8 and y = 4.', NULL, N'6', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat6, 'fill_blank', N'Evaluate 3x + 2y when x = 3 and y = 5.', NULL, N'19', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat6, 'fill_blank', N'Evaluate x/2 + y when x = 10 and y = 3.', NULL, N'8', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat6, 'fill_blank', N'Evaluate 6 + 5x when x = 4.', NULL, N'26', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat6, 'fill_blank', N'Evaluate x² - y when x = 5 and y = 10.', NULL, N'15', 13);

-- 7. Area of Triangles, Parallelograms & Composite Figures (13 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat7, 'fill_blank', N'A triangle has a base of 10 cm and a height of 6 cm. What is its area?', NULL, N'30 sq cm', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat7, 'fill_blank', N'A triangle has a base of 8 cm and a height of 9 cm. What is its area?', NULL, N'36 sq cm', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat7, 'fill_blank', N'A parallelogram has a base of 12 cm and a height of 5 cm. What is its area?', NULL, N'60 sq cm', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat7, 'fill_blank', N'A parallelogram has a base of 7 cm and a height of 8 cm. What is its area?', NULL, N'56 sq cm', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat7, 'fill_blank', N'A triangle has a base of 14 cm and a height of 4 cm. What is its area?', NULL, N'28 sq cm', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat7, 'fill_blank', N'A parallelogram has a base of 9 cm and a height of 10 cm. What is its area?', NULL, N'90 sq cm', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat7, 'fill_blank', N'A triangle has a base of 16 cm and a height of 5 cm. What is its area?', NULL, N'40 sq cm', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat7, 'fill_blank', N'A composite figure is a 6 cm by 8 cm rectangle with a right triangle (base 6 cm, height 4 cm) attached to one side. What is the total area?', NULL, N'60 sq cm', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat7, 'fill_blank', N'A composite figure is a 10 cm by 4 cm rectangle with a triangle (base 10 cm, height 3 cm) on top. What is the total area?', NULL, N'55 sq cm', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat7, 'fill_blank', N'A parallelogram has a base of 15 cm and a height of 6 cm. What is its area?', NULL, N'90 sq cm', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat7, 'fill_blank', N'A triangle has a base of 20 cm and a height of 7 cm. What is its area?', NULL, N'70 sq cm', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat7, 'fill_blank', N'A composite figure is an 8 cm by 5 cm rectangle with a triangle (base 8 cm, height 6 cm) on top. What is the total area?', NULL, N'64 sq cm', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat7, 'fill_blank', N'A triangle has a base of 12 cm and a height of 11 cm. What is its area?', NULL, N'66 sq cm', 13);

-- 8. Surface Area & Volume of Rectangular Prisms (13 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat8, 'fill_blank', N'A rectangular prism has length 4 cm, width 3 cm, and height 5 cm. What is its volume?', NULL, N'60 cubic cm', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat8, 'fill_blank', N'A rectangular prism has length 6 cm, width 2 cm, and height 4 cm. What is its volume?', NULL, N'48 cubic cm', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat8, 'fill_blank', N'A rectangular prism has length 5 cm, width 5 cm, and height 3 cm. What is its volume?', NULL, N'75 cubic cm', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat8, 'fill_blank', N'A rectangular prism has length 8 cm, width 3 cm, and height 2 cm. What is its volume?', NULL, N'48 cubic cm', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat8, 'fill_blank', N'A rectangular prism has length 10 cm, width 4 cm, and height 2 cm. What is its volume?', NULL, N'80 cubic cm', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat8, 'fill_blank', N'A cube has sides of 6 cm. What is its volume?', NULL, N'216 cubic cm', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat8, 'fill_blank', N'A rectangular prism has length 4 cm, width 3 cm, and height 5 cm. What is its surface area?', NULL, N'94 sq cm', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat8, 'fill_blank', N'A rectangular prism has length 6 cm, width 2 cm, and height 4 cm. What is its surface area?', NULL, N'88 sq cm', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat8, 'fill_blank', N'A rectangular prism has length 5 cm, width 4 cm, and height 3 cm. What is its surface area?', NULL, N'94 sq cm', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat8, 'fill_blank', N'A cube has sides of 4 cm. What is its surface area?', NULL, N'96 sq cm', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat8, 'fill_blank', N'A rectangular prism has length 7 cm, width 3 cm, and height 2 cm. What is its volume?', NULL, N'42 cubic cm', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat8, 'fill_blank', N'A rectangular prism has length 9 cm, width 2 cm, and height 5 cm. What is its surface area?', NULL, N'146 sq cm', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat8, 'fill_blank', N'A cube has sides of 5 cm. What is its volume?', NULL, N'125 cubic cm', 13);

-- 9. Statistics: Mean, Median, Mode & Range (13 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat9, 'fill_blank', N'Find the mean of 4, 8, 6, 10, 2.', NULL, N'6', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat9, 'fill_blank', N'Find the median of 7, 2, 9, 4, 5.', NULL, N'5', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat9, 'fill_blank', N'Find the mode of 3, 5, 5, 7, 5, 9.', NULL, N'5', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat9, 'fill_blank', N'Find the range of 12, 4, 18, 7, 15.', NULL, N'14', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat9, 'fill_blank', N'Find the mean of 10, 20, 30, 40.', NULL, N'25', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat9, 'fill_blank', N'Find the median of 6, 1, 8, 3, 10, 2.', NULL, N'4.5', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat9, 'fill_blank', N'Find the mode of 2, 4, 4, 6, 8, 4, 2.', NULL, N'4', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat9, 'fill_blank', N'Find the range of 100, 85, 92, 78, 95.', NULL, N'22', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat9, 'fill_blank', N'Find the mean of 5, 7, 9, 11, 13.', NULL, N'9', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat9, 'fill_blank', N'Find the median of 15, 22, 9, 30, 18, 4.', NULL, N'16.5', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat9, 'fill_blank', N'Find the mode of 11, 14, 11, 17, 20, 11, 14.', NULL, N'11', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat9, 'fill_blank', N'Find the range of 6, 19, 3, 25, 12.', NULL, N'22', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat9, 'fill_blank', N'Find the mean of 2, 3, 4, 5, 6, 10.', NULL, N'5', 13);

-- 10. Coordinate Plane (All Four Quadrants) (13 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat10, 'fill_blank', N'In which quadrant is the point (3, 5)?', NULL, N'Quadrant I', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat10, 'fill_blank', N'In which quadrant is the point (-4, 2)?', NULL, N'Quadrant II', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat10, 'fill_blank', N'In which quadrant is the point (-6, -3)?', NULL, N'Quadrant III', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat10, 'fill_blank', N'In which quadrant is the point (5, -7)?', NULL, N'Quadrant IV', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat10, 'fill_blank', N'What is the reflection of point (4, 6) across the x-axis?', NULL, N'(4, -6)', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat10, 'fill_blank', N'What is the reflection of point (-3, 5) across the y-axis?', NULL, N'(3, 5)', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat10, 'fill_blank', N'What is the reflection of point (2, -8) across the x-axis?', NULL, N'(2, 8)', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat10, 'fill_blank', N'What is the reflection of point (-5, -2) across the y-axis?', NULL, N'(5, -2)', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat10, 'fill_blank', N'In which quadrant is the point (-1, -9)?', NULL, N'Quadrant III', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat10, 'fill_blank', N'In which quadrant is the point (8, 1)?', NULL, N'Quadrant I', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat10, 'fill_blank', N'What is the distance between (2, 4) and (2, -3) on the coordinate plane?', NULL, N'7 units', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat10, 'fill_blank', N'What is the distance between (-5, 3) and (4, 3) on the coordinate plane?', NULL, N'9 units', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat10, 'fill_blank', N'In which quadrant is the point (-2, 6)?', NULL, N'Quadrant II', 13);

-- 11. Proportional Reasoning Word Problems (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat11, 'short_response', N'A recipe calls for 2 cups of flour to make 12 cookies. How many cups of flour are needed to make 30 cookies?', NULL, N'5 cups', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat11, 'short_response', N'If 4 notebooks cost $10, how much would 10 notebooks cost at the same rate?', NULL, N'$25', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat11, 'short_response', N'A car travels 150 miles using 6 gallons of gas. How many gallons would it need to travel 400 miles at the same rate?', NULL, N'16 gallons', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat11, 'short_response', N'Ollie the Owl counted 8 mice in 2 hours while hunting. At that same rate, how many mice would Ollie catch in 5 hours?', NULL, N'20 mice', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat11, 'short_response', N'A painter can paint 3 walls in 2 days. At that rate, how many walls can she paint in 8 days?', NULL, N'12 walls', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat11, 'short_response', N'If 5 apples cost $3, how much would 15 apples cost at the same rate?', NULL, N'$9', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat11, 'short_response', N'Ollie the Owl uses 3 twigs to build every 1 foot of nest. If Ollie''s nest is 9 feet around, how many twigs did Ollie use?', NULL, N'27 twigs', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat11, 'short_response', N'A recipe uses 3 eggs for every 4 cups of milk. How many eggs are needed for 16 cups of milk?', NULL, N'12 eggs', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat11, 'short_response', N'A factory produces 240 toys in 8 hours. At the same rate, how many toys are produced in 3 hours?', NULL, N'90 toys', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat11, 'short_response', N'If a runner covers 5 kilometers in 25 minutes, how many minutes would it take to cover 8 kilometers at the same pace?', NULL, N'40 minutes', 10);

-- 12. Theme & Central Idea (Advanced Text) (13 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat12, 'short_response', N'A young athlete trains every day despite losing every race, and eventually wins the championship. What is the most likely theme of this story?', NULL, N'Perseverance and hard work lead to success', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat12, 'short_response', N'In a story, a wealthy man discovers happiness only after helping others less fortunate than himself. What is the central theme?', NULL, N'True happiness comes from generosity and helping others', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat12, 'short_response', N'A fable ends with a slow but steady turtle beating a fast but overconfident hare in a race. What is the theme?', NULL, N'Slow and steady wins the race; persistence beats overconfidence', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat12, 'short_response', N'A passage describes how a small town rebuilds together after a flood, with neighbors helping neighbors. What is the central idea?', NULL, N'Community and cooperation help people overcome hardship', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat12, 'short_response', N'A character refuses to give up on her dream of becoming a scientist, even when others doubt her. What is the theme?', NULL, N'Believing in yourself and staying determined leads to success', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat12, 'short_response', N'An article explains three renewable energy sources and how each reduces pollution. What is the central idea?', NULL, N'Renewable energy sources can help reduce pollution', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat12, 'short_response', N'In a story, a boy learns that lying to his friends only causes more problems in the end. What is the theme?', NULL, N'Honesty is important; lying causes more harm than good', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat12, 'short_response', N'A passage explains the water cycle, describing evaporation, condensation, and precipitation. What is the central idea?', NULL, N'The water cycle moves water through different stages/forms', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat12, 'short_response', N'A character who was once selfish learns to share after seeing how it helps her classmates. What is the theme?', NULL, N'Sharing and kindness benefit everyone', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat12, 'short_response', N'An article compares the eating habits of different ocean animals and how they depend on each other. What is the central idea?', NULL, N'Ocean animals are connected through what they eat (a food web)', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat12, 'short_response', N'A story follows a boy who fears the dark until he learns to face his fears one night at a time. What is the theme?', NULL, N'Facing your fears makes you stronger; courage grows with practice', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat12, 'short_response', N'A passage describes how bees pollinate flowers and why this matters for growing food. What is the central idea?', NULL, N'Bees play an important role in pollinating the plants that produce our food', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat12, 'short_response', N'In a story, two rival teams learn to work together to win a bigger competition. What is the theme?', NULL, N'Teamwork and cooperation accomplish more than working alone', 13);

-- 13. Figurative Language & Tone (13 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat13, 'multiple_choice', N'“The waves roared angrily against the shore.” — identify the figurative language.', N'["simile", "metaphor", "personification", "hyperbole"]', N'personification', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat13, 'multiple_choice', N'“Her laughter was music to his ears.” — identify the figurative language.', N'["simile", "metaphor", "personification", "hyperbole"]', N'metaphor', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat13, 'multiple_choice', N'“The runner was as quick as lightning.” — identify the figurative language.', N'["simile", "metaphor", "personification", "hyperbole"]', N'simile', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat13, 'multiple_choice', N'“I''ve told you a million times to clean your room!” — identify the figurative language.', N'["simile", "metaphor", "personification", "hyperbole"]', N'hyperbole', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat13, 'multiple_choice', N'“The stars winked at us from the night sky.” — identify the figurative language.', N'["simile", "metaphor", "personification", "hyperbole"]', N'personification', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat13, 'multiple_choice', N'“Life is a rollercoaster full of ups and downs.” — identify the figurative language.', N'["simile", "metaphor", "personification", "hyperbole"]', N'metaphor', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat13, 'multiple_choice', N'“The soup was as hot as fire.” — identify the figurative language.', N'["simile", "metaphor", "personification", "hyperbole"]', N'simile', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat13, 'multiple_choice', N'“My backpack weighs a ton!” — identify the figurative language.', N'["simile", "metaphor", "personification", "hyperbole"]', N'hyperbole', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat13, 'multiple_choice', N'A story describes a character sneaking through a dark house with creaking floors and shadows on the wall. What is the tone of this passage?', N'["suspenseful", "cheerful", "humorous"]', N'suspenseful', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat13, 'multiple_choice', N'A passage describes a sunny picnic with laughing children and a gentle breeze. What is the tone?', N'["gloomy", "joyful", "tense"]', N'joyful', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat13, 'multiple_choice', N'A character says, “Oh great, ANOTHER pop quiz. Just what I always wanted,” after learning about a surprise test. What is the tone?', N'["sarcastic", "excited", "peaceful"]', N'sarcastic', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat13, 'multiple_choice', N'A news article states the exact statistics and dates of a historical event without any emotional language. What is the tone?', N'["objective", "angry", "playful"]', N'objective', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat13, 'multiple_choice', N'“The old oak tree stood as a silent guardian over the empty playground.” — identify the figurative language.', N'["simile", "metaphor", "personification", "hyperbole"]', N'personification', 13);

-- 14. Text Structure & Organization (13 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat14, 'multiple_choice', N'A passage explains how volcanoes and earthquakes are similar and different. What text structure is used?', N'["compare and contrast", "cause and effect", "sequence", "problem and solution", "description"]', N'compare and contrast', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat14, 'multiple_choice', N'A passage explains that pollution causes fish populations to decline. What text structure is used?', N'["compare and contrast", "cause and effect", "sequence", "problem and solution", "description"]', N'cause and effect', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat14, 'multiple_choice', N'A passage lists the steps to plant a garden, from preparing soil to watering seeds. What text structure is used?', N'["compare and contrast", "cause and effect", "sequence", "problem and solution", "description"]', N'sequence', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat14, 'multiple_choice', N'A passage describes a litter problem in a park and then explains a cleanup plan the city created. What text structure is used?', N'["compare and contrast", "cause and effect", "sequence", "problem and solution", "description"]', N'problem and solution', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat14, 'multiple_choice', N'A passage describes the colors, shape, and texture of a coral reef in detail. What text structure is used?', N'["compare and contrast", "cause and effect", "sequence", "problem and solution", "description"]', N'description', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat14, 'multiple_choice', N'A passage explains the causes and effects of climate change. What text structure is used?', N'["compare and contrast", "cause and effect", "sequence", "problem and solution", "description"]', N'cause and effect', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat14, 'multiple_choice', N'A passage compares how mammals and reptiles care for their young. What text structure is used?', N'["compare and contrast", "cause and effect", "sequence", "problem and solution", "description"]', N'compare and contrast', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat14, 'multiple_choice', N'A passage explains the order of events leading up to the American Revolution. What text structure is used?', N'["compare and contrast", "cause and effect", "sequence", "problem and solution", "description"]', N'sequence', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat14, 'multiple_choice', N'A passage explains that a town has a water shortage and describes a new conservation program to fix it. What text structure is used?', N'["compare and contrast", "cause and effect", "sequence", "problem and solution", "description"]', N'problem and solution', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat14, 'multiple_choice', N'A passage describes what happens step-by-step when you bake bread, from mixing to baking. What text structure is used?', N'["compare and contrast", "cause and effect", "sequence", "problem and solution", "description"]', N'sequence', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat14, 'multiple_choice', N'A passage explains how too much screen time can affect sleep. What text structure is used?', N'["compare and contrast", "cause and effect", "sequence", "problem and solution", "description"]', N'cause and effect', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat14, 'multiple_choice', N'A passage explains the similarities and differences between two ancient civilizations. What text structure is used?', N'["compare and contrast", "cause and effect", "sequence", "problem and solution", "description"]', N'compare and contrast', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat14, 'multiple_choice', N'A passage vividly describes the sounds, smells, and sights of a rainforest. What text structure is used?', N'["compare and contrast", "cause and effect", "sequence", "problem and solution", "description"]', N'description', 13);

-- 15. Author's Craft & Word Choice (13 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat15, 'fill_blank', N'Both “thrifty” and “stingy” describe someone careful with money, but which word has a more negative connotation?', NULL, N'stingy', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat15, 'short_response', N'An author describes a house as “ancient” instead of “old.” What effect does this word choice have?', NULL, N'It makes the house sound more mysterious and impressively aged', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat15, 'fill_blank', N'Both “unique” and “weird” describe something different from the norm, but which word has a more positive connotation?', NULL, N'unique', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat15, 'short_response', N'An author writes that the villain “smirked” instead of “smiled.” What does this word choice suggest about the villain?', NULL, N'It suggests the villain feels sly, superior, or mocking', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat15, 'fill_blank', N'Both “curious” and “nosy” describe someone who wants to know things, but which word has a more negative connotation?', NULL, N'nosy', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat15, 'short_response', N'An author describes rain “pelting” the windows instead of “hitting” them. What effect does this word choice create?', NULL, N'It makes the rain sound harsher and more intense', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat15, 'fill_blank', N'Both “confident” and “cocky” describe someone who believes in themselves, but which word has a more negative connotation?', NULL, N'cocky', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat15, 'short_response', N'An author writes that a character “marched” into the room instead of “walked.” What does this suggest about the character''s mood?', NULL, N'It suggests the character is angry, determined, or upset', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat15, 'fill_blank', N'Both “slender” and “skinny” describe someone thin, but which word has a more negative connotation?', NULL, N'skinny', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat15, 'short_response', N'An author repeats the phrase “never again” three times at the end of a passage. What technique is this, and what effect does it create?', NULL, N'Repetition — it emphasizes the character''s determination and adds emphasis', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat15, 'fill_blank', N'Both “inexpensive” and “cheap” describe something that doesn''t cost much, but which word has a more positive connotation?', NULL, N'inexpensive', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat15, 'short_response', N'An author describes a character''s eyes as “blazing” instead of “bright.” What effect does this word choice have?', NULL, N'It makes the character seem intensely angry or passionate', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat15, 'fill_blank', N'Both “assertive” and “bossy” describe someone who takes charge, but which word has a more negative connotation?', NULL, N'bossy', 13);

-- 16. Evaluating Arguments & Claims (13 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat16, 'short_response', N'Claim: “Schools should start later in the day.” Evidence: “Studies show teenagers who sleep more perform better academically.” Does this evidence support the claim?', NULL, N'Yes, it directly supports the claim with research', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat16, 'short_response', N'Claim: “Dogs make the best pets.” Evidence: “My neighbor has a dog.” Does this evidence support the claim?', NULL, N'No, it doesn''t give a real reason why dogs are the best pets', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat16, 'short_response', N'In the sentence “We should ban plastic bags because they harm sea animals,” what is the claim?', NULL, N'We should ban plastic bags', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat16, 'short_response', N'In the sentence “We should ban plastic bags because they harm sea animals,” what is the reasoning/evidence?', NULL, N'They harm sea animals', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat16, 'short_response', N'Claim: “Recycling should be mandatory in every city.” Which piece of evidence is strongest: “Recycling helps the environment” or “Recycling reduced landfill waste by 30% in cities that require it”?', NULL, N'The second one — the specific statistic', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat16, 'short_response', N'An essay claims exercise improves mental health but only gives the writer''s personal opinion with no facts or studies. Is this argument well-supported?', NULL, N'No, it lacks factual evidence', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat16, 'short_response', N'Claim: “Students should have less homework.” Evidence: “A study found students with less homework reported lower stress and similar test scores.” Is this evidence relevant to the claim?', NULL, N'Yes, it directly relates to the claim', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat16, 'short_response', N'Identify the claim: “Solar energy is the best choice for our town because it is renewable and reduces electric bills.”', NULL, N'Solar energy is the best choice for our town', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat16, 'short_response', N'Identify the two pieces of evidence in: “Solar energy is the best choice for our town because it is renewable and reduces electric bills.”', NULL, N'It is renewable; it reduces electric bills', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat16, 'short_response', N'An argument states “Everyone knows video games are bad” without any facts. What is the weakness of this argument?', NULL, N'It''s just an opinion or assumption with no evidence', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat16, 'short_response', N'Claim: “Our school needs a new library.” Which is stronger evidence: “The current library only has 200 outdated books for 800 students” or “I don''t like the library”?', NULL, N'The first one — specific facts about the shortage', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat16, 'short_response', N'A writer argues that a new park should be built and includes a survey showing 80% of residents want one. What kind of evidence is this?', NULL, N'Statistical/survey evidence', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat16, 'short_response', N'Claim: “Cell phones should be allowed in class.” Evidence: “I really want to text my friends.” Is this evidence convincing?', NULL, N'No, it''s a personal want, not a strong reason', 13);

-- 17. Grammar: Active & Passive Voice (13 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat17, 'multiple_choice', N'“The dog chased the ball.” — is this sentence active or passive voice?', N'["active", "passive"]', N'active', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat17, 'multiple_choice', N'“The ball was chased by the dog.” — is this sentence active or passive voice?', N'["active", "passive"]', N'passive', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat17, 'short_response', N'Rewrite in active voice: “The cake was baked by Maria.”', NULL, N'Maria baked the cake.', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat17, 'short_response', N'Rewrite in passive voice: “The teacher graded the tests.”', NULL, N'The tests were graded by the teacher.', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat17, 'multiple_choice', N'“The window was broken by the storm.” — is this sentence active or passive voice?', N'["active", "passive"]', N'passive', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat17, 'multiple_choice', N'“The storm broke the window.” — is this sentence active or passive voice?', N'["active", "passive"]', N'active', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat17, 'short_response', N'Rewrite in active voice: “The letter was written by Sam.”', NULL, N'Sam wrote the letter.', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat17, 'short_response', N'Rewrite in passive voice: “The chef cooked the meal.”', NULL, N'The meal was cooked by the chef.', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat17, 'multiple_choice', N'“The scientists conducted the experiment.” — is this sentence active or passive voice?', N'["active", "passive"]', N'active', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat17, 'multiple_choice', N'“The experiment was conducted by the scientists.” — is this sentence active or passive voice?', N'["active", "passive"]', N'passive', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat17, 'short_response', N'Rewrite in active voice: “The trophy was won by our team.”', NULL, N'Our team won the trophy.', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat17, 'multiple_choice', N'“The artist painted the mural.” — is this sentence active or passive voice?', N'["active", "passive"]', N'active', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat17, 'short_response', N'Rewrite in passive voice: “The gardener planted the flowers.”', NULL, N'The flowers were planted by the gardener.', 13);

-- 18. Grammar: Pronoun-Antecedent Agreement (13 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat18, 'multiple_choice', N'Each student must bring ___ own pencil.', N'["his or her", "their"]', N'his or her', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat18, 'multiple_choice', N'The players celebrated because ___ team won the game.', N'["its", "their"]', N'their', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat18, 'multiple_choice', N'Neither Sam nor his brothers finished ___ homework.', N'["his", "their"]', N'their', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat18, 'multiple_choice', N'The committee announced ___ decision.', N'["its", "their"]', N'its', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat18, 'multiple_choice', N'Every dog needs ___ own bed.', N'["its", "their"]', N'its', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat18, 'multiple_choice', N'The girls forgot ___ lunches at home.', N'["her", "their"]', N'their', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat18, 'multiple_choice', N'A student should always check ___ work before submitting it.', N'["their", "his or her"]', N'his or her', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat18, 'multiple_choice', N'The class took ___ field trip on Friday.', N'["its", "their"]', N'its', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat18, 'multiple_choice', N'Both Maria and Ana brought ___ own lunch.', N'["her", "their"]', N'their', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat18, 'multiple_choice', N'Everyone should bring ___ own water bottle.', N'["their", "his or her"]', N'his or her', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat18, 'multiple_choice', N'The herd of elephants moved slowly across ___ path.', N'["its", "their"]', N'its', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat18, 'multiple_choice', N'Either Jake or his friends will bring ___ own snacks.', N'["his", "their"]', N'their', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat18, 'multiple_choice', N'The company changed ___ logo this year.', N'["its", "their"]', N'its', 13);

-- 19. Vocabulary: Greek & Latin Roots (13 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat19, 'fill_blank', N'The root “bio” means ___.', NULL, N'life', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat19, 'fill_blank', N'The root “graph” means ___.', NULL, N'write/writing', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat19, 'fill_blank', N'The root “tele” means ___.', NULL, N'far/distant', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat19, 'fill_blank', N'The root “aud” means ___.', NULL, N'hear', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat19, 'fill_blank', N'The root “port” means ___.', NULL, N'carry', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat19, 'fill_blank', N'The root “spect” means ___.', NULL, N'look/see', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat19, 'fill_blank', N'The root “dict” means ___.', NULL, N'speak/say', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat19, 'fill_blank', N'The root “scrib/script” means ___.', NULL, N'write', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat19, 'fill_blank', N'The root “phon” means ___.', NULL, N'sound', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat19, 'fill_blank', N'The root “chrono” means ___.', NULL, N'time', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat19, 'short_response', N'Using the root “bio” (life) and “graphy” (writing), what does “biography” mean?', NULL, N'The story/writing of someone''s life', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat19, 'short_response', N'Using the root “tele” (far) and “vision” (to see), what does “television” mean?', NULL, N'Seeing images from far away', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat19, 'short_response', N'Using the root “aud” (hear) and “ence” (state of), what does “audience” mean?', NULL, N'A group of people who hear/listen', 13);

-- 20. Context Clues (Advanced) (13 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat20, 'short_response', N'“The lecture was so tedious that half the audience fell asleep.” What does “tedious” most likely mean?', NULL, N'boring; long and dull', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat20, 'short_response', N'“Her meticulous notes included every detail of the experiment.” What does “meticulous” most likely mean?', NULL, N'extremely careful and precise', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat20, 'short_response', N'“The results of the study were ambiguous, so scientists couldn''t draw a clear conclusion.” What does “ambiguous” most likely mean?', NULL, N'unclear or open to more than one interpretation', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat20, 'short_response', N'“His candid response surprised everyone because he usually avoided the truth.” What does “candid” most likely mean?', NULL, N'honest and direct', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat20, 'short_response', N'“The archaeologists were elated when they finally unearthed the ancient artifact.” What does “elated” most likely mean?', NULL, N'extremely happy/excited', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat20, 'short_response', N'“The scarcity of clean water forced the village to ration its supply.” What does “scarcity” most likely mean?', NULL, N'a shortage; not enough of something', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat20, 'short_response', N'“The critics gave the movie a scathing review, calling it the worst of the year.” What does “scathing” most likely mean?', NULL, N'harshly critical', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat20, 'short_response', N'“Despite the chaos in the kitchen, the head chef remained composed.” What does “composed” most likely mean?', NULL, N'calm and in control', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat20, 'short_response', N'“The villain''s cryptic message left the detectives puzzled for days.” What does “cryptic” most likely mean?', NULL, N'mysterious; hard to understand', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat20, 'short_response', N'“The company''s profits were negligible this year, barely covering costs.” What does “negligible” most likely mean?', NULL, N'very small; not significant', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat20, 'short_response', N'“The teacher''s blunt feedback hurt his feelings, even though it was honest.” What does “blunt” most likely mean?', NULL, N'very direct, sometimes to the point of being harsh', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat20, 'short_response', N'“The hikers were relieved to reach the summit before the storm hit.” What does “summit” most likely mean?', NULL, N'the top/peak of a mountain', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat20, 'short_response', N'“The stubborn negotiator refused to compromise on any point.” What does “compromise” most likely mean?', NULL, N'to give up part of a demand to reach an agreement', 13);

-- 21. Reading Comprehension (6 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat21, 'short_response', N'According to the passage, how far can monarch butterflies travel during migration?', NULL, N'Up to 3,000 miles', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat21, 'short_response', N'Why is it surprising that monarchs can find their way to the same forests in Mexico?', NULL, N'Because it takes four or five generations to complete the migration, so no single butterfly has made the trip before', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat21, 'short_response', N'What two things do scientists believe monarchs use to navigate?', NULL, N'The sun''s position and an internal magnetic compass', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat21, 'short_response', N'What role do monarchs play in ecosystems along their migration route?', NULL, N'They pollinate flowers and serve as food for birds and other predators', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat21, 'short_response', N'Why have monarch populations declined in recent decades?', NULL, N'Habitat loss and the disappearance of milkweed', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat21, 'short_response', N'What is the main idea of this passage?', NULL, N'Monarch butterflies make a remarkable, multi-generation migration that is important to ecosystems but threatened by habitat loss', 6);

-- 22. Argumentative Essay Planning (8 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat22, 'short_response', N'What is your claim (the position you are arguing for)?', NULL, N'Open response — check for a clear, arguable claim.', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat22, 'short_response', N'What is your strongest piece of evidence to support your claim?', NULL, N'Open response — check for relevant, specific evidence.', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat22, 'short_response', N'What is a second piece of evidence or reasoning that supports your claim?', NULL, N'Open response — check for relevant, specific evidence.', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat22, 'short_response', N'What is a possible counterclaim (an argument someone might make against your position)?', NULL, N'Open response — check that the counterclaim is realistic and relevant.', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat22, 'short_response', N'How will you rebut (respond to) that counterclaim?', NULL, N'Open response — check for a reasonable, evidence-based rebuttal.', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat22, 'short_response', N'What transition words will you use to connect your ideas (for example, however, therefore, in addition)?', NULL, N'Open response — check for appropriate transition words.', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat22, 'short_response', N'How will you restate your claim in your conclusion?', NULL, N'Open response — check that the claim is restated clearly.', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat22, 'short_response', N'Who is your audience, and how might that shape your word choice and tone?', NULL, N'Open response — check for an identified audience and matching tone.', 8);

-- 23. Narrative/Personal Essay Planning (With Literary Devices) (8 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat23, 'short_response', N'What real (or realistic) experience will your narrative be about?', NULL, N'Open response — check for a clear, focused experience.', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat23, 'short_response', N'Who is the narrator, and what is their point of view (for example, first person)?', NULL, N'Open response — check for a consistent point of view.', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat23, 'short_response', N'What is the central conflict or challenge in your narrative?', NULL, N'Open response — check for a clear conflict or challenge.', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat23, 'short_response', N'Where and when does your story take place (setting)?', NULL, N'Open response — check for a clearly described setting.', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat23, 'short_response', N'What figurative language (simile, metaphor, or personification) could you use to describe a key moment?', NULL, N'Open response — check for at least one clear example of figurative language.', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat23, 'short_response', N'What sensory details (sight, sound, smell, touch, taste) will help your reader picture the scene?', NULL, N'Open response — check for vivid, specific sensory details.', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat23, 'short_response', N'How does the narrator change, or what do they learn, by the end of the story?', NULL, N'Open response — check for a clear change or lesson learned.', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat23, 'short_response', N'How will you use dialogue to bring a moment in your story to life?', NULL, N'Open response — check for a planned use of dialogue.', 8);

-- 24. Cells & Body Systems (13 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat24, 'fill_blank', N'The basic unit of life is the ___.', NULL, N'cell', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat24, 'fill_blank', N'The part of the cell that controls its activities is the ___.', NULL, N'nucleus', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat24, 'fill_blank', N'The jelly-like substance that fills a cell is called ___.', NULL, N'cytoplasm', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat24, 'fill_blank', N'The structure that acts like the “powerhouse” of the cell, producing energy, is the ___.', NULL, N'mitochondria', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat24, 'fill_blank', N'The outer layer that controls what enters and leaves a cell is the ___.', NULL, N'cell membrane', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat24, 'fill_blank', N'The rigid outer layer found only in plant cells (not animal cells) is the ___.', NULL, N'cell wall', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat24, 'fill_blank', N'The system responsible for pumping blood through the body is the ___ system.', NULL, N'circulatory', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat24, 'fill_blank', N'The system that breaks down food for the body to use is the ___ system.', NULL, N'digestive', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat24, 'fill_blank', N'The system made up of the brain, spinal cord, and nerves is the ___ system.', NULL, N'nervous', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat24, 'fill_blank', N'The system responsible for bringing oxygen into the body is the ___ system.', NULL, N'respiratory', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat24, 'fill_blank', N'The system made up of bones that supports and protects the body is the ___ system.', NULL, N'skeletal', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat24, 'fill_blank', N'The organ that pumps blood throughout the circulatory system is the ___.', NULL, N'heart', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat24, 'fill_blank', N'The organ that filters toxins from the blood and produces bile is the ___.', NULL, N'liver', 13);

-- 25. Earth's Structure, Plate Tectonics & Weathering (13 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat25, 'fill_blank', N'The outermost layer of the Earth, where we live, is called the ___.', NULL, N'crust', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat25, 'fill_blank', N'The hot, mostly solid middle layer of the Earth is called the ___.', NULL, N'mantle', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat25, 'fill_blank', N'The layer at the very center of the Earth, made mostly of iron and nickel, is called the ___.', NULL, N'core', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat25, 'fill_blank', N'Large sections of Earth''s crust that slowly move are called tectonic ___.', NULL, N'plates', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat25, 'fill_blank', N'When two tectonic plates push into each other, this is called a ___ boundary.', NULL, N'convergent', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat25, 'fill_blank', N'When two tectonic plates move apart from each other, this is called a ___ boundary.', NULL, N'divergent', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat25, 'fill_blank', N'When two tectonic plates slide past each other, this is called a ___ boundary.', NULL, N'transform', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat25, 'fill_blank', N'The sudden shaking of the ground caused by moving tectonic plates is called an ___.', NULL, N'earthquake', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat25, 'fill_blank', N'A mountain formed when magma erupts through the Earth''s crust is called a ___.', NULL, N'volcano', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat25, 'fill_blank', N'The slow breakdown of rock by wind, water, or ice is called ___.', NULL, N'weathering', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat25, 'fill_blank', N'The process of small pieces of rock and soil being moved from one place to another is called ___.', NULL, N'erosion', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat25, 'fill_blank', N'When sediment settles and builds up in a new location, this process is called ___.', NULL, N'deposition', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat25, 'fill_blank', N'Mountain ranges like the Himalayas often form at ___ plate boundaries, where two plates collide.', NULL, N'convergent', 13);

-- 26. Ancient Civilizations Survey (13 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat26, 'fill_blank', N'Mesopotamia developed between which two rivers?', NULL, N'The Tigris and Euphrates rivers', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat26, 'fill_blank', N'The system of laws created by Babylonian king Hammurabi is known as ___.', NULL, N'Hammurabi''s Code', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat26, 'fill_blank', N'One of the earliest writing systems, developed in Mesopotamia, is called ___.', NULL, N'cuneiform', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat26, 'fill_blank', N'The river that ancient Egypt depended on for farming and transportation is the ___ River.', NULL, N'Nile', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat26, 'fill_blank', N'Ancient Egyptian writing that used pictures and symbols is called ___.', NULL, N'hieroglyphics', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat26, 'fill_blank', N'The large stone tombs built for Egyptian pharaohs are called ___.', NULL, N'pyramids', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat26, 'fill_blank', N'The process ancient Egyptians used to preserve bodies after death is called ___.', NULL, N'mummification', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat26, 'fill_blank', N'Ancient Greece is often called the birthplace of ___, a form of government where citizens vote.', NULL, N'democracy', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat26, 'fill_blank', N'The ancient Greek city-state known for its military strength was ___.', NULL, N'Sparta', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat26, 'fill_blank', N'The ancient Greek city-state known for its focus on philosophy, art, and democracy was ___.', NULL, N'Athens', 10);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat26, 'fill_blank', N'Ancient Greek stories about gods and heroes are called ___.', NULL, N'mythology', 11);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat26, 'fill_blank', N'The ruler of ancient Egypt was called the ___.', NULL, N'pharaoh', 12);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat26, 'fill_blank', N'Mesopotamia is often called the “Cradle of Civilization” because it is considered the birthplace of the first ___.', NULL, N'cities (civilizations)', 13);

-- 27. Comparing Government Systems (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat27, 'fill_blank', N'In a ___, citizens vote for their leaders and have a say in government.', NULL, N'democracy', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat27, 'fill_blank', N'In a ___, one king or queen holds all the power, often passed down through family.', NULL, N'monarchy', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat27, 'fill_blank', N'In a ___, one person or small group holds total power, often without free elections.', NULL, N'dictatorship', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat27, 'short_response', N'In a democracy, who ultimately holds the power to choose leaders?', NULL, N'The citizens/the people', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat27, 'short_response', N'In an absolute monarchy, how does someone usually become the ruler?', NULL, N'By inheriting the throne (through family/birthright)', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat27, 'short_response', N'In a dictatorship, are citizens typically free to vote in fair elections?', NULL, N'No, elections are usually unfair or do not exist', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat27, 'fill_blank', N'In a ___ monarchy, the king or queen shares power with an elected government and follows a constitution.', NULL, N'constitutional', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat27, 'short_response', N'What is one key difference between a democracy and a dictatorship?', NULL, N'In a democracy citizens choose leaders through free elections; in a dictatorship one person or group holds power without free elections', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat27, 'short_response', N'Name one country today that has a democratic government.', NULL, N'Any correct example, such as the United States', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat27, 'short_response', N'Why might citizens have more individual freedoms in a democracy than in a dictatorship?', NULL, N'Because democracies protect citizens'' rights and voting power, while dictatorships concentrate power in one leader', 10);

-- 28. Economics: Global Trade & Personal Finance Basics (10 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat28, 'fill_blank', N'When a country sells goods to other countries, this is called ___.', NULL, N'exporting', 1);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat28, 'fill_blank', N'When a country buys goods from other countries, this is called ___.', NULL, N'importing', 2);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat28, 'fill_blank', N'Setting aside part of your money instead of spending it is called ___.', NULL, N'saving', 3);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat28, 'fill_blank', N'A plan for how you will spend and save your money is called a ___.', NULL, N'budget', 4);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat28, 'fill_blank', N'The extra money a bank pays you for keeping your money saved with them is called ___.', NULL, N'interest', 5);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat28, 'fill_blank', N'Trading goods between countries so each country can get things it doesn''t produce itself is called ___ trade.', NULL, N'global (international)', 6);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat28, 'fill_blank', N'If a country is especially good at producing one type of good efficiently, economists say it has a ___ advantage in producing that good.', NULL, N'comparative', 7);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat28, 'short_response', N'If Maya earns $40 a week and saves $10 of it, what percent of her earnings is she saving?', NULL, N'25%', 8);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat28, 'short_response', N'If a savings account earns 5% interest per year and you deposit $200, how much interest will you earn after one year?', NULL, N'$10', 9);
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat28, 'short_response', N'Why do countries trade with each other instead of only using their own resources?', NULL, N'Because trade lets countries get goods they don''t have or can''t produce as efficiently themselves', 10);

-- 29. Word Search Puzzle (1 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat29, 'word_search', N'Find these words: RATIO, PERCENT, INTEGER, EQUATION, VOLUME, MITOCHONDRIA, DEMOCRACY, PHARAOH', NULL, N'RATIO, PERCENT, INTEGER, EQUATION, VOLUME, MITOCHONDRIA, DEMOCRACY, PHARAOH', 1);

-- 30. Logic Grid Puzzle (1 questions)
INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES (@g6cat30, 'short_response', N'Liam, Nora, Omar, and Priya each have a different favorite subject: Math, Science, History, or Art. Clue 1: Liam''s favorite subject is not Math and not Science. Clue 2: Nora''s favorite subject is Art. Clue 3: Omar does not like History. Clue 4: Priya''s favorite subject is Science. Who likes what?', NULL, N'Liam: History, Nora: Art, Omar: Math, Priya: Science', 1);

END
GO
