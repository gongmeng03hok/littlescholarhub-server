-- 73_cognitive_skills_games_content.sql
-- Adds a 'Brain & Strategy Games' category to the existing always-on
-- 'cognitive_skills' subject_area for every grade (TK-6th) — no schema or
-- proc changes needed, reuses dbo.PacketSubjectAreas/
-- usp_GetOrCreateWeeklyPacket exactly as-is (see 64_sel_cognitive_content.sql
-- for the other cognitive_skills categories already shipped: Critical
-- Thinking, Design Thinking & Innovation, Metacognition, Problem-Solving,
-- Spatial Awareness).
--
-- Each grade gets a pool of 14 games; target_count=7 (fixed, not the usual
-- ~65% auto-rebalance ratio) means the existing NEWID()-sampling rotation
-- serves a different 7-of-14 combination most weeks a grade's
-- cognitive_skills category is selected, satisfying "7 brain games,
-- different set each week" without any manual per-week authoring.
--
-- Each game is ONE PacketQuestions row: prompt carries the Name/Objective/
-- Materials, diagram_type='sequence_steps' carries the Step-by-Step
-- Instructions (already-shipped diagram type, renders as a numbered list in
-- both the app and print — see 63_whole_child_rotation.sql).
-- See gen_73_cognitive_skills_games_content.py.

IF NOT EXISTS (SELECT 1 FROM dbo.PacketCategories WHERE subject_area = 'cognitive_skills' AND category_name = N'Brain & Strategy Games')
BEGIN
    DECLARE @cat_cog_0 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (0, 'cognitive_skills', N'Brain & Strategy Games', 'space_heavy', 7, N'Challenge your brain with a fun thinking game this week!', 0);
    SET @cat_cog_0 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_0, N'short_response', N'🧸 Matching Pairs

Objective: Practice remembering where things are by finding two toys that match.

Materials: 6 pairs of small matching toys or objects | A blanket or cloth to hide them under

Follow the steps below to play!', NULL, N'Looking closely before you guess helps your brain remember better.', 1, N'sequence_steps', N'{"steps": ["A grown-up lines up 4 objects (2 matching pairs) on the floor.", "Look closely at each object for a few seconds.", "Cover them with a cloth, then try to point to where each match is.", "Lift the cloth together and check if you remembered right!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_0, N'short_response', N'🔵 What Comes Next?

Objective: Practice noticing and continuing a simple color or shape pattern.

Materials: Colored blocks, buttons, or crayons (2-3 colors)

Follow the steps below to play!', NULL, N'Patterns repeat — once you spot the rule, you can guess what''s next!', 2, N'sequence_steps', N'{"steps": ["A grown-up lines up a simple pattern, like red-blue-red-blue.", "Look at the pattern together and say the colors out loud.", "Guess what color comes next.", "Add the next piece and check if you were right!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_0, N'short_response', N'🏗️ Tallest Tower

Objective: Practice planning and balancing while building the tallest tower you can.

Materials: 10-15 soft blocks or small stackable boxes

Follow the steps below to play!', NULL, N'Big blocks on the bottom, small ones on top — that''s a builder''s trick!', 3, N'sequence_steps', N'{"steps": ["Stack blocks one at a time to build a tower.", "Go slowly and check that each block is balanced before adding another.", "See how tall you can build before it wobbles.", "If it falls, laugh and try again — can you beat your height?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_0, N'short_response', N'🙈 Hidden Object Peek

Objective: Practice remembering an object after it disappears from view.

Materials: 1 favorite small toy | A cup or small box to hide it under

Follow the steps below to play!', NULL, N'Just because something is hidden doesn''t mean it''s gone — great thinking!', 4, N'sequence_steps', N'{"steps": ["Show the toy, then hide it under a cup while the child watches.", "Ask, ''Where did it go?''", "Let the child lift the cup to find it.", "Try hiding it under one of two cups and guess which one!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_0, N'short_response', N'🧩 Big Piece Puzzle Race

Objective: Practice looking at shapes and finding where they fit.

Materials: A simple 4-6 piece chunky puzzle

Follow the steps below to play!', NULL, N'Turning a piece around and around helps you see where it fits.', 5, N'sequence_steps', N'{"steps": ["Dump the puzzle pieces out on a table.", "Look at each piece''s shape and edges.", "Try fitting a piece into the puzzle board.", "Keep going until every piece is in its spot!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_0, N'short_response', N'👋 Copy My Moves

Objective: Practice remembering and repeating a short sequence of actions.

Materials: None — just your body!

Follow the steps below to play!', NULL, N'Saying the moves out loud while you do them helps your brain remember.', 6, N'sequence_steps', N'{"steps": ["A grown-up claps once, then touches their head.", "Try copying the same two moves in the same order.", "Add one more move to the sequence (clap, head, jump!).", "See how many moves you can remember in a row."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_0, N'short_response', N'🎨 Odd One Out

Objective: Practice looking closely to spot which object doesn''t belong.

Materials: 4 small toys or objects (3 similar, 1 different)

Follow the steps below to play!', NULL, N'Ask yourself: what do most of them have that this one doesn''t?', 7, N'sequence_steps', N'{"steps": ["Line up 4 objects, like 3 spoons and 1 crayon.", "Look at all of them carefully.", "Point to the one that is different from the rest.", "Try again with a new group of 4 objects!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_0, N'short_response', N'🧱 Copy the Shape

Objective: Practice looking at a simple block shape and building it the same way.

Materials: 8-10 building blocks

Follow the steps below to play!', NULL, N'Looking at one block at a time makes copying a shape easier.', 8, N'sequence_steps', N'{"steps": ["A grown-up builds a small, simple shape with 3-4 blocks.", "Look at the shape carefully.", "Use your own blocks to build the exact same shape.", "Compare the two shapes side by side — do they match?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_0, N'short_response', N'🐘 Animal Sound Match

Objective: Practice thinking of the right answer by matching sounds to animals.

Materials: Pictures of 4-5 animals (or toy animals)

Follow the steps below to play!', NULL, N'Thinking about what you already know about an animal helps you guess.', 9, N'sequence_steps', N'{"steps": ["Line up pictures or toys of a few animals.", "A grown-up makes an animal sound, like ''moo.''", "Point to the animal that makes that sound.", "Take turns making sounds for each other to guess!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_0, N'short_response', N'🪢 Which Path Goes There?

Objective: Practice following a simple path with your eyes to solve a mini maze.

Materials: Paper with 2 simple squiggly lines drawn to 2 different pictures | Crayon

Follow the steps below to play!', NULL, N'Following a line slowly with your eyes helps you see where it goes.', 10, N'sequence_steps', N'{"steps": ["Draw two wiggly lines from a starting dot to two different pictures.", "Look at both lines with just your eyes (no tracing yet).", "Guess which line leads to which picture.", "Trace the line with a crayon to check your guess!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_0, N'short_response', N'🔺 Sort the Shapes

Objective: Practice grouping objects by shape to notice what''s the same.

Materials: A mixed pile of circles, squares, and triangles (paper or blocks)

Follow the steps below to play!', NULL, N'Grouping things that are alike is one of the first steps thinkers use.', 11, N'sequence_steps', N'{"steps": ["Spread out a mixed pile of shapes.", "Pick one shape and name it out loud.", "Put all the matching shapes into their own group.", "Keep sorting until every shape has a group!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_0, N'short_response', N'🧠 Guess My Rule

Objective: Practice figuring out a simple hidden rule by watching examples.

Materials: A few small toys (some soft, some hard — or some red, some not)

Follow the steps below to play!', NULL, N'Watching a few examples helps your brain figure out the hidden rule.', 12, N'sequence_steps', N'{"steps": ["A grown-up quietly picks a rule, like ''only soft things.''", "Grown-up puts one soft toy in a pile and says ''yes'' and one hard toy outside it and says ''no.''", "Guess which pile a new toy belongs in.", "After a few tries, guess the grown-up''s secret rule!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_0, N'short_response', N'🌉 Build a Bridge

Objective: Practice inventing a simple solution to hold up a toy using blocks.

Materials: Building blocks | A small toy car or figure to cross the bridge

Follow the steps below to play!', NULL, N'If your first idea falls down, that''s okay — try a new way!', 13, N'sequence_steps', N'{"steps": ["Set two block towers a small gap apart.", "Think about how to connect them so a toy can cross.", "Try laying a flat block across the gap like a bridge.", "Test it by rolling the toy car across!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_0, N'short_response', N'💭 Happy or Tricky Face

Objective: Practice noticing and naming how a puzzle or game made you feel.

Materials: None — just talking together

Follow the steps below to play!', NULL, N'Noticing how a puzzle feels is the very first step to thinking about your thinking.', 14, N'sequence_steps', N'{"steps": ["After playing any game today, sit together for a moment.", "Ask, ''Did that feel easy, tricky, or in between?''", "Make a face that shows how it felt (smile, thinking face, big smile).", "Talk about what part was the trickiest."]}');

    DECLARE @cat_cog_1 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (1, 'cognitive_skills', N'Brain & Strategy Games', 'space_heavy', 7, N'Challenge your brain with a fun thinking game this week!', 0);
    SET @cat_cog_1 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_1, N'short_response', N'🧠 Memory Match Cards

Objective: Practice remembering the location of matching pairs of cards.

Materials: 8 cards (4 matching pairs) — drawn or index cards

Follow the steps below to play!', NULL, N'Try to remember not just what you saw, but exactly where you saw it.', 1, N'sequence_steps', N'{"steps": ["Lay all 8 cards face-down in rows.", "Flip two cards over to see if they match.", "If they don''t match, flip them back down and remember where they were.", "Keep going until you''ve found all 4 pairs!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_1, N'short_response', N'❌ Three in a Row

Objective: Practice planning ahead to line up three marks while blocking a partner.

Materials: Paper with a 3x3 grid drawn | Pencil or 2 colors of small tokens

Follow the steps below to play!', NULL, N'Watch your partner''s marks too — sometimes blocking them is the smart move.', 2, N'sequence_steps', N'{"steps": ["Draw a 3x3 grid on paper.", "Take turns placing your mark (X or O) in an empty square.", "Try to get 3 of your marks in a row, while watching what your partner is doing.", "First to get 3 in a row (across, down, or diagonal) wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_1, N'short_response', N'🔍 Spot the Difference

Objective: Practice careful looking by comparing two nearly-identical drawings.

Materials: Two simple drawings of the same picture, with 3-4 small changes made to one

Follow the steps below to play!', NULL, N'Look at one small section at a time instead of the whole picture at once.', 3, N'sequence_steps', N'{"steps": ["Draw a simple picture (like a house), then copy it but change 3-4 small details.", "Look at both pictures side by side.", "Point out each difference you can find.", "Check together — did you find them all?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_1, N'short_response', N'🧱 Copy the Block Tower

Objective: Practice studying a structure carefully and rebuilding it from memory.

Materials: 10-12 building blocks

Follow the steps below to play!', NULL, N'Saying the block order out loud while you look helps you remember it.', 4, N'sequence_steps', N'{"steps": ["A partner builds a small tower using 5-6 blocks.", "Study it carefully for 10 seconds, then it gets covered or knocked down.", "Try to rebuild the exact same tower from memory.", "Compare with a new tower your partner builds to check!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_1, N'short_response', N'🗺️ Treasure Map Directions

Objective: Practice following and giving step-by-step directions to find a hidden spot.

Materials: Small hidden object | Open room or yard

Follow the steps below to play!', NULL, N'Clear, simple directions — one step at a time — work best.', 5, N'sequence_steps', N'{"steps": ["Hide a small object somewhere in the room.", "Give a partner 3-4 simple directions (forward, turn left, forward).", "Partner follows the directions exactly to try to find the object.", "Switch roles and hide a new object!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_1, N'short_response', N'🔷 What''s the Pattern?

Objective: Practice figuring out and continuing a repeating pattern.

Materials: Colored blocks, beads, or crayons

Follow the steps below to play!', NULL, N'Find the smallest repeating chunk — that''s the secret to any pattern.', 6, N'sequence_steps', N'{"steps": ["Line up a pattern with 3 or more repeats, like square-circle-circle.", "Study the pattern and figure out its repeating rule.", "Predict what shape comes next.", "Add it, then try making your own tricky pattern for a partner!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_1, N'short_response', N'🏗️ Strongest Bridge Challenge

Objective: Design and test a simple structure that can hold a small weight.

Materials: Building blocks or craft sticks | A small toy to place on top as a test weight

Follow the steps below to play!', NULL, N'Real inventors expect their first try to need fixing — that''s part of designing.', 7, N'sequence_steps', N'{"steps": ["Think of a way to build a bridge or platform between two blocks.", "Build your idea.", "Test it by gently placing a small toy on top.", "If it falls, redesign it and test again!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_1, N'short_response', N'🎭 Guess the Category

Objective: Practice thinking of examples that fit a hidden group.

Materials: None — just your imagination

Follow the steps below to play!', NULL, N'Think about what all the ''yes'' answers have in common.', 8, N'sequence_steps', N'{"steps": ["One player thinks of a secret category, like ''things that are cold.''", "They name one example (ice cream).", "Others guess more things that might fit, and the player says yes or no.", "Whoever guesses the secret category first picks the next one!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_1, N'short_response', N'🧩 Shape Puzzle Builder

Objective: Practice fitting shapes together to fill in an outline.

Materials: Paper cut into 6-8 simple shapes | A larger outline drawn on paper for the shapes to fill

Follow the steps below to play!', NULL, N'Turning a shape sideways or upside down might help it fit better.', 9, N'sequence_steps', N'{"steps": ["Draw a simple big outline (like a house or star) on paper.", "Cut smaller shapes that could fit inside pieces of it.", "Arrange the shapes to fill the outline without gaps.", "Trace around your finished design!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_1, N'short_response', N'🧠 Remember the Order

Objective: Practice holding a short sequence of words in your memory.

Materials: None — just listening and talking

Follow the steps below to play!', NULL, N'Picturing each word as a little picture in your mind can help you remember it.', 10, N'sequence_steps', N'{"steps": ["A grown-up says 3 words in a row, like ''apple, ball, cat.''", "Wait a few seconds, then repeat the words back in the same order.", "Try again with 4 words if that felt easy.", "Take turns being the one who says the words!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_1, N'short_response', N'🐢 Slow Motion Detective

Objective: Practice noticing small clues by observing something closely and describing it.

Materials: A mystery object in a bag or box

Follow the steps below to play!', NULL, N'Good detectives notice size, shape, and texture, not just one clue.', 11, N'sequence_steps', N'{"steps": ["A grown-up puts a small object inside a bag without showing it.", "Feel the object through the bag (or peek quickly) and think of 3 clues about it.", "Say your clues out loud, one at a time.", "Guess what the object is, then peek to check!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_1, N'short_response', N'🔢 Number Line Hop

Objective: Practice using logic to guess a hidden number using clues.

Materials: Paper with numbers 1-20 written in a line

Follow the steps below to play!', NULL, N'Guessing right in the middle each time helps you find the number faster.', 12, N'sequence_steps', N'{"steps": ["One player secretly picks a number between 1 and 20.", "Others guess a number, and the picker says ''higher'' or ''lower.''", "Use each clue to narrow down your next guess.", "Keep guessing smarter until you find the secret number!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_1, N'short_response', N'🎯 Invent a Game Rule

Objective: Practice creating and explaining a brand-new simple rule for a familiar game.

Materials: A ball or beanbag

Follow the steps below to play!', NULL, N'Inventing new rules is a way of designing your very own game.', 13, N'sequence_steps', N'{"steps": ["Think of one new silly rule to add to a simple toss game (like ''only toss with your left hand'').", "Explain your new rule to a partner.", "Play a few rounds using your invented rule.", "Ask your partner to invent a new rule too and try that one!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_1, N'short_response', N'💭 Easy, Tricky, or Just Right?

Objective: Practice reflecting on and describing how challenging a game felt.

Materials: None — just talking together

Follow the steps below to play!', NULL, N'Thinking about how a challenge felt helps you pick better challenges next time.', 14, N'sequence_steps', N'{"steps": ["After playing a game, pause and think back on it.", "Decide if it felt too easy, too tricky, or just right.", "Explain why you picked that answer.", "Think of one thing that would make it more fun next time!"]}');

    DECLARE @cat_cog_2 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (2, 'cognitive_skills', N'Brain & Strategy Games', 'space_heavy', 7, N'Challenge your brain with a fun thinking game this week!', 0);
    SET @cat_cog_2 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_2, N'short_response', N'🧠 Double Memory Match

Objective: Practice remembering more card locations using a bigger matching grid.

Materials: 12 cards (6 matching pairs)

Follow the steps below to play!', NULL, N'Try beating your own flip-count the next time you play.', 1, N'sequence_steps', N'{"steps": ["Lay all 12 cards face-down in a grid.", "Flip two cards at a time, trying to find a match.", "If it''s not a match, flip both back and remember their spots.", "Keep playing until all 6 pairs are found — count your total flips!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_2, N'short_response', N'⭕ Four in a Row Strategy

Objective: Practice planning multiple moves ahead in a connect-the-dots strategy game.

Materials: Paper with a 4x4 grid of dots | Pencil or 2 colors of tokens

Follow the steps below to play!', NULL, N'Look two moves ahead: what will your partner do after your turn?', 2, N'sequence_steps', N'{"steps": ["Draw a 4x4 grid of dots on paper.", "Take turns placing your token on a dot.", "Try to connect 4 of your tokens in a line while blocking your partner.", "First to connect 4 in a row wins — then swap who goes first!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_2, N'short_response', N'🏙️ Block City Blueprint

Objective: Practice planning a design on paper before building it with blocks.

Materials: Building blocks | Paper and pencil

Follow the steps below to play!', NULL, N'Planning first, then building, usually works better than building without a plan.', 3, N'sequence_steps', N'{"steps": ["Sketch a simple blueprint of a small building on paper first.", "Look at your blueprint and pick out the blocks you''ll need.", "Build your design to match the blueprint as closely as you can.", "Compare your finished build to your sketch — how close was it?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_2, N'short_response', N'🗝️ Two-Step Code Breaker

Objective: Practice using logic clues to crack a simple secret code.

Materials: Paper | Pencil

Follow the steps below to play!', NULL, N'Change just one symbol at a time so you know exactly what each clue means.', 4, N'sequence_steps', N'{"steps": ["One player secretly writes a 3-symbol code using shapes or colors.", "The other guesses a 3-symbol sequence.", "The code-maker says how many symbols are correct (not positions).", "Use each clue to make a smarter next guess until it''s cracked!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_2, N'short_response', N'🧭 Mental Map Maze

Objective: Practice picturing a path in your mind before tracing it.

Materials: A simple maze drawn on paper | Pencil

Follow the steps below to play!', NULL, N'Planning the whole route in your head first often beats guessing as you go.', 5, N'sequence_steps', N'{"steps": ["Look at a maze without touching your pencil to it yet.", "Trace the path with just your eyes to find a route to the end.", "Once you think you''ve found it, trace it with a pencil.", "Try a trickier maze and see if planning first still helps!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_2, N'short_response', N'🔤 Word Ladder Start

Objective: Practice changing one letter at a time to turn one word into another.

Materials: Paper | Pencil

Follow the steps below to play!', NULL, N'Say each new word out loud — sometimes hearing it helps you spot the next change.', 6, N'sequence_steps', N'{"steps": ["Write a simple 3-letter word, like CAT.", "Change just one letter to make a brand-new real word (CAT to COT).", "Keep changing one letter at a time to make new words.", "See how many words you can make in a row!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_2, N'short_response', N'🏗️ Tallest Paper Tower

Objective: Design and test a free-standing tower using only paper and tape.

Materials: 10 sheets of paper | Tape | A ruler (to measure)

Follow the steps below to play!', NULL, N'Rolled or folded paper is much stronger than flat paper — try it and see.', 7, N'sequence_steps', N'{"steps": ["Think of a way to fold or roll paper to make it stand up tall.", "Build your tower using only paper and tape.", "Measure how tall it stands on its own.", "Redesign and try to beat your own height!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_2, N'short_response', N'🃏 Category Speed Round

Objective: Practice thinking quickly of examples that belong to a category.

Materials: None — just quick thinking

Follow the steps below to play!', NULL, N'Grouping ideas in your head ahead of time (farm animals, zoo animals...) helps you think faster.', 8, N'sequence_steps', N'{"steps": ["Pick a category, like ''animals'' or ''fruits.''", "Take turns naming one example without repeating.", "Keep going faster each round — if you get stuck, you''re out!", "Play again with a brand-new category."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_2, N'short_response', N'🧩 Tangram Shape Challenge

Objective: Practice rotating and arranging shapes to build a bigger picture.

Materials: 7 paper shapes cut into a simple tangram set (triangles, square, parallelogram)

Follow the steps below to play!', NULL, N'Flipping a piece over is allowed — don''t forget that trick when stuck.', 9, N'sequence_steps', N'{"steps": ["Cut a square of paper into 7 simple shapes (a basic tangram set).", "Try arranging all 7 pieces to build a picture, like a house or cat.", "If a piece doesn''t fit, try rotating or flipping it.", "Once you finish one picture, try inventing your own!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_2, N'short_response', N'🎯 Twenty Questions Lite

Objective: Practice asking smart yes/no questions to narrow down a hidden answer.

Materials: None — just thinking and talking

Follow the steps below to play!', NULL, N'Big questions first (''Does it live in water?'') narrow things down faster than small guesses.', 10, N'sequence_steps', N'{"steps": ["One player secretly thinks of an animal.", "Others take turns asking yes/no questions to narrow it down.", "Use each answer to guide your next smarter question.", "Try to guess the animal in as few questions as possible!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_2, N'short_response', N'🔧 Fix the Broken Toy Challenge

Objective: Practice inventing a creative fix for a made-up broken-toy problem.

Materials: A toy (pretend it''s ''broken'' — like a wheel fell off) | Craft supplies: tape, string, paper clips

Follow the steps below to play!', NULL, N'Inventors almost always try more than one idea before finding the best one.', 11, N'sequence_steps', N'{"steps": ["Pick a toy and imagine one part of it stopped working.", "Brainstorm 2-3 different ways you could fix it using your supplies.", "Pick your favorite idea and try building the fix.", "Test it out — did your fix work the way you hoped?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_2, N'short_response', N'🧠 Where Am I Pointing?

Objective: Practice using spatial words (left, right, above, below) to describe a location.

Materials: A simple picture with several objects on it

Follow the steps below to play!', NULL, N'Precise words like ''above the tree, to the left of the house'' work better than ''over there.''', 12, N'sequence_steps', N'{"steps": ["Look at a busy picture with several objects together.", "One player secretly picks an object and describes its location using only direction words.", "The other player points to what they think is being described.", "Check if you found the right one, then switch turns!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_2, N'short_response', N'🪞 Mirror Me Moves

Objective: Practice copying a partner''s movement pattern exactly like a mirror.

Materials: None — just two people and some space

Follow the steps below to play!', NULL, N'Watching closely and moving slowly makes mirroring much easier.', 13, N'sequence_steps', N'{"steps": ["Stand facing a partner.", "One person slowly moves an arm, leg, or makes a face.", "The other copies it like a mirror reflection (opposite side).", "Switch who leads every 30 seconds!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_2, N'short_response', N'💭 My Thinking Steps

Objective: Practice explaining out loud the steps you used to solve a puzzle.

Materials: Any puzzle or game played earlier

Follow the steps below to play!', NULL, N'Explaining your steps out loud helps your brain remember strategies for next time.', 14, N'sequence_steps', N'{"steps": ["After finishing a puzzle, pause before putting it away.", "Think back to the very first thing you tried.", "Explain out loud, step by step, what you did to solve it.", "Think of one thing you''d try first if you played again."]}');

    DECLARE @cat_cog_3 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (3, 'cognitive_skills', N'Brain & Strategy Games', 'space_heavy', 7, N'Challenge your brain with a fun thinking game this week!', 0);
    SET @cat_cog_3 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_3, N'short_response', N'🧠 Speed Memory Grid

Objective: Practice remembering a growing set of card locations under time pressure.

Materials: 16 cards (8 matching pairs) | A timer or phone stopwatch

Follow the steps below to play!', NULL, N'Grouping the grid into sections in your mind can make it easier to track.', 1, N'sequence_steps', N'{"steps": ["Lay all 16 cards face-down in a 4x4 grid.", "Time yourself finding all 8 matching pairs.", "Flip two cards at a time, remembering locations of cards you''ve already seen.", "Write down your time, then try to beat it in a rematch!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_3, N'short_response', N'🔺 Five in a Row Strategy

Objective: Practice thinking several moves ahead while blocking an opponent''s plan.

Materials: Paper with a 6x6 grid | Pencil or 2 colors of tokens

Follow the steps below to play!', NULL, N'A move that helps you AND blocks your partner is usually the strongest move.', 2, N'sequence_steps', N'{"steps": ["Draw a 6x6 grid on paper.", "Take turns placing a token, trying to connect 5 in a row (any direction).", "Watch your partner''s tokens closely — block them if they''re close to 5.", "First to connect 5 in a row wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_3, N'short_response', N'🏗️ Load-Bearing Bridge

Objective: Design, test, and improve a bridge that must hold a growing weight.

Materials: Craft sticks or paper strips | Tape | Small weights (coins or blocks) to test with

Follow the steps below to play!', NULL, N'Triangle shapes are much stronger than square shapes — engineers use this trick constantly.', 3, N'sequence_steps', N'{"steps": ["Build a bridge across a gap using only craft sticks and tape.", "Test it by placing one coin on top, then adding coins one at a time.", "Note how many coins it holds before bending or breaking.", "Redesign one part and test again — did your fix add strength?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_3, N'short_response', N'🗝️ Three-Clue Code Breaker

Objective: Practice using logical deduction to crack a hidden 4-symbol code.

Materials: Paper | Pencil | 4 different colors or symbols

Follow the steps below to play!', NULL, N'Keep a written list of your guesses and clues — it''s easy to lose track in your head.', 4, N'sequence_steps', N'{"steps": ["One player secretly writes a 4-symbol code (repeats allowed).", "The other guesses a sequence of 4 symbols.", "The code-maker gives clues: how many are the right symbol, and how many are also in the right spot.", "Use the clues to narrow guesses until the code is cracked!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_3, N'short_response', N'🧭 Grid Coordinate Hunt

Objective: Practice using row-and-column coordinates to locate hidden spots.

Materials: Paper with a labeled grid (A-E across, 1-5 down) | Pencil

Follow the steps below to play!', NULL, N'Guessing near the center first usually eliminates more possibilities than guessing an edge.', 5, N'sequence_steps', N'{"steps": ["Draw a 5x5 grid, labeling columns A-E and rows 1-5.", "One player secretly marks a hidden square, like C3, on their own hidden grid.", "The other guesses coordinates one at a time; the hider says ''hit'' or ''miss.''", "Use each miss to narrow your next guess — find the hidden square!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_3, N'short_response', N'🔤 Word Ladder Challenge

Objective: Practice changing one letter at a time to connect a start word to a target word.

Materials: Paper | Pencil

Follow the steps below to play!', NULL, N'Sometimes it helps to work backward from the target word too.', 6, N'sequence_steps', N'{"steps": ["Pick a starting word and a target word with the same number of letters (COLD to WARM).", "Change exactly one letter at a time, making a real word each step.", "Keep going until you reach the target word.", "Try to reach it in the fewest steps possible!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_3, N'short_response', N'🏙️ Blueprint Build Challenge

Objective: Practice designing a structure to meet a specific requirement, then building it.

Materials: Building blocks or craft sticks | Paper and pencil | A small toy to test the design

Follow the steps below to play!', NULL, N'Real designers redraw their blueprint after every failed test — that''s not a mistake, it''s the process.', 7, N'sequence_steps', N'{"steps": ["Pick a design challenge, like ''build a structure a toy car can drive under.''", "Sketch your plan on paper first.", "Build it to match your sketch.", "Test it with the toy — if it doesn''t work, revise your blueprint and rebuild!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_3, N'short_response', N'🃏 Category Chain Reaction

Objective: Practice connecting ideas by naming items that link category to category.

Materials: None — just quick thinking

Follow the steps below to play!', NULL, N'There''s no single right answer — flexible thinking is what makes a good chain.', 8, N'sequence_steps', N'{"steps": ["Start with a word, like ''apple.''", "The next player must name something connected to it, like ''apple'' leads to ''tree.''", "Keep the chain going, explaining each connection out loud.", "See how long you can keep the chain before someone gets stuck!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_3, N'short_response', N'🧩 Tangram Silhouette Challenge

Objective: Practice mentally rotating shapes to recreate a silhouette outline exactly.

Materials: A 7-piece paper tangram set | A silhouette outline drawn or printed

Follow the steps below to play!', NULL, N'Picture rotating a piece in your mind before physically turning it — it builds your spatial thinking.', 9, N'sequence_steps', N'{"steps": ["Look at a silhouette outline without touching the pieces yet.", "Plan in your head which shapes might fit where.", "Arrange all 7 tangram pieces to exactly fill the silhouette.", "Try a harder silhouette once you solve the first one!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_3, N'short_response', N'🎯 Twenty Questions Strategy

Objective: Practice narrowing down a hidden answer using efficient, well-ordered questions.

Materials: None — just thinking and talking

Follow the steps below to play!', NULL, N'A great strategy is to split possibilities roughly in half with each question.', 10, N'sequence_steps', N'{"steps": ["One player secretly thinks of any object, place, or person.", "Others ask only yes/no questions, starting broad and narrowing down.", "Keep track mentally of what''s already been ruled out.", "Try to guess correctly in fewer than 15 questions!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_3, N'short_response', N'🔧 Redesign the Everyday Object

Objective: Practice inventing an improved version of a common object to solve a problem.

Materials: Paper | Pencil | Craft supplies (optional, for a model)

Follow the steps below to play!', NULL, N'The best inventions usually solve just ONE clear problem really well.', 11, N'sequence_steps', N'{"steps": ["Pick a simple everyday object, like a backpack or umbrella.", "Think of one problem people have with it.", "Sketch (or build) your redesign that solves that problem.", "Explain your redesign to someone and see what they think!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_3, N'short_response', N'🪞 Reverse Mirror Sequence

Objective: Practice mentally reversing a sequence of movements to mirror it correctly.

Materials: None — just two people and some space

Follow the steps below to play!', NULL, N'Picture the whole sequence backward in your mind before you start moving.', 12, N'sequence_steps', N'{"steps": ["One partner performs a sequence of 3 movements in a row.", "The other must copy it in mirror-image AND in reverse order.", "Check together if the reversed mirror sequence was correct.", "Switch roles and try a trickier sequence!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_3, N'short_response', N'🗺️ Shortest Path Planner

Objective: Practice comparing multiple possible routes to find the most efficient one.

Materials: Paper with a simple map or grid drawn, with 2-3 stops marked | Pencil

Follow the steps below to play!', NULL, N'Comparing more than one plan before choosing is exactly how real route-planning works.', 13, N'sequence_steps', N'{"steps": ["Draw a simple map with a start point and 3 stops to visit.", "Sketch out 2 different possible routes that visit all stops.", "Count the steps or distance for each route.", "Pick the shorter route and explain why you chose it!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_3, N'short_response', N'💭 Strategy Replay

Objective: Practice reflecting on which strategy worked and which didn''t during a game.

Materials: Any strategy game played earlier this week

Follow the steps below to play!', NULL, N'Thinking back on both your wins and your mistakes makes you a stronger strategist.', 14, N'sequence_steps', N'{"steps": ["After finishing a strategy game, think back over how you played.", "Identify one move or idea that worked well.", "Identify one move that didn''t work as planned.", "Say out loud what you''d try differently next time."]}');

    DECLARE @cat_cog_4 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (4, 'cognitive_skills', N'Brain & Strategy Games', 'space_heavy', 7, N'Challenge your brain with a fun thinking game this week!', 0);
    SET @cat_cog_4 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_4, N'short_response', N'🧠 Memory Grid Master

Objective: Practice tracking and recalling locations across a large matching grid under time pressure.

Materials: 20 cards (10 matching pairs) | A timer

Follow the steps below to play!', NULL, N'Reviewing cards you''ve already seen (even the ones that didn''t match) speeds up later turns.', 1, N'sequence_steps', N'{"steps": ["Lay all 20 cards face-down in a 4x5 grid.", "Time yourself finding all 10 pairs, flipping two cards per turn.", "Mentally note every card you see, even non-matches, for later.", "Record your time and try beating it in a rematch!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_4, N'short_response', N'🔺 Diagonal Strategy Grid

Objective: Practice planning several moves ahead across rows, columns, and diagonals.

Materials: Paper with a 7x7 grid | Pencil or 2 colors of tokens

Follow the steps below to play!', NULL, N'A move that creates two possible winning lines at once is very hard for an opponent to block.', 2, N'sequence_steps', N'{"steps": ["Draw a 7x7 grid; take turns placing a token, aiming to connect 5 in a row.", "Watch all directions (row, column, diagonal) for both your progress and your partner''s.", "Play a move that blocks your partner while also building your own line, if possible.", "First to connect 5 in a row wins — discuss the winning strategy afterward!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_4, N'short_response', N'🏗️ Maximum Weight Bridge

Objective: Engineer, test, and refine a bridge design to hold the most weight for its material cost.

Materials: 20 craft sticks | Tape | Small weights (coins) to test with | Paper for sketching

Follow the steps below to play!', NULL, N'Compare the weight held per stick used — the most ''efficient'' design isn''t always the biggest one.', 3, N'sequence_steps', N'{"steps": ["Sketch 2 different bridge designs on paper before building either one.", "Build your strongest design idea using no more than 20 craft sticks.", "Test it by adding coins one at a time until it fails, and record the count.", "Redesign the weakest part and rebuild to try beating your own score!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_4, N'short_response', N'🗝️ Four-Peg Code Breaker

Objective: Practice systematic logical deduction to crack a hidden multi-symbol code.

Materials: Paper | Pencil | 5-6 different colors or symbols

Follow the steps below to play!', NULL, N'A written chart of guesses and clues beats trying to hold it all in your head.', 4, N'sequence_steps', N'{"steps": ["One player secretly writes a 4-symbol code from 5-6 possible symbols (repeats allowed).", "The other guesses a full 4-symbol sequence.", "The code-maker gives feedback: correct symbol+position count, and correct symbol wrong-position count.", "Track every guess and clue in a chart, narrowing down until it''s solved!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_4, N'short_response', N'🧭 Battleship Coordinate Hunt

Objective: Practice using a coordinate grid and probability thinking to find hidden targets.

Materials: Paper with two labeled 6x6 grids per player (columns A-F, rows 1-6) | Pencil

Follow the steps below to play!', NULL, N'After a hit, checking the squares right next to it is usually smarter than guessing randomly.', 5, N'sequence_steps', N'{"steps": ["Each player secretly marks 3 hidden ''ships'' (single squares) on their own grid.", "Take turns calling out coordinates to guess the other''s ship locations.", "Mark hits and misses on your tracking grid to guide smarter future guesses.", "First to find all 3 of the other player''s ships wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_4, N'short_response', N'🔤 Word Ladder Puzzle Master

Objective: Practice planning a multi-step chain of one-letter word changes to reach a target.

Materials: Paper | Pencil | A dictionary (optional, to check words)

Follow the steps below to play!', NULL, N'Working from both ends toward the middle can reveal a shorter path than going straight through.', 6, N'sequence_steps', N'{"steps": ["Pick a start word and a target word of equal length, like RICH to POOR.", "Plan possible middle words before committing to your first change.", "Change one letter at a time, keeping every step a real word.", "Compare your solution length with someone else''s — who found a shorter ladder?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_4, N'short_response', N'🏙️ Constraint Design Challenge

Objective: Practice designing a structure that satisfies multiple specific requirements at once.

Materials: Building blocks or craft materials | Paper and pencil | A small object to test the design with

Follow the steps below to play!', NULL, N'When a design has multiple requirements, check each one separately instead of just eyeballing the whole thing.', 7, N'sequence_steps', N'{"steps": ["Pick a design challenge with 2 requirements, like ''must hold a toy AND have a door.''", "Sketch 2 different plans that could meet both requirements.", "Build your best plan and test it against both requirements.", "If one requirement fails, revise just that part and retest!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_4, N'short_response', N'🃏 Category Chain Speed Round

Objective: Practice quickly generating and justifying flexible category connections under time pressure.

Materials: A timer

Follow the steps below to play!', NULL, N'Unusual, creative connections count too, as long as you can explain the link.', 8, N'sequence_steps', N'{"steps": ["Start with any word and set a 60-second timer.", "Each player must name a connected word and briefly explain the link before time runs out.", "Keep the chain going, alternating turns, until time expires.", "Count how many links you made — try to beat your record next round!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_4, N'short_response', N'🧩 Rotated Tangram Challenge

Objective: Practice mentally rotating and flipping shapes without moving pieces until a plan is set.

Materials: A 7-piece paper tangram set | A rotated or upside-down silhouette outline

Follow the steps below to play!', NULL, N'Mentally rotating a shape before touching it trains a skill engineers and architects use constantly.', 9, N'sequence_steps', N'{"steps": ["Look at a silhouette outline shown rotated or flipped from the ''normal'' position.", "Plan in your head how each tangram piece needs to rotate to fit.", "Only after planning, move the pieces into place to fill the silhouette.", "Try a second silhouette using fewer ''trial and error'' moves than the first!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_4, N'short_response', N'🎯 Efficient Twenty Questions

Objective: Practice using binary-split questioning strategy to minimize the number of guesses needed.

Materials: None — just thinking and talking

Follow the steps below to play!', NULL, N'Questions like ''is it bigger than a chair?'' cut possibilities in half far better than specific guesses.', 10, N'sequence_steps', N'{"steps": ["One player secretly picks any object, person, or place.", "Others ask only yes/no questions, aiming to eliminate about half the possibilities each time.", "Track what''s already been ruled in or out as you go.", "Try to correctly guess in fewer questions than your previous best!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_4, N'short_response', N'🔧 Problem-Solution Pitch

Objective: Practice identifying a real problem, inventing a solution, and explaining why it works.

Materials: Paper | Pencil | Craft supplies (optional, for a model)

Follow the steps below to play!', NULL, N'Explaining the ''why'' behind your idea is just as important as the idea itself.', 11, N'sequence_steps', N'{"steps": ["Think of a real small problem you notice at home or school.", "Brainstorm 2-3 possible solutions, listing a pro and con for each.", "Pick your best solution and sketch or build a simple model of it.", "Pitch your idea to someone, explaining the problem and why your solution helps!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_4, N'short_response', N'🪞 Multi-Step Mirror Reverse

Objective: Practice holding and manipulating a longer movement sequence in working memory.

Materials: None — just two people and some space

Follow the steps below to play!', NULL, N'Breaking the sequence into 2 smaller chunks in your memory makes reversing it much easier.', 12, N'sequence_steps', N'{"steps": ["One partner performs a sequence of 4-5 movements in a row.", "The other must mentally reverse the order AND mirror each movement.", "Perform the reversed-mirrored sequence, then check together for accuracy.", "Take turns leading with increasingly longer sequences!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_4, N'short_response', N'🗺️ Multi-Stop Route Optimizer

Objective: Practice comparing several possible routes to find the most efficient order to visit multiple stops.

Materials: Paper with a simple map showing 4-5 stops and a start point | Pencil

Follow the steps below to play!', NULL, N'This is the same kind of thinking delivery drivers and trip planners use every day.', 13, N'sequence_steps', N'{"steps": ["Draw a map with a start point and 4-5 stops scattered around it.", "Sketch at least 2 different orders for visiting all the stops.", "Estimate the total distance or steps for each route.", "Choose the shortest route and explain your reasoning!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_4, N'short_response', N'💭 Strategy Debrief Journal

Objective: Practice analyzing your own thinking process after a challenging game to improve future performance.

Materials: Paper | Pencil | Any strategy game played earlier this week

Follow the steps below to play!', NULL, N'Writing your thinking down (not just saying it) makes the reflection stick longer.', 14, N'sequence_steps', N'{"steps": ["After a strategy game, write down the strategy you used at the start.", "Note one moment where your strategy changed and why.", "Write one thing that worked well and one thing you''d change.", "Set one specific goal for your strategy next time you play!"]}');

    DECLARE @cat_cog_5 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (5, 'cognitive_skills', N'Brain & Strategy Games', 'space_heavy', 7, N'Challenge your brain with a fun thinking game this week!', 0);
    SET @cat_cog_5 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_5, N'short_response', N'🧠 Full Grid Memory Challenge

Objective: Practice managing a large amount of spatial-memory information efficiently under time pressure.

Materials: 24 cards (12 matching pairs) | A timer

Follow the steps below to play!', NULL, N'Competitive memory athletes use a system to organize what they see — try inventing your own.', 1, N'sequence_steps', N'{"steps": ["Lay all 24 cards face-down in a 4x6 grid, and start the timer.", "Flip two cards per turn, working to find all 12 pairs.", "Use a mental system (like grouping the grid into quadrants) to track what you''ve seen.", "Record your total time and flip count, then challenge yourself to improve both!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_5, N'short_response', N'🔺 Double-Threat Strategy Grid

Objective: Practice recognizing and creating fork situations where two winning moves exist at once.

Materials: Paper with an 8x8 grid | Pencil or 2 colors of tokens

Follow the steps below to play!', NULL, N'A fork is powerful because your opponent can only block one line — the other wins.', 2, N'sequence_steps', N'{"steps": ["Draw an 8x8 grid; take turns placing tokens, aiming to connect 5 in a row.", "Look for a move that creates two possible winning lines simultaneously (a ''fork'').", "Also watch for and block your partner''s forks before they complete them.", "Play until someone connects 5, then discuss where the game''s key turning point was!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_5, N'short_response', N'🏗️ Efficiency-Optimized Bridge

Objective: Engineer a bridge that maximizes weight held per material used, applying trade-off thinking.

Materials: 25 craft sticks | Tape | Small weights to test with | Paper for sketching and data notes

Follow the steps below to play!', NULL, N'The strongest bridge isn''t always the winner — the most efficient one (strength per stick) often is.', 3, N'sequence_steps', N'{"steps": ["Sketch 2-3 different truss designs, predicting which will be strongest for its stick count.", "Build your top choice, using as few sticks as reasonably possible.", "Test with weights, recording your held-weight-to-stick-count ratio.", "Redesign to improve the ratio, and explain what trade-off you made!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_5, N'short_response', N'🗝️ Five-Peg Master Code

Objective: Practice applying systematic elimination logic to crack a complex hidden code.

Materials: Paper | Pencil | 6 different colors or symbols

Follow the steps below to play!', NULL, N'After a few guesses, some symbol combinations become logically impossible — cross them off to guess smarter.', 4, N'sequence_steps', N'{"steps": ["One player secretly writes a 5-symbol code from 6 possible symbols (repeats allowed).", "The other guesses a full sequence and receives feedback on correct symbol/position counts.", "Chart every guess and clue, and use logical elimination to rule out impossible codes.", "Try to crack the code in the fewest possible guesses — compare your best score!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_5, N'short_response', N'🧭 Probability Battleship

Objective: Practice applying probability thinking to make efficient guesses on a larger hidden grid.

Materials: Paper with two labeled 8x8 grids per player | Pencil

Follow the steps below to play!', NULL, N'Longer ships have fewer possible positions — think about which squares are statistically more likely.', 5, N'sequence_steps', N'{"steps": ["Each player secretly places 4 hidden ships (of different lengths) on their own grid.", "Take turns calling coordinates, tracking hits and misses on a record grid.", "After a hit, use the ship''s likely length to predict and target nearby squares.", "First to sink all of the other player''s ships wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_5, N'short_response', N'🔤 Two-Way Word Ladder

Objective: Practice planning simultaneously from both a start and end word to find the shortest possible chain.

Materials: Paper | Pencil | A dictionary (optional, to verify words)

Follow the steps below to play!', NULL, N'Meeting in the middle from both directions often finds a shorter path than working from one end only.', 6, N'sequence_steps', N'{"steps": ["Pick a challenging start and target word of equal length, like STONE to BREAD.", "Build possible word chains from the start AND separately from the end, working toward the middle.", "See where the two chains can connect into one full ladder.", "Count your total steps and try to beat it with a shorter chain next time!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_5, N'short_response', N'🏙️ Multi-Constraint Engineering Design

Objective: Practice designing under 3+ simultaneous constraints and evaluating trade-offs between them.

Materials: Building materials (blocks, craft sticks, paper) | Paper and pencil | A test object

Follow the steps below to play!', NULL, N'When requirements conflict, engineers pick the design with the best overall balance, not a perfect score on just one.', 7, N'sequence_steps', N'{"steps": ["Pick a challenge with 3 requirements (e.g., ''holds weight, uses under 15 pieces, has an opening'').", "Sketch 2 different plans, noting which requirement each plan is weaker on.", "Build your strongest overall plan, and test it against all 3 requirements.", "Explain which requirement was hardest to satisfy and why!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_5, N'short_response', N'🃏 Rapid Category Web

Objective: Practice building a web of flexible, justified connections between ideas under time pressure.

Materials: Paper | Pencil | A timer

Follow the steps below to play!', NULL, N'A web (not just a straight chain) lets you branch off in more than one direction — much faster.', 8, N'sequence_steps', N'{"steps": ["Write a starting word in the center of the paper.", "In 90 seconds, branch outward writing connected words, briefly justifying each link.", "Count how many valid connected branches you made.", "Compare webs with a partner — did you find different, equally valid connections?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_5, N'short_response', N'🧩 Blind Tangram Planning

Objective: Practice fully mentally solving a spatial puzzle before touching any pieces.

Materials: A 7-piece paper tangram set | A complex silhouette outline

Follow the steps below to play!', NULL, N'This kind of full mental planning before acting is exactly what chess players and architects train.', 9, N'sequence_steps', N'{"steps": ["Study a complex silhouette outline for up to 2 minutes without touching any pieces.", "Mentally plan the position and rotation of every single piece.", "Only once your full plan is set, place all 7 pieces to fill the silhouette.", "Compare how many pieces you placed correctly on the first try!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_5, N'short_response', N'🎯 Twenty Questions Championship

Objective: Practice using optimal information-gathering strategy across a full multi-round competition.

Materials: None — just thinking and talking | Paper to track scores (optional)

Follow the steps below to play!', NULL, N'A wasted question is one where the answer doesn''t rule out many possibilities — avoid overly specific early guesses.', 10, N'sequence_steps', N'{"steps": ["Play several rounds of Twenty Questions, keeping score of questions used each round.", "For each round, plan your first 2-3 questions before asking, aiming to split possibilities evenly.", "After each round, briefly review which question wasted the most ''information.''", "Lowest total question count across all rounds wins the championship!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_5, N'short_response', N'🔧 Real-World Problem Deep Dive

Objective: Practice thoroughly analyzing a real problem from multiple angles before proposing a solution.

Materials: Paper | Pencil | Craft supplies (optional, for a model)

Follow the steps below to play!', NULL, N'Understanding the problem deeply, before jumping to solutions, is what separates a good design process from a rushed one.', 11, N'sequence_steps', N'{"steps": ["Choose a real problem affecting your home, school, or community.", "List who is affected by the problem and what''s been tried before, if anything.", "Brainstorm at least 3 different solution ideas, weighing a pro and con for each.", "Build or sketch your top idea, and prepare to explain your full reasoning!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_5, N'short_response', N'🪞 Chained Reflection Sequence

Objective: Practice mentally transforming a long movement sequence through multiple operations at once.

Materials: None — just two or more people and some space

Follow the steps below to play!', NULL, N'Breaking a long sequence into smaller memorable chunks (chunking) is a real memory-science strategy.', 12, N'sequence_steps', N'{"steps": ["One partner performs a sequence of 6+ movements in a row.", "The others must mentally reverse the order, mirror each movement, AND wait 5 seconds before starting.", "Perform the transformed sequence, then check accuracy together as a group.", "Take turns leading, and try adding one more transformation rule each round!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_5, N'short_response', N'🗺️ Traveling Route Challenge

Objective: Practice solving a simplified version of finding the most efficient order to visit many locations.

Materials: Paper with a map showing 6-7 stops and a start/end point | Pencil

Follow the steps below to play!', NULL, N'This puzzle (visiting many stops in the shortest order) is a real, famously hard problem computer scientists still study.', 13, N'sequence_steps', N'{"steps": ["Draw a map with a start point and 6-7 scattered stops that must all be visited once.", "Try out at least 3 different visiting orders, estimating the total distance for each.", "Identify your shortest route found so far.", "Challenge a partner to try to beat your best route!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_5, N'short_response', N'💭 Metacognitive Strategy Audit

Objective: Practice deeply analyzing your own problem-solving strategy to identify patterns across multiple games.

Materials: Paper | Pencil | Notes from at least 2 games played this week

Follow the steps below to play!', NULL, N'Spotting a pattern across multiple games (not just one) reveals your real thinking habits, not just a lucky or unlucky moment.', 14, N'sequence_steps', N'{"steps": ["Review your notes or memory of 2 different strategy games you''ve played.", "Identify one strategy or habit that showed up in both games.", "Decide if that habit generally helps or hurts your performance.", "Write one specific, actionable change to try in your next game!"]}');

    DECLARE @cat_cog_6 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (6, 'cognitive_skills', N'Brain & Strategy Games', 'space_heavy', 7, N'Challenge your brain with a fun thinking game this week!', 0);
    SET @cat_cog_6 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_6, N'short_response', N'🧠 Championship Memory Grid

Objective: Practice managing a large-scale memory task using a personal organizational system.

Materials: 30 cards (15 matching pairs) | A timer | Paper to sketch your system (optional)

Follow the steps below to play!', NULL, N'Having a deliberate system beats relying on raw memory alone — that''s true for real memory competitions too.', 1, N'sequence_steps', N'{"steps": ["Lay all 30 cards face-down in a 5x6 grid, and start the timer.", "Before flipping, decide on a system for tracking what you see (grid coordinates, grouping, etc.).", "Find all 15 pairs, using your system to avoid re-checking known cards.", "Record your time and flip-efficiency (flips per pair found), then aim to beat both!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_6, N'short_response', N'🔺 Grand Master Strategy Grid

Objective: Practice advanced multi-move planning, including sacrificing a smaller advantage for a bigger one.

Materials: Paper with a 10x10 grid | Pencil or 2 colors of tokens

Follow the steps below to play!', NULL, N'Sometimes ignoring a small threat to set up a bigger unstoppable one is the winning move — that''s real strategic thinking.', 2, N'sequence_steps', N'{"steps": ["Draw a 10x10 grid; take turns placing tokens, aiming to connect 5 in a row.", "Plan at least 2 moves ahead, considering how your partner might respond to each option.", "Watch for opportunities to set up a fork (two threats at once) rather than just blocking.", "Play to a finish, then walk through the game together identifying the critical turning point!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_6, N'short_response', N'🏗️ Optimized Load Bridge Engineering

Objective: Apply structural engineering trade-off analysis to design the most efficient bridge possible.

Materials: 30 craft sticks | Tape | A set of standard test weights (coins) | Paper for data and sketches

Follow the steps below to play!', NULL, N'Real bridge engineers always report a strength-to-material ratio, not just raw strength — try thinking the same way.', 3, N'sequence_steps', N'{"steps": ["Research or recall one real bridge design principle (truss, arch, suspension) before sketching.", "Sketch 2-3 designs applying that principle, predicting relative strength and material cost.", "Build and test your best design, recording weight held versus sticks used.", "Write a short analysis: what worked, what you''d change, and why!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_6, N'short_response', N'🗝️ Master Code Breaker

Objective: Practice full systematic logical deduction to solve a complex multi-symbol code efficiently.

Materials: Paper | Pencil | 6-8 different colors or symbols

Follow the steps below to play!', NULL, N'Mathematicians have studied this exact game and shown it can always be solved in a small, fixed number of optimal guesses.', 4, N'sequence_steps', N'{"steps": ["One player secretly writes a 5-symbol code from 8 possible symbols (repeats allowed).", "The other guesses, receiving position and symbol-match feedback each round.", "Build a logical elimination chart, tracking every impossible combination as you go.", "Try to crack the code using the theoretical minimum number of guesses — research shows it''s possible in very few!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_6, N'short_response', N'🧭 Strategic Probability Battleship

Objective: Practice applying probability and Bayesian-style reasoning to optimize search efficiency.

Materials: Paper with two labeled 10x10 grids per player | Pencil

Follow the steps below to play!', NULL, N'Professional game theorists study exactly this kind of search-and-probability strategy — you''re doing real applied math.', 5, N'sequence_steps', N'{"steps": ["Each player secretly places 5 ships of varying lengths on their own grid.", "Take turns guessing coordinates, tracking probability ''heat'' for likely ship locations based on misses.", "After every hit, calculate the most likely direction the rest of the ship extends.", "First to sink all the other player''s ships wins — discuss your probability strategy afterward!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_6, N'short_response', N'🔤 Constrained Word Ladder Challenge

Objective: Practice solving a word-transformation puzzle under an added difficulty constraint.

Materials: Paper | Pencil | A dictionary (optional, to verify words)

Follow the steps below to play!', NULL, N'Adding a constraint (like a fixed word length) makes the puzzle harder but often reveals a cleverer solution path.', 6, N'sequence_steps', N'{"steps": ["Pick a challenging start and target word, and add one constraint (e.g., every word must be 5 letters).", "Plan possible paths from both ends toward the middle, honoring the constraint.", "Build your full ladder, checking every word is real and meets the rule.", "Compare your ladder length with a partner''s — whose solution was more efficient?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_6, N'short_response', N'🏙️ Trade-Off Engineering Studio

Objective: Practice designing under competing constraints and clearly justifying the trade-offs made.

Materials: Building materials (blocks, craft sticks, paper) | Paper and pencil | A test object or scenario

Follow the steps below to play!', NULL, N'Being able to explain WHY you gave something up is the mark of real engineering thinking, not just guessing.', 7, N'sequence_steps', N'{"steps": ["Pick a challenge with constraints that conflict (e.g., ''lightweight but very strong, and cheap'' — using a set piece budget).", "Sketch 2-3 designs, explicitly labeling what each design sacrifices to gain something else.", "Build and test your chosen design against every constraint.", "Present your design, explaining exactly which trade-off you chose and why it made sense!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_6, N'short_response', N'🃏 Six-Degrees Connection Challenge

Objective: Practice building a long, logically justified chain connecting two seemingly unrelated ideas.

Materials: Paper | Pencil

Follow the steps below to play!', NULL, N'This is inspired by the real ''six degrees of separation'' idea — almost anything can be logically connected in surprisingly few steps.', 8, N'sequence_steps', N'{"steps": ["Pick two very different starting and ending words (like ''ocean'' and ''guitar'').", "Build a connected chain of ideas linking one to the other, explaining each link.", "Try to connect them in 6 steps or fewer.", "Challenge someone else to find an even shorter valid chain!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_6, N'short_response', N'🧩 Constraint Tangram Design

Objective: Practice inventing an original silhouette design using all pieces under a specific rule.

Materials: A 7-piece paper tangram set | Paper to trace your design

Follow the steps below to play!', NULL, N'Designing your own puzzle (not just solving one) exercises a completely different, more advanced part of spatial thinking.', 9, N'sequence_steps', N'{"steps": ["Set yourself a design rule, like ''create an animal using every piece exactly once.''", "Plan mentally, then arrange all 7 pieces to create your original silhouette.", "Trace around your finished design onto paper.", "Challenge a partner to recreate your design using only your traced outline!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_6, N'short_response', N'🎯 Information Theory Guessing Game

Objective: Practice using strategic questioning to minimize guesses across a large possibility space.

Materials: A picture or list showing 30+ possible items | Paper to track eliminations

Follow the steps below to play!', NULL, N'For 30+ items, splitting possibilities evenly means you can usually find the answer in about 5 well-chosen questions.', 10, N'sequence_steps', N'{"steps": ["One player secretly picks an item from a large set (30+ options shown to everyone).", "Others ask only yes/no questions, tracking eliminations on paper as they go.", "Aim to cut the remaining possibilities roughly in half with every question.", "Compare your final question count to the mathematical minimum needed for that many options!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_6, N'short_response', N'🔧 Full Design Thinking Sprint

Objective: Practice the complete design-thinking cycle: empathize, define, ideate, prototype, and test.

Materials: Paper | Pencil | Craft supplies for a quick prototype

Follow the steps below to play!', NULL, N'This 5-step process — empathize, define, ideate, prototype, test — is the same cycle real product designers use.', 11, N'sequence_steps', N'{"steps": ["Interview a family member or friend about one small frustration in their daily routine (empathize).", "Clearly define the specific problem in one sentence.", "Brainstorm at least 4 possible solutions before picking your favorite (ideate).", "Build a quick prototype and get feedback from that person, then note one improvement to make!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_6, N'short_response', N'🪞 Multi-Layer Transformation Chain

Objective: Practice mentally applying and tracking several sequential transformations to a complex sequence.

Materials: None — just two or more people and some space

Follow the steps below to play!', NULL, N'Holding several transformation rules in mind at once and applying them in the right order is advanced working-memory training.', 12, N'sequence_steps', N'{"steps": ["One partner performs a sequence of 6-8 movements in a row.", "The others must apply 3 transformations in order: reverse it, mirror it, then skip every other movement.", "Perform the fully transformed sequence, then check accuracy together as a group.", "Take turns leading and inventing new transformation combinations to apply!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_6, N'short_response', N'🗺️ Optimization Under Constraints

Objective: Practice solving a route-planning puzzle with an added real-world constraint like a time or fuel budget.

Materials: Paper with a map showing 8+ stops and a start/end point | Pencil

Follow the steps below to play!', NULL, N'Choosing what NOT to do, given limited resources, is just as important a skill as planning what to do.', 13, N'sequence_steps', N'{"steps": ["Draw a map with a start point and 8+ stops, each with a different ''cost'' (distance or time) to reach.", "Add a constraint: you can only visit 6 of the 8 stops within a limited total budget.", "Test different combinations of stops and orders to maximize value within the budget.", "Present your best solution and explain which stops you chose to skip and why!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_6, N'short_response', N'💭 Personal Strategy Portfolio

Objective: Practice building a long-term, evidence-based understanding of your own thinking strengths and habits.

Materials: Paper or a notebook | Pencil | Notes from at least 3 different games played over time

Follow the steps below to play!', NULL, N'Tracking your thinking across many games — not just reflecting after one — is how real experts build lasting self-awareness.', 14, N'sequence_steps', N'{"steps": ["Review notes or memories from at least 3 different thinking games you''ve played recently.", "Identify one thinking strength that shows up consistently across them.", "Identify one habit that consistently holds you back or wastes time.", "Write a short ''strategy plan'' with 2 specific things to try in your next challenging game!"]}');

    DECLARE @cat_cog_7 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (7, 'cognitive_skills', N'Brain & Strategy Games', 'space_heavy', 7, N'Challenge your brain with a fun thinking game this week!', 0);
    SET @cat_cog_7 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_7, N'short_response', N'🧠 Elite Memory Championship

Objective: Practice applying an advanced personal memory system to master a large-scale recall challenge.

Materials: 36 cards (18 matching pairs) | A timer | Paper to design your memory system

Follow the steps below to play!', NULL, N'World memory champions all use invented systems, not raw memorization — building your own is real cognitive science in action.', 1, N'sequence_steps', N'{"steps": ["Before starting, design and write out your own memory system (chunking, coordinates, story-linking, etc.).", "Lay all 36 cards face-down in a 6x6 grid, and start the timer.", "Find all 18 pairs using your system, refining it mid-game if it''s not working well.", "Record your time and reflect on which part of your system helped most!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_7, N'short_response', N'🔺 Tournament Strategy Grid

Objective: Practice deep multi-move strategic planning across a full best-of-three match format.

Materials: Paper with a 12x12 grid | Pencil or 2 colors of tokens

Follow the steps below to play!', NULL, N'Studying your own games afterward, like real strategy-game competitors do, improves your play faster than just playing more.', 2, N'sequence_steps', N'{"steps": ["Draw a 12x12 grid; play a best-of-3 match, connecting 5 in a row to win each game.", "Between games, discuss what opening strategy worked and adjust your approach.", "In each game, plan at least 3 moves ahead and watch for double-threat opportunities.", "Whoever wins 2 of 3 games is the match champion — analyze the deciding game together!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_7, N'short_response', N'🏗️ Full Engineering Design Report

Objective: Apply the complete engineering design process — research, design, build, test, iterate, report.

Materials: 35 craft sticks | Tape | A set of standard test weights | Paper for a written design report

Follow the steps below to play!', NULL, N'Writing a real design report — not just building — is what turns a fun project into genuine engineering practice.', 3, N'sequence_steps', N'{"steps": ["Research one real structural principle and explain in writing how it applies to your build.", "Sketch and label 2-3 candidate designs, predicting strength and material efficiency for each.", "Build and test your chosen design, recording data at each weight increment until failure.", "Write a short report: hypothesis, results, and what you''d change in version 2!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_7, N'short_response', N'🗝️ Optimal-Strategy Code Breaker

Objective: Practice applying a proven optimal opening strategy to minimize guesses in a logic-deduction game.

Materials: Paper | Pencil | 8 different colors or symbols

Follow the steps below to play!', NULL, N'This exact puzzle has a mathematically proven optimal strategy — see if you can rediscover its logic through play.', 4, N'sequence_steps', N'{"steps": ["One player secretly writes a 5-symbol code from 8 symbols (repeats allowed).", "Before guessing, plan a fixed opening strategy designed to gather the most information possible.", "Guess and track feedback in a systematic elimination chart, adjusting your strategy as clues arrive.", "Try to consistently solve the code in 6 guesses or fewer across several rounds!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_7, N'short_response', N'🧭 Adversarial Search Battleship

Objective: Practice modeling an opponent''s likely strategy while applying your own probability-based search.

Materials: Paper with two labeled 10x10 grids per player | Pencil

Follow the steps below to play!', NULL, N'Thinking about how your OPPONENT thinks (not just the raw odds) is the next level up in game strategy — it''s called ''theory of mind.''', 5, N'sequence_steps', N'{"steps": ["Each player secretly places 5 ships of varying lengths, thinking about where an opponent is LEAST likely to guess.", "Take turns guessing, tracking both your own probability map and guessing where your opponent might avoid.", "Adjust your placement strategy in a rematch based on what worked against you.", "Play a best-of-3 series and discuss which placement and search strategies were strongest!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_7, N'short_response', N'🔤 Constrained Optimization Word Ladder

Objective: Practice solving a word-transformation puzzle while optimizing for the shortest possible valid path.

Materials: Paper | Pencil | A dictionary (optional, to verify words)

Follow the steps below to play!', NULL, N'This puzzle mirrors real ''shortest-path'' problems used in computer science and network routing.', 6, N'sequence_steps', N'{"steps": ["Pick a difficult start and target word pair, and set yourself a target step-count to beat.", "Work from both ends simultaneously, mapping possible middle connection points.", "Build your full ladder and verify every word is valid.", "Try a second, harder word pair, applying the strategy that worked best the first time!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_7, N'short_response', N'🏙️ Systems-Level Design Challenge

Objective: Practice designing a solution that considers how multiple interacting parts affect each other.

Materials: Building materials (blocks, craft sticks, paper) | Paper and pencil | A test scenario

Follow the steps below to play!', NULL, N'Thinking about how parts of a system affect each other, not just one piece at a time, is called ''systems thinking'' — a core skill in real engineering.', 7, N'sequence_steps', N'{"steps": ["Pick a challenge involving multiple connected parts (e.g., a small town layout with roads, a bridge, and a park).", "Sketch how each part affects the others (e.g., where the bridge goes affects where the road can go).", "Build your design, checking that all parts work together, not just individually.", "Present your design, explaining one trade-off where improving one part meant compromising another!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_7, N'short_response', N'🃏 Cross-Domain Connection Marathon

Objective: Practice building sophisticated, well-reasoned chains of connection across very different domains of knowledge.

Materials: Paper | Pencil

Follow the steps below to play!', NULL, N'The ability to find non-obvious connections across different fields is a hallmark of highly creative and innovative thinkers.', 8, N'sequence_steps', N'{"steps": ["Pick two words from completely different domains (like ''volcano'' and ''symphony'').", "Build the shortest logical chain of connected ideas linking them, explaining each link clearly.", "Try to reach the connection in 5 steps or fewer.", "Trade starting pairs with a partner and compare whose chain used more creative reasoning!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_7, N'short_response', N'🧩 Original Puzzle Design Studio

Objective: Practice designing an original spatial puzzle for someone else to solve, including a difficulty rating.

Materials: A 7-piece paper tangram set (or graph paper for a custom puzzle) | Paper

Follow the steps below to play!', NULL, N'Designing a puzzle requires understanding the solution even more deeply than solving one does.', 9, N'sequence_steps', N'{"steps": ["Design an original silhouette or spatial puzzle using your materials.", "Solve it yourself first to confirm it''s actually solvable.", "Rate its difficulty (easy/medium/hard) and write one hint for solvers.", "Give it to a partner to solve, and see if your difficulty rating matched their experience!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_7, N'short_response', N'🎯 Optimal Information Strategy Game

Objective: Practice applying formal information-theory reasoning to minimize guesses across a very large possibility space.

Materials: A list or picture showing 50+ possible items | Paper to track eliminations

Follow the steps below to play!', NULL, N'This is a simplified version of how computer scientists measure the efficiency of real search and sorting algorithms.', 10, N'sequence_steps', N'{"steps": ["One player secretly picks an item from a large set (50+ options).", "Others plan a strategy that splits possibilities as evenly as possible with each question.", "Track eliminations carefully, refining your questioning strategy as you go.", "Compare your final question count to the mathematical minimum for that many options (about 6)!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_7, N'short_response', N'🔧 Community Problem Design Sprint

Objective: Practice the full design-thinking cycle applied to a genuine problem affecting a wider group of people.

Materials: Paper | Pencil | Craft supplies for a quick prototype

Follow the steps below to play!', NULL, N'The strongest designs come from deeply understanding a problem from other people''s perspectives, not just your own.', 11, N'sequence_steps', N'{"steps": ["Identify a real problem affecting your school, neighborhood, or community (not just yourself).", "Interview at least one other person affected by it to understand their perspective.", "Brainstorm and narrow down to your strongest solution idea, considering cost and feasibility.", "Build a prototype or detailed plan, and present it as if pitching to people who could actually implement it!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_7, N'short_response', N'🪞 Recursive Transformation Challenge

Objective: Practice applying a transformation rule to its own output, testing deep working-memory and abstraction.

Materials: None — just two or more people and some space

Follow the steps below to play!', NULL, N'Applying a rule to its own result is called recursion — a concept at the core of both math and computer programming.', 12, N'sequence_steps', N'{"steps": ["One partner performs a sequence of 5 movements.", "The group applies a transformation rule (like ''reverse and mirror'') to create a new sequence.", "Now apply the SAME transformation rule again to that new sequence, and perform the final result.", "Check accuracy together, then invent a new transformation rule to apply recursively!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_7, N'short_response', N'🗺️ Real-World Logistics Simulation

Objective: Practice solving a realistic, constrained optimization problem similar to real delivery or scheduling systems.

Materials: Paper with a map showing 10+ stops with varying priorities and a start/end point | Pencil

Follow the steps below to play!', NULL, N'This mirrors exactly how real delivery companies and emergency responders plan efficient routes under real-world limits.', 13, N'sequence_steps', N'{"steps": ["Draw a map with a start point and 10+ stops, each labeled with a priority level and a travel cost.", "Set a limited total budget (time, distance, or fuel) that can''t cover every stop.", "Plan a route maximizing total priority value visited within budget, testing multiple combinations.", "Present your final route and defend why it''s the best possible use of a limited budget!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_cog_7, N'short_response', N'💭 Cognitive Strategy Research Project

Objective: Practice conducting a small self-directed investigation into what thinking strategies work best for you personally.

Materials: Paper or a notebook | Pencil | Several different thinking games played over at least a week

Follow the steps below to play!', NULL, N'This is literally the scientific method applied to your own brain — forming a hypothesis, testing it, and drawing conclusions.', 14, N'sequence_steps', N'{"steps": ["Choose 2 different strategies to test across multiple plays of the same type of game (e.g., planning ahead vs. reacting).", "Track your results and how each strategy felt across several games.", "Analyze which strategy performed better and think about why.", "Write a short conclusion with your personal ''best strategy'' recommendation and evidence for it!"]}');

END
GO

DELETE FROM dbo.WeeklyPacketPlan;
GO