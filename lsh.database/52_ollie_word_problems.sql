-- 52_ollie_word_problems.sql
-- Weaves the "Ollie the Owl" mascot into a few existing word-problem
-- prompts as a recurring named character (Grade 1 Word Problems, Grade 2
-- Money Word Problems, Grade 3 Multiplication & Two-Step Word Problems).
-- Only rewrites the character name — numbers/answers are unchanged.

IF EXISTS (
    SELECT 1 FROM dbo.PacketQuestions q
    JOIN dbo.PacketCategories c ON q.category_id = c.category_id
    WHERE c.grade_id = 2 AND c.category_name = N'Word Problems (Addition/Subtraction Within 20)'
      AND q.sort_order = 1 AND q.prompt LIKE N'Sam had 10 stickers%'
)
BEGIN
    UPDATE q SET q.prompt = N'Ollie the Owl had 10 stickers. Ollie gave away 6. How many stickers does Ollie have left?'
    FROM dbo.PacketQuestions q
    JOIN dbo.PacketCategories c ON q.category_id = c.category_id
    WHERE c.grade_id = 2 AND c.category_name = N'Word Problems (Addition/Subtraction Within 20)' AND q.sort_order = 1;
END
GO

IF EXISTS (
    SELECT 1 FROM dbo.PacketQuestions q
    JOIN dbo.PacketCategories c ON q.category_id = c.category_id
    WHERE c.grade_id = 3 AND c.category_name = N'Money Word Problems'
      AND q.sort_order = 1 AND q.prompt LIKE N'Maria has 3 quarters%'
)
BEGIN
    UPDATE q SET q.prompt = N'Ollie the Owl has 3 quarters, 2 dimes, and 1 nickel. How much money does he have in all?'
    FROM dbo.PacketQuestions q
    JOIN dbo.PacketCategories c ON q.category_id = c.category_id
    WHERE c.grade_id = 3 AND c.category_name = N'Money Word Problems' AND q.sort_order = 1;
END
GO

IF EXISTS (
    SELECT 1 FROM dbo.PacketQuestions q
    JOIN dbo.PacketCategories c ON q.category_id = c.category_id
    WHERE c.grade_id = 4 AND c.category_name = N'Multiplication Word Problems'
      AND q.sort_order = 1 AND q.prompt LIKE N'Elena has 4 bags%'
)
BEGIN
    UPDATE q SET q.prompt = N'Ollie the Owl has 4 bags of apples, with 8 in each. How many are there in all?'
    FROM dbo.PacketQuestions q
    JOIN dbo.PacketCategories c ON q.category_id = c.category_id
    WHERE c.grade_id = 4 AND c.category_name = N'Multiplication Word Problems' AND q.sort_order = 1;
END
GO

IF EXISTS (
    SELECT 1 FROM dbo.PacketQuestions q
    JOIN dbo.PacketCategories c ON q.category_id = c.category_id
    WHERE c.grade_id = 4 AND c.category_name = N'Two-Step Word Problems'
      AND q.sort_order = 1 AND q.prompt LIKE N'Emma had 65 baseball cards%'
)
BEGIN
    UPDATE q SET q.prompt = N'Ollie the Owl had 65 baseball cards. Ollie traded away 19 and then bought 19 more. How many cards does Ollie have now?'
    FROM dbo.PacketQuestions q
    JOIN dbo.PacketCategories c ON q.category_id = c.category_id
    WHERE c.grade_id = 4 AND c.category_name = N'Two-Step Word Problems' AND q.sort_order = 1;
END
GO
