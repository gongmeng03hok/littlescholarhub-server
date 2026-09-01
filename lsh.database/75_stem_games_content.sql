-- 75_stem_games_content.sql
-- Adds a 'STEM Challenge Games' category to the existing always-on
-- 'stem_engineering' subject_area for every grade (TK-6th) -- no schema
-- or proc changes needed, reuses dbo.PacketSubjectAreas/
-- usp_GetOrCreateWeeklyPacket exactly as-is.
--
-- Each grade gets a pool of 14 games; target_count=7 (fixed, not the usual
-- ~65% auto-rebalance ratio) means the existing NEWID()-sampling rotation
-- serves a different 7-of-14 combination most weeks a grade's
-- stem_engineering category is selected, satisfying "7 STEM challenge
-- games, different set each week" without any manual per-week authoring.
--
-- Each game is ONE PacketQuestions row: prompt carries the Name/Objective/
-- Materials, diagram_type='sequence_steps' carries the Step-by-Step
-- Instructions (already-shipped diagram type, renders as a numbered list in
-- both the app and print -- see 63_whole_child_rotation.sql and
-- 68_outdoor_games_content.sql), and answer_text carries the closing
-- engineering-mindset tip.
-- See gen_75_stem_games_content.py.

IF NOT EXISTS (SELECT 1 FROM dbo.PacketCategories WHERE subject_area = 'stem_engineering' AND category_name = N'STEM Challenge Games')
BEGIN
    DECLARE @cat_stem_0 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (0, 'stem_engineering', N'STEM Challenge Games', 'space_heavy', 7, N'Build, test, and experiment with a hands-on STEM challenge!', 0);
    SET @cat_stem_0 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_0, N'short_response', N'🏗️ Tallest Cup Tower

Objective: Practice stacking cups carefully to build the tallest tower you can.

Materials: 10 plastic or paper cups

Follow the steps below to try the challenge!', NULL, N'Every engineer tests, and towers fall sometimes -- that''s how we learn to build better!', 1, N'sequence_steps', N'{"steps": ["Stack the cups one on top of another, biggest ones at the bottom.", "Go slow and steady so the tower doesn''t wobble.", "Count how many cups tall your tower is!", "If it falls, that''s okay -- stack it again."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_0, N'short_response', N'🌉 Block Bridge for Teddy

Objective: Build a simple bridge with blocks that a toy can cross over a ''river.''

Materials: Building blocks | A small toy (like a stuffed animal) | A towel or string to mark a ''river''

Follow the steps below to try the challenge!', NULL, N'Bridges connect two sides so nobody has to get wet -- great job, builder!', 2, N'sequence_steps', N'{"steps": ["Lay a towel on the floor to be your pretend river.", "Stack blocks on each side, then lay a flat block across the top to connect them.", "Walk your toy carefully across the bridge.", "Try making the river wider and see if your bridge still reaches!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_0, N'short_response', N'⛵ Foil Boat Float Test

Objective: Guess whether a foil boat will float, then test it in water.

Materials: A small piece of aluminum foil | A bowl or tub of water

Follow the steps below to try the challenge!', NULL, N'Guessing first and then testing is exactly what scientists do!', 3, N'sequence_steps', N'{"steps": ["Shape the foil into a little boat with an adult''s help.", "Guess out loud: will it float or sink?", "Gently place the boat on the water.", "Cheer if it floats -- try reshaping it if it sinks!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_0, N'short_response', N'✈️ First Flight Paper Airplane

Objective: Fly a simple paper airplane and measure how far it goes using big steps.

Materials: 1 sheet of paper

Follow the steps below to try the challenge!', NULL, N'Every throw is a chance to try again -- that''s what makes flying fun!', 4, N'sequence_steps', N'{"steps": ["An adult helps fold a simple paper airplane.", "Stand behind a starting line and throw it gently.", "Count how many big steps away it landed.", "Try again and see if you can go even farther!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_0, N'short_response', N'🤖 Robot Friend Directions

Objective: Practice giving and following simple step-by-step directions, just like programming a robot.

Materials: Open floor space

Follow the steps below to try the challenge!', NULL, N'Robots (and computers) only do exactly what they''re told -- that''s why clear directions matter!', 5, N'sequence_steps', N'{"steps": ["One person is the ''programmer,'' the other is the ''robot.''", "The programmer gives one simple direction at a time, like ''walk forward 3 steps.''", "The ''robot'' follows the direction exactly, like a real robot would.", "Take turns being the programmer and the robot!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_0, N'short_response', N'🗺️ Follow the Arrow Path

Objective: Follow a simple path of arrow cards laid on the floor from start to finish.

Materials: 5-6 large arrow cards or drawings (forward, left, right)

Follow the steps below to try the challenge!', NULL, N'Following the arrows in order got you all the way to the end -- nice work!', 6, N'sequence_steps', N'{"steps": ["An adult lays arrow cards in a simple line on the floor.", "Walk along the path, following each arrow''s direction.", "Cheer when you reach the end!", "Rearrange the arrows and try a new path."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_0, N'short_response', N'🔤 Sort the Shapes Game

Objective: Sort a mixed pile of shapes into matching groups.

Materials: A mixed pile of shape blocks or buttons (circles, squares, triangles)

Follow the steps below to try the challenge!', NULL, N'Grouping things that are alike helps us find and count them faster.', 7, N'sequence_steps', N'{"steps": ["Dump all the shapes into one big pile.", "Make a group for each shape type.", "Move each shape to its matching group.", "Count how many are in each group when you''re done!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_0, N'short_response', N'🔵 Copy My Pattern

Objective: Copy a simple repeating pattern using blocks or beads.

Materials: 10-12 blocks or beads in 2 colors

Follow the steps below to try the challenge!', NULL, N'Patterns repeat in a predictable way -- spotting that repeat is the first step to reading any code.', 8, N'sequence_steps', N'{"steps": ["An adult makes a simple pattern, like red-blue-red-blue.", "Look closely at the pattern.", "Copy the exact same pattern using your own blocks.", "Try making your own pattern for someone else to copy!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_0, N'short_response', N'📊 Favorite Color Vote

Objective: Take a simple vote and count the results together.

Materials: Paper | Crayons or markers

Follow the steps below to try the challenge!', NULL, N'Counting up everyone''s answers is the very first step of data collection.', 9, N'sequence_steps', N'{"steps": ["Ask 5 family members or friends their favorite color.", "Make a tally mark on paper for each answer.", "Count the tally marks for each color together.", "Say out loud which color got the most votes!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_0, N'short_response', N'🪨 Sink or Float Guess

Objective: Guess whether household objects will sink or float, then test them in water.

Materials: A bowl or tub of water | 5-6 small household objects (spoon, cork, rock, leaf, coin)

Follow the steps below to try the challenge!', NULL, N'Guessing before testing is exactly how scientists start every experiment.', 10, N'sequence_steps', N'{"steps": ["Look at each object and guess: sink or float?", "Gently place one object in the water and watch.", "Cheer for a correct guess!", "Try the next object and guess again."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_0, N'short_response', N'🎈 Balloon Rocket Zoom

Objective: Watch a balloon rocket zoom along a string and enjoy the surprise of air power.

Materials: 1 balloon | A long piece of string | A straw | Tape

Follow the steps below to try the challenge!', NULL, N'Air rushing out is what pushed your rocket forward -- that''s the same idea behind real rockets!', 11, N'sequence_steps', N'{"steps": ["An adult sets up a string across a room, threaded through a straw, pulled tight.", "An adult tapes an inflated (but not tied) balloon to the straw.", "Let go of the balloon and watch it zoom along the string!", "Try it again -- did it go the same way?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_0, N'short_response', N'🧸 Soft Landing for Teddy

Objective: Explore how a soft cushion protects a toy dropped from a low height.

Materials: A small stuffed toy | A pillow or folded blanket

Follow the steps below to try the challenge!', NULL, N'A soft cushion spreads out the bump, which is why pillows make landings feel gentler.', 12, N'sequence_steps', N'{"steps": ["Hold the toy up at a low height (like standing height) over the pillow.", "Drop the toy gently onto the pillow and watch what happens.", "Try dropping it onto the hard floor instead (with a grown-up''s okay) and compare.", "Talk about why the pillow felt like a softer landing!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_0, N'short_response', N'🚀 Pom-Pom Push Launch

Objective: Push a pom-pom along a simple ramp and watch it launch off the end.

Materials: A pom-pom or cotton ball | A book propped up as a ramp

Follow the steps below to try the challenge!', NULL, N'Ramps use gravity to help push things forward -- no batteries needed!', 13, N'sequence_steps', N'{"steps": ["Prop up a book to make a ramp.", "Place the pom-pom at the top.", "Gently let it go and watch it roll and launch off the bottom.", "Try it again from a taller ramp!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_0, N'short_response', N'📚 Paper Plate Strong Shelf

Objective: Test which of two paper shapes holds a toy without collapsing.

Materials: 2 paper plates or sheets of paper | A small lightweight toy

Follow the steps below to try the challenge!', NULL, N'A folded shape held up better than a flat one -- folding makes paper stronger!', 14, N'sequence_steps', N'{"steps": ["Lay one paper flat between two books like a little shelf.", "Place the toy on top and see what happens.", "Fold the second paper into an accordion (zigzag) shape and try again as a shelf.", "Compare -- which shape held the toy better?"]}');

    DECLARE @cat_stem_1 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (1, 'stem_engineering', N'STEM Challenge Games', 'space_heavy', 7, N'Build, test, and experiment with a hands-on STEM challenge!', 0);
    SET @cat_stem_1 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_1, N'short_response', N'🏗️ Cup Tower Champion

Objective: Build the tallest possible tower using cups and compare designs with a partner.

Materials: 10-12 plastic cups

Follow the steps below to try the challenge!', NULL, N'Trying it a second way is exactly what real engineers do -- retesting makes designs better.', 1, N'sequence_steps', N'{"steps": ["Build your tallest tower using all the cups.", "Measure it with your hands (how many hand-lengths tall?).", "Knock it down gently and try again with a different stacking order.", "See if your second tower is taller than your first!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_1, N'short_response', N'🌉 Paper Bridge Crossing

Objective: Build a paper bridge that spans a gap and can hold a small toy.

Materials: 1 sheet of paper | 2 stacks of books (to make a gap) | A small toy car or block

Follow the steps below to try the challenge!', NULL, N'A flat sheet bends easily, but a folded sheet is much stronger -- folding is an engineering trick!', 2, N'sequence_steps', N'{"steps": ["Set up two book stacks with a gap between them.", "Lay the paper flat across the gap like a bridge.", "Carefully roll the small toy across the bridge.", "If the paper sags too much, try folding it before laying it across."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_1, N'short_response', N'⛵ Cup Boat Cargo Test

Objective: Test how many small toys a floating cup boat can carry before sinking.

Materials: 1 small plastic cup | A bowl or tub of water | Small toys or coins as cargo

Follow the steps below to try the challenge!', NULL, N'Even a simple cup can carry cargo -- that''s how real boats work too!', 3, N'sequence_steps', N'{"steps": ["Float the cup gently on the water like a boat.", "Add one small toy as cargo.", "Keep adding toys one at a time, counting as you go.", "Stop and cheer when you find the number that makes it sink!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_1, N'short_response', N'✈️ Paper Airplane Distance Hop

Objective: Throw a paper airplane and compare distances across a few tries.

Materials: 1-2 sheets of paper | A starting line marker

Follow the steps below to try the challenge!', NULL, N'Not every throw goes the same distance -- that''s normal, even for real pilots!', 4, N'sequence_steps', N'{"steps": ["Fold a simple paper airplane.", "Throw it from the starting line and mark where it lands.", "Throw it two more times, marking each spot.", "See which of your three throws went the farthest!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_1, N'short_response', N'🤖 Program-a-Friend Walk

Objective: Give a short sequence of two or three directions for a partner-robot to follow in order.

Materials: Open floor space | A small toy as a ''goal'' to reach

Follow the steps below to try the challenge!', NULL, N'Giving directions in the right order matters -- computers follow steps exactly in order, too.', 5, N'sequence_steps', N'{"steps": ["Place a toy a few steps away as the goal.", "Give your robot-friend 2-3 directions in a row, like ''forward 2 steps, turn left, forward 1 step.''", "The robot-friend follows the directions exactly, one at a time, to try to reach the toy.", "Take turns programming each other!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_1, N'short_response', N'🗺️ Arrow Card Maze

Objective: Follow a short sequence of arrow cards through a simple maze shape to reach a goal.

Materials: 6-8 arrow cards | A small toy as the goal

Follow the steps below to try the challenge!', NULL, N'A maze with a turn is trickier than a straight line -- you handled it like a pro!', 6, N'sequence_steps', N'{"steps": ["Lay out arrow cards in a path with one turn to reach the goal toy.", "Walk the path one arrow at a time, in order.", "If you reach the goal, celebrate!", "Rearrange the arrows to make a new, trickier path."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_1, N'short_response', N'🔢 Sort by Size Game

Objective: Sort a collection of objects from smallest to largest.

Materials: 8-10 small household objects of different sizes (blocks, spoons, toys)

Follow the steps below to try the challenge!', NULL, N'Putting things in order by size is a math skill computers and scientists use too -- you just did it!', 7, N'sequence_steps', N'{"steps": ["Gather your objects in one pile.", "Pick the smallest one and set it down first.", "Keep picking the next-smallest object and lining it up in order.", "Check your line from smallest to largest when you''re done!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_1, N'short_response', N'🔵 Pattern Detective Game

Objective: Figure out what comes next in a simple repeating pattern.

Materials: 12-15 blocks, beads, or shapes in 2-3 colors

Follow the steps below to try the challenge!', NULL, N'Being a pattern detective means looking for what repeats -- that''s a skill mathematicians use every day.', 8, N'sequence_steps', N'{"steps": ["An adult lays out a pattern but stops partway, like red-blue-red-blue-red-___.", "Study the pattern to figure out what should come next.", "Place the correct next piece.", "Try laying out your own pattern and leaving a blank for someone else to solve!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_1, N'short_response', N'📊 Class Snack Survey

Objective: Survey a few people about a favorite snack and count the results.

Materials: Paper | Pencil or crayon

Follow the steps below to try the challenge!', NULL, N'Asking the same question to everyone is what makes a survey fair.', 9, N'sequence_steps', N'{"steps": ["Pick 2-3 snack choices to ask about (like apple, cracker, cheese).", "Ask at least 5 people which one they like best.", "Make a tally mark for each answer under the right snack.", "Count up the tallies and see which snack won!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_1, N'short_response', N'🪨 Sink or Float Sorting Game

Objective: Sort a group of objects into ''sink'' and ''float'' groups after testing each in water.

Materials: A bowl or tub of water | 8 small household objects | 2 paper labels: ''Sink'' and ''Float''

Follow the steps below to try the challenge!', NULL, N'Sorting your results after testing helps you spot patterns you might otherwise miss.', 10, N'sequence_steps', N'{"steps": ["Lay out your ''Sink'' and ''Float'' labels on the table.", "Test each object one at a time in the water.", "Place the object under the correct label based on what happened.", "Look at your two groups when you''re done -- what do the float objects have in common?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_1, N'short_response', N'🎈 Balloon Rocket Race

Objective: Race two balloon rockets along strings and see which one travels the fastest.

Materials: 2 balloons | 2 long pieces of string | 2 straws | Tape

Follow the steps below to try the challenge!', NULL, N'Racing two rockets at once is a fun way to compare -- did the winner surprise you?', 11, N'sequence_steps', N'{"steps": ["Set up two balloon rocket strings side-by-side.", "Blow up both balloons the same amount and tape them to their straws.", "Let go of both balloons at the same time.", "Watch which rocket wins the race!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_1, N'short_response', N'🧸 Cushion Catch Challenge

Objective: Build a simple soft catcher to protect a small ball dropped from a chair.

Materials: A small ball | A pillow, blanket, or folded towel | A chair (adult supervises the drop)

Follow the steps below to try the challenge!', NULL, N'More cushioning usually means a gentler landing -- you''re already thinking like an engineer!', 12, N'sequence_steps', N'{"steps": ["Set up your soft catcher (pillow or blanket) on the floor.", "With an adult, drop the ball from the chair height onto the catcher.", "Watch and check -- did the ball bounce or land gently?", "Try adding more padding and see if the landing gets even softer."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_1, N'short_response', N'🚀 Ramp Roll Race

Objective: Roll a ball down a ramp and see how far it travels after leaving the ramp.

Materials: A small ball | A book or board propped up as a ramp | A measuring tape or string with marks

Follow the steps below to try the challenge!', NULL, N'A taller ramp usually sends the ball rolling farther -- you''re testing gravity''s power!', 13, N'sequence_steps', N'{"steps": ["Set up your ramp using a propped-up book.", "Let the ball roll down and off the end.", "Measure where it stopped.", "Try again from a taller ramp and compare distances!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_1, N'short_response', N'📚 Strongest Shape Test

Objective: Test flat, rolled, and folded paper shapes to see which holds a small object best.

Materials: 3 sheets of paper | A small toy or block | 2 books to rest the paper between

Follow the steps below to try the challenge!', NULL, N'Shape changes strength even when the amount of paper stays exactly the same -- a great engineering discovery!', 14, N'sequence_steps', N'{"steps": ["Test a flat sheet of paper as a bridge between two books, placing the toy on top.", "Roll a second sheet into a tube shape and test it the same way.", "Fold a third sheet into a zigzag shape and test it the same way.", "Compare all three -- which held the toy the best without collapsing?"]}');

    DECLARE @cat_stem_2 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (2, 'stem_engineering', N'STEM Challenge Games', 'space_heavy', 7, N'Build, test, and experiment with a hands-on STEM challenge!', 0);
    SET @cat_stem_2 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_2, N'short_response', N'🏗️ Tallest Paper Tower

Objective: Build a free-standing tower out of rolled paper tubes and tape.

Materials: 5 sheets of paper | Tape

Follow the steps below to try the challenge!', NULL, N'Tall towers need a wide, steady base -- just like a real building!', 1, N'sequence_steps', N'{"steps": ["Roll each sheet of paper into a tight tube and tape it closed.", "Stand the tubes up and tape them together to build upward.", "Measure your tower''s height with a ruler or string.", "Try rearranging the tubes to build it even taller."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_2, N'short_response', N'🌉 Popsicle Stick Bridge

Objective: Build a bridge from craft sticks that spans a gap and holds a small object.

Materials: 10-15 craft sticks (or cut paper strips) | Tape | 2 stacks of books | A coin

Follow the steps below to try the challenge!', NULL, N'A bridge that holds even one coin is already doing real engineering work!', 2, N'sequence_steps', N'{"steps": ["Set up two book stacks with a gap between them.", "Lay and tape craft sticks together to span the gap.", "Place a coin in the middle of your bridge.", "If it holds, try adding a second coin!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_2, N'short_response', N'⛵ Coin-Carrying Boat

Objective: Build a simple foil boat and test how many coins it can carry before sinking.

Materials: A piece of aluminum foil (about the size of a sheet of paper) | A bowl or tub of water | A pile of coins

Follow the steps below to try the challenge!', NULL, N'Boats with taller sides usually hold more cargo before water gets in.', 3, N'sequence_steps', N'{"steps": ["Shape the foil into a boat with sides high enough to hold cargo.", "Float the boat on the water.", "Add coins to the boat one at a time, counting as you go.", "Record how many coins it held before sinking!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_2, N'short_response', N'✈️ Paper Airplane Distance Test

Objective: Fold and test a paper airplane, then try folding it a new way to compare distances.

Materials: 2 sheets of paper | Measuring tape or a long string with marks

Follow the steps below to try the challenge!', NULL, N'Small changes in folding can make a big difference in how far a plane flies.', 4, N'sequence_steps', N'{"steps": ["Fold your first paper airplane and throw it from a starting line.", "Measure how far it flew.", "Fold a second airplane a different way and throw it.", "Measure and compare -- which design flew farther?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_2, N'short_response', N'🤖 Step-by-Step Robot Program

Objective: Write out a full sequence of movement directions on paper before your robot-friend runs it.

Materials: Paper and pencil | Open floor space | A toy or marker as the goal

Follow the steps below to try the challenge!', NULL, N'Writing the program down first (instead of calling out directions) is exactly how real programmers work.', 5, N'sequence_steps', N'{"steps": ["Write down a numbered list of directions (forward, turn, stop) to get your robot-friend to a goal.", "Hand your written ''program'' to your robot-friend.", "The robot-friend follows your written steps exactly, one at a time.", "If they don''t reach the goal, look at your program and fix it!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_2, N'short_response', N'🗺️ Coding Maze Challenge

Objective: Write a sequence of movement instructions to solve a simple chalk or tape maze.

Materials: Sidewalk chalk or tape | Paper and pencil

Follow the steps below to try the challenge!', NULL, N'Writing your plan before moving helps you catch mistakes before they happen.', 6, N'sequence_steps', N'{"steps": ["Draw or tape down a simple maze on the floor or driveway with one path to the goal.", "Write down the sequence of moves (forward, left, right) needed to solve it.", "Walk the maze exactly following your written instructions.", "If you get stuck, fix your instructions and try again."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_2, N'short_response', N'🔠 Sort Two Ways Challenge

Objective: Sort the same set of objects using two different rules to show that sorting rules can change the groups.

Materials: 10-12 small household objects (mixed colors and sizes)

Follow the steps below to try the challenge!', NULL, N'The same pile of things can be sorted many different ways -- the rule you choose changes the picture.', 7, N'sequence_steps', N'{"steps": ["Sort your objects into groups by color.", "Count and record how many are in each color group.", "Now re-sort the same objects into groups by size instead.", "Compare -- did the groups look different with a new sorting rule?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_2, N'short_response', N'🔵 Extend the Pattern Challenge

Objective: Extend a given pattern several steps further and explain the rule you used.

Materials: 15-20 small objects in 2-3 colors or shapes

Follow the steps below to try the challenge!', NULL, N'Saying the rule out loud proves you really understand the pattern, not just guessing.', 8, N'sequence_steps', N'{"steps": ["Look at a pattern someone else laid out (at least 4-6 pieces long).", "Figure out the repeating rule.", "Extend the pattern 4 more pieces using your own objects.", "Say the rule out loud, like ''red, blue, blue, repeat.''"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_2, N'short_response', N'📊 Tally and Count Challenge

Objective: Collect tally data on a chosen question and turn it into simple counts.

Materials: Paper | Pencil

Follow the steps below to try the challenge!', NULL, N'Turning tally marks into a total count is your first step toward becoming a data scientist!', 9, N'sequence_steps', N'{"steps": ["Choose a simple yes/no or pick-one question to ask around the house.", "Ask at least 6 people and make a tally mark for each answer.", "Add up the tallies for each answer choice.", "Write a sentence about which answer was most common."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_2, N'short_response', N'🪨 Predict and Test: Sink or Float

Objective: Write a prediction for each object before testing, then check how many predictions were correct.

Materials: A bowl or tub of water | 8-10 small household objects | Paper and pencil

Follow the steps below to try the challenge!', NULL, N'Even scientists get some predictions wrong -- that''s exactly how we learn what''s really true.', 10, N'sequence_steps', N'{"steps": ["List your objects on paper with a ''predict'' column next to each.", "Write sink or float for every object before testing any of them.", "Test each object and write down what actually happened.", "Count how many of your predictions were correct!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_2, N'short_response', N'🎈 Balloon Rocket Distance Test

Objective: Measure how far a balloon rocket travels and try to beat your own distance.

Materials: 1-2 balloons | A long string | A straw | Tape | Measuring tape or string with marks

Follow the steps below to try the challenge!', NULL, N'Measuring your results (not just watching) is how you know if you''re really improving.', 11, N'sequence_steps', N'{"steps": ["Set up your balloon rocket string.", "Blow up the balloon, tape it to the straw, and let go.", "Measure how far along the string it traveled.", "Blow it up again and try to beat your distance!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_2, N'short_response', N'🧸 Cotton Ball Cushion Challenge

Objective: Build a cushion from cotton balls and paper to protect a small toy dropped from table height.

Materials: A small toy figure | 10-15 cotton balls | Paper or a small box | Tape

Follow the steps below to try the challenge!', NULL, N'Padding on all sides -- not just the bottom -- protects best against a fall.', 12, N'sequence_steps', N'{"steps": ["Build a small nest or box padded with cotton balls.", "Place the toy inside the padded nest.", "With an adult, drop it from table height and check if the toy is okay.", "If it wasn''t protected enough, add more cotton and try again."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_2, N'short_response', N'🚀 Spoon Catapult Toss

Objective: Build a simple spoon catapult and measure how far it launches a pom-pom.

Materials: A plastic spoon | A pencil or small dowel to use as a pivot | A pom-pom or small soft ball | Measuring tape

Follow the steps below to try the challenge!', NULL, N'A catapult stores up energy when you press down, then releases it all at once -- that''s what makes the launch.', 13, N'sequence_steps', N'{"steps": ["Rest the spoon over the pencil to make a simple see-saw catapult.", "Place the pom-pom in the spoon''s bowl.", "Press down on the spoon handle and let go to launch it.", "Measure how far it flew, then try again!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_2, N'short_response', N'📚 Paper Column Strength Test

Objective: Build paper columns of different shapes and test how much weight each can hold before buckling.

Materials: 3 sheets of paper | Tape | A small book or a stack of coins for weight testing

Follow the steps below to try the challenge!', NULL, N'Different shapes hold weight differently, even using the exact same amount of paper.', 14, N'sequence_steps', N'{"steps": ["Roll one sheet into a round tube column and tape it closed.", "Fold another sheet into a triangle-shaped column and tape it closed.", "Fold a third sheet into a square-shaped column and tape it closed.", "Stand each column up and gently add weight on top, one at a time, until each buckles -- compare which held the most."]}');

    DECLARE @cat_stem_3 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (3, 'stem_engineering', N'STEM Challenge Games', 'space_heavy', 7, N'Build, test, and experiment with a hands-on STEM challenge!', 0);
    SET @cat_stem_3 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_3, N'short_response', N'🏗️ Index Card Tower Challenge

Objective: Design a tower using only index cards and tape that stands on its own.

Materials: 15 index cards (or cut cardstock) | Tape

Follow the steps below to try the challenge!', NULL, N'Folded shapes are much stronger than flat cards -- shape changes strength!', 1, N'sequence_steps', N'{"steps": ["Fold or roll cards into shapes (tubes, triangles, fans) to use as building pieces.", "Stack and tape your shapes into a tower that can stand by itself.", "Measure the final height.", "Take it apart and try a new shape combination to beat your height."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_3, N'short_response', N'🌉 Coin-Crossing Bridge Challenge

Objective: Design a paper bridge that can hold as many coins as possible without collapsing.

Materials: 2 sheets of paper | Tape | 2 stacks of books | A pile of coins

Follow the steps below to try the challenge!', NULL, N'Folded paper (like a zigzag) holds far more weight than flat paper -- try it and see!', 2, N'sequence_steps', N'{"steps": ["Set up a gap between two book stacks.", "Fold or shape your paper into a bridge and tape it in place across the gap.", "Add coins to the middle of the bridge one at a time, counting as you go.", "Record how many coins your bridge held before it sagged to the table."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_3, N'short_response', N'⛵ Foil Boat Cargo Challenge

Objective: Design a foil boat to hold the maximum number of pennies before sinking.

Materials: A piece of aluminum foil | A bowl or tub of water | A pile of pennies or coins

Follow the steps below to try the challenge!', NULL, N'A wider, flatter boat usually floats more cargo than a narrow one -- shape really matters.', 3, N'sequence_steps', N'{"steps": ["Shape your foil into a boat, thinking about how wide and deep to make it.", "Float it and add pennies one at a time, counting as you go.", "Record the total number of pennies it held.", "Reshape your boat and try to beat your first score!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_3, N'short_response', N'✈️ Two Airplane Design Face-off

Objective: Design and test two different paper airplanes to determine which flies farther.

Materials: 2 sheets of paper | Measuring tape or string | Paper and pencil to record results

Follow the steps below to try the challenge!', NULL, N'Testing each design more than once helps you trust your results -- one lucky throw isn''t proof!', 4, N'sequence_steps', N'{"steps": ["Fold two different airplane designs -- try to make them look different from each other.", "Throw each one three times, recording the distance each time.", "Find the average (or best) distance for each design.", "Decide which design wins, and think about why."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_3, N'short_response', N'🤖 Robot Obstacle Program

Objective: Write a sequence of commands that guides a robot-friend safely around an obstacle to a goal.

Materials: Paper and pencil | A few soft objects as obstacles | A toy or marker as the goal

Follow the steps below to try the challenge!', NULL, N'Planning around obstacles before you run the program saves a lot of do-overs -- that''s smart programming.', 5, N'sequence_steps', N'{"steps": ["Set up 1-2 soft obstacles between the start and a goal.", "Write a numbered program of directions that avoids the obstacles.", "Your robot-friend follows your program exactly, without helping figure out the path themselves.", "If they bump an obstacle, revise your program and try again!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_3, N'short_response', N'🗺️ Grid Maze Program

Objective: Write step-by-step instructions to move a token through a paper grid maze to the goal.

Materials: Paper with a drawn grid maze | A small token or coin | Pencil

Follow the steps below to try the challenge!', NULL, N'Every wrong turn just means one more clue for how to fix your next program.', 6, N'sequence_steps', N'{"steps": ["Draw a simple grid maze on paper with a start and goal square.", "Write out the moves (up, down, left, right, how many squares) to get the token from start to goal.", "Move the token exactly following your written steps.", "If it lands in the wrong square, revise your instructions and try again."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_3, N'short_response', N'🗂️ Mystery Sorting Rule

Objective: Sort objects by a secret rule and have a partner guess the rule by observing the groups.

Materials: 10-15 small household objects | A card to write your secret rule on

Follow the steps below to try the challenge!', NULL, N'Figuring out a hidden pattern from grouped examples is exactly what data scientists do.', 7, N'sequence_steps', N'{"steps": ["Pick a secret sorting rule (like ''things that are round'' or ''things smaller than a spoon'') and write it down without showing anyone.", "Sort the objects into ''yes'' and ''no'' groups following your rule.", "Have a partner look at the groups and guess your rule.", "Reveal your rule and check if they guessed correctly -- then switch roles!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_3, N'short_response', N'🔵 Growing Pattern Challenge

Objective: Build and extend a growing pattern (like AAB, ABB) instead of a simple repeating one.

Materials: 20+ small objects in 2 colors

Follow the steps below to try the challenge!', NULL, N'Growing patterns show up in real math sequences -- you''re getting an early look at algebra thinking.', 8, N'sequence_steps', N'{"steps": ["Build a growing pattern, like 1 red - 2 blue - 1 red - 2 blue.", "Notice how it''s different from a simple repeating pattern -- the groups have counts that matter.", "Extend the pattern 3 more groups.", "Try inventing your own growing pattern (like 1-2-3 counting groups) for a partner to extend!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_3, N'short_response', N'📊 Bar Graph Builder Challenge

Objective: Survey family members and turn the results into a simple hand-drawn bar graph.

Materials: Paper | Pencil | Ruler (optional)

Follow the steps below to try the challenge!', NULL, N'A bar graph turns numbers into a picture you can understand at a glance.', 9, N'sequence_steps', N'{"steps": ["Ask at least 6 family members or friends a question with 3 answer choices.", "Tally the results for each choice.", "Draw a bar graph: one bar per answer choice, with height showing how many people chose it.", "Label your bars and say which one is tallest."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_3, N'short_response', N'🪨 Sink or Float Data Chart

Objective: Build a data chart of sink/float results and identify a pattern in materials.

Materials: A bowl or tub of water | 10 small household objects (mix of plastic, wood, metal, rubber) | Paper and pencil

Follow the steps below to try the challenge!', NULL, N'Once you spot a material pattern, you can predict new objects without even testing them!', 10, N'sequence_steps', N'{"steps": ["Make a 3-column chart: Object, Material, Result.", "Test every object and fill in the result column.", "Look down the material column -- do certain materials always sink, and others always float?", "Write one sentence describing the pattern you found."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_3, N'short_response', N'🎈 Balloon Rocket Design Challenge

Objective: Test how balloon size affects rocket travel distance.

Materials: 3 balloons (different sizes to blow up) | A long string | A straw | Tape | Measuring tape

Follow the steps below to try the challenge!', NULL, N'More isn''t always better in engineering -- sometimes there''s a ''just right'' amount, and testing is how you find it.', 11, N'sequence_steps', N'{"steps": ["Blow up your first balloon just a little and test its distance.", "Blow up a second balloon medium-full and test its distance.", "Blow up a third balloon as full as you safely can and test its distance.", "Compare all three distances -- did more air always mean farther travel?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_3, N'short_response', N'🧸 Package Protector Challenge

Objective: Build a padded box to protect a small toy from a short supervised drop.

Materials: A small toy figure | A small box | Padding materials (cotton balls, paper scraps, bubble wrap) | Tape

Follow the steps below to try the challenge!', NULL, N'Padding on every side of the object, not just underneath, is the key to real package protection.', 12, N'sequence_steps', N'{"steps": ["Pack your box with padding material, placing the toy in the center surrounded on all sides.", "Seal the box with tape.", "With an adult, drop the box from a set height (like a chair).", "Open it up and check if the toy survived -- if not, redesign your padding and try again."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_3, N'short_response', N'🚀 Catapult Distance Challenge

Objective: Test and compare catapult launch distances across several tries.

Materials: A plastic spoon | A pencil (pivot) | A pom-pom or small ball | Measuring tape | Paper and pencil

Follow the steps below to try the challenge!', NULL, N'Comparing multiple launches shows you which technique actually gets the best results.', 13, N'sequence_steps', N'{"steps": ["Set up your spoon catapult.", "Launch the pom-pom 3 times, measuring and recording each distance.", "Find your best (longest) distance.", "Try changing how hard you press before launching -- does more force always mean farther?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_3, N'short_response', N'📚 How Many Books? Challenge

Objective: Test how many light books a rolled paper column can hold before collapsing.

Materials: 2-3 sheets of paper | Tape | Several lightweight books

Follow the steps below to try the challenge!', NULL, N'A wider tube usually holds more weight than a narrow one -- try it and see if that''s true for you.', 14, N'sequence_steps', N'{"steps": ["Roll a sheet of paper into a sturdy tube and tape it closed.", "Stand the tube upright and carefully add one book flat on top.", "Keep adding books one at a time, counting as you go.", "Record how many books it held before collapsing, then try a wider or taller tube to compare!"]}');

    DECLARE @cat_stem_4 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (4, 'stem_engineering', N'STEM Challenge Games', 'space_heavy', 7, N'Build, test, and experiment with a hands-on STEM challenge!', 0);
    SET @cat_stem_4 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_4, N'short_response', N'🏗️ Tape-Limited Tower Challenge

Objective: Build the tallest self-standing tower while working within a strict tape limit.

Materials: 20 sheets of scrap paper | Exactly 10 small pieces of tape

Follow the steps below to try the challenge!', NULL, N'Working within a limit forces creative solutions -- real engineers always work within a budget.', 1, N'sequence_steps', N'{"steps": ["Plan your tower design before you start building -- tape is limited!", "Build using only your 10 pieces of tape.", "Measure your finished tower''s height.", "If it collapses, note why, then try again with a smarter tape plan."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_4, N'short_response', N'🌉 Load-Bearing Bridge Challenge

Objective: Build a bridge that spans a fixed distance and test how much weight it can hold.

Materials: 3-4 sheets of paper or craft sticks | Tape | 2 stacks of books set a ruler-length apart | Coins or dried beans

Follow the steps below to try the challenge!', NULL, N'The middle of a bridge is usually the weakest point -- reinforcing it is a real engineering strategy.', 2, N'sequence_steps', N'{"steps": ["Set the book stacks exactly one ruler-length apart.", "Build a bridge that reaches all the way across the gap.", "Add coins to the center, one at a time, recording the count as you go.", "Note the total right before the bridge fails, then try a design change and retest."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_4, N'short_response', N'⛵ Design-Your-Own Boat Challenge

Objective: Design an original boat from one sheet of foil to carry the most cargo possible, testing and comparing two versions.

Materials: 2 sheets of aluminum foil | A bowl or tub of water | Cargo (coins, dried beans, or small blocks)

Follow the steps below to try the challenge!', NULL, N'Comparing two designs side by side is how engineers figure out what actually works best.', 3, N'sequence_steps', N'{"steps": ["Design and build your first boat, using only one sheet of foil.", "Test it by adding cargo until it sinks, and record the total.", "Build a second, different-shaped boat from your second sheet.", "Compare which design carried more cargo, and think about why."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_4, N'short_response', N'✈️ Airplane Design Lab

Objective: Test three different paper airplane designs and record which flies the farthest.

Materials: 3 sheets of paper | Measuring tape or string | Paper and pencil for a data table

Follow the steps below to try the challenge!', NULL, N'Recording every trial -- not just the best one -- gives you the full, honest picture.', 4, N'sequence_steps', N'{"steps": ["Fold three differently-shaped airplanes (try changing wing width or nose shape).", "Throw each one twice from the same starting line, recording both distances.", "Record all six distances in a data table.", "Circle your best-performing design and describe what made it different."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_4, N'short_response', N'🤖 Debug the Robot Program

Objective: Find and fix an intentional mistake in a written robot program, practicing the skill of debugging.

Materials: Paper and pencil | Open floor space | A toy or marker as the goal

Follow the steps below to try the challenge!', NULL, N'Finding a bug isn''t a failure -- it''s a normal, expected part of every programmer''s job.', 5, N'sequence_steps', N'{"steps": ["One player secretly writes a program with one mistake in it (a wrong direction or missing step).", "The robot-friend follows the program exactly as written, even if it leads the wrong way.", "Together, figure out which step caused the problem -- that''s the ''bug.''", "Fix the bug and run the corrected program to reach the goal."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_4, N'short_response', N'🗺️ Shortest Path Coding Challenge

Objective: Find and write the most efficient (fewest-step) set of instructions to solve a maze.

Materials: Paper with a drawn grid maze (multiple possible paths) | A token | Pencil

Follow the steps below to try the challenge!', NULL, N'Finding the shortest path isn''t just neat -- it''s exactly what real navigation apps and robots try to do.', 6, N'sequence_steps', N'{"steps": ["Draw a maze with more than one possible path to the goal.", "Find and write out the path that uses the fewest total moves.", "Test your instructions by moving the token exactly as written.", "Compare with a partner''s maze solution -- whose path used fewer steps?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_4, N'short_response', N'🗂️ Venn Diagram Sort Challenge

Objective: Sort a collection into two overlapping categories using a physical Venn diagram made of string or hoops.

Materials: 2 pieces of string or 2 hula hoops (to make overlapping circles) | 15-20 small household objects

Follow the steps below to try the challenge!', NULL, N'The overlap in a Venn diagram shows what two categories share -- a powerful way to compare things.', 7, N'sequence_steps', N'{"steps": ["Lay out two overlapping circles with string or hoops.", "Label one circle ''red'' and the other ''round'' (or two categories of your choice).", "Sort each object into the correct circle -- or into the overlap if it fits both.", "Check the overlap area: what do those objects have in common?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_4, N'short_response', N'🔵 Create-a-Pattern Challenge

Objective: Design an original, moderately complex pattern for a partner to figure out and solve.

Materials: 20-25 small objects (colors, shapes, or sizes) | Paper and pencil

Follow the steps below to try the challenge!', NULL, N'Designing a pattern is harder than solving one -- you have to think one step ahead of your partner!', 8, N'sequence_steps', N'{"steps": ["Design your own repeating or growing pattern using at least 3 different objects.", "Lay it out at least 8 pieces long, then remove the last 2-3 pieces.", "Hand it to a partner and have them figure out and complete the missing pieces.", "Check together -- did they find your exact rule?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_4, N'short_response', N'📊 Data Hunt Challenge

Objective: Collect and graph real data by counting item types found around the house.

Materials: Paper | Pencil

Follow the steps below to try the challenge!', NULL, N'Real data doesn''t come pre-organized -- collecting and sorting it yourself is real scientific work.', 9, N'sequence_steps', N'{"steps": ["Pick a category to count around the house (like book colors, shoe types, or spoon vs. fork count).", "Walk around and tally each item you find into its category.", "Draw a bar graph showing your final counts.", "Write one sentence describing the pattern you notice in your data."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_4, N'short_response', N'🪨 Sink or Float Investigation

Objective: Investigate sink/float results across a wider set of objects and look for a material-based pattern.

Materials: A bowl or tub of water | 12-15 small household objects | Paper and pencil for a data table

Follow the steps below to try the challenge!', NULL, N'Comparing predicted vs. actual results shows you exactly where your understanding needs updating.', 10, N'sequence_steps', N'{"steps": ["Build a data table with columns for object, material, and predicted vs. actual result.", "Predict every object first, then test them all and record actual results.", "Group your results by material type (metal, wood, plastic, etc.).", "Write a conclusion: which material types were the most predictable, and which surprised you?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_4, N'short_response', N'🎈 Balloon Rocket Fair Test Challenge

Objective: Run a fair test changing only the straw size to isolate its effect on rocket distance.

Materials: 2-3 balloons | A long string | Straws of 2-3 different widths | Tape | Measuring tape

Follow the steps below to try the challenge!', NULL, N'Keeping the balloon size exactly the same each time is what makes this a true fair test of the straw.', 11, N'sequence_steps', N'{"steps": ["Blow up each balloon to the exact same size (use a piece of tape as a size marker) to keep that part fair.", "Test the rocket with a narrow straw and record the distance.", "Test the rocket with a wider straw, keeping the balloon size the same, and record the distance.", "Compare -- did straw width alone make a difference?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_4, N'short_response', N'🥚 Egg-Safe Landing Challenge

Objective: Design a protective capsule for a raw egg (or a wrapped ice cube for a mess-free version) to survive a short supervised drop.

Materials: 1 raw egg (or a wrapped ice cube as a mess-free substitute) | A small box or cup | Padding materials (cotton balls, paper, tissue) | Tape

Follow the steps below to try the challenge!', NULL, N'Even a raw egg can survive a fall with the right padding -- that''s the whole idea behind protective packaging.', 12, N'sequence_steps', N'{"steps": ["Build a padded capsule with your egg (or ice cube) centered and surrounded on all sides.", "With an adult, drop the capsule from a set low height onto a hard surface.", "Carefully open the capsule and check for cracks (or check the ice cube substitute for melting/damage).", "If it didn''t survive, add more padding around the weak spot and test again."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_4, N'short_response', N'🚀 Catapult Design Challenge

Objective: Build a rubber-band-powered catapult, test its distance, and adjust the design to improve it.

Materials: A plastic spoon | A pencil (pivot) | A rubber band | A pom-pom or small ball | Measuring tape

Follow the steps below to try the challenge!', NULL, N'Adjusting one part of a design and re-testing is the fastest way engineers make real improvements.', 13, N'sequence_steps', N'{"steps": ["Attach a rubber band to add extra launching power to your spoon catapult.", "Test-launch and measure the distance.", "Adjust the pivot point or rubber band tension and test again.", "Compare your before-and-after distances to see if your adjustment helped."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_4, N'short_response', N'📚 Shape Strength Investigation

Objective: Systematically test cylinder, triangle, and square paper columns to determine which shape holds the most weight.

Materials: 3 sheets of paper (same size) | Tape | Small weights (books or coins) for testing | Paper and pencil for a data table

Follow the steps below to try the challenge!', NULL, N'This is one of the most famous tests in engineering -- triangles and cylinders usually beat squares because they resist bending in every direction.', 14, N'sequence_steps', N'{"steps": ["Build a cylinder, a triangular column, and a square column, each from an identical sheet of paper.", "Test each column''s maximum weight capacity, adding weight until it buckles, and record results in a data table.", "Rank the three shapes from strongest to weakest.", "Write one sentence explaining which shape won and why you think that shape resists buckling best."]}');

    DECLARE @cat_stem_5 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (5, 'stem_engineering', N'STEM Challenge Games', 'space_heavy', 7, N'Build, test, and experiment with a hands-on STEM challenge!', 0);
    SET @cat_stem_5 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_5, N'short_response', N'🏗️ Newspaper Skyscraper Challenge

Objective: Engineer a tall tower from newspaper that can support the weight of a book on top.

Materials: 5-6 sheets of newspaper or scrap paper | Tape

Follow the steps below to try the challenge!', NULL, N'A wide base and a light top load are the secret to a skyscraper that doesn''t tip!', 1, N'sequence_steps', N'{"steps": ["Roll newspaper sheets into sturdy tubes for support columns.", "Build a tower structure using the tubes, taping joints for stability.", "Carefully place a lightweight book flat on top.", "If it wobbles or collapses, adjust your base and try again."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_5, N'short_response', N'🌉 Two-Paper Bridge Challenge

Objective: Engineer a bridge using only two sheets of paper and tape, then test and improve it through iteration.

Materials: Exactly 2 sheets of paper | Tape | 2 stacks of books | Coins or dried beans for weight testing

Follow the steps below to try the challenge!', NULL, N'Using fewer materials well is just as important to engineers as using more materials -- efficiency matters!', 2, N'sequence_steps', N'{"steps": ["Plan how to fold or shape just two sheets of paper into a strong bridge.", "Build and tape your bridge across the gap between the books.", "Load coins onto the bridge until it fails, recording the total.", "Rebuild using only your same two sheets in a new shape, and compare your results."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_5, N'short_response', N'⛵ Cargo Capacity Boat Challenge

Objective: Iterate on a boat design across three versions, recording cargo capacity data for each to find the best design.

Materials: 3 sheets of aluminum foil | A bowl or tub of water | Cargo (coins or dried beans) | Paper and pencil for a data table

Follow the steps below to try the challenge!', NULL, N'Changing one thing at a time between versions is how you know what actually made the difference.', 3, N'sequence_steps', N'{"steps": ["Build your first boat and test its cargo capacity, recording the result.", "Change one thing about the design (deeper sides, wider base, etc.) and build version 2.", "Test version 2 and record its capacity, then build and test version 3.", "Compare all three results in your data table and identify your best design."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_5, N'short_response', N'✈️ Distance vs. Design Challenge

Objective: Investigate how changing wing shape affects flight distance using a recorded data table.

Materials: 4 sheets of paper | Measuring tape or string | Paper and pencil for a data table

Follow the steps below to try the challenge!', NULL, N'Changing only one part of the design at a time is called a ''fair test'' -- it''s how you know what really caused the change.', 4, N'sequence_steps', N'{"steps": ["Fold a base airplane design and test it, recording the distance.", "Change only the wings (wider, narrower, angled up) and test again, recording distance.", "Repeat with two more wing variations, keeping everything else the same.", "Study your data table -- which wing change had the biggest effect on distance?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_5, N'short_response', N'🤖 Loop Command Challenge

Objective: Use a ''loop'' instruction (repeat a set of steps several times) to shorten a robot program.

Materials: Paper and pencil | Open floor space | Markers to lay out a repeating path

Follow the steps below to try the challenge!', NULL, N'Loops let programmers say ''repeat this'' instead of writing the same steps over and over -- real code uses this trick constantly.', 5, N'sequence_steps', N'{"steps": ["Set up a path that repeats the same shape several times (like a zigzag).", "Instead of writing each step separately, write a ''loop'': ''Repeat 3 times: forward 2 steps, turn right.''", "Your robot-friend follows the loop instruction exactly, repeating the steps the stated number of times.", "Compare how many lines your loop program took versus writing every step out separately."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_5, N'short_response', N'🗺️ Maze Algorithm Challenge

Objective: Write precise, unambiguous instructions for a partner to solve a maze without looking at it themselves.

Materials: Paper with a drawn grid maze | A blindfold or simple barrier (a folder) to block the maze from the solver''s view | Pencil

Follow the steps below to try the challenge!', NULL, N'If your partner couldn''t follow it perfectly, the instructions -- not your partner -- needed fixing. That''s the programmer''s job.', 6, N'sequence_steps', N'{"steps": ["One partner studies the maze and writes exact step-by-step instructions.", "The other partner (without looking at the maze) follows only the written instructions to trace the path on a matching blank grid.", "Compare the traced path to the real maze -- did the instructions work?", "If not, discuss what was unclear or missing, and rewrite the instructions to fix it."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_5, N'short_response', N'🗂️ Classify the Collection Challenge

Objective: Design an original multi-level classification system for a household collection.

Materials: 20+ small household objects (a mixed drawer or toy bin works well) | Paper and pencil

Follow the steps below to try the challenge!', NULL, N'Multi-level classification (categories within categories) is how scientists organize everything from animals to elements.', 7, N'sequence_steps', N'{"steps": ["Choose a big collection of mixed objects to classify.", "Create a main category system (like ''made of'' -- plastic, wood, metal, paper).", "Within each main category, create at least one sub-group (like ''plastic -- toys'' vs ''plastic -- tools'').", "Draw your classification system as a simple tree diagram on paper."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_5, N'short_response', N'🔵 Number Pattern Code Challenge

Objective: Identify the rule behind a number pattern and use it to predict several more terms.

Materials: Paper and pencil

Follow the steps below to try the challenge!', NULL, N'Every number pattern has a rule hiding inside it -- finding that rule is the heart of algebra.', 8, N'sequence_steps', N'{"steps": ["Write a number pattern with a hidden rule, like 2, 4, 6, 8, ___ or 3, 6, 12, 24, ___.", "Study the differences (or ratios) between numbers to find the rule.", "Predict and write the next 3 numbers in the sequence.", "Swap patterns with a partner and solve each other''s!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_5, N'short_response', N'📊 Survey & Graph Challenge

Objective: Design an original survey question, collect data, graph it, and draw a conclusion from the results.

Materials: Paper | Pencil

Follow the steps below to try the challenge!', NULL, N'A good conclusion connects your graph back to a real statement about what the data shows -- that''s the whole point of collecting it.', 9, N'sequence_steps', N'{"steps": ["Write your own survey question with 3-4 possible answers.", "Ask at least 8 people and record their answers with tally marks.", "Create a labeled bar graph of your results.", "Write a conclusion sentence: what does your graph tell you about people''s answers?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_5, N'short_response', N'🪨 What Makes It Float? Challenge

Objective: Test same-weight objects of different shapes to explore how shape affects floating, introducing the idea of density in kid-friendly terms.

Materials: A bowl or tub of water | A ball of modeling clay (or foil) that can be reshaped | Paper and pencil

Follow the steps below to try the challenge!', NULL, N'Spreading the same weight over a wider area is the secret behind why boats (and this clay bowl) float.', 10, N'sequence_steps', N'{"steps": ["Roll your clay (or foil) into a tight ball and test if it sinks or floats.", "Reshape the exact same amount of clay into a flat, wide bowl shape and test it again.", "Compare: did the same amount of material sink in one shape but float in another?", "Explain in your own words why shape -- not just what something''s made of -- affects floating."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_5, N'short_response', N'🎈 Balloon Rocket Engineering Challenge

Objective: Design a lightweight capsule attached to a balloon rocket and test how it affects travel distance.

Materials: 2-3 balloons | A long string | A straw | Tape | A small paper cup or folded paper capsule | Measuring tape

Follow the steps below to try the challenge!', NULL, N'Adding weight to a design almost always changes performance -- engineers always test ''before and after'' an add-on.', 11, N'sequence_steps', N'{"steps": ["Test your balloon rocket''s baseline distance with no capsule attached.", "Build a lightweight paper capsule and attach it to the rocket.", "Test the rocket again with the capsule attached and record the new distance.", "Compare the two distances and explain what effect the extra weight had."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_5, N'short_response', N'🥚 Egg Drop Engineering Challenge

Objective: Engineer an egg-protection capsule within a limited material budget and test it from increasing heights.

Materials: 1 raw egg (or a wrapped ice cube as a mess-free substitute) | A limited kit: 1 small box, 10 cotton balls, 5 pieces of tape | A ruler or tape measure

Follow the steps below to try the challenge!', NULL, N'Working within a strict material budget forces the smartest possible design -- that''s real engineering constraint-solving.', 12, N'sequence_steps', N'{"steps": ["Design and build your capsule using only your limited materials.", "Test-drop from a low height first (like 1 foot) with an adult supervising.", "If it survives, raise the height gradually and retest, recording the highest successful height.", "If it breaks, note what happened and think about what you''d change with the same limited materials."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_5, N'short_response', N'🚀 Ramp Angle Investigation

Objective: Investigate how ramp steepness affects rolling distance using a fair test.

Materials: A small ball | A book or board that can be propped at different angles | Books to prop the ramp at different heights | Measuring tape

Follow the steps below to try the challenge!', NULL, N'Keeping everything the same except the ramp angle is what makes this a true fair test of steepness.', 13, N'sequence_steps', N'{"steps": ["Set your ramp at a low angle and roll the ball, measuring the total distance traveled.", "Raise the ramp to a medium angle (keeping the ball and rolling surface exactly the same) and test again.", "Raise it to a steep angle and test a third time.", "Graph or chart your three distances -- does a steeper ramp always mean farther travel?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_5, N'short_response', N'📚 Strongest Shape Engineering Challenge

Objective: Design and iterate a paper column within a strict one-sheet material constraint to maximize weight held.

Materials: 3 sheets of paper (one for each of 3 attempts) | Tape | Small weights (books or coins) for testing | Paper and pencil for a data table

Follow the steps below to try the challenge!', NULL, N'Sticking to a strict one-sheet limit across every version is what makes this a fair comparison between your own designs.', 14, N'sequence_steps', N'{"steps": ["Design and build your first column using exactly one sheet of paper, then test its max weight capacity.", "Redesign using your second sheet, changing the shape or fold pattern based on what you learned.", "Test your second design and record whether it improved.", "Build and test a third version, aiming to beat both previous results, and record all three in your data table."]}');

    DECLARE @cat_stem_6 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (6, 'stem_engineering', N'STEM Challenge Games', 'space_heavy', 7, N'Build, test, and experiment with a hands-on STEM challenge!', 0);
    SET @cat_stem_6 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_6, N'short_response', N'🏗️ Spaghetti Tower Challenge

Objective: Design and test a freestanding tower using uncooked spaghetti and tape, then record which design held the most weight.

Materials: 20 pieces of uncooked spaghetti | Tape | A small paper cup | Coins or dried beans for weight testing

Follow the steps below to try the challenge!', NULL, N'Triangles brace better than squares -- most engineers reach for triangle shapes when strength matters!', 1, N'sequence_steps', N'{"steps": ["Build a tower using spaghetti as the frame and tape as the connector.", "Attach the paper cup to the top of your tower.", "Add coins to the cup one at a time until the tower buckles -- count how many it held.", "Redesign and test a second tower, then compare which design held more weight and why."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_6, N'short_response', N'🌉 Longest-Span Bridge Challenge

Objective: Design a bridge to span the longest possible distance while still holding a set amount of weight, recording results in a data table.

Materials: 5-6 craft sticks or paper strips | Tape | Books to create an adjustable gap | Coins for weight testing | Paper and pencil for a data table

Follow the steps below to try the challenge!', NULL, N'Longer spans need cleverer support -- that''s why real bridges use triangle trusses underneath.', 2, N'sequence_steps', N'{"steps": ["Build a bridge design and test the maximum gap it can span while still holding 5 coins.", "Record the span distance and coin count in a data table.", "Redesign to try increasing the span without losing weight capacity.", "Compare your two designs -- which had the better span-to-strength ratio?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_6, N'short_response', N'⛵ Maximum Cargo Boat Engineering Challenge

Objective: Design and test multiple boat versions to maximize cargo capacity, graphing the results to identify design trends.

Materials: 3-4 sheets of aluminum foil | A bowl or tub of water | Cargo (coins or dried beans) | Paper and pencil for a graph

Follow the steps below to try the challenge!', NULL, N'Graphing your results turns raw numbers into a pattern you can actually see and use.', 3, N'sequence_steps', N'{"steps": ["Design and test at least 3 different boat shapes, recording the cargo count each held.", "Make a simple bar graph comparing the cargo capacity of each design.", "Look at your graph and identify which shape features (wide, deep, boxy) held the most.", "Build one final ''best guess'' design combining your best features and test it."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_6, N'short_response', N'✈️ Aerodynamics Design Challenge

Objective: Conduct a fair test on paper airplane design, changing one variable at a time and analyzing which variable matters most.

Materials: 5 sheets of paper | Measuring tape or string | Paper and pencil for a data table

Follow the steps below to try the challenge!', NULL, N'Changing only one variable at a time is the core of fair scientific testing -- it''s what separates a guess from real evidence.', 4, N'sequence_steps', N'{"steps": ["Choose one variable to test (paper weight, wing width, or fold count) and build two versions differing only in that variable.", "Fly each version three times, recording all distances in a table.", "Calculate the average distance for each version.", "Write a sentence stating which version performed better and why you think that variable made the difference."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_6, N'short_response', N'🤖 If-Then Robot Challenge

Objective: Introduce conditional logic by writing ''if-then'' rules for a robot-friend to follow when reaching a decision point.

Materials: Paper and pencil | Open floor space | Markers for a fork-in-the-path course

Follow the steps below to try the challenge!', NULL, N'''If-then'' rules let a program make decisions on its own -- this is a building block of real computer logic.', 5, N'sequence_steps', N'{"steps": ["Set up a path with a fork where the robot-friend must choose a direction.", "Write a conditional rule, like ''If you reach a wall, turn right. If you reach an open space, keep going forward.''", "Your robot-friend follows the program exactly, applying the if-then rule at the decision point.", "Test the program on two different paths and see if the same rule still works for both."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_6, N'short_response', N'🗺️ Efficient Algorithm Challenge

Objective: Compare multiple valid maze solutions to determine which is most efficient, and explain what ''efficient'' means in this context.

Materials: Paper with a drawn grid maze (multiple valid paths) | Pencil | Paper and pencil for a comparison table

Follow the steps below to try the challenge!', NULL, N'In computer science, doing the same job in fewer steps is called ''efficiency'' -- it''s a core engineering goal.', 6, N'sequence_steps', N'{"steps": ["Find at least two different valid paths through the maze and write instructions for each.", "Count the total number of moves in each path.", "Record both path lengths in a table and identify the shorter (more efficient) one.", "Write a sentence explaining why a shorter set of instructions can still solve the same problem just as well."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_6, N'short_response', N'🗂️ Data Categories Design Challenge

Objective: Design a logical sorting system for a large item collection and explain the reasoning behind your categories.

Materials: 25-30 small household objects (books, toys, or a junk drawer work well) | Paper and pencil

Follow the steps below to try the challenge!', NULL, N'Good categories cover every case with no overlap -- that''s the same standard real data organizers use.', 7, N'sequence_steps', N'{"steps": ["Design at least 3 categories that could organize your whole collection with no leftover items.", "Sort every item into a category, keeping a tally count for each.", "Check: does every item fit somewhere, and does no item obviously fit two categories?", "Write 2-3 sentences explaining why you chose those categories and how you''d adjust them if a strange new item didn''t fit."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_6, N'short_response', N'🔵 Pattern Rule Challenge

Objective: Find the mathematical rule behind a pattern and express it in words and in a table.

Materials: Paper and pencil

Follow the steps below to try the challenge!', NULL, N'Writing a rule that predicts any term -- even far-away ones -- is exactly what a math formula does.', 8, N'sequence_steps', N'{"steps": ["Create a number or shape pattern with at least 6 terms.", "Make a table with ''term number'' in one column and ''value'' in the other.", "Study the table to find the rule connecting term number to value (like ''multiply by 2, then add 1'').", "Use your rule to predict the value of term number 10 without building it out by hand."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_6, N'short_response', N'📊 Data Analysis Challenge

Objective: Collect numeric measurement data, calculate an average, and graph the results.

Materials: Paper | Pencil | A measuring tool (ruler, tape measure, or a scale)

Follow the steps below to try the challenge!', NULL, N'The average gives you one number that summarizes a whole set of data -- it''s one of the most useful tools in math.', 9, N'sequence_steps', N'{"steps": ["Choose something measurable to collect data on (like the length of 8 different household objects, or step counts across a room).", "Measure and record 8-10 data points.", "Add all your numbers together and divide by how many you collected to find the average.", "Graph your data points and mark where the average falls on the graph."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_6, N'short_response', N'🪨 Density Detective Challenge

Objective: Investigate and explain the sink/float pattern across a wide range of materials using the concept of density.

Materials: A bowl or tub of water | 15+ small household objects of different materials | Paper and pencil for a data table

Follow the steps below to try the challenge!', NULL, N'This ''weight compared to size'' idea is called density -- you just investigated one of the biggest ideas in physical science.', 10, N'sequence_steps', N'{"steps": ["Test and record sink/float results for all your objects, noting the material of each.", "Group results by material and look for a consistent pattern.", "Recall which everyday materials are generally ''light for their size'' (float) versus ''heavy for their size'' (sink).", "Write a short explanation connecting your data to the idea that floating depends on weight compared to size, not weight alone."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_6, N'short_response', N'🎈 Balloon Rocket Optimization Challenge

Objective: Run multiple trials of a balloon rocket design, calculate an average distance, and iterate to improve it.

Materials: 4-5 balloons | A long string | A straw | Tape | Measuring tape | Paper and pencil for a data table

Follow the steps below to try the challenge!', NULL, N'One trial can be lucky or unlucky, but an average across several tells you what''s really true.', 11, N'sequence_steps', N'{"steps": ["Run 3 trials of your rocket design, recording each distance in a data table.", "Calculate the average distance across the 3 trials.", "Make one design change (straw angle, balloon size, or string tautness) and run 3 more trials.", "Compare the two averages -- did your change improve performance?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_6, N'short_response', N'🥚 Impact Protection Challenge

Objective: Design an egg-protection capsule, test it from a measured starting height, and increase the height across iterations to find its breaking point.

Materials: 2-3 raw eggs (or wrapped ice cubes) | Building materials (box, cotton balls, tape, paper) | A tape measure | Paper and pencil for a data table

Follow the steps below to try the challenge!', NULL, N'Recording the exact height where a design fails tells you precisely how much stronger your next version needs to be.', 12, N'sequence_steps', N'{"steps": ["Build your first capsule design and test-drop it from a measured 2-foot height, recording pass/fail.", "If it survives, increase the height in 1-foot increments, recording each result in a data table.", "When it fails, note the exact height and think about which part of the design likely failed.", "Build a second, improved capsule and repeat the height tests to see if it survives higher drops."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_6, N'short_response', N'🚀 Catapult Engineering Challenge

Objective: Design a catapult with an adjustable launch angle and test performance across multiple angle settings.

Materials: A plastic spoon or craft-stick catapult frame | A pencil (pivot) | A rubber band | A pom-pom or small ball | Measuring tape | Paper and pencil for a data table

Follow the steps below to try the challenge!', NULL, N'Testing across a full range of settings -- not just one -- is how you find the true best design, not just a good-enough one.', 13, N'sequence_steps', N'{"steps": ["Build your catapult so the pivot or angle can be adjusted between tests.", "Test-launch at a low angle setting, recording the distance.", "Adjust to a medium and then a steep angle, recording distance for each.", "Identify which angle setting produced the longest launch, and record all results in your data table."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_6, N'short_response', N'📚 Load Test Engineering Challenge

Objective: Systematically test multiple column shapes with a full data table and calculate the maximum load per shape.

Materials: 4-5 sheets of paper | Tape | Small weights (coins or dried beans, counted individually) | Paper and pencil for a data table

Follow the steps below to try the challenge!', NULL, N'Measuring load per exact same amount of material is how real engineers fairly compare different structural designs.', 14, N'sequence_steps', N'{"steps": ["Build at least 3 different column shapes, one sheet of paper each.", "Test each column by adding weights one at a time, counting the exact number added before buckling.", "Record the total weight (number of coins/beans) held by each shape in a data table.", "Calculate which shape held the most weight per sheet of paper used, and explain your reasoning in writing."]}');

    DECLARE @cat_stem_7 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (7, 'stem_engineering', N'STEM Challenge Games', 'space_heavy', 7, N'Build, test, and experiment with a hands-on STEM challenge!', 0);
    SET @cat_stem_7 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_7, N'short_response', N'🏗️ Free-Standing Tower Engineering Challenge

Objective: Apply a strict material budget to design a tower, test its weight capacity, and reflect on which structural shape performed best.

Materials: 30 index cards or paper strips | Tape (measured, e.g. 50 cm total) | A small paper cup | Coins or dried beans for weight testing | Paper and pencil for a data table

Follow the steps below to try the challenge!', NULL, N'Recording your data and comparing designs is the real engineering process -- it''s not just building, it''s improving.', 1, N'sequence_steps', N'{"steps": ["Sketch your design first, staying within the material budget.", "Build the tower and attach a cup to the top for weight-testing.", "Add coins one at a time, recording the total weight in a data table each round until it fails.", "Rebuild with one deliberate change (shape, base width, or bracing) and retest -- record whether the new design held more or less weight, and explain why."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_7, N'short_response', N'🌉 Bridge Design Trade-Off Challenge

Objective: Investigate the trade-off between bridge span and strength, and explain the engineering reasoning behind the results.

Materials: 8-10 craft sticks or paper strips | Tape | Books to create an adjustable gap | Coins for weight testing | Paper and pencil for a data table

Follow the steps below to try the challenge!', NULL, N'Every real bridge design balances span, strength, and materials -- you just did real structural engineering.', 2, N'sequence_steps', N'{"steps": ["Build a bridge and test it at three different span lengths, recording the maximum weight held at each length.", "Graph or chart your results (span vs. weight held).", "Identify the pattern -- does a longer span always mean less strength?", "Write one sentence explaining what your data shows about the trade-off between span and strength."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_7, N'short_response', N'⛵ Boat Hull Design Challenge

Objective: Systematically compare different hull shapes for cargo capacity and explain the buoyancy principle behind the results.

Materials: 4 sheets of aluminum foil | A bowl or tub of water | Cargo (coins or dried beans) | Paper and pencil for a data table

Follow the steps below to try the challenge!', NULL, N'A boat floats by pushing water out of the way -- the more water it displaces, the more weight it can carry.', 3, N'sequence_steps', N'{"steps": ["Build four boats with distinctly different hull shapes (flat, round, boxy, pointed).", "Test each one''s cargo capacity, recording results in a data table.", "Rank the hull shapes from most to least cargo held.", "Write one or two sentences explaining, in your own words, why the winning shape displaces more water and floats more weight."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_7, N'short_response', N'✈️ Flight Engineering Challenge

Objective: Design a paper airplane under material constraints, run multiple controlled trials, and reflect on the importance of variable control.

Materials: 1 sheet of paper only (constraint) | Tape (max 3 pieces) | Measuring tape or string | Paper and pencil for a data table

Follow the steps below to try the challenge!', NULL, N'Averaging multiple trials smooths out lucky or unlucky throws -- real engineers never trust just one test.', 4, N'sequence_steps', N'{"steps": ["Design your best airplane using only the allowed sheet of paper and tape.", "Fly it 5 times from the same spot in the same way, recording every distance.", "Calculate the average distance across all 5 trials.", "Reflect in writing: why does flying multiple trials give a more reliable result than a single throw?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_7, N'short_response', N'🤖 Full Program Design Challenge

Objective: Design a complete program combining loops and conditionals to navigate a complex path, then debug a partner''s program.

Materials: Paper and pencil | Open floor space | Markers to lay out a multi-turn course

Follow the steps below to try the challenge!', NULL, N'Combining loops, conditionals, and careful debugging is exactly what real software engineers do every day.', 5, N'sequence_steps', N'{"steps": ["Design a course with turns, a repeating section, and a decision point.", "Write a full program for it using at least one loop and one if-then rule.", "Trade programs with a partner and run their program exactly as written on your robot-friend.", "If it fails partway, work together to find and fix the bug, then rerun it successfully."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_7, N'short_response', N'🗺️ Maze Optimization Challenge

Objective: Write a maze-solving algorithm using loop notation for repeated moves, then measure and compare its efficiency to a non-looped version.

Materials: Paper with a drawn grid maze that has a repeating straight section | Pencil | Paper and pencil for a data table

Follow the steps below to try the challenge!', NULL, N'Real programming languages use loops for exactly this reason -- shorter code that does the same job is easier to read and fix.', 6, N'sequence_steps', N'{"steps": ["Write out the full maze solution move-by-move (e.g., ''forward, forward, forward, forward, turn left'').", "Rewrite the same solution using loop notation for the repeated section (e.g., ''repeat 4 times: forward. Then turn left.'').", "Count the total written lines/instructions for each version and compare in a table.", "Explain in writing why the loop version does the same job with fewer written instructions."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_7, N'short_response', N'🗂️ Sorting Algorithm Race

Objective: Physically perform a simple sorting algorithm (comparing and swapping pairs) on number cards and time how long it takes.

Materials: 10 index cards, each with a different random number written on it | A stopwatch or phone timer

Follow the steps below to try the challenge!', NULL, N'You just performed a real sorting algorithm by hand -- computers do the exact same compare-and-swap steps, just much faster.', 7, N'sequence_steps', N'{"steps": ["Lay your 10 number cards in a random row.", "Using only ''compare two neighboring cards and swap if out of order,'' work left to right and repeat full passes until the whole row is in order (this is called a ''bubble sort'').", "Time how long it takes and count how many total swaps you made.", "Shuffle and try again -- did you finish faster or with fewer swaps the second time?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_7, N'short_response', N'🔵 Pattern & Sequence Design Challenge

Objective: Design a multi-step pattern with a clear rule, then challenge a partner to discover the rule and predict a distant term.

Materials: Paper and pencil

Follow the steps below to try the challenge!', NULL, N'A pattern that takes real thinking to crack is more fun to design than one that''s too easy -- that''s the mark of a good puzzle-maker.', 8, N'sequence_steps', N'{"steps": ["Design an original pattern (numbers or shapes) with a rule that takes at least two steps to describe (like ''double it, then subtract 1'').", "Write out the first 5 terms only, keeping your rule secret.", "Give it to a partner and challenge them to find the rule and predict term number 10.", "Check their answer against your actual rule, and discuss any tricky parts that made it hard to find."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_7, N'short_response', N'📊 Data Investigation Challenge

Objective: Formulate an original data question, collect and graph evidence, and write a data-based conclusion.

Materials: Paper | Pencil | A measuring tool if needed

Follow the steps below to try the challenge!', NULL, N'Starting with a real question and following the evidence -- even to an uncertain answer -- is exactly how real data investigations work.', 9, N'sequence_steps', N'{"steps": ["Write down a real question you''re curious about that data could answer (like ''do taller family members have bigger feet?'').", "Collect at least 8-10 data points relevant to your question.", "Graph your data in a way that helps answer the question (bar graph, line graph, or scatter of points).", "Write a short data-based conclusion: does your evidence support a ''yes,'' ''no,'' or ''not enough data yet'' answer?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_7, N'short_response', N'🪨 Buoyancy Engineering Challenge

Objective: Redesign a naturally sinking object to make it float by adding materials, iterating through multiple versions.

Materials: A bowl or tub of water | A small heavy object that sinks (like a metal washer or heavy bolt) | Aluminum foil or modeling clay | Paper and pencil for a data table

Follow the steps below to try the challenge!', NULL, N'You just applied real buoyancy engineering -- adding the right shape and volume can make even heavy things float.', 10, N'sequence_steps', N'{"steps": ["Confirm your heavy object sinks on its own.", "Wrap or attach foil/clay around it in a shape designed to add floating volume, then retest.", "If it still sinks, redesign with a wider or more boat-like shape and test again -- track each version in a data table.", "Once it floats, explain in writing what design change finally made the difference and why."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_7, N'short_response', N'🎈 Balloon Rocket Payload Challenge

Objective: Determine the maximum payload a balloon rocket can carry while still traveling a minimum distance, using a full data table and written reflection.

Materials: 5+ balloons | A long string | A straw | Tape | Small weights (paper clips or coins) | Measuring tape | Paper and pencil for a data table

Follow the steps below to try the challenge!', NULL, N'Every real rocket and cargo vehicle has to balance how much it carries against how far or fast it can go -- you just tackled that same trade-off.', 11, N'sequence_steps', N'{"steps": ["Test your rocket''s unloaded distance and set a minimum distance goal (e.g., at least half the string''s length).", "Attach a small weight to the rocket and test whether it still reaches the minimum distance.", "Keep adding weight in small increments, recording payload and distance in a data table after each test.", "Identify the maximum payload that still met your minimum distance, and write a short reflection on the trade-off between payload and performance."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_7, N'short_response', N'🥚 Egg Drop Redesign Challenge

Objective: Iterate through three full capsule redesigns, recording data on each, and reflect on which single design change mattered most.

Materials: 3 raw eggs (or wrapped ice cubes) | Building materials (box, cotton balls, tape, paper, straws) | A tape measure | Paper and pencil for a data table

Follow the steps below to try the challenge!', NULL, N'Changing one variable per version is what makes your data trustworthy -- now you know exactly which change mattered, not just that something worked.', 12, N'sequence_steps', N'{"steps": ["Build version 1 of your capsule and test-drop it from a fixed height (like 4 feet), recording the result.", "Redesign with exactly one deliberate change (more padding, a different shape, a shock-absorbing layer) to build version 2, and test it from the same height.", "Build a third version with another single change, and test it too, recording all results in your data table.", "Write a reflection identifying which single change made the biggest difference in survival, and explain your reasoning."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_7, N'short_response', N'🚀 Projectile Distance Optimization Challenge

Objective: Systematically vary launch angle and pull-back force one at a time to find the combination that maximizes distance.

Materials: A craft-stick or spoon catapult with an adjustable pivot | A rubber band | A pom-pom or small ball | Measuring tape | Paper and pencil for a data table

Follow the steps below to try the challenge!', NULL, N'Testing one variable at a time before combining your best settings is a real optimization strategy engineers use to fine-tune designs.', 13, N'sequence_steps', N'{"steps": ["Fix the pull-back force and test 3 different launch angles, recording distance for each in a data table.", "Identify your best angle, then fix that angle and test 3 different pull-back forces, recording each distance.", "Identify your best pull-back force from that round.", "Combine your best angle and best pull-back force in one final launch, and compare it to all your earlier results -- was it truly your longest?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_stem_7, N'short_response', N'📚 Structural Engineering Challenge

Objective: Design a paper structure under a strict material budget to hold the maximum possible weight, and reflect on why triangulated shapes resist buckling.

Materials: Exactly 3 sheets of paper and 15 cm of tape (fixed budget) | Small weights (coins or dried beans) for load-testing | Paper and pencil for a data table

Follow the steps below to try the challenge!', NULL, N'Triangles can''t collapse into a different shape the way squares can -- that''s why triangulated structures like bridges and cranes are built the way they are.', 14, N'sequence_steps', N'{"steps": ["Sketch your structure design before building, planning to use triangulated shapes for strength within your fixed budget.", "Build your structure exactly within the material limit.", "Load-test it by adding weight gradually, recording the total held in a data table right up to the point of failure.", "Write a short reflection explaining, using the idea of triangulation, why your design held (or didn''t hold) as much weight as you expected."]}');

END
GO

DELETE FROM dbo.WeeklyPacketPlan;
GO