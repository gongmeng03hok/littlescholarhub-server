-- 66_stem_arts_content.sql
-- Whole-Child Curriculum expansion, batch 3: content for the 'stem_engineering'
-- (MIT STEM/Coding, Caltech Science & Experimentation, Georgia Tech Engineering &
-- Robotics, UIUC CS/Math/Data) and 'arts' (Visual Art, Music & Performing Arts,
-- Creative Writing & Storytelling) subject_area groups, hand-crafted across all
-- 8 grades from the curriculum matrix the site owner provided. Requires
-- 63_whole_child_rotation.sql to already be applied. See gen_66_stem_arts_content.py.

IF NOT EXISTS (SELECT 1 FROM dbo.PacketCategories WHERE subject_area = 'stem_engineering')
BEGIN
    DECLARE @cat_mit_stem_0 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (0, 'stem_engineering', N'STEM, Engineering & Coding', 'short_answer', 4, NULL, 0);
    SET @cat_mit_stem_0 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_mit_stem_0, N'multiple_choice', N'Which simple machine helps you roll something up to a higher spot?', N'["Ramp", "Lever", "Wheel"]', N'Ramp', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_mit_stem_0, N'multiple_choice', N'A see-saw is an example of a...', N'["Lever", "Ramp", "Pulley"]', N'Lever', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_mit_stem_0, N'short_response', N'Name a simple machine you''ve seen or used.', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_mit_stem_0, N'multiple_choice', N'A ramp helps you...', N'["Move something up or down more easily", "Make something disappear", "Make noise"]', N'Move something up or down more easily', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_mit_stem_0, N'short_response', N'Draw a picture of a ramp being used.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_mit_stem_0, N'multiple_choice', N'Simple machines help people...', N'["Do work more easily", "Make things harder", "Nothing useful"]', N'Do work more easily', 6);

    DECLARE @cat_mit_stem_1 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (1, 'stem_engineering', N'STEM, Engineering & Coding', 'short_answer', 4, N'Take on the build-a-tower challenge!', 0);
    SET @cat_mit_stem_1 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_mit_stem_1, N'short_response', N'What materials would you use to build the tallest tower you can?', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_mit_stem_1, N'multiple_choice', N'A strong tower base should be...', N'["Wide, to help it balance", "As thin as possible", "Made only of paper"]', N'Wide, to help it balance', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_mit_stem_1, N'short_response', N'If your tower fell over, what would you try differently next time?', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_mit_stem_1, N'multiple_choice', N'Why does a wide base usually make a tower more stable?', N'["It spreads the weight out and resists tipping over", "Wide bases make towers weaker", "Base width doesn''t matter"]', N'It spreads the weight out and resists tipping over', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_mit_stem_1, N'short_response', N'Draw your tower design before building it.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_mit_stem_1, N'multiple_choice', N'Testing your tower after building it helps you...', N'["See if your design actually works", "Nothing, testing is a waste of time", "Make the tower shorter"]', N'See if your design actually works', 6);

    DECLARE @cat_mit_stem_2 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (2, 'stem_engineering', N'STEM, Engineering & Coding', 'short_answer', 4, N'Practice unplugged coding by sequencing arrows to move a character.', 0);
    SET @cat_mit_stem_2 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_mit_stem_2, N'short_response', N'Sequence the arrows to move a character from start to the treasure: up, right, right, down.', NULL, N'Up, right, right, down.', 1, N'sequence_steps', N'{"steps": ["Up", "Right", "Right", "Down"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_mit_stem_2, N'multiple_choice', N'In coding, a ''sequence'' is...', N'["A set of steps done in order", "A random guess", "A single step only"]', N'A set of steps done in order', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_mit_stem_2, N'short_response', N'Write your own 3-arrow sequence to move a character forward, then turn.', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_mit_stem_2, N'multiple_choice', N'If you put the arrows in the WRONG order, what happens?', N'["The character goes the wrong way", "Nothing changes", "The character disappears"]', N'The character goes the wrong way', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_mit_stem_2, N'short_response', N'Why does the ORDER of the arrows matter so much in coding?', NULL, N'Each step happens one after another, so the wrong order leads to the wrong result.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_mit_stem_2, N'multiple_choice', N'Coding without a computer, using arrows or cards, is called...', N'["Unplugged coding", "Plugged coding", "No coding at all"]', N'Unplugged coding', 6);

    DECLARE @cat_mit_stem_3 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (3, 'stem_engineering', N'STEM, Engineering & Coding', 'short_answer', 4, N'Explore simple circuits and levers.', 0);
    SET @cat_mit_stem_3 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_mit_stem_3, N'multiple_choice', N'A simple circuit needs a power source, wires, and a...', N'["Light bulb or device to power", "Nothing else", "A lever"]', N'Light bulb or device to power', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_mit_stem_3, N'multiple_choice', N'If a circuit has a break in the wire, what happens?', N'["The circuit won''t work", "It works even better", "Nothing changes"]', N'The circuit won''t work', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_mit_stem_3, N'short_response', N'Draw a simple circuit with a battery, a wire, and a light bulb.', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_mit_stem_3, N'multiple_choice', N'A lever helps you lift a heavy object by...', N'["Using a pivot point to multiply your force", "Making the object lighter", "Removing gravity"]', N'Using a pivot point to multiply your force', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_mit_stem_3, N'short_response', N'Name one place you might see a lever used in real life.', NULL, N'Answers will vary (e.g., a seesaw, a bottle opener, scissors).', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_mit_stem_3, N'multiple_choice', N'Circuits and levers are both examples of...', N'["Simple tools that make work easier", "Living things", "Foods"]', N'Simple tools that make work easier', 6);

    DECLARE @cat_mit_stem_4 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (4, 'stem_engineering', N'STEM, Engineering & Coding', 'short_answer', 4, N'Solve coding logic puzzles using if/then sequencing.', 0);
    SET @cat_mit_stem_4 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_mit_stem_4, N'short_response', N'Write an IF/THEN rule for a robot: ''IF it sees a wall, THEN ___.''', NULL, N'Answers will vary (e.g., ''THEN it turns right.'').', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_mit_stem_4, N'multiple_choice', N'An IF/THEN statement lets a program...', N'["Make a decision based on a condition", "Always do the exact same thing no matter what", "Skip all its steps"]', N'Make a decision based on a condition', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_mit_stem_4, N'short_response', N'Write your own IF/THEN rule for a game character.', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_mit_stem_4, N'multiple_choice', N'IF a robot''s battery is low, THEN it should probably...', N'["Go recharge", "Move faster", "Stop working forever"]', N'Go recharge', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_mit_stem_4, N'short_response', N'Why are IF/THEN rules useful for programming instead of just one long list of steps?', NULL, N'They let the program react differently depending on what''s happening, not just repeat the same steps blindly.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_mit_stem_4, N'multiple_choice', N'A coding logic puzzle usually asks you to...', N'["Figure out the right sequence and conditions to solve a problem", "Draw a picture with no logic involved", "Memorize random facts"]', N'Figure out the right sequence and conditions to solve a problem', 6);

    DECLARE @cat_mit_stem_5 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (5, 'stem_engineering', N'STEM, Engineering & Coding', 'space_heavy', 4, N'Design, build, and test a bridge challenge.', 0);
    SET @cat_mit_stem_5 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_mit_stem_5, N'short_response', N'What materials would you use to build a bridge that can hold weight?', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_mit_stem_5, N'short_response', N'Put the engineering design steps in order for this bridge challenge.', NULL, N'Plan, build, test, improve.', 2, N'sequence_steps', N'{"steps": ["Plan your bridge design", "Build it with your materials", "Test it with weight", "Improve it based on what happened"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_mit_stem_5, N'short_response', N'What shape (like a triangle) might make a bridge stronger, and why?', NULL, N'Triangles are strong shapes that resist bending, so triangle supports help distribute weight.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_mit_stem_5, N'multiple_choice', N'If your bridge collapses during testing, that means...', N'["You learned something useful for your next design", "You should give up on engineering", "Nothing, testing doesn''t matter"]', N'You learned something useful for your next design', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_mit_stem_5, N'short_response', N'How would you test how much weight your bridge can hold?', NULL, N'Answers will vary (e.g., adding weights gradually until it fails).', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_mit_stem_5, N'multiple_choice', N'Why do engineers build and test PROTOTYPES before a final design?', N'["Testing reveals weaknesses you can''t predict just by planning", "Prototypes are a waste of time", "The first design is always perfect"]', N'Testing reveals weaknesses you can''t predict just by planning', 6);

    DECLARE @cat_mit_stem_6 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (6, 'stem_engineering', N'STEM, Engineering & Coding', 'space_heavy', 4, N'Get an intro to algorithms and flowcharts.', 0);
    SET @cat_mit_stem_6 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_mit_stem_6, N'short_response', N'What is an algorithm? Explain in your own words.', NULL, N'A step-by-step set of instructions for solving a problem or completing a task.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_mit_stem_6, N'short_response', N'Write a simple algorithm (as ordered steps) for making a peanut butter sandwich.', NULL, N'Answers will vary but should be a clear, ordered sequence.', 2, N'sequence_steps', N'{"steps": ["Get bread", "Spread peanut butter", "Put the slices together"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_mit_stem_6, N'multiple_choice', N'A flowchart uses shapes and arrows to show...', N'["The steps and decisions in a process", "A piece of art with no meaning", "A list with no order"]', N'The steps and decisions in a process', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_mit_stem_6, N'short_response', N'Draw a simple flowchart for deciding whether to bring an umbrella (hint: start with ''Is it raining?'').', NULL, N'Answers will vary — should include a decision point (yes/no) leading to different outcomes.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_mit_stem_6, N'multiple_choice', N'Why do programmers often plan with flowcharts BEFORE writing code?', N'["It helps them think through the logic clearly first", "Flowcharts have nothing to do with programming", "It''s required by law"]', N'It helps them think through the logic clearly first', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_mit_stem_6, N'short_response', N'Why might an algorithm with unclear or missing steps cause problems?', NULL, N'Whoever (or whatever) follows the algorithm might not know what to do, or do the wrong thing.', 6);

    DECLARE @cat_mit_stem_7 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (7, 'stem_engineering', N'STEM, Engineering & Coding', 'space_heavy', 4, N'Complete a mini engineering design project: plan, build, test, improve.', 0);
    SET @cat_mit_stem_7 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_mit_stem_7, N'short_response', N'Choose a simple engineering challenge (like a paper airplane that flies far, or a container that protects an egg drop). Describe your PLAN.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_mit_stem_7, N'short_response', N'Describe how you BUILT your design based on the plan.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_mit_stem_7, N'short_response', N'Describe how you TESTED your design, and what happened.', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_mit_stem_7, N'short_response', N'Describe how you would IMPROVE your design based on the test results.', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_mit_stem_7, N'multiple_choice', N'The engineering design cycle (plan, build, test, improve) is usually...', N'["Repeated multiple times to get a better result", "Only ever done once", "Done in a random order"]', N'Repeated multiple times to get a better result', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_mit_stem_7, N'multiple_choice', N'Why is ''improve'' an important final step, not just ''test''?', N'["Testing shows what''s wrong, but improving actually fixes it", "Improving is unnecessary once you''ve tested", "The improve step should come before testing"]', N'Testing shows what''s wrong, but improving actually fixes it', 6);

    DECLARE @cat_caltech_sci_0 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (0, 'stem_engineering', N'Science & Experimentation', 'short_answer', 4, NULL, 0);
    SET @cat_caltech_sci_0 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_caltech_sci_0, N'multiple_choice', N'Which sense would you use to find a flower on a nature walk?', N'["Smell or sight", "Taste", "Hearing only"]', N'Smell or sight', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_caltech_sci_0, N'short_response', N'Name one thing you might see, hear, or smell outside.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_caltech_sci_0, N'multiple_choice', N'On a nature walk, scientists...', N'["Observe things closely", "Ignore everything around them", "Stay inside"]', N'Observe things closely', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_caltech_sci_0, N'short_response', N'Draw one thing you noticed on a walk outside (real or imagined).', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_caltech_sci_0, N'multiple_choice', N'Which sense helps you feel if a leaf is smooth or rough?', N'["Touch", "Taste", "Hearing"]', N'Touch', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_caltech_sci_0, N'short_response', N'What is your favorite thing to notice outside?', NULL, N'Answers will vary.', 6);

    DECLARE @cat_caltech_sci_1 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (1, 'stem_engineering', N'Science & Experimentation', 'short_answer', 4, N'Predict whether objects will sink or float, then test them!', 0);
    SET @cat_caltech_sci_1 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_caltech_sci_1, N'multiple_choice', N'Do you predict a rock will sink or float?', N'["Sink", "Float"]', N'Sink', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_caltech_sci_1, N'multiple_choice', N'Do you predict a small piece of wood will sink or float?', N'["Float", "Sink"]', N'Float', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_caltech_sci_1, N'short_response', N'Pick an object. Predict if it will sink or float, then explain why you think so.', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_caltech_sci_1, N'multiple_choice', N'A prediction is...', N'["A guess based on what you already know", "Always 100% correct", "The same thing as a fact"]', N'A guess based on what you already know', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_caltech_sci_1, N'short_response', N'Why do scientists make predictions BEFORE testing something?', NULL, N'It helps them think about what they expect and compare it to what actually happens.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_caltech_sci_1, N'multiple_choice', N'If your prediction was wrong, that means...', N'["You learned something new", "You''re bad at science", "The experiment was pointless"]', N'You learned something new', 6);

    DECLARE @cat_caltech_sci_2 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (2, 'stem_engineering', N'Science & Experimentation', 'short_answer', 4, N'Keep a simple observation journal — draw and describe what you notice.', 0);
    SET @cat_caltech_sci_2 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_caltech_sci_2, N'short_response', N'Pick something to observe (a plant, a bug, the sky). Draw it and describe 2 things you notice.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_caltech_sci_2, N'multiple_choice', N'An observation journal helps scientists...', N'["Remember and record what they noticed", "Forget their findings quickly", "Skip taking notes"]', N'Remember and record what they noticed', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_caltech_sci_2, N'short_response', N'Why is it useful to WRITE DOWN observations instead of just remembering them?', NULL, N'Written notes don''t get forgotten and can be checked or compared later.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_caltech_sci_2, N'multiple_choice', N'A good observation describes...', N'["What you actually see, not just what you think or feel", "Only your opinion", "Something you imagined"]', N'What you actually see, not just what you think or feel', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_caltech_sci_2, N'short_response', N'Observe the same thing again tomorrow (or later today). Did anything change?', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_caltech_sci_2, N'multiple_choice', N'Careful observation is an important first step in...', N'["The scientific process", "Cooking dinner", "Playing a video game"]', N'The scientific process', 6);

    DECLARE @cat_caltech_sci_3 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (3, 'stem_engineering', N'Science & Experimentation', 'short_answer', 4, N'Try a predict-observe-record mini experiment.', 0);
    SET @cat_caltech_sci_3 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_caltech_sci_3, N'short_response', N'PREDICT: what do you think will happen if you put an ice cube in warm water?', NULL, N'Answers will vary (e.g., it will melt).', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_caltech_sci_3, N'short_response', N'OBSERVE: describe what actually happens when you (or someone) tries it.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_caltech_sci_3, N'short_response', N'RECORD: write down your results clearly.', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_caltech_sci_3, N'multiple_choice', N'The ''predict-observe-record'' method helps scientists...', N'["Compare what they expected to what really happened", "Skip actually doing the experiment", "Guess randomly with no structure"]', N'Compare what they expected to what really happened', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_caltech_sci_3, N'multiple_choice', N'If your observation matched your prediction, what does that suggest?', N'["Your prediction was based on good reasoning", "The experiment failed", "Nothing useful"]', N'Your prediction was based on good reasoning', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_caltech_sci_3, N'short_response', N'Why is the RECORD step important, even after you''ve already observed the result?', NULL, N'Recording keeps an accurate record you can refer back to or share with others.', 6);

    DECLARE @cat_caltech_sci_4 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (4, 'stem_engineering', N'Science & Experimentation', 'short_answer', 4, N'Practice writing a hypothesis and running a simple experiment.', 0);
    SET @cat_caltech_sci_4 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_caltech_sci_4, N'short_response', N'Write a hypothesis (a testable guess) about what happens to a plant with no sunlight.', NULL, N'Answers will vary (e.g., ''I think the plant will not grow well without sunlight.'').', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_caltech_sci_4, N'multiple_choice', N'A hypothesis should be...', N'["Testable — you can actually check if it''s true", "Impossible to test", "Just a random statement"]', N'Testable — you can actually check if it''s true', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_caltech_sci_4, N'short_response', N'Design a simple experiment to test your hypothesis above.', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_caltech_sci_4, N'multiple_choice', N'A hypothesis is different from a fact because...', N'["It hasn''t been tested/proven yet", "It''s always true", "It''s the same as an opinion with no reasoning"]', N'It hasn''t been tested/proven yet', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_caltech_sci_4, N'short_response', N'What result would PROVE your hypothesis wrong?', NULL, N'Answers will vary (e.g., if the plant grew fine without sunlight).', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_caltech_sci_4, N'multiple_choice', N'Why do scientists write a hypothesis BEFORE running an experiment?', N'["It gives the experiment a clear question to test", "Hypotheses are written after, not before", "It''s not actually necessary"]', N'It gives the experiment a clear question to test', 6);

    DECLARE @cat_caltech_sci_5 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (5, 'stem_engineering', N'Science & Experimentation', 'space_heavy', 4, N'Learn about variables: what changes, and what stays the same.', 0);
    SET @cat_caltech_sci_5 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_caltech_sci_5, N'short_response', N'In a plant-growth experiment testing sunlight, what is the ONE thing you''d change (the variable)?', NULL, N'The amount of sunlight the plant gets.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_caltech_sci_5, N'short_response', N'What things should stay the SAME between your test plants (besides sunlight)?', NULL, N'Water amount, soil type, pot size, temperature, etc.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_caltech_sci_5, N'multiple_choice', N'Changing only ONE variable at a time in an experiment helps you...', N'["Know that variable caused the result, not something else", "Get faster but less accurate results", "Confuse your results"]', N'Know that variable caused the result, not something else', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_caltech_sci_5, N'multiple_choice', N'If you changed BOTH sunlight AND water amount at once, what problem would that cause?', N'["You couldn''t tell which change caused the result", "Nothing, that''s actually the best method", "The experiment would be more accurate"]', N'You couldn''t tell which change caused the result', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_caltech_sci_5, N'short_response', N'Why is keeping everything else the SAME (except your variable) important for a fair test?', NULL, N'It isolates the effect of the one thing you''re testing, making the results reliable.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_caltech_sci_5, N'short_response', N'Design your own simple experiment, clearly stating your variable and what stays constant.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_caltech_sci_6 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (6, 'stem_engineering', N'Science & Experimentation', 'space_heavy', 4, N'Design a controlled experiment.', 0);
    SET @cat_caltech_sci_6 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_caltech_sci_6, N'short_response', N'Pick a question to test (e.g., ''Does music affect how fast people solve a puzzle?''). Write it as a hypothesis.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_caltech_sci_6, N'short_response', N'Describe your CONTROL group (the group with no change) and your TEST group (the group with the variable changed).', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_caltech_sci_6, N'multiple_choice', N'A control group in an experiment is used to...', N'["Compare against, to see if the variable really made a difference", "Make the experiment take longer", "Nothing important"]', N'Compare against, to see if the variable really made a difference', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_caltech_sci_6, N'short_response', N'Why might an experiment WITHOUT a control group give misleading results?', NULL, N'Without something to compare to, you can''t tell if the variable actually caused the change.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_caltech_sci_6, N'multiple_choice', N'A well-controlled experiment usually has...', N'["One clear variable, a control group, and consistent conditions", "Many different variables changing all at once", "No plan at all"]', N'One clear variable, a control group, and consistent conditions', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_caltech_sci_6, N'short_response', N'Design a simple controlled experiment for a question of your own choosing.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_caltech_sci_7 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (7, 'stem_engineering', N'Science & Experimentation', 'space_heavy', 4, N'Plan a science-fair-style project: question, hypothesis, method, data.', 0);
    SET @cat_caltech_sci_7 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_caltech_sci_7, N'short_response', N'Write a clear scientific QUESTION for your project.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_caltech_sci_7, N'short_response', N'Write your HYPOTHESIS (testable prediction) for that question.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_caltech_sci_7, N'short_response', N'Describe your METHOD — how would you actually test your hypothesis, step by step?', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_caltech_sci_7, N'short_response', N'What DATA would you collect, and how would you record it?', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_caltech_sci_7, N'multiple_choice', N'A strong science fair project plan includes...', N'["A clear question, hypothesis, method, and data plan — all connected", "Just an interesting topic with no real plan", "Only a hypothesis, nothing else"]', N'A clear question, hypothesis, method, and data plan — all connected', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_caltech_sci_7, N'multiple_choice', N'Why is planning your DATA COLLECTION method in advance important?', N'["It ensures you gather the right information to actually answer your question", "Data doesn''t matter for science projects", "You should decide what data to collect after the experiment is done"]', N'It ensures you gather the right information to actually answer your question', 6);

    DECLARE @cat_gt_robotics_0 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (0, 'stem_engineering', N'Engineering & Robotics', 'short_answer', 4, NULL, 0);
    SET @cat_gt_robotics_0 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gt_robotics_0, N'short_response', N'Build the tallest tower you can with blocks. How many blocks did you use?', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gt_robotics_0, N'multiple_choice', N'A wide base helps a block tower...', N'["Stay standing without falling", "Fall over faster", "Disappear"]', N'Stay standing without falling', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gt_robotics_0, N'short_response', N'What happened when your tower got too tall? Why do you think that happened?', NULL, N'Answers will vary (e.g., it got wobbly and fell).', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gt_robotics_0, N'multiple_choice', N'Building with blocks is a way to practice...', N'["Engineering and building skills", "Cooking", "Reading"]', N'Engineering and building skills', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gt_robotics_0, N'short_response', N'Draw your tallest tower.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gt_robotics_0, N'multiple_choice', N'If your tower falls, what should you do?', N'["Try building it again, maybe differently", "Give up on building forever", "Never try again"]', N'Try building it again, maybe differently', 6);

    DECLARE @cat_gt_robotics_1 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (1, 'stem_engineering', N'Engineering & Robotics', 'short_answer', 4, N'Measure objects using non-standard units (like paperclips or blocks).', 0);
    SET @cat_gt_robotics_1 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gt_robotics_1, N'short_response', N'How many paperclips long is your pencil (a guess is fine if you don''t have one)?', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gt_robotics_1, N'multiple_choice', N'A non-standard unit for measuring is something like...', N'["A paperclip or a block", "A ruler with inches", "A stopwatch"]', N'A paperclip or a block', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gt_robotics_1, N'short_response', N'Measure your desk or table using a non-standard unit. How many did it take?', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gt_robotics_1, N'multiple_choice', N'Why might two people get different answers measuring the same object with paperclips?', N'["Their paperclips (or how they measured) might be slightly different sizes", "Measuring is always exactly the same for everyone", "Objects change size when measured"]', N'Their paperclips (or how they measured) might be slightly different sizes', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gt_robotics_1, N'short_response', N'Why might scientists prefer standard units (like inches) over non-standard ones (like paperclips)?', NULL, N'Standard units are the same everywhere, so everyone gets the same answer.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gt_robotics_1, N'multiple_choice', N'Measuring helps engineers...', N'["Know exact sizes so things fit together correctly", "Guess randomly", "Skip planning"]', N'Know exact sizes so things fit together correctly', 6);

    DECLARE @cat_gt_robotics_2 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (2, 'stem_engineering', N'Engineering & Robotics', 'short_answer', 4, N'Sequence a simple robot''s path using arrows on a grid.', 0);
    SET @cat_gt_robotics_2 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_gt_robotics_2, N'short_response', N'Sequence the robot''s path from start to the goal: forward, forward, turn right, forward.', NULL, N'Forward, forward, turn right, forward.', 1, N'sequence_steps', N'{"steps": ["Forward", "Forward", "Turn right", "Forward"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gt_robotics_2, N'multiple_choice', N'A robot follows instructions...', N'["In the exact order it''s given them", "In a random order", "Only sometimes"]', N'In the exact order it''s given them', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gt_robotics_2, N'short_response', N'Write your own path for a robot to go around an obstacle in the middle of a grid.', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gt_robotics_2, N'multiple_choice', N'If a robot''s path sequence has an error, what happens?', N'["The robot goes to the wrong place", "The robot fixes itself automatically", "Nothing changes"]', N'The robot goes to the wrong place', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gt_robotics_2, N'short_response', N'Why is planning a robot''s path on paper first (before running it) a good idea?', NULL, N'It lets you catch mistakes before the robot actually moves.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gt_robotics_2, N'multiple_choice', N'A grid with arrows is a way to practice...', N'["Robot path planning and sequencing", "Painting", "Singing"]', N'Robot path planning and sequencing', 6);

    DECLARE @cat_gt_robotics_3 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (3, 'stem_engineering', N'Engineering & Robotics', 'short_answer', 4, N'Practice measuring in inches and centimeters.', 0);
    SET @cat_gt_robotics_3 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gt_robotics_3, N'fill_blank', N'A pencil is about 7 inches long. About how many centimeters is that (roughly, 1 inch ≈ 2.5 cm)?', NULL, N'About 17-18 cm', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gt_robotics_3, N'multiple_choice', N'A ruler is used to measure...', N'["Length", "Weight", "Temperature"]', N'Length', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gt_robotics_3, N'short_response', N'Measure 3 objects around you in inches or centimeters, and record their lengths.', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gt_robotics_3, N'multiple_choice', N'Which unit would you use to measure the length of a classroom — inches or feet?', N'["Feet", "Inches", "Neither works"]', N'Feet', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gt_robotics_3, N'short_response', N'Why is it important to line up a ruler''s zero mark exactly with the start of what you''re measuring?', NULL, N'Otherwise the measurement will be inaccurate.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gt_robotics_3, N'multiple_choice', N'Engineers rely on accurate measurement because...', N'["Parts need to fit together precisely", "Measurement doesn''t actually matter", "Guessing is just as good"]', N'Parts need to fit together precisely', 6);

    DECLARE @cat_gt_robotics_4 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (4, 'stem_engineering', N'Engineering & Robotics', 'short_answer', 4, N'Build a vehicle challenge and measure your results.', 0);
    SET @cat_gt_robotics_4 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gt_robotics_4, N'short_response', N'Design a simple vehicle (real or on paper) using materials like straws, wheels, or cardboard.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gt_robotics_4, N'short_response', N'Measure how far your vehicle travels after one push. Record the distance.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gt_robotics_4, N'multiple_choice', N'If your vehicle doesn''t travel far, what could you try changing?', N'["The wheels, weight, or shape", "Nothing, it can''t be improved", "The color only"]', N'The wheels, weight, or shape', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gt_robotics_4, N'short_response', N'Why is measuring your vehicle''s distance important, not just watching it move?', NULL, N'Measuring gives you an exact number to compare between different designs.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gt_robotics_4, N'multiple_choice', N'Comparing measurements between different vehicle designs helps you...', N'["Figure out which design works best", "Nothing useful", "Guess randomly which is best"]', N'Figure out which design works best', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gt_robotics_4, N'short_response', N'What would you change about your vehicle design to make it travel farther next time?', NULL, N'Answers will vary.', 6);

    DECLARE @cat_gt_robotics_5 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (5, 'stem_engineering', N'Engineering & Robotics', 'space_heavy', 4, N'Explore robotics logic: loops and conditionals (unplugged).', 0);
    SET @cat_gt_robotics_5 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gt_robotics_5, N'short_response', N'Write a LOOP instruction for a robot: ''REPEAT 3 TIMES: move forward.'' What would the robot do?', NULL, N'It would move forward 3 times in a row.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gt_robotics_5, N'multiple_choice', N'A loop in programming means...', N'["Repeating a set of instructions multiple times", "Doing something only once", "Stopping the program"]', N'Repeating a set of instructions multiple times', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gt_robotics_5, N'short_response', N'Write your own conditional rule: ''IF the robot detects an obstacle, THEN ___.''', NULL, N'Answers will vary (e.g., ''THEN it stops or turns.'').', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gt_robotics_5, N'multiple_choice', N'Why is a loop more efficient than writing the same instruction 10 separate times?', N'["It''s shorter and easier to change if you need a different number of repeats", "Loops and repeated instructions do completely different things", "Loops are always slower"]', N'It''s shorter and easier to change if you need a different number of repeats', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gt_robotics_5, N'short_response', N'Combine a loop AND a conditional: write instructions for a robot to repeat moving forward UNTIL it hits a wall.', NULL, N'Answers will vary (e.g., ''REPEAT: move forward. IF wall detected, THEN stop.'').', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gt_robotics_5, N'multiple_choice', N'Loops and conditionals together let a program...', N'["React to its environment while repeating useful actions", "Do nothing at all", "Only work if a human controls every single step"]', N'React to its environment while repeating useful actions', 6);

    DECLARE @cat_gt_robotics_6 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (6, 'stem_engineering', N'Engineering & Robotics', 'space_heavy', 4, N'Take on a structural engineering challenge: test weight and strength.', 0);
    SET @cat_gt_robotics_6 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gt_robotics_6, N'short_response', N'Design a structure (like a paper tower or bridge) meant to hold as much weight as possible.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gt_robotics_6, N'short_response', N'Test your structure by adding weight gradually. How much did it hold before failing?', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gt_robotics_6, N'multiple_choice', N'Triangular shapes are often used in engineering because they...', N'["Resist bending and distribute weight well", "Are the easiest shape to draw", "Look nicer than other shapes"]', N'Resist bending and distribute weight well', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gt_robotics_6, N'short_response', N'What part of your structure failed first under weight? Why do you think that happened?', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gt_robotics_6, N'multiple_choice', N'Testing a structure''s strength helps engineers...', N'["Know its real-world limits before it''s actually used", "Nothing useful", "Guess randomly about safety"]', N'Know its real-world limits before it''s actually used', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gt_robotics_6, N'short_response', N'Redesign your structure to be stronger, based on what you learned from testing.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_gt_robotics_7 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (7, 'stem_engineering', N'Engineering & Robotics', 'space_heavy', 4, N'Complete a robotics/engineering capstone: design, build, test, iterate.', 0);
    SET @cat_gt_robotics_7 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gt_robotics_7, N'short_response', N'Choose a robotics or engineering challenge. Describe your initial DESIGN.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gt_robotics_7, N'short_response', N'Describe how you (or would) BUILD your design.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gt_robotics_7, N'short_response', N'Describe your TEST results — what worked, what didn''t?', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gt_robotics_7, N'short_response', N'Describe how you ITERATED (improved) your design based on the test.', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gt_robotics_7, N'multiple_choice', N'''Iterate'' means...', N'["Making repeated, improved versions based on feedback", "Doing something only once, perfectly", "Giving up after the first try"]', N'Making repeated, improved versions based on feedback', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gt_robotics_7, N'multiple_choice', N'Why do real engineers go through MANY iterations instead of stopping at the first working version?', N'["Each iteration usually improves performance, safety, or efficiency", "The first version is always the best possible one", "Iterating wastes time with no benefit"]', N'Each iteration usually improves performance, safety, or efficiency', 6);

    DECLARE @cat_uiuc_data_0 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (0, 'stem_engineering', N'Computer Science, Math & Data', 'short_answer', 4, NULL, 0);
    SET @cat_uiuc_data_0 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_uiuc_data_0, N'fill_blank', N'What comes next in the pattern? Red, Blue, Red, Blue, ___', NULL, N'Red', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_uiuc_data_0, N'fill_blank', N'What comes next in the pattern? Circle, Circle, Square, Circle, Circle, Square, ___', NULL, N'Circle', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_uiuc_data_0, N'multiple_choice', N'A pattern is something that...', N'["Repeats in a predictable way", "Is completely random", "Never repeats"]', N'Repeats in a predictable way', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_uiuc_data_0, N'short_response', N'Make your own AB pattern using shapes or colors.', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_uiuc_data_0, N'short_response', N'Make your own ABC pattern using shapes or colors.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_uiuc_data_0, N'multiple_choice', N'Finding patterns is an important skill for...', N'["Computer scientists and mathematicians", "No one in particular", "Only artists"]', N'Computer scientists and mathematicians', 6);

    DECLARE @cat_uiuc_data_1 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (1, 'stem_engineering', N'Computer Science, Math & Data', 'short_answer', 4, N'Practice number bonds and simple patterns.', 0);
    SET @cat_uiuc_data_1 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_uiuc_data_1, N'fill_blank', N'Number bond: 3 + ___ = 5', NULL, N'2', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_uiuc_data_1, N'fill_blank', N'Number bond: 4 + ___ = 10', NULL, N'6', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_uiuc_data_1, N'fill_blank', N'What comes next? 2, 4, 6, 8, ___', NULL, N'10', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_uiuc_data_1, N'fill_blank', N'What comes next? 5, 10, 15, 20, ___', NULL, N'25', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_uiuc_data_1, N'short_response', N'Explain how number bonds show two numbers that make a target number.', NULL, N'A number bond shows a pair of numbers that add up to a specific total.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_uiuc_data_1, N'multiple_choice', N'Number patterns like counting by 2s or 5s help you...', N'["Predict what number comes next", "Nothing useful", "Only work for counting to 10"]', N'Predict what number comes next', 6);

    DECLARE @cat_uiuc_data_2 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (2, 'stem_engineering', N'Computer Science, Math & Data', 'short_answer', 4, N'Build addition/subtraction fact fluency.', 0);
    SET @cat_uiuc_data_2 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_uiuc_data_2, N'fill_blank', N'7 + 6 = ___', NULL, N'13', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_uiuc_data_2, N'fill_blank', N'9 + 8 = ___', NULL, N'17', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_uiuc_data_2, N'fill_blank', N'15 - 7 = ___', NULL, N'8', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_uiuc_data_2, N'fill_blank', N'12 - 5 = ___', NULL, N'7', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_uiuc_data_2, N'fill_blank', N'6 + 6 = ___', NULL, N'12', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_uiuc_data_2, N'short_response', N'Why is knowing your addition/subtraction facts quickly (fluently) useful for harder math later?', NULL, N'It frees up your brain to focus on new, harder problems instead of basic facts.', 6);

    DECLARE @cat_uiuc_data_3 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (3, 'stem_engineering', N'Computer Science, Math & Data', 'short_answer', 4, N'Practice multiplication facts and spot number patterns.', 0);
    SET @cat_uiuc_data_3 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_uiuc_data_3, N'fill_blank', N'6 x 7 = ___', NULL, N'42', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_uiuc_data_3, N'fill_blank', N'8 x 9 = ___', NULL, N'72', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_uiuc_data_3, N'fill_blank', N'What comes next? 3, 6, 9, 12, ___', NULL, N'15', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_uiuc_data_3, N'fill_blank', N'What comes next? 5, 10, 20, 40, ___', NULL, N'80', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_uiuc_data_3, N'short_response', N'Describe the pattern rule for: 5, 10, 20, 40, 80 (hint: what happens each time?)', NULL, N'Each number doubles the one before it.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_uiuc_data_3, N'multiple_choice', N'Finding the RULE behind a number pattern helps you...', N'["Predict future numbers in the sequence without counting each one", "Nothing useful", "Only works for that one specific pattern"]', N'Predict future numbers in the sequence without counting each one', 6);

    DECLARE @cat_uiuc_data_4 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (4, 'stem_engineering', N'Computer Science, Math & Data', 'short_answer', 4, N'Practice basic algorithms and flowcharts with numbers.', 0);
    SET @cat_uiuc_data_4 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_uiuc_data_4, N'short_response', N'Write a step-by-step algorithm (in order) for finding the largest number in a list of 3 numbers.', NULL, N'Answers will vary (e.g., compare the first two, keep the bigger, compare with the third).', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_uiuc_data_4, N'multiple_choice', N'An algorithm for solving a math problem is...', N'["A clear set of steps that always leads to the answer", "A random guess", "Only useful for computers, not people"]', N'A clear set of steps that always leads to the answer', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_uiuc_data_4, N'short_response', N'Draw a simple flowchart for deciding if a number is even or odd.', NULL, N'Answers will vary — should include a decision point (divisible by 2?) leading to yes/no outcomes.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_uiuc_data_4, N'multiple_choice', N'Why might writing an algorithm help you solve similar problems FASTER in the future?', N'["You can reuse the same clear steps instead of figuring it out from scratch each time", "Algorithms only work once and can''t be reused", "Algorithms make problems harder to solve"]', N'You can reuse the same clear steps instead of figuring it out from scratch each time', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_uiuc_data_4, N'short_response', N'Test your even/odd algorithm on the number 17. Does it correctly identify it as odd?', NULL, N'Yes — 17 divided by 2 has a remainder, so it''s odd.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_uiuc_data_4, N'short_response', N'Test your even/odd algorithm on the number 24. What does it say?', NULL, N'Even — 24 divided by 2 has no remainder.', 6);

    DECLARE @cat_uiuc_data_5 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (5, 'stem_engineering', N'Computer Science, Math & Data', 'space_heavy', 4, N'Collect data and represent it in a pictograph.', 0);
    SET @cat_uiuc_data_5 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_uiuc_data_5, N'short_response', N'Collect a small set of data (e.g., ask 5 friends their favorite color). List your results.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_uiuc_data_5, N'short_response', N'Design a pictograph to show your data, with a key explaining what each picture represents.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_uiuc_data_5, N'multiple_choice', N'A pictograph uses...', N'["Small pictures or symbols to represent data amounts", "Only numbers, no pictures", "Random doodles with no meaning"]', N'Small pictures or symbols to represent data amounts', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_uiuc_data_5, N'multiple_choice', N'Why does a pictograph need a KEY (explaining what one picture equals)?', N'["Without it, no one would know how many each symbol represents", "Keys are optional and never necessary", "Pictographs don''t actually need a key"]', N'Without it, no one would know how many each symbol represents', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_uiuc_data_5, N'short_response', N'Looking at your pictograph, what''s one thing you can tell at a glance from the data?', NULL, N'Answers will vary (e.g., which category had the most/fewest).', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_uiuc_data_5, N'multiple_choice', N'Collecting and graphing real data helps you...', N'["See patterns and answer questions using evidence", "Nothing useful", "Only matters for scientists, not everyday questions"]', N'See patterns and answer questions using evidence', 6);

    DECLARE @cat_uiuc_data_6 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (6, 'stem_engineering', N'Computer Science, Math & Data', 'short_answer', 4, N'Practice fractions and decimals, and extend a pattern.', 0);
    SET @cat_uiuc_data_6 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_uiuc_data_6, N'fill_blank', N'What is 1/2 written as a decimal?', NULL, N'0.5', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_uiuc_data_6, N'fill_blank', N'What is 3/4 written as a decimal?', NULL, N'0.75', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_uiuc_data_6, N'fill_blank', N'What comes next in the pattern? 0.1, 0.2, 0.3, 0.4, ___', NULL, N'0.5', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_uiuc_data_6, N'fill_blank', N'What comes next in the pattern? 1/8, 2/8, 3/8, 4/8, ___', NULL, N'5/8', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_uiuc_data_6, N'short_response', N'Explain how a fraction and a decimal can represent the same amount.', NULL, N'Both show a part of a whole — a fraction like 1/2 equals the decimal 0.5.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_uiuc_data_6, N'multiple_choice', N'Why is it useful to be able to convert between fractions and decimals?', N'["Some situations are easier with one form than the other", "They''re never actually related", "Only fractions are ever useful"]', N'Some situations are easier with one form than the other', 6);

    DECLARE @cat_uiuc_data_7 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (7, 'stem_engineering', N'Computer Science, Math & Data', 'space_heavy', 4, N'Get an intro to algebra and complete a simple data analysis project.', 0);
    SET @cat_uiuc_data_7 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_uiuc_data_7, N'fill_blank', N'Solve for x: x + 5 = 12', NULL, N'x = 7', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_uiuc_data_7, N'fill_blank', N'Solve for x: 3x = 21', NULL, N'x = 7', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_uiuc_data_7, N'multiple_choice', N'In algebra, a variable (like x) represents...', N'["An unknown number you''re solving for", "A fixed number that never changes", "A word, not a number"]', N'An unknown number you''re solving for', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_uiuc_data_7, N'short_response', N'Collect a small data set (real or made up) and describe one pattern or trend you notice in it.', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_uiuc_data_7, N'short_response', N'Why might a data analysis project use a chart or graph instead of just listing numbers?', NULL, N'Visuals can make patterns and trends easier to spot at a glance than a plain list of numbers.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_uiuc_data_7, N'multiple_choice', N'Algebra and data analysis are connected because...', N'["Both involve finding and using patterns/relationships between numbers", "They have nothing in common", "Algebra is only about words, not numbers"]', N'Both involve finding and using patterns/relationships between numbers', 6);

    DECLARE @cat_visual_art_0 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (0, 'arts', N'Visual Art Appreciation & Drawing', 'short_answer', 4, NULL, 0);
    SET @cat_visual_art_0 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_visual_art_0, N'multiple_choice', N'Which color do you get by mixing red and yellow?', N'["Orange", "Green", "Purple"]', N'Orange', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_visual_art_0, N'multiple_choice', N'Which color do you get by mixing blue and yellow?', N'["Green", "Orange", "Red"]', N'Green', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_visual_art_0, N'short_response', N'Draw anything you''d like! What did you draw?', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_visual_art_0, N'multiple_choice', N'What color is a typical banana?', N'["Yellow", "Blue", "Purple"]', N'Yellow', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_visual_art_0, N'short_response', N'Name your favorite color and one thing that color.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_visual_art_0, N'multiple_choice', N'Which color do you get by mixing red and blue?', N'["Purple", "Green", "Orange"]', N'Purple', 6);

    DECLARE @cat_visual_art_1 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (1, 'arts', N'Visual Art Appreciation & Drawing', 'short_answer', 4, N'Create art using different shapes.', 0);
    SET @cat_visual_art_1 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_visual_art_1, N'short_response', N'Draw a picture using only circles, squares, and triangles.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_visual_art_1, N'multiple_choice', N'Which shape has 4 equal sides?', N'["Square", "Triangle", "Circle"]', N'Square', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_visual_art_1, N'short_response', N'What did you make using shapes (an animal, a house, something else)?', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_visual_art_1, N'multiple_choice', N'Artists sometimes use simple shapes to...', N'["Build up bigger, more complex pictures", "Avoid drawing anything", "Erase their work"]', N'Build up bigger, more complex pictures', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_visual_art_1, N'short_response', N'Which shape did you use the MOST in your drawing?', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_visual_art_1, N'multiple_choice', N'Combining shapes to make a picture is an example of...', N'["Visual art", "Music", "Math only"]', N'Visual art', 6);

    DECLARE @cat_visual_art_2 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (2, 'arts', N'Visual Art Appreciation & Drawing', 'space_heavy', 4, N'Look closely at a famous painting and describe what you see.', 0);
    SET @cat_visual_art_2 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_visual_art_2, N'short_response', N'Pick a famous painting (or any artwork). What is the FIRST thing you notice?', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_visual_art_2, N'short_response', N'What colors are used the most in the painting?', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_visual_art_2, N'short_response', N'What do you think is happening in the painting?', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_visual_art_2, N'multiple_choice', N'Looking closely at art before judging it is called...', N'["Observation", "Guessing", "Ignoring it"]', N'Observation', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_visual_art_2, N'short_response', N'How does the painting make you feel? Why do you think that is?', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_visual_art_2, N'multiple_choice', N'Why might two people notice different things in the same painting?', N'["People pay attention to different details based on their own interests", "Everyone always notices the exact same things", "Paintings only have one correct interpretation"]', N'People pay attention to different details based on their own interests', 6);

    DECLARE @cat_visual_art_3 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (3, 'arts', N'Visual Art Appreciation & Drawing', 'short_answer', 4, N'Learn the basics of color theory: warm vs. cool colors.', 0);
    SET @cat_visual_art_3 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_visual_art_3, N'matching', N'Sort each color as WARM or COOL.', N'{"left": ["Red", "Blue", "Orange", "Green"], "right": ["Warm", "Cool", "Warm", "Cool"]}', N'[[0, 0], [1, 1], [2, 0], [3, 1]]', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_visual_art_3, N'multiple_choice', N'Warm colors often remind people of...', N'["Sun and fire", "Ocean and ice", "Nothing in particular"]', N'Sun and fire', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_visual_art_3, N'multiple_choice', N'Cool colors often remind people of...', N'["Water and sky", "Fire and heat", "Nothing in particular"]', N'Water and sky', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_visual_art_3, N'short_response', N'Draw a small picture using ONLY warm colors.', NULL, N'Answers will vary — should use reds/oranges/yellows.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_visual_art_3, N'short_response', N'Draw a small picture using ONLY cool colors.', NULL, N'Answers will vary — should use blues/greens/purples.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_visual_art_3, N'multiple_choice', N'Artists use warm and cool colors to...', N'["Create different moods or feelings in their art", "Make art harder to see", "Follow strict rules with no creative purpose"]', N'Create different moods or feelings in their art', 6);

    DECLARE @cat_visual_art_4 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (4, 'arts', N'Visual Art Appreciation & Drawing', 'space_heavy', 4, N'Compare the styles of two different artists.', 0);
    SET @cat_visual_art_4 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_visual_art_4, N'short_response', N'Pick two artists (or artworks) to compare. Describe one difference in their styles.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_visual_art_4, N'short_response', N'Describe one similarity between the two artists'' work.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_visual_art_4, N'multiple_choice', N'An artist''s ''style'' refers to...', N'["The distinctive way they create their art", "Only the colors they use", "Something that never changes between artists"]', N'The distinctive way they create their art', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_visual_art_4, N'short_response', N'Which of the two artists'' styles do you like more, and why?', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_visual_art_4, N'multiple_choice', N'Comparing artists'' styles helps you...', N'["Notice and appreciate different artistic choices", "Decide which artist is ''better'' with no other reasoning", "Nothing useful"]', N'Notice and appreciate different artistic choices', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_visual_art_4, N'short_response', N'If you could combine elements of both artists'' styles, what would your art look like?', NULL, N'Answers will vary.', 6);

    DECLARE @cat_visual_art_5 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (5, 'arts', N'Visual Art Appreciation & Drawing', 'short_answer', 4, N'Practice the basics of perspective drawing.', 0);
    SET @cat_visual_art_5 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_visual_art_5, N'multiple_choice', N'In perspective drawing, objects that are FARTHER away should look...', N'["Smaller", "Bigger", "The same size"]', N'Smaller', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_visual_art_5, N'short_response', N'Draw a simple road that appears to go far into the distance using perspective.', NULL, N'Answers will vary — road should narrow toward a vanishing point.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_visual_art_5, N'multiple_choice', N'A ''vanishing point'' in perspective drawing is...', N'["The point where parallel lines appear to meet in the distance", "The exact center of the page", "A place you erase"]', N'The point where parallel lines appear to meet in the distance', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_visual_art_5, N'short_response', N'Why does perspective drawing make a flat picture look more 3D and realistic?', NULL, N'It mimics how our eyes actually see depth and distance in real life.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_visual_art_5, N'multiple_choice', N'Without perspective, drawings often look...', N'["Flat, with everything the same size", "More realistic", "Impossible to draw"]', N'Flat, with everything the same size', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_visual_art_5, N'short_response', N'Practice drawing 3 objects at different distances using the perspective rule (farther = smaller).', NULL, N'Answers will vary.', 6);

    DECLARE @cat_visual_art_6 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (6, 'arts', N'Visual Art Appreciation & Drawing', 'space_heavy', 4, N'Research and write a mini art-history report.', 0);
    SET @cat_visual_art_6 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_visual_art_6, N'short_response', N'Choose an artist or art movement to research. Name your topic.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_visual_art_6, N'short_response', N'List 3 facts you learned about your chosen artist or movement.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_visual_art_6, N'short_response', N'What makes your chosen artist or movement''s work distinctive?', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_visual_art_6, N'multiple_choice', N'A good art-history report should include...', N'["Real facts and context about the art", "Only your personal opinion, no facts", "Random unrelated information"]', N'Real facts and context about the art', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_visual_art_6, N'short_response', N'How did the time period or events happening then influence this artist''s work?', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_visual_art_6, N'multiple_choice', N'Understanding art history helps you...', N'["Appreciate why art looks the way it does in different eras", "Nothing useful", "Only matters for professional artists"]', N'Appreciate why art looks the way it does in different eras', 6);

    DECLARE @cat_visual_art_7 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (7, 'arts', N'Visual Art Appreciation & Drawing', 'space_heavy', 4, N'Create an original artwork and write an artist''s statement about it.', 0);
    SET @cat_visual_art_7 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_visual_art_7, N'short_response', N'Describe (or create) an original artwork. What is it, and what materials did you use?', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_visual_art_7, N'short_response', N'What inspired your artwork?', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_visual_art_7, N'short_response', N'Write an artist''s statement explaining the meaning or message behind your work.', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_visual_art_7, N'multiple_choice', N'An artist''s statement is meant to...', N'["Explain the artist''s intention and meaning behind the work", "Replace the need to actually look at the art", "List only the materials used, nothing else"]', N'Explain the artist''s intention and meaning behind the work', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_visual_art_7, N'short_response', N'What choice (color, subject, style) in your artwork are you most proud of, and why?', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_visual_art_7, N'multiple_choice', N'Why might an artist''s statement help a viewer understand the art better?', N'["It gives context and intention that might not be obvious just from looking", "Statements never add anything useful", "Viewers should never read about the art, only look at it"]', N'It gives context and intention that might not be obvious just from looking', 6);

    DECLARE @cat_music_0 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (0, 'arts', N'Music & Performing Arts', 'short_answer', 4, NULL, 0);
    SET @cat_music_0 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_music_0, N'short_response', N'Clap this rhythm pattern in order: clap, clap, pause, clap.', NULL, N'Clap, clap, pause, clap.', 1, N'sequence_steps', N'{"steps": ["Clap", "Clap", "Pause", "Clap"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_music_0, N'multiple_choice', N'A rhythm is a pattern of...', N'["Sounds and pauses", "Colors", "Smells"]', N'Sounds and pauses', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_music_0, N'short_response', N'Make up your own simple clapping pattern with 4 claps or pauses.', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_music_0, N'multiple_choice', N'Clapping along to music helps you practice...', N'["Rhythm", "Drawing", "Reading"]', N'Rhythm', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_music_0, N'short_response', N'Name a song you like to clap or dance along to.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_music_0, N'multiple_choice', N'A pattern that repeats in music, like clap-clap-pause, is an example of...', N'["Rhythm", "A color", "A shape"]', N'Rhythm', 6);

    DECLARE @cat_music_1 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (1, 'arts', N'Music & Performing Arts', 'short_answer', 4, N'Match instrument sounds to their names.', 0);
    SET @cat_music_1 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_music_1, N'matching', N'Match the instrument to how it makes sound.', N'{"left": ["Drum", "Guitar", "Flute", "Piano"], "right": ["Hit/struck", "Strummed strings", "Blown air", "Keys pressed"]}', N'[[0, 0], [1, 1], [2, 2], [3, 3]]', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_music_1, N'multiple_choice', N'Which instrument do you blow into to make sound?', N'["Flute", "Drum", "Guitar"]', N'Flute', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_music_1, N'multiple_choice', N'Which instrument has strings you pluck or strum?', N'["Guitar", "Drum", "Flute"]', N'Guitar', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_music_1, N'short_response', N'Name your favorite instrument and describe its sound.', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_music_1, N'multiple_choice', N'Which instrument do you hit or tap to make sound?', N'["Drum", "Flute", "Guitar"]', N'Drum', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_music_1, N'short_response', N'If you could learn to play one instrument, which would you choose and why?', NULL, N'Answers will vary.', 6);

    DECLARE @cat_music_2 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (2, 'arts', N'Music & Performing Arts', 'short_answer', 4, N'Try simple rhythm notation — reading beats on a page.', 0);
    SET @cat_music_2 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_music_2, N'multiple_choice', N'In simple rhythm notation, a long line often means...', N'["A longer sound or beat", "A shorter sound", "No sound at all"]', N'A longer sound or beat', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_music_2, N'short_response', N'Clap out a rhythm pattern shown as: long, short, short, long.', NULL, N'Long clap, two quick claps, long clap.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_music_2, N'multiple_choice', N'Rhythm notation helps musicians...', N'["Play the same rhythm consistently, even without hearing it first", "Never play the same thing twice", "Ignore timing completely"]', N'Play the same rhythm consistently, even without hearing it first', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_music_2, N'short_response', N'Create your own simple rhythm pattern using long and short marks.', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_music_2, N'multiple_choice', N'Why might written rhythm notation be useful for a group of musicians playing together?', N'["Everyone can follow the same timing without guessing", "Notation makes music harder to play together", "Groups never need to match their timing"]', N'Everyone can follow the same timing without guessing', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_music_2, N'short_response', N'Practice clapping your rhythm pattern from above 3 times in a row, keeping it steady.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_music_3 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (3, 'arts', N'Music & Performing Arts', 'short_answer', 4, N'Write song lyrics by filling in the blanks.', 0);
    SET @cat_music_3 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_music_3, N'short_response', N'Complete this lyric: ''The sun is shining, the sky is ___, today is a ___ day.''', NULL, N'Answers will vary (e.g., ''blue'', ''wonderful'').', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_music_3, N'multiple_choice', N'Song lyrics often...', N'["Rhyme or follow a pattern", "Have no structure at all", "Are always about the weather"]', N'Rhyme or follow a pattern', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_music_3, N'short_response', N'Write 2 lines of your own song lyrics about something you like.', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_music_3, N'multiple_choice', N'Rhyming words in lyrics can help make a song...', N'["Catchy and easier to remember", "Harder to sing", "Less musical"]', N'Catchy and easier to remember', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_music_3, N'short_response', N'What word rhymes with ''day''? Use it to finish a lyric line.', NULL, N'Answers will vary (e.g., ''play'', ''stay'').', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_music_3, N'multiple_choice', N'Writing your own lyrics is a way to practice...', N'["Creative self-expression through music", "Only math skills", "Nothing related to music"]', N'Creative self-expression through music', 6);

    DECLARE @cat_music_4 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (4, 'arts', N'Music & Performing Arts', 'space_heavy', 4, N'Compare two different musical genres.', 0);
    SET @cat_music_4 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_music_4, N'short_response', N'Pick two music genres (like pop and classical). Describe one difference between them.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_music_4, N'short_response', N'Describe one similarity between the two genres.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_music_4, N'multiple_choice', N'A ''genre'' of music refers to...', N'["A category or style of music", "A single specific song", "An instrument"]', N'A category or style of music', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_music_4, N'short_response', N'Which of the two genres do you personally prefer, and why?', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_music_4, N'multiple_choice', N'Comparing genres helps you...', N'["Notice how different musical styles create different moods", "Nothing useful", "Prove one genre is objectively the best"]', N'Notice how different musical styles create different moods', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_music_4, N'short_response', N'Name a song from each of your two genres that you know.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_music_5 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (5, 'arts', N'Music & Performing Arts', 'short_answer', 4, N'Practice reading basic music notation.', 0);
    SET @cat_music_5 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_music_5, N'multiple_choice', N'On a musical staff, notes that are higher on the staff represent...', N'["Higher-pitched sounds", "Louder sounds", "Longer sounds"]', N'Higher-pitched sounds', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_music_5, N'short_response', N'What does a ''quarter note'' generally represent in rhythm compared to a ''half note''?', NULL, N'A quarter note is typically half the length (duration) of a half note.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_music_5, N'multiple_choice', N'Reading music notation lets a musician...', N'["Play a piece correctly without having heard it first", "Ignore the actual notes", "Play any random notes they want"]', N'Play a piece correctly without having heard it first', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_music_5, N'short_response', N'Why might learning to read music notation take practice, similar to learning to read words?', NULL, N'Both involve learning a symbol system that represents sound/meaning, which takes repetition to master.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_music_5, N'multiple_choice', N'A time signature at the start of music notation tells you...', N'["How the beats are grouped in each measure", "What instrument to play", "The song''s title"]', N'How the beats are grouped in each measure', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_music_5, N'short_response', N'Try clapping a simple rhythm shown in basic notation (quarter notes = 1 clap each).', NULL, N'Answers will vary.', 6);

    DECLARE @cat_music_6 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (6, 'arts', N'Music & Performing Arts', 'space_heavy', 4, N'Write a short song or poem with rhythm.', 0);
    SET @cat_music_6 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_music_6, N'short_response', N'Write a short song or poem (at least 4 lines) with a clear rhythm or rhyme scheme.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_music_6, N'multiple_choice', N'A rhyme scheme is...', N'["The pattern of rhyming words at the end of each line", "The tempo of a song", "The instrument used"]', N'The pattern of rhyming words at the end of each line', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_music_6, N'short_response', N'Read your song/poem aloud. Does the rhythm feel consistent? Where does it feel off?', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_music_6, N'multiple_choice', N'Why might writers revise a song or poem''s wording to better fit the rhythm?', N'["Word choice affects how smoothly the piece flows when spoken or sung", "Rhythm doesn''t matter once the words are written", "Revision is never necessary for song lyrics"]', N'Word choice affects how smoothly the piece flows when spoken or sung', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_music_6, N'short_response', N'What is your song/poem about, and why did you choose that topic?', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_music_6, N'multiple_choice', N'Combining rhythm and meaning in a song/poem is a skill that involves...', N'["Both technical craft (rhythm/rhyme) and creative expression", "Only following strict rules with no creativity", "Pure randomness with no structure"]', N'Both technical craft (rhythm/rhyme) and creative expression', 6);

    DECLARE @cat_music_7 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (7, 'arts', N'Music & Performing Arts', 'space_heavy', 4, N'Reflect on and critique a musical or theatrical performance.', 0);
    SET @cat_music_7 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_music_7, N'short_response', N'Describe a performance you''ve seen or heard (live, recorded, or a class performance). What stood out to you?', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_music_7, N'short_response', N'What did the performer(s) do well?', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_music_7, N'short_response', N'What is one constructive suggestion you''d offer to help the performance improve?', NULL, N'Answers will vary — should be specific and constructive, not just negative.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_music_7, N'multiple_choice', N'A constructive critique should...', N'["Balance what worked well with specific, helpful suggestions", "Only point out flaws with no positives", "Avoid saying anything specific at all"]', N'Balance what worked well with specific, helpful suggestions', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_music_7, N'multiple_choice', N'Reflecting on a performance (your own or someone else''s) helps you...', N'["Grow and improve as a performer or audience member", "Nothing useful", "Only matters for professional critics"]', N'Grow and improve as a performer or audience member', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_music_7, N'short_response', N'If this were YOUR performance, what''s one thing you''d want honest feedback about?', NULL, N'Answers will vary.', 6);

    DECLARE @cat_creative_writing_0 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (0, 'arts', N'Creative Writing & Storytelling', 'short_answer', 4, NULL, 0);
    SET @cat_creative_writing_0 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_writing_0, N'short_response', N'Draw a picture of a story in your imagination, then tell a grown-up about it.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_writing_0, N'multiple_choice', N'A story usually has a...', N'["Beginning, middle, and end", "Only a middle", "No characters at all"]', N'Beginning, middle, and end', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_writing_0, N'short_response', N'Who is the main character in your story?', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_writing_0, N'multiple_choice', N'The main character in a story is...', N'["The person or animal the story is mostly about", "Always a real person", "Never important"]', N'The person or animal the story is mostly about', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_writing_0, N'short_response', N'What happens at the END of your story?', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_writing_0, N'multiple_choice', N'Telling a story out loud is called...', N'["Storytelling", "Singing", "Drawing"]', N'Storytelling', 6);

    DECLARE @cat_creative_writing_1 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (1, 'arts', N'Creative Writing & Storytelling', 'short_answer', 4, N'Use a picture prompt to start your own story.', 0);
    SET @cat_creative_writing_1 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_writing_1, N'short_response', N'Look at (or imagine) a picture of a magical forest. Start a story about what happens there.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_writing_1, N'multiple_choice', N'A ''story starter'' is meant to...', N'["Give you an idea to begin writing your own story", "Finish the whole story for you", "Have nothing to do with your story"]', N'Give you an idea to begin writing your own story', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_writing_1, N'short_response', N'Who would be the main character in your forest story?', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_writing_1, N'multiple_choice', N'Using a picture prompt can help writers who...', N'["Aren''t sure what to write about yet", "Already have a finished story", "Never want to write"]', N'Aren''t sure what to write about yet', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_writing_1, N'short_response', N'What problem or adventure could happen in your forest story?', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_writing_1, N'short_response', N'Finish your story with a sentence about how it ends.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_creative_writing_2 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (2, 'arts', N'Creative Writing & Storytelling', 'short_answer', 4, N'Write a complete 3-sentence story.', 0);
    SET @cat_creative_writing_2 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_writing_2, N'short_response', N'Write sentence 1 of your story: introduce a character and setting.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_writing_2, N'short_response', N'Write sentence 2 of your story: describe a problem or event.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_writing_2, N'short_response', N'Write sentence 3 of your story: describe how it ends.', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_writing_2, N'multiple_choice', N'Even a very short story should have...', N'["A beginning, middle, and end", "Only one part", "No characters"]', N'A beginning, middle, and end', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_writing_2, N'short_response', N'Read your 3-sentence story out loud. Does it make sense from start to finish?', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_writing_2, N'multiple_choice', N'Writing a short story helps you practice...', N'["Telling a complete story with limited words", "Nothing useful", "Only spelling, not storytelling"]', N'Telling a complete story with limited words', 6);

    DECLARE @cat_creative_writing_3 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (3, 'arts', N'Creative Writing & Storytelling', 'space_heavy', 4, N'Fill out a story map: character, setting, problem, solution.', 0);
    SET @cat_creative_writing_3 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_writing_3, N'short_response', N'CHARACTER: who is your story about?', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_writing_3, N'short_response', N'SETTING: where and when does your story take place?', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_writing_3, N'short_response', N'PROBLEM: what problem does your character face?', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_writing_3, N'short_response', N'SOLUTION: how does your character solve the problem?', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_writing_3, N'multiple_choice', N'A story map helps writers...', N'["Plan the key parts of a story before writing it in full", "Skip planning entirely", "Draw a literal map, not plan a story"]', N'Plan the key parts of a story before writing it in full', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_writing_3, N'multiple_choice', N'Why is the PROBLEM an important part of most stories?', N'["It creates the challenge the character must work through, driving the plot", "Stories don''t actually need a problem", "The problem should always be solved instantly"]', N'It creates the challenge the character must work through, driving the plot', 6);

    DECLARE @cat_creative_writing_4 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (4, 'arts', N'Creative Writing & Storytelling', 'space_heavy', 4, N'Write a short story that includes dialogue.', 0);
    SET @cat_creative_writing_4 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_writing_4, N'short_response', N'Write a short story (5+ sentences) that includes at least one line of dialogue (something a character says).', NULL, N'Answers will vary — should include quoted dialogue.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_writing_4, N'multiple_choice', N'Dialogue in a story is...', N'["Words that characters actually say, usually in quotation marks", "The narrator''s description of events", "Never used in stories"]', N'Words that characters actually say, usually in quotation marks', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_writing_4, N'short_response', N'Why might dialogue make a story feel more alive than only description?', NULL, N'It lets readers hear characters'' own voices and personalities directly.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_writing_4, N'multiple_choice', N'Which is an example of dialogue?', N'["''I''m scared,'' said Maya.", "Maya was scared.", "The forest was dark and quiet."]', N'''I''m scared,'' said Maya.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_writing_4, N'short_response', N'Add one more line of dialogue to your story, from a different character.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_writing_4, N'multiple_choice', N'Dialogue is usually punctuated using...', N'["Quotation marks", "Parentheses", "No punctuation at all"]', N'Quotation marks', 6);

    DECLARE @cat_creative_writing_5 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (5, 'arts', N'Creative Writing & Storytelling', 'space_heavy', 4, N'Write a creative story in a specific genre — mystery or fantasy.', 0);
    SET @cat_creative_writing_5 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_writing_5, N'short_response', N'Choose mystery OR fantasy. Write the opening paragraph of a story in that genre.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_writing_5, N'multiple_choice', N'A mystery story usually centers on...', N'["A puzzle or question the character tries to solve", "A magical creature", "No plot at all"]', N'A puzzle or question the character tries to solve', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_writing_5, N'multiple_choice', N'A fantasy story usually includes...', N'["Magic or fantastical elements not found in the real world", "Only real, everyday events", "No characters"]', N'Magic or fantastical elements not found in the real world', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_writing_5, N'short_response', N'What genre-specific element (a clue, a magic power, etc.) did you include in your story?', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_writing_5, N'multiple_choice', N'Writing within a specific genre helps a writer...', N'["Focus their story around that genre''s expectations and conventions", "Have zero rules or structure", "Avoid needing a plot"]', N'Focus their story around that genre''s expectations and conventions', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_writing_5, N'short_response', N'Continue your story with one more paragraph.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_creative_writing_6 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (6, 'arts', N'Creative Writing & Storytelling', 'space_heavy', 4, N'Write a multi-paragraph narrative.', 0);
    SET @cat_creative_writing_6 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_writing_6, N'short_response', N'Write a narrative (story) with at least 3 paragraphs: a beginning, middle, and end paragraph.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_writing_6, N'multiple_choice', N'Each paragraph in a multi-paragraph story usually...', N'["Focuses on a different part or moment of the story", "Repeats the exact same sentence", "Has no connection to the others"]', N'Focuses on a different part or moment of the story', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_writing_6, N'short_response', N'How does your middle paragraph build tension or develop the story from your beginning?', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_writing_6, N'multiple_choice', N'A strong ending paragraph should...', N'["Resolve the story''s main problem or conflict", "Introduce a brand new unrelated problem", "Be left completely unfinished"]', N'Resolve the story''s main problem or conflict', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_writing_6, N'short_response', N'Read your narrative and check: does each paragraph clearly connect to the next?', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_writing_6, N'short_response', N'What transition words or phrases did you use to move between paragraphs?', NULL, N'Answers will vary (e.g., ''Later that day,'' ''Then,'' ''Finally'').', 6);

    DECLARE @cat_creative_writing_7 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (7, 'arts', N'Creative Writing & Storytelling', 'space_heavy', 4, N'Write, then edit and revise, an original short story.', 0);
    SET @cat_creative_writing_7 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_writing_7, N'short_response', N'Write an original short story (several paragraphs) with a clear beginning, middle, and end.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_writing_7, N'short_response', N'Reread your story. What''s one part that could be clearer or more interesting?', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_writing_7, N'multiple_choice', N'Editing and revising a story means...', N'["Reviewing and improving your writing after the first draft", "Writing the exact same draft again unchanged", "Something only professional authors do"]', N'Reviewing and improving your writing after the first draft', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_writing_7, N'short_response', N'Revise the part you identified above — rewrite it to be clearer or more engaging.', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_writing_7, N'multiple_choice', N'Why is revising almost always necessary, even for skilled writers?', N'["First drafts rarely capture the best version of an idea right away", "First drafts are always perfect and need no changes", "Revising makes writing worse"]', N'First drafts rarely capture the best version of an idea right away', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_writing_7, N'short_response', N'What is the biggest improvement between your first draft and your revised version?', NULL, N'Answers will vary.', 6);

END
GO

DELETE FROM dbo.WeeklyPacketPlan;
GO