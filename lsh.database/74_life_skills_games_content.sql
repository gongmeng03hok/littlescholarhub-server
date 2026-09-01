-- 74_life_skills_games_content.sql
-- Adds a 'Real-Life Skills Games' category to the existing always-on
-- 'life_skills' subject_area for every grade (TK-6th) — no schema or proc
-- changes needed, reuses dbo.PacketSubjectAreas/usp_GetOrCreateWeeklyPacket
-- exactly as-is.
--
-- Each grade gets a pool of 14 games spanning the subject area's existing
-- themes (Digital Literacy & Online Safety, Financial Literacy,
-- Organization, Time Management); target_count=7 (fixed, not the usual
-- ~65% auto-rebalance ratio) means the existing NEWID()-sampling rotation
-- serves a different 7-of-14 combination most weeks a grade's life_skills
-- category is selected, satisfying "7 games, different set each week"
-- without any manual per-week authoring.
--
-- Every game is a screen-free, printed activity played at home — including
-- the digital-literacy games, which use role-play and hand-drawn scenario
-- cards rather than any actual device use.
--
-- Each game is ONE PacketQuestions row: prompt carries the Name/Objective/
-- Materials, diagram_type='sequence_steps' carries the Step-by-Step
-- Instructions (already-shipped diagram type, renders as a numbered list in
-- both the app and print — see 63_whole_child_rotation.sql).
-- See gen_74_life_skills_games_content.py.

IF NOT EXISTS (SELECT 1 FROM dbo.PacketCategories WHERE subject_area = 'life_skills' AND category_name = N'Real-Life Skills Games')
BEGIN
    DECLARE @cat_life_0 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (0, 'life_skills', N'Real-Life Skills Games', 'space_heavy', 7, N'Practice a real-world skill through a fun hands-on game!', 0);
    SET @cat_life_0 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_0, N'short_response', N'💰 Penny Sorting Circle

Objective: Practice sorting pretend coins by size while taking turns.

Materials: Pretend coins or buttons in 2-3 sizes | A bowl or basket

Follow the steps below to play!', NULL, N'Sorting money by size is the very first step toward counting it later!', 1, N'sequence_steps', N'{"steps": ["Dump the pretend coins in the middle.", "Take turns picking one up.", "Say if it''s big or small and put it in the matching pile.", "Keep going until every coin is sorted."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_0, N'short_response', N'🧺 Toy Basket Race

Objective: Practice putting toys away in the right basket to build simple organizing habits.

Materials: 2 baskets or bins | A small pile of toys, blocks, or stuffed animals

Follow the steps below to play!', NULL, N'A place for everything makes clean-up time so much faster.', 2, N'sequence_steps', N'{"steps": ["Label one basket ''soft toys'' and one ''hard toys'' (a grown-up can help).", "Set a timer for one minute.", "Race to put every toy in the correct basket before time is up.", "Count together how many you got right!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_0, N'short_response', N'🚦 Ask a Grown-Up Game

Objective: Practice knowing which everyday choices need a grown-up''s okay first.

Materials: None — just talk it through together

Follow the steps below to play!', NULL, N'Learning to pause and ask is a safe habit worth starting small, today.', 3, N'sequence_steps', N'{"steps": ["A grown-up names a simple situation, like ''a video I''ve never seen pops up.''", "The child decides: ''ask a grown-up'' or ''it''s fine by myself.''", "Talk together about why.", "Try a few more examples."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_0, N'short_response', N'⏰ Morning Picture Parade

Objective: Practice putting a morning routine in the right order using picture cards.

Materials: 4-5 hand-drawn picture cards showing wake up, brush teeth, get dressed, eat breakfast

Follow the steps below to play!', NULL, N'Seeing the steps in order helps mornings feel calm instead of rushed.', 4, N'sequence_steps', N'{"steps": ["Draw or find simple pictures for each morning step.", "Mix up the cards.", "Work together to line them up in the order they really happen.", "Act out the routine as you go!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_0, N'short_response', N'🪙 Piggy Bank Drop

Objective: Practice counting pretend coins one at a time into a bank.

Materials: Pretend coins or buttons | A jar or piggy bank

Follow the steps below to play!', NULL, N'Counting slowly and out loud is how real counting skills grow.', 5, N'sequence_steps', N'{"steps": ["Give the child a small pile of pretend coins.", "Drop them in one at a time, counting out loud together.", "See how many you counted when the pile is empty.", "Try again and see if the count matches!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_0, N'short_response', N'🎒 Backpack Bin Match

Objective: Practice matching everyday items to where they belong.

Materials: A backpack or bag | A few household items like a cup, a book, a shoe

Follow the steps below to play!', NULL, N'Naming a ''home'' for each item makes putting things away simple.', 6, N'sequence_steps', N'{"steps": ["Spread the items out on the floor.", "Show a ''home'' spot for each one (shelf, bag, basket).", "Take turns carrying an item to its home.", "Cheer when every item finds its spot!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_0, N'short_response', N'🕐 Beat the Timer Cleanup

Objective: Practice tidying quickly and happily before a timer runs out.

Materials: A timer or clock | A few toys to tidy

Follow the steps below to play!', NULL, N'Turning cleanup into a game makes it something to look forward to.', 7, N'sequence_steps', N'{"steps": ["Set a timer for 2 minutes.", "Pick up as many toys as you can before it beeps.", "Cheer together when the timer goes off.", "Reset and try to beat your own time!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_0, N'short_response', N'🛍️ Pretend Store Visit

Objective: Practice a simple ''buy'' and ''pay'' routine with pretend money.

Materials: Pretend coins or paper money | 2-3 toy items to ''sell''

Follow the steps below to play!', NULL, N'Trading coins for items is a gentle first taste of how buying works.', 8, N'sequence_steps', N'{"steps": ["A grown-up sets out a few toys with a coin next to each.", "The child picks an item and hands over the matching coin.", "The grown-up says ''thank you!'' and hands over the toy.", "Take turns being the shopper and the shopkeeper."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_0, N'short_response', N'🧦 Sock Match Sprint

Objective: Practice matching pairs quickly, an early sorting and organizing skill.

Materials: Several pairs of socks

Follow the steps below to play!', NULL, N'Matching pairs is a fun warm-up for real laundry-folding later.', 9, N'sequence_steps', N'{"steps": ["Mix up a pile of socks.", "Take turns pulling out two socks.", "Check if they match — if yes, set the pair aside.", "Keep going until every sock has its partner!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_0, N'short_response', N'🗓️ What Comes Next?

Objective: Practice predicting the next step in a simple daily routine.

Materials: None — just talk it through together

Follow the steps below to play!', NULL, N'Predicting ''what''s next'' helps little ones feel ready for the day.', 10, N'sequence_steps', N'{"steps": ["A grown-up starts a routine out loud, like ''First we wake up, then we...''", "The child guesses what comes next.", "Keep building the routine one step at a time.", "Try a bedtime routine too!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_0, N'short_response', N'🙋 Safe or Wait Game

Objective: Practice telling the difference between things okay to do alone and things that need a helper.

Materials: None — just talk it through together

Follow the steps below to play!', NULL, N'Small decisions like these build the confidence to make bigger safe choices later.', 11, N'sequence_steps', N'{"steps": ["A grown-up names a simple action, like ''pouring my own water.''", "The child gives thumbs up for ''I can do it'' or thumbs sideways for ''ask first.''", "Talk about the answer together.", "Try five more examples."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_0, N'short_response', N'📦 Big Box, Little Box

Objective: Practice sorting toys by size into two containers.

Materials: 2 boxes or bins (one bigger, one smaller) | A mix of toys

Follow the steps below to play!', NULL, N'Sorting by size is an early building block for organizing anything.', 12, N'sequence_steps', N'{"steps": ["Set out the two boxes side by side.", "Pick up a toy and decide if it''s big or little.", "Place it in the matching box.", "Keep sorting until every toy has a home!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_0, N'short_response', N'🍎 Snack Time Sharing

Objective: Practice fair sharing and simple counting with a pretend snack.

Materials: Play food pieces or crackers | 2-3 plates

Follow the steps below to play!', NULL, N'Fair sharing is one of the very first ''money sense'' lessons kids learn.', 13, N'sequence_steps', N'{"steps": ["Count out a small pile of pretend snack pieces.", "Share them evenly between the plates, one at a time.", "Count how many ended up on each plate.", "Talk about whether the sharing was fair."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_0, N'short_response', N'🧸 Toy Library Checkout

Objective: Practice a simple borrow-and-return routine, an early responsibility habit.

Materials: A few toys | A small shelf or basket as the ''library''

Follow the steps below to play!', NULL, N'Returning things to their place is a habit that helps for life.', 14, N'sequence_steps', N'{"steps": ["Line up the toys on the ''library'' shelf.", "Take turns ''checking out'' one toy to play with.", "When done playing, return it to its exact spot.", "Check that every toy made it back home!"]}');

    DECLARE @cat_life_1 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (1, 'life_skills', N'Real-Life Skills Games', 'space_heavy', 7, N'Practice a real-world skill through a fun hands-on game!', 0);
    SET @cat_life_1 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_1, N'short_response', N'💰 Coin Value Count

Objective: Practice counting pretend pennies and nickels to reach a small total.

Materials: Pretend pennies and nickels (or paper cutouts) | A small cup

Follow the steps below to play!', NULL, N'Small counting goals like this build real number sense for money later.', 1, N'sequence_steps', N'{"steps": ["Show the child a penny (worth 1) and a nickel (worth 5).", "Ask them to collect coins until they reach a target number, like 10.", "Count out loud together as coins go in the cup.", "Check the total together when done."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_1, N'short_response', N'🛒 Three Item Shop

Objective: Practice choosing items within a small pretend budget.

Materials: Pretend coins | 3 toy items each with a price tag (1-5)

Follow the steps below to play!', NULL, N'Choosing what fits your coins is the very start of budgeting.', 2, N'sequence_steps', N'{"steps": ["Give the shopper 5 pretend coins to spend.", "Look at the price tags on each item.", "Decide which item(s) to buy without going over 5 coins.", "Pay and trade roles with a partner."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_1, N'short_response', N'🗂️ Sort By Type Relay

Objective: Practice organizing household items into matching categories quickly.

Materials: A mixed pile of toys, clothes, and books | 3 labeled bins

Follow the steps below to play!', NULL, N'Categories make it much faster to find things later — and to clean up too!', 3, N'sequence_steps', N'{"steps": ["Label three bins: toys, clothes, books.", "Set a timer for 90 seconds.", "Race to sort the mixed pile into the right bins.", "Check together and re-sort any mistakes."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_1, N'short_response', N'🕵️ Real or Pretend Online Pop-Up

Objective: Practice spotting the difference between a trusted grown-up message and a surprise pop-up, using drawn cards.

Materials: 3-4 hand-drawn cards showing simple scenes (a video, a game, a pop-up ad)

Follow the steps below to play!', NULL, N'Pausing before clicking anything new is a habit worth starting early.', 4, N'sequence_steps', N'{"steps": ["Lay out the drawn cards face up.", "Talk about which ones a grown-up should see first.", "Sort the cards into ''show a grown-up'' and ''just for fun.''", "Discuss why some things need a grown-up''s eyes first."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_1, N'short_response', N'🗓️ Build My Day Cards

Objective: Practice arranging picture cards into a simple daily schedule.

Materials: 5-6 picture cards for daily activities (breakfast, school, play, dinner, bed)

Follow the steps below to play!', NULL, N'Seeing a whole day laid out helps make even busy days feel manageable.', 5, N'sequence_steps', N'{"steps": ["Spread the picture cards out, mixed up.", "Put them in order from morning to night.", "Talk through the day using the cards.", "Try swapping two cards and see if the day still makes sense!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_1, N'short_response', N'⏳ Race the Sand Timer

Objective: Practice estimating how long simple tasks take.

Materials: A sand timer or 1-minute phone timer | Blocks to stack

Follow the steps below to play!', NULL, N'Guessing and checking time is how kids learn what ''one minute'' really feels like.', 6, N'sequence_steps', N'{"steps": ["Guess how many blocks you can stack before time runs out.", "Start the timer and stack as fast (and carefully) as you can.", "Count your blocks when time is up.", "Compare your guess to your real result!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_1, N'short_response', N'🧦 Laundry Color Sort

Objective: Practice sorting clothes by color, an early organizing skill.

Materials: A pile of clean clothes (or clothing pictures) | 2 baskets

Follow the steps below to play!', NULL, N'Color-sorting laundry is a real chore your grown-ups will thank you for.', 7, N'sequence_steps', N'{"steps": ["Label one basket ''light colors'' and one ''dark colors.''", "Take turns picking up a clothing item.", "Decide which basket it belongs in.", "Sort the whole pile together!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_1, N'short_response', N'🪙 Save or Spend Jar

Objective: Practice deciding whether to save a coin or spend it on a small treat.

Materials: Pretend coins | 2 jars labeled ''save'' and ''spend''

Follow the steps below to play!', NULL, N'There''s no wrong answer — just practice noticing you always have a choice.', 8, N'sequence_steps', N'{"steps": ["Give the child several pretend coins one at a time.", "For each coin, decide: save it or spend it on a pretend treat.", "Drop the coin in the matching jar.", "Count how many ended up in each jar at the end."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_1, N'short_response', N'🧹 Chore Chart Sticker Hunt

Objective: Practice completing a simple set of chores and tracking them.

Materials: A paper chore chart with 3-4 simple pictures | Stickers

Follow the steps below to play!', NULL, N'Checking off finished tasks feels great — that''s why grown-ups do it too!', 9, N'sequence_steps', N'{"steps": ["Look at the chore chart together (make bed, feed pet, tidy shoes).", "Complete one chore at a time.", "Add a sticker next to each finished chore.", "Celebrate when the whole chart is full of stickers!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_1, N'short_response', N'🚦 Stranger at the Door Practice

Objective: Practice the safe response when someone unexpected knocks or calls.

Materials: None — just talk it through together

Follow the steps below to play!', NULL, N'Practicing the words ahead of time makes them easy to remember for real.', 10, N'sequence_steps', N'{"steps": ["A grown-up pretends to be a delivery person or unknown caller.", "The child practices saying ''I need to get a grown-up'' instead of answering alone.", "Switch roles and try it again.", "Talk about who the safe grown-ups to get are."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_1, N'short_response', N'📚 Bookshelf Order-Up

Objective: Practice organizing books by a simple rule like size or color.

Materials: 5-8 books

Follow the steps below to play!', NULL, N'Organizing by a rule is a skill that works for books, toys, and someday desks.', 11, N'sequence_steps', N'{"steps": ["Pick a rule together: biggest to smallest, or by color.", "Line the books up on a shelf or the floor following the rule.", "Check the order together.", "Try a new rule and reorganize!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_1, N'short_response', N'⏰ Bedtime Countdown

Objective: Practice following a short step-by-step countdown to bedtime.

Materials: None — just talk it through together | A clock if available

Follow the steps below to play!', NULL, N'Breaking bedtime into small steps makes the routine feel easy, not rushed.', 12, N'sequence_steps', N'{"steps": ["Name the 3 steps left before bed: pajamas, teeth, story.", "Do each step one at a time, checking it off out loud.", "Notice how much closer to bedtime you get after each step.", "Celebrate finishing all 3!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_1, N'short_response', N'🛍️ Grocery Picture List

Objective: Practice following a simple picture list while ''shopping'' at home.

Materials: A picture list of 4-5 pretend grocery items | Play food or household stand-ins

Follow the steps below to play!', NULL, N'Following a list is a real skill you''ll use at the grocery store for years.', 13, N'sequence_steps', N'{"steps": ["Look at the picture list together.", "Find or point to each item around the room.", "Check it off the list as you find it.", "See if you found everything on the list!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_1, N'short_response', N'🤝 Take Turns Trade

Objective: Practice fair trading and turn-taking with toys.

Materials: A few small toys or trinkets

Follow the steps below to play!', NULL, N'Fair trades are an early lesson in value that money math builds on later.', 14, N'sequence_steps', N'{"steps": ["Each player picks one toy to start with.", "Take turns offering a trade to a partner.", "Both players must agree before trading.", "Play a few rounds and talk about what made a trade feel fair."]}');

    DECLARE @cat_life_2 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (2, 'life_skills', N'Real-Life Skills Games', 'space_heavy', 7, N'Practice a real-world skill through a fun hands-on game!', 0);
    SET @cat_life_2 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_2, N'short_response', N'💰 Coin Combo Challenge

Objective: Practice combining different coin values to reach a target amount.

Materials: Pretend pennies, nickels, dimes (or paper cutouts) | A small tray

Follow the steps below to play!', NULL, N'There''s often more than one right way to make the same amount — just like in real life.', 1, N'sequence_steps', N'{"steps": ["Pick a target number, like 15 cents.", "Find different coin combinations that add up to the target.", "Try to find more than one way to make it.", "Check your combos with a partner."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_2, N'short_response', N'🛒 Set a Budget Shop

Objective: Practice staying within a set spending limit while choosing items.

Materials: Pretend coins totaling 20 | 5 toy items with price tags 3-10

Follow the steps below to play!', NULL, N'Checking the total before you pay is a habit that saves real money later.', 2, N'sequence_steps', N'{"steps": ["Give the shopper exactly 20 pretend coins.", "Browse the price tags and pick which items to buy.", "Add up the prices before paying to make sure you''re under 20.", "Pay and see how many coins you have left over."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_2, N'short_response', N'🗂️ Desk Organizer Dash

Objective: Practice sorting school supplies into labeled groups quickly.

Materials: A mixed pile of pencils, crayons, erasers, and paper clips | 3-4 small containers

Follow the steps below to play!', NULL, N'A tidy desk means less time hunting and more time for the fun stuff.', 3, N'sequence_steps', N'{"steps": ["Label each container (pencils, crayons, small stuff).", "Set a 2-minute timer.", "Race to sort the whole pile into the right containers.", "Check your work and fix any mix-ups."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_2, N'short_response', N'🕵️ Pop-Up Trap Spotter

Objective: Practice recognizing tricky online pop-ups and ads through drawn scenario cards, without using an actual device.

Materials: 4-5 drawn cards showing pretend pop-up scenes with flashy prizes or ''click now'' messages

Follow the steps below to play!', NULL, N'If something online feels too exciting or too urgent, that''s often a clue to slow down.', 4, N'sequence_steps', N'{"steps": ["Lay out the drawn pop-up cards.", "Talk about which details seem like a trick (too-good prizes, urgent countdowns).", "Sort the cards into ''ignore/close'' and ''tell a grown-up.''", "Discuss what makes something feel trustworthy versus tricky."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_2, N'short_response', N'🗓️ To-Do List Planner

Objective: Practice writing and checking off a short to-do list in a logical order.

Materials: Paper and pencil

Follow the steps below to play!', NULL, N'A written list means your brain doesn''t have to remember everything at once.', 5, N'sequence_steps', N'{"steps": ["Write down 4-5 things you need to do today.", "Number them in the order that makes the most sense.", "Cross off each task as you finish it.", "Look back at your list at the end of the day."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_2, N'short_response', N'⏳ Time Estimate Showdown

Objective: Practice estimating how long several tasks take and comparing to the real time.

Materials: A timer or clock | 3 simple tasks (build a small tower, draw a picture, tidy a shelf)

Follow the steps below to play!', NULL, N'Getting better at estimating time helps you plan your whole day more realistically.', 6, N'sequence_steps', N'{"steps": ["Guess how long each of the 3 tasks will take.", "Time yourself doing each one.", "Compare your guesses to the real times.", "See which task you guessed most accurately!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_2, N'short_response', N'🧦 Drawer Organization Race

Objective: Practice organizing a drawer or shelf by category against the clock.

Materials: A messy drawer or box of mixed items | Small dividers or containers

Follow the steps below to play!', NULL, N'A little organizing now saves a lot of searching time later.', 7, N'sequence_steps', N'{"steps": ["Dump the drawer''s contents out and group into categories.", "Set a timer for a few minutes.", "Put each category back into the drawer in its own section.", "Check that everything has a clear spot."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_2, N'short_response', N'🪙 Saving Goal Tracker

Objective: Practice tracking progress toward a small savings goal over several pretend weeks.

Materials: Pretend coins | Paper for a simple savings chart

Follow the steps below to play!', NULL, N'Watching your savings grow bit by bit makes reaching a goal feel exciting, not slow.', 8, N'sequence_steps', N'{"steps": ["Pick a fun small goal, like 30 coins for a pretend toy.", "Each ''week,'' add a few coins and mark the chart.", "Watch the chart fill up toward the goal.", "Celebrate when you reach it!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_2, N'short_response', N'🧹 Family Chore Auction

Objective: Practice choosing and committing to chores fairly among a group.

Materials: Paper strips listing 5-6 simple chores | Pretend coins as ''bids'' (optional)

Follow the steps below to play!', NULL, N'Choosing your own chore makes it feel less like a chore and more like a choice.', 9, N'sequence_steps', N'{"steps": ["Lay out the chore strips where everyone can see them.", "Take turns picking (or ''bidding'' pretend coins for) the chore you want.", "Make sure every chore gets picked by someone.", "Complete your chosen chore and check it off together."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_2, N'short_response', N'🚦 Stranger Message Sort

Objective: Practice sorting pretend messages into ''from someone I know'' and ''from someone unknown,'' a core online-safety skill.

Materials: 6-8 index cards each describing a short pretend message scenario

Follow the steps below to play!', NULL, N'Not answering messages from people you don''t know is always a safe first move.', 10, N'sequence_steps', N'{"steps": ["Write or draw 6-8 short message scenarios on cards.", "Read each one and decide: known sender or unknown sender.", "Sort into two piles.", "Talk about what to do with unknown-sender messages (tell a grown-up, don''t reply)."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_2, N'short_response', N'📚 Category Bookshelf Challenge

Objective: Practice sorting a mixed shelf into logical categories of your own choosing.

Materials: 8-10 books or labeled item cards

Follow the steps below to play!', NULL, N'There''s often more than one ''right'' way to organize — the goal is that YOU can find things fast.', 11, N'sequence_steps', N'{"steps": ["Look at all the items and think of 2-3 categories that fit them.", "Sort every item into a category.", "Explain your categories to a partner.", "Try re-sorting using different categories!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_2, N'short_response', N'⏰ Weekend Schedule Draft

Objective: Practice planning a balanced weekend with both chores and fun activities.

Materials: Paper and pencil, or a simple 2-day calendar grid

Follow the steps below to play!', NULL, N'Planning fun and responsibilities together helps neither one get forgotten.', 12, N'sequence_steps', N'{"steps": ["Draw two columns: Saturday and Sunday.", "Write in must-do items first (chores, homework).", "Fill in fun activities around them.", "Check that your weekend has a good balance of both."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_2, N'short_response', N'🛍️ Unit Price Comparison

Objective: Practice comparing which of two similar items gives more for the money.

Materials: 2-3 pairs of pretend items with different sizes and prices written on cards

Follow the steps below to play!', NULL, N'A bigger price doesn''t always mean a worse deal — comparing carefully matters.', 13, N'sequence_steps', N'{"steps": ["Look at two similar items — same thing, different size and price.", "Figure out which one seems like the better value.", "Explain your reasoning out loud.", "Try a few more pairs to practice."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_2, N'short_response', N'🤝 Chore Swap Negotiation

Objective: Practice respectfully negotiating a trade of responsibilities with another person.

Materials: Paper strips listing a few chores for two players

Follow the steps below to play!', NULL, N'Good negotiating means both people feel like the deal was fair.', 14, N'sequence_steps', N'{"steps": ["Each player lists 2-3 chores they''re responsible for.", "Talk about whether either player would like to swap a chore.", "Agree together on a fair swap (or agree not to swap).", "Complete your (possibly new) chore list."]}');

    DECLARE @cat_life_3 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (3, 'life_skills', N'Real-Life Skills Games', 'space_heavy', 7, N'Practice a real-world skill through a fun hands-on game!', 0);
    SET @cat_life_3 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_3, N'short_response', N'💰 Allowance Add-Up

Objective: Practice adding coins and small bills to total a weekly allowance.

Materials: Pretend coins and small bills | Paper and pencil

Follow the steps below to play!', NULL, N'Adding up your own money is the first step toward tracking it.', 1, N'sequence_steps', N'{"steps": ["Give the child a mixed pile of pretend money.", "Add it all up and write the total.", "Check the math together.", "Try a different mixed pile and total it again."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_3, N'short_response', N'🛒 Shopping List Budget

Objective: Practice planning purchases from a list while staying under a spending limit.

Materials: A written price list of 6-8 items | Pretend money totaling a set budget

Follow the steps below to play!', NULL, N'Planning your purchases before you shop helps your money go further.', 2, N'sequence_steps', N'{"steps": ["Look at the price list and decide what you want to buy.", "Add up your choices as you go.", "Stop adding items once you''re close to your budget.", "Check that your total doesn''t go over the limit."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_3, N'short_response', N'🗂️ Backpack Overhaul

Objective: Practice organizing a backpack or desk by category under a time limit.

Materials: A messy backpack or desk full of papers and supplies | A few folders or bins

Follow the steps below to play!', NULL, N'An organized backpack means less searching and more time for what matters.', 3, N'sequence_steps', N'{"steps": ["Dump everything out and sort into categories (papers, supplies, books).", "Set a timer for 3 minutes.", "Put each category back in an organized spot.", "Check if everything has a clear place."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_3, N'short_response', N'🕵️ Pop-Up Trap Spotter

Objective: Practice recognizing tricky online pop-ups and ads through drawn scenario cards, without using an actual device.

Materials: 4-5 drawn cards showing pretend pop-up scenes with flashy prizes or ''click now'' messages

Follow the steps below to play!', NULL, N'If something online feels too exciting or too urgent, that''s often a clue to slow down.', 4, N'sequence_steps', N'{"steps": ["Lay out the drawn pop-up cards.", "Talk about which details seem like a trick (too-good prizes, urgent countdowns).", "Sort the cards into ''ignore/close'' and ''tell a grown-up.''", "Discuss what makes something feel trustworthy versus tricky."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_3, N'short_response', N'🗓️ To-Do List Planner

Objective: Practice writing and checking off a short to-do list in a logical order.

Materials: Paper and pencil

Follow the steps below to play!', NULL, N'A written list means your brain doesn''t have to remember everything at once.', 5, N'sequence_steps', N'{"steps": ["Write down 4-5 things you need to do today.", "Number them in the order that makes the most sense.", "Cross off each task as you finish it.", "Look back at your list at the end of the day."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_3, N'short_response', N'⏳ Time Estimate Showdown

Objective: Practice estimating how long several tasks take and comparing to the real time.

Materials: A timer or clock | 3 simple tasks (build a small tower, draw a picture, tidy a shelf)

Follow the steps below to play!', NULL, N'Getting better at estimating time helps you plan your whole day more realistically.', 6, N'sequence_steps', N'{"steps": ["Guess how long each of the 3 tasks will take.", "Time yourself doing each one.", "Compare your guesses to the real times.", "See which task you guessed most accurately!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_3, N'short_response', N'🧦 Drawer Organization Race

Objective: Practice organizing a drawer or shelf by category against the clock.

Materials: A messy drawer or box of mixed items | Small dividers or containers

Follow the steps below to play!', NULL, N'A little organizing now saves a lot of searching time later.', 7, N'sequence_steps', N'{"steps": ["Dump the drawer''s contents out and group into categories.", "Set a timer for a few minutes.", "Put each category back into the drawer in its own section.", "Check that everything has a clear spot."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_3, N'short_response', N'🪙 Saving Goal Tracker

Objective: Practice tracking progress toward a small savings goal over several pretend weeks.

Materials: Pretend coins | Paper for a simple savings chart

Follow the steps below to play!', NULL, N'Watching your savings grow bit by bit makes reaching a goal feel exciting, not slow.', 8, N'sequence_steps', N'{"steps": ["Pick a fun small goal, like 30 coins for a pretend toy.", "Each ''week,'' add a few coins and mark the chart.", "Watch the chart fill up toward the goal.", "Celebrate when you reach it!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_3, N'short_response', N'🧹 Family Chore Auction

Objective: Practice choosing and committing to chores fairly among a group.

Materials: Paper strips listing 5-6 simple chores | Pretend coins as ''bids'' (optional)

Follow the steps below to play!', NULL, N'Choosing your own chore makes it feel less like a chore and more like a choice.', 9, N'sequence_steps', N'{"steps": ["Lay out the chore strips where everyone can see them.", "Take turns picking (or ''bidding'' pretend coins for) the chore you want.", "Make sure every chore gets picked by someone.", "Complete your chosen chore and check it off together."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_3, N'short_response', N'🚦 Stranger Message Sort

Objective: Practice sorting pretend messages into ''from someone I know'' and ''from someone unknown,'' a core online-safety skill.

Materials: 6-8 index cards each describing a short pretend message scenario

Follow the steps below to play!', NULL, N'Not answering messages from people you don''t know is always a safe first move.', 10, N'sequence_steps', N'{"steps": ["Write or draw 6-8 short message scenarios on cards.", "Read each one and decide: known sender or unknown sender.", "Sort into two piles.", "Talk about what to do with unknown-sender messages (tell a grown-up, don''t reply)."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_3, N'short_response', N'📚 Category Bookshelf Challenge

Objective: Practice sorting a mixed shelf into logical categories of your own choosing.

Materials: 8-10 books or labeled item cards

Follow the steps below to play!', NULL, N'There''s often more than one ''right'' way to organize — the goal is that YOU can find things fast.', 11, N'sequence_steps', N'{"steps": ["Look at all the items and think of 2-3 categories that fit them.", "Sort every item into a category.", "Explain your categories to a partner.", "Try re-sorting using different categories!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_3, N'short_response', N'⏰ Weekend Schedule Draft

Objective: Practice planning a balanced weekend with both chores and fun activities.

Materials: Paper and pencil, or a simple 2-day calendar grid

Follow the steps below to play!', NULL, N'Planning fun and responsibilities together helps neither one get forgotten.', 12, N'sequence_steps', N'{"steps": ["Draw two columns: Saturday and Sunday.", "Write in must-do items first (chores, homework).", "Fill in fun activities around them.", "Check that your weekend has a good balance of both."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_3, N'short_response', N'🛍️ Unit Price Comparison

Objective: Practice comparing which of two similar items gives more for the money.

Materials: 2-3 pairs of pretend items with different sizes and prices written on cards

Follow the steps below to play!', NULL, N'A bigger price doesn''t always mean a worse deal — comparing carefully matters.', 13, N'sequence_steps', N'{"steps": ["Look at two similar items — same thing, different size and price.", "Figure out which one seems like the better value.", "Explain your reasoning out loud.", "Try a few more pairs to practice."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_3, N'short_response', N'🤝 Chore Swap Negotiation

Objective: Practice respectfully negotiating a trade of responsibilities with another person.

Materials: Paper strips listing a few chores for two players

Follow the steps below to play!', NULL, N'Good negotiating means both people feel like the deal was fair.', 14, N'sequence_steps', N'{"steps": ["Each player lists 2-3 chores they''re responsible for.", "Talk about whether either player would like to swap a chore.", "Agree together on a fair swap (or agree not to swap).", "Complete your (possibly new) chore list."]}');

    DECLARE @cat_life_4 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (4, 'life_skills', N'Real-Life Skills Games', 'space_heavy', 7, N'Practice a real-world skill through a fun hands-on game!', 0);
    SET @cat_life_4 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_4, N'short_response', N'💰 Budget the Ten Dollars

Objective: Practice dividing a small budget across needs, wants, and savings.

Materials: Pretend $10 in bills | Paper divided into ''needs,'' ''wants,'' ''savings''

Follow the steps below to play!', NULL, N'Deciding how to split money before you spend it is real budgeting in action.', 1, N'sequence_steps', N'{"steps": ["Look at your $10 and the three categories.", "Decide how much to put toward each category.", "Write your amounts down and make sure they add up to $10.", "Explain why you split it that way."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_4, N'short_response', N'🛒 Grocery Budget Challenge

Objective: Practice planning a grocery list that stays within a set budget while covering different needs.

Materials: A price list of 10-12 pretend grocery items | A set budget amount

Follow the steps below to play!', NULL, N'Real grocery budgeting means balancing what you want with what you actually need.', 2, N'sequence_steps', N'{"steps": ["Look at the price list and think about what a family might need.", "Pick items that add up to your budget or less.", "Make sure your list covers a few different food groups.", "Compare your list with a partner''s — did you both stay in budget?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_4, N'short_response', N'🗂️ Junk Drawer Sprint

Objective: Practice organizing a chaotic mixed drawer into clear categories under time pressure.

Materials: A pile of mixed small household items | 4-5 small containers

Follow the steps below to play!', NULL, N'Even the messiest drawer becomes manageable once you group things by type.', 3, N'sequence_steps', N'{"steps": ["Dump the mixed pile out and look it over.", "Decide on 4-5 categories that make sense.", "Set a 3-minute timer and sort everything into its category.", "Check your work — does everything have an obvious home?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_4, N'short_response', N'🕵️ Personal Info Detective

Objective: Practice identifying which details are safe to share online and which are private, through scenario cards.

Materials: 6-8 scenario cards listing different pieces of information (favorite color, home address, pet''s name, school name)

Follow the steps below to play!', NULL, N'A good rule of thumb: if it could help a stranger find you in real life, keep it private.', 4, N'sequence_steps', N'{"steps": ["Read each scenario card out loud.", "Decide: safe to share publicly, or private/ask a grown-up first.", "Sort into two piles.", "Discuss why some details (address, school, full name) are more sensitive than others."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_4, N'short_response', N'🗓️ Weekend Time-Block Planner

Objective: Practice planning a weekend using time blocks instead of just a list.

Materials: Paper with a simple hourly grid for Saturday | Pencil

Follow the steps below to play!', NULL, N'Blocking out time (not just listing tasks) is how many grown-ups plan their busiest days.', 5, N'sequence_steps', N'{"steps": ["Draw a grid with rough time blocks (morning, midday, afternoon, evening).", "Fill in an activity or chore for each block.", "Leave at least one block open for free time.", "Review your plan — does it feel realistic?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_4, N'short_response', N'⏳ Password Strength Sort

Objective: Practice recognizing what makes a password strong versus easy to guess, through card sorting (no device needed).

Materials: 8-10 cards each with a made-up example password written on it

Follow the steps below to play!', NULL, N'A strong password mixes letters, numbers, and symbols — and is never something easy to guess.', 6, N'sequence_steps', N'{"steps": ["Write several example passwords on cards, some weak (like ''1234'') and some stronger.", "Sort the cards from weakest to strongest.", "Talk about what makes the stronger ones harder to guess.", "Try writing a new strong example together."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_4, N'short_response', N'🧦 Closet Category Challenge

Objective: Practice organizing clothing by multiple categories (type and season) under time pressure.

Materials: A mixed pile of clothing (or clothing picture cards) | Labeled sections or bins

Follow the steps below to play!', NULL, N'Sorting by more than one rule at once is a great brain workout — and a real organizing skill.', 7, N'sequence_steps', N'{"steps": ["Decide on 2 sorting rules together, like type and season.", "Set a timer and sort the pile using both rules.", "Check that everything landed in a sensible spot.", "Talk about which rule was trickier to apply."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_4, N'short_response', N'🪙 Save For a Goal Simulation

Objective: Practice planning several weeks of saving toward a specific price goal.

Materials: Pretend money | Paper for a multi-week savings tracker

Follow the steps below to play!', NULL, N'Big goals become easy to reach once you break them into small weekly steps.', 8, N'sequence_steps', N'{"steps": ["Pick a goal item and its price (like a $25 toy).", "Decide a realistic amount to save each pretend week.", "Fill in the tracker week by week until you reach the goal.", "Talk about what you''d do if you got extra money one week — save more or the same?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_4, N'short_response', N'🧹 Chore Rotation Wheel

Objective: Practice planning a fair rotating chore schedule for a group.

Materials: Paper and pencil, or a simple hand-drawn spinner

Follow the steps below to play!', NULL, N'A rotation means nobody gets stuck with the same chore forever.', 9, N'sequence_steps', N'{"steps": ["List everyone in your household or group.", "List the chores that need doing each week.", "Assign chores so each person gets a fair, rotating turn.", "Write out next week''s rotation so everyone knows what''s coming."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_4, N'short_response', N'🚦 Online Kindness or Not

Objective: Practice recognizing kind versus unkind online comments through scenario cards, and choosing a safe, kind response.

Materials: 6-8 cards with short example comments written on them

Follow the steps below to play!', NULL, N'The same kindness rules from real life apply online too — always.', 10, N'sequence_steps', N'{"steps": ["Write a mix of kind and unkind example comments on cards.", "Read each one and decide: kind, unkind, or unsure.", "For unkind ones, talk about a safe response (don''t reply, tell a grown-up).", "Discuss why kindness matters just as much online as in person."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_4, N'short_response', N'📚 File Folder System

Objective: Practice creating a simple filing system for papers by subject or type.

Materials: A stack of mixed papers (or paper stand-ins) | 3-4 folders

Follow the steps below to play!', NULL, N'A simple filing system means important papers are never lost in a pile again.', 11, N'sequence_steps', N'{"steps": ["Label each folder with a category (school, art, important, other).", "Sort the stack of papers into the correct folders.", "Stack the folders neatly in order of importance.", "Explain your system to someone else."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_4, N'short_response', N'⏰ Homework Time Estimate

Objective: Practice estimating and tracking time spent on different types of homework tasks.

Materials: A timer or clock | Paper for tracking | Actual or pretend homework tasks

Follow the steps below to play!', NULL, N'Knowing which tasks take longer helps you plan your homework time better.', 12, N'sequence_steps', N'{"steps": ["List 2-3 homework-style tasks and guess how long each will take.", "Time yourself completing each one.", "Compare your guesses to the real times.", "Talk about which subject tends to take longer than expected."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_4, N'short_response', N'🛍️ Comparison Shopping Trip

Objective: Practice comparing prices and features across similar products to find the smartest buy.

Materials: 3-4 pretend product cards with different prices and features

Follow the steps below to play!', NULL, N'The cheapest option isn''t always the smartest — think about what you''re really getting.', 13, N'sequence_steps', N'{"steps": ["Look over 3-4 similar pretend products with different prices.", "List one pro and one con for each option.", "Decide which one is the smartest buy and explain why.", "Try a new set of products and compare again."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_4, N'short_response', N'🗺️ Plan the Class Trip Budget

Objective: Practice budgeting for a group activity with several cost categories.

Materials: Paper and pencil | A pretend total budget | A list of cost categories (transport, food, activity)

Follow the steps below to play!', NULL, N'Planning a group budget means balancing everyone''s needs against a fixed amount.', 14, N'sequence_steps', N'{"steps": ["Look at your total pretend budget and the cost categories.", "Decide how much to spend in each category.", "Add everything up and check it matches your total budget.", "Adjust one category if you go over!"]}');

    DECLARE @cat_life_5 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (5, 'life_skills', N'Real-Life Skills Games', 'space_heavy', 7, N'Practice a real-world skill through a fun hands-on game!', 0);
    SET @cat_life_5 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_5, N'short_response', N'💰 Needs vs Wants Sort

Objective: Practice distinguishing needs from wants while planning a budget.

Materials: 10-12 item cards (some needs like shoes, some wants like a video game) | Paper

Follow the steps below to play!', NULL, N'Knowing the difference between needs and wants is the foundation of every good budget.', 1, N'sequence_steps', N'{"steps": ["Read each item card and decide: need or want.", "Sort the cards into two piles.", "Talk about items that felt tricky to decide.", "Rank the want-pile items by how much you''d want to save for them."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_5, N'short_response', N'🛒 Savings Goal Trade-Off

Objective: Practice choosing between saving for a big goal versus spending on smaller things now.

Materials: Pretend money | Cards listing one big goal item and several small treat items

Follow the steps below to play!', NULL, N'Every spending choice is really a choice about what you''re saying no to.', 2, N'sequence_steps', N'{"steps": ["Look at the big goal''s price and the small treats'' prices.", "Decide: buy small treats now, or skip them to save for the big goal faster?", "Simulate a few pretend weeks of choices.", "Reflect on how your choices affected your progress toward the goal."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_5, N'short_response', N'🗂️ Study Space Setup Challenge

Objective: Practice designing and organizing a study space system that would actually help you focus.

Materials: A table or desk area | Various supplies to arrange | Paper for a ''system'' sketch

Follow the steps below to play!', NULL, N'A study space that''s organized before you sit down helps you actually get started faster.', 3, N'sequence_steps', N'{"steps": ["Look at your available supplies and space.", "Decide where each type of item should live for easy access.", "Set it up and sketch a simple map of your system.", "Test it: can you find everything within 10 seconds?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_5, N'short_response', N'🕵️ Cyberbullying Bystander Role-Play

Objective: Practice deciding how to respond kindly and safely when witnessing unkind online behavior, through role-play.

Materials: None — just talk it through together, or simple scenario cards

Follow the steps below to play!', NULL, N'Standing up for someone online takes courage — and it makes a real difference.', 4, N'sequence_steps', N'{"steps": ["One person describes a scenario: someone is being teased in a group chat.", "Talk through the options: join in, ignore, or support the person being teased.", "Role-play saying something kind and supportive, or the choice to tell a grown-up.", "Discuss why being a supportive bystander matters."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_5, N'short_response', N'🗓️ Multi-Day Project Planner

Objective: Practice breaking a project into steps spread across several days before a deadline.

Materials: Paper and pencil | A pretend project with a due date 5 days away

Follow the steps below to play!', NULL, N'Big projects feel much less overwhelming once they''re broken into daily steps.', 5, N'sequence_steps', N'{"steps": ["Write down the project''s final deadline.", "List all the smaller steps needed to finish it.", "Spread the steps across the days leading up to the deadline.", "Check your plan leaves room for the unexpected."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_5, N'short_response', N'⏳ Priority Trade-Off Game

Objective: Practice choosing which of several tasks to do first when time is limited.

Materials: Cards listing 5-6 tasks with different time lengths | A fixed total time budget

Follow the steps below to play!', NULL, N'When time is short, deciding what matters most is a skill just like budgeting money.', 6, N'sequence_steps', N'{"steps": ["Look at your total available time and the list of tasks.", "Decide which tasks fit and in what order.", "Explain why you prioritized the way you did.", "Try a new time budget and see if your choices change."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_5, N'short_response', N'🧦 Family Closet Reorganize

Objective: Practice designing and executing an organization system for a shared space.

Materials: A mixed pile of clothing (or picture cards) | Several bins or sections

Follow the steps below to play!', NULL, N'A system that''s easy to explain to someone else is usually a system that will actually last.', 7, N'sequence_steps', N'{"steps": ["Discuss what organizing rule would work best for a shared space (by person, by type, by season).", "Sort the whole pile using your chosen rule.", "Label each section clearly.", "Explain your system so someone else could keep it up."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_5, N'short_response', N'🪙 Comparison Savings Rate

Objective: Practice comparing how choices about spending now change how fast a savings goal is reached.

Materials: Pretend money | Paper for two savings trackers

Follow the steps below to play!', NULL, N'Saving a little more now can mean reaching your goal a lot sooner.', 8, N'sequence_steps', N'{"steps": ["Pick a savings goal and its price.", "Try Plan A: save a small amount weekly and see how many weeks it takes.", "Try Plan B: save a bigger amount and compare how much faster it goes.", "Talk about the trade-off between spending now and saving faster."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_5, N'short_response', N'🧹 Chore Negotiation Meeting

Objective: Practice a respectful family-meeting-style negotiation over chore responsibilities.

Materials: Paper listing current chores and who does them

Follow the steps below to play!', NULL, N'Talking things through calmly usually gets a fairer result than just complaining.', 9, N'sequence_steps', N'{"steps": ["List all household chores and who currently does each one.", "Take turns sharing if any chore feels unfair or too much.", "Discuss and agree on any changes as a group.", "Write the new agreement down so everyone remembers it."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_5, N'short_response', N'🚦 Screen Time Balance Dilemma

Objective: Practice weighing the trade-offs of screen time against other priorities through discussion scenarios.

Materials: None — just talk it through together, or a few written dilemma cards

Follow the steps below to play!', NULL, N'Balance isn''t about never having fun — it''s about making sure everything important gets its turn.', 10, N'sequence_steps', N'{"steps": ["Read a dilemma out loud, like ''You have homework and a favorite show is on.''", "Talk through what each choice would mean for tomorrow.", "Decide together what a balanced choice looks like.", "Try a few more dilemmas with different priorities."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_5, N'short_response', N'📚 Digital Footprint Discussion

Objective: Practice understanding that things posted online can last and be seen by others, through a screen-free discussion game.

Materials: None — just talk it through together, or index cards with example posts written out

Follow the steps below to play!', NULL, N'Thinking ahead about who might see something later is a smart digital habit for life.', 11, N'sequence_steps', N'{"steps": ["Read an example pretend post out loud (drawn on a card, not a real device).", "Discuss: who might see this now, and who might see it years from now?", "Decide if it''s something you''d want out there long-term.", "Talk about the ''would I be okay with grandma seeing this?'' test."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_5, N'short_response', N'⏰ Weekly Time Audit

Objective: Practice tracking how time is actually spent across a week and reflecting on the balance.

Materials: Paper with a simple 7-day grid | Pencil

Follow the steps below to play!', NULL, N'Seeing where your time actually goes is the first step to using it more the way you want.', 12, N'sequence_steps', N'{"steps": ["Estimate how many hours go to school, homework, chores, fun, and sleep each day.", "Fill in your best guesses across the week.", "Add up each category''s weekly total.", "Reflect: does the balance match what you''d want it to be?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_5, N'short_response', N'🛍️ Sales and Discount Math

Objective: Practice calculating a discounted price to compare real savings.

Materials: 3-4 pretend price tags with a percent-off sale written on them | Paper for math

Follow the steps below to play!', NULL, N'A big discount percentage doesn''t always mean the biggest real savings — the math matters.', 13, N'sequence_steps', N'{"steps": ["Look at an item''s original price and its discount percentage.", "Calculate the sale price (estimates are fine).", "Compare a few different discounted items to find the best real savings.", "Check your math with a partner."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_5, N'short_response', N'🤝 Family Budget Meeting Role-Play

Objective: Practice participating respectfully in a simple family discussion about spending priorities.

Materials: Paper listing a pretend family budget and a few spending requests

Follow the steps below to play!', NULL, N'Being part of a budget conversation helps you understand choices grown-ups make every day.', 14, N'sequence_steps', N'{"steps": ["Look at the pretend family''s total budget together.", "Take turns presenting a spending request and why it matters.", "Discuss as a group which requests fit the budget this ''month.''", "Agree together on a final plan."]}');

    DECLARE @cat_life_6 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (6, 'life_skills', N'Real-Life Skills Games', 'space_heavy', 7, N'Practice a real-world skill through a fun hands-on game!', 0);
    SET @cat_life_6 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_6, N'short_response', N'💰 Monthly Budget Simulation

Objective: Practice allocating a pretend monthly income across several expense categories.

Materials: Pretend money representing a monthly income | Paper divided into categories (housing, food, fun, savings)

Follow the steps below to play!', NULL, N'Every real budget is a series of trade-offs — practicing them now makes the real thing easier later.', 1, N'sequence_steps', N'{"steps": ["Start with a set pretend monthly income.", "Decide how much goes into each category, making sure it all adds up.", "Write your budget plan down.", "Reflect: which category was hardest to decide on, and why?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_6, N'short_response', N'🛒 Unexpected Expense Curveball

Objective: Practice adjusting a budget when an unplanned cost comes up.

Materials: A completed pretend monthly budget (or a new simple one) | A card describing a surprise expense

Follow the steps below to play!', NULL, N'Real budgets need flexibility — leaving a little room for surprises is smart planning.', 2, N'sequence_steps', N'{"steps": ["Start with your planned budget.", "Draw a surprise expense card (like ''bike tire needs replacing'').", "Decide which category to pull money from to cover it.", "Reflect on how it felt to adjust your plan."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_6, N'short_response', N'🗂️ Filing System Overhaul

Objective: Practice designing a multi-level organization system for a large mixed collection.

Materials: A large mixed pile of papers or items | Several folders or bins | Labels

Follow the steps below to play!', NULL, N'Big organizing jobs go faster when you sort broad-to-narrow instead of all at once.', 3, N'sequence_steps', N'{"steps": ["Sort the pile into a few broad categories first.", "Within each category, sort into smaller subcategories.", "Label everything clearly at both levels.", "Test your system by asking someone to find one specific item fast."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_6, N'short_response', N'🕵️ Digital Citizenship Dilemma Cards

Objective: Practice discussing and deciding responses to realistic digital citizenship dilemmas.

Materials: 6-8 written dilemma cards (e.g., ''a friend shares a mean post about someone else'')

Follow the steps below to play!', NULL, N'Thinking through dilemmas ahead of time makes it easier to choose well in the real moment.', 4, N'sequence_steps', N'{"steps": ["Draw a dilemma card and read it aloud.", "Discuss a few possible responses and their consequences.", "Choose the response that feels most responsible and kind.", "Talk about what you''d say to a friend who wasn''t sure what to do."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_6, N'short_response', N'🗓️ Deadline Juggling Simulation

Objective: Practice planning around multiple deadlines that overlap in the same week.

Materials: Paper and pencil | Cards listing 3-4 pretend assignments with different due dates

Follow the steps below to play!', NULL, N'Planning backward from a deadline is one of the most useful time-management tricks there is.', 5, N'sequence_steps', N'{"steps": ["Lay out all your pretend deadlines for the week.", "Estimate how much time each task will realistically take.", "Build a day-by-day plan that finishes everything on time.", "Reflect: what would you do differently if a new task got added?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_6, N'short_response', N'⏳ Time vs Priority Reflection

Objective: Practice reflecting on whether time spent actually matched personal priorities.

Materials: Paper and pencil | A completed weekly time log, if available

Follow the steps below to play!', NULL, N'Noticing a gap between priorities and actual time is the first step to closing it.', 6, N'sequence_steps', N'{"steps": ["List your top 3 personal priorities right now (school, sports, family, etc.).", "Estimate how much time last week actually went to each one.", "Compare the numbers honestly.", "Reflect and discuss: what''s one small change that would better match your time to your priorities?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_6, N'short_response', N'🧦 Move-In Organization Challenge

Objective: Practice organizing a large set of belongings into a new space efficiently.

Materials: A mixed pile of belongings (or picture cards) | Several bins or shelves representing ''rooms''

Follow the steps below to play!', NULL, N'Thinking through an organization plan before you start saves a lot of re-sorting later.', 7, N'sequence_steps', N'{"steps": ["Sort belongings by which ''room'' they''d go in.", "Within each room group, decide a logical placement order.", "Set everything up and check that similar items are grouped together.", "Reflect: what would you organize differently next time?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_6, N'short_response', N'🪙 Compound Savings Story

Objective: Practice understanding how consistent small savings add up significantly over pretend time.

Materials: Pretend money | Paper for a multi-month savings tracker

Follow the steps below to play!', NULL, N'Small consistent savings really do add up — that''s one of the most powerful ideas in personal finance.', 8, N'sequence_steps', N'{"steps": ["Pick a small consistent weekly savings amount.", "Track it growing week by week across several pretend months.", "Notice how the total grows faster the longer you keep going.", "Reflect: what''s a real goal this kind of saving could help you reach?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_6, N'short_response', N'🧹 Household Systems Design

Objective: Practice designing a full chore and organization system for a household as a small project.

Materials: Paper and pencil | A list of household members and typical chores

Follow the steps below to play!', NULL, N'A well-designed system means chores get done without anyone having to nag.', 9, N'sequence_steps', N'{"steps": ["List all regular household chores and how often each needs doing.", "Design a fair rotation or assignment system for the group.", "Write clear, simple instructions for each chore.", "Present your system and get feedback from the group."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_6, N'short_response', N'🚦 Online Reputation Discussion

Objective: Practice discussing how online behavior can shape how others see you over time.

Materials: None — just talk it through together, or written example-post cards

Follow the steps below to play!', NULL, N'What you put online becomes part of your story — it''s worth choosing it thoughtfully.', 10, N'sequence_steps', N'{"steps": ["Read a few example pretend posts or comments.", "Discuss what impression each one might give someone reading it later.", "Talk about the difference between a private feeling and a public post.", "Reflect: what''s one habit that keeps an online reputation positive?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_6, N'short_response', N'📚 Categorize and Cross-Reference

Objective: Practice organizing information so it can be found more than one way.

Materials: 10-12 item or topic cards | Paper for a simple index

Follow the steps below to play!', NULL, N'The best organization systems make sense to someone besides just you.', 11, N'sequence_steps', N'{"steps": ["Sort the cards into main categories.", "Notice items that could fit more than one category.", "Create a simple index or key showing where each item is filed.", "Test it: can a partner find an item using your index?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_6, N'short_response', N'⏰ Extracurricular Balance Scenario

Objective: Practice weighing time commitments across multiple activities and reflecting on balance.

Materials: Paper and pencil | Cards listing 4-5 pretend activities with weekly time commitments

Follow the steps below to play!', NULL, N'Saying no to one good thing sometimes makes room for another good thing to actually get your full attention.', 12, N'sequence_steps', N'{"steps": ["Look at your pretend activities and their weekly time costs.", "Add up the total time and compare it to a realistic weekly limit.", "Decide which activities to keep, adjust, or set aside.", "Reflect: how did you decide what to prioritize?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_6, N'short_response', N'🛍️ Subscription Trap Spotter

Objective: Practice recognizing how small recurring costs add up over time, using pretend subscription cards.

Materials: 4-5 cards listing pretend small monthly costs

Follow the steps below to play!', NULL, N'Small recurring costs can quietly add up to a big number over a year — worth checking in on regularly.', 13, N'sequence_steps', N'{"steps": ["Look at each pretend monthly cost card.", "Calculate what each one adds up to over a full year.", "Add all the yearly totals together.", "Reflect: were you surprised by the total? What would you do with that money instead?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_6, N'short_response', N'🤝 Big Purchase Planning Meeting

Objective: Practice planning and presenting a savings plan for a bigger personal goal.

Materials: Paper and pencil | A pretend big-goal item with a price

Follow the steps below to play!', NULL, N'A goal with a real plan behind it is far more likely to actually happen.', 14, N'sequence_steps', N'{"steps": ["Pick a bigger pretend goal item and find its price.", "Plan out a realistic weekly or monthly savings amount to reach it.", "Write out a full timeline to the goal.", "Present your plan to a partner and explain your reasoning."]}');

    DECLARE @cat_life_7 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (7, 'life_skills', N'Real-Life Skills Games', 'space_heavy', 7, N'Practice a real-world skill through a fun hands-on game!', 0);
    SET @cat_life_7 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_7, N'short_response', N'💰 Paycheck to Budget Simulation

Objective: Practice building a full monthly budget from a pretend paycheck, covering fixed and variable expenses.

Materials: Pretend money representing a monthly paycheck | Paper listing fixed costs (rent, bills) and variable costs (food, fun)

Follow the steps below to play!', NULL, N'Paying fixed costs first, then deciding on the rest, is how many real budgets are built.', 1, N'sequence_steps', N'{"steps": ["Start with your pretend monthly paycheck total.", "Subtract fixed costs first, since those don''t change.", "Divide what''s left between variable costs and savings.", "Reflect: what would you cut first if the paycheck were smaller?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_7, N'short_response', N'🛒 Emergency Fund Scenario

Objective: Practice understanding why setting aside savings for emergencies matters, through a decision simulation.

Materials: Pretend money | A card describing an unexpected emergency cost

Follow the steps below to play!', NULL, N'An emergency fund exists so a surprise cost doesn''t have to become a crisis.', 2, N'sequence_steps', N'{"steps": ["Start with a pretend budget that includes a small emergency fund.", "Draw an emergency card (like ''a bike needs a big repair'').", "Decide: cover it from the emergency fund, or scramble to find money elsewhere?", "Reflect on which felt less stressful and why."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_7, N'short_response', N'🗂️ Moving Day Packing Challenge

Objective: Practice labeling and organizing belongings efficiently under a time limit, simulating a move.

Materials: A pile of mixed items (or picture cards) | Boxes or bins | Labels or markers

Follow the steps below to play!', NULL, N'Clear labeling now always saves confusion (and time) later.', 3, N'sequence_steps', N'{"steps": ["Sort items into logical box groups (kitchen, books, clothes).", "Label each box clearly with its contents and destination room.", "Set a timer and pack as efficiently as possible.", "Reflect: what would you label differently to make unpacking easier?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_7, N'short_response', N'🕵️ Digital Footprint Deep Dive

Objective: Practice reflecting on how an online presence builds up over years and what that might mean later in life.

Materials: None — just talk it through together, or written example scenario cards

Follow the steps below to play!', NULL, N'The habits you build online now are the same ones that will follow you for years.', 4, N'sequence_steps', N'{"steps": ["Discuss a scenario: a college or employer looks someone up online someday.", "Talk through what kinds of posts would leave a good impression versus a concerning one.", "Come up with 3 personal ''digital habits'' worth keeping.", "Reflect: which habit do you think matters most, and why?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_7, N'short_response', N'🗓️ Group Project Dependency Planner

Objective: Practice scheduling a group project where some tasks depend on others being finished first.

Materials: Paper and pencil | Cards listing 5-6 pretend project tasks, some dependent on others

Follow the steps below to play!', NULL, N'In group projects, one delayed task can delay everything after it — planning for that in advance really helps.', 5, N'sequence_steps', N'{"steps": ["Lay out all the tasks and note which ones must happen before others can start.", "Build a schedule that respects those dependencies.", "Assign rough time estimates and a final deadline.", "Reflect: what happens to the whole plan if one early task runs late?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_7, N'short_response', N'⏳ Extracurricular Juggling Reflection

Objective: Practice mapping and honestly evaluating a full schedule of commitments for sustainability.

Materials: Paper and pencil | A list of current or pretend weekly commitments with time estimates

Follow the steps below to play!', NULL, N'A schedule that looks fine on paper can still feel overwhelming — checking in with yourself matters too.', 6, N'sequence_steps', N'{"steps": ["List every regular commitment and its weekly time cost.", "Add up the total and compare it to available free hours in a week.", "Identify anything that feels like too much, or room for more.", "Reflect: is your current balance actually working for you?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_7, N'short_response', N'🧦 Full Closet System Redesign

Objective: Practice designing and justifying a complete, sustainable organization system for a personal space.

Materials: A mixed pile of belongings (or picture cards) | Bins or sections | Labels

Follow the steps below to play!', NULL, N'The best system isn''t the fanciest one — it''s the one you''ll actually keep using.', 7, N'sequence_steps', N'{"steps": ["Assess what''s currently disorganized and why.", "Design a system with clear categories and an easy-to-maintain routine.", "Set it up and write a short ''how to keep this working'' note.", "Reflect: what''s the biggest reason organization systems usually fail, and how does yours avoid it?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_7, N'short_response', N'🪙 Cost Comparison Over Time

Objective: Practice comparing the true long-term cost of different spending choices.

Materials: 2-3 cards describing pretend purchase options with different upfront and ongoing costs

Follow the steps below to play!', NULL, N'Looking at total cost over time, not just the price tag today, leads to smarter decisions.', 8, N'sequence_steps', N'{"steps": ["Compare a cheaper option with ongoing costs versus a pricier one-time option.", "Calculate the total cost of each over a full year (or more).", "Decide which is actually the better long-term value.", "Reflect: does the ''cheaper'' choice always win?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_7, N'short_response', N'🧹 Household CEO Challenge

Objective: Practice designing and delegating a full household organization and chore system as a leadership exercise.

Materials: Paper and pencil | A list of all household chores and members

Follow the steps below to play!', NULL, N'Good leadership means designing systems that make life easier for everyone, not just yourself.', 9, N'sequence_steps', N'{"steps": ["Take on the role of ''household CEO'' for this game.", "Design a full chore schedule, considering everyone''s fairness and strengths.", "Write clear instructions and a simple way to track completion.", "Present your plan and explain your reasoning for each decision."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_7, N'short_response', N'🚦 Online Dilemma Debate

Objective: Practice defending a reasoned position on a digital citizenship dilemma through respectful discussion.

Materials: 4-5 written dilemma cards with no clear single right answer

Follow the steps below to play!', NULL, N'The most complex digital dilemmas rarely have one perfect answer — reasoning through them is the real skill.', 10, N'sequence_steps', N'{"steps": ["Draw a dilemma card with a genuinely tricky digital scenario.", "Take a position and explain your reasoning.", "Have a partner argue a different view, respectfully.", "Reflect together on what a thoughtful person might actually do."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_7, N'short_response', N'📚 Master Index System

Objective: Practice building a comprehensive, multi-level organization and reference system for a large set of information.

Materials: 15+ item or topic cards | Paper for a detailed index

Follow the steps below to play!', NULL, N'A well-built index turns a big pile of information into something anyone could navigate.', 11, N'sequence_steps', N'{"steps": ["Sort all items into main categories and subcategories.", "Build a written index showing exactly where to find each item.", "Test the system with a partner using only the index.", "Reflect: what made the system fast (or slow) to use?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_7, N'short_response', N'⏰ Time-Money Trade-Off Debate

Objective: Practice reasoning through scenarios where time and money decisions are linked.

Materials: 3-4 scenario cards describing a choice between spending more time or more money for the same result

Follow the steps below to play!', NULL, N'Time and money are both limited resources — recognizing when you''re trading one for the other is a grown-up skill.', 12, N'sequence_steps', N'{"steps": ["Read a scenario, like ''pay for a faster option or spend extra time doing it yourself.''", "Discuss the trade-offs of each choice.", "Decide which you''d choose and explain your reasoning.", "Try a few more scenarios and see if your reasoning changes."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_7, N'short_response', N'🛍️ Subscription Audit Project

Objective: Practice auditing a set of recurring pretend costs and deciding what''s actually worth keeping.

Materials: 6-8 cards listing pretend recurring subscriptions with monthly costs and how often they''re ''used''

Follow the steps below to play!', NULL, N'Regularly auditing recurring costs is one of the simplest ways to find extra money in a budget.', 13, N'sequence_steps', N'{"steps": ["Review each subscription''s cost and how much value it seems to provide.", "Decide which to keep, cancel, or downgrade.", "Calculate the total yearly savings from your decisions.", "Reflect: how would you decide if something is really worth the recurring cost?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_life_7, N'short_response', N'🤝 Big Goal Investment Plan

Objective: Practice building and presenting a full multi-month plan to reach an ambitious savings goal.

Materials: Paper and pencil | A pretend big-goal item with a price | Calculator (optional)

Follow the steps below to play!', NULL, N'A clear plan turns ''I want that someday'' into ''here''s exactly how I''ll get it.''', 14, N'sequence_steps', N'{"steps": ["Pick an ambitious pretend goal and its total price.", "Plan a realistic monthly savings amount and calculate the full timeline.", "Identify one way you could reach the goal faster (extra saving, or a smaller starting goal).", "Present your full plan, including your reasoning, to a partner."]}');

END
GO

DELETE FROM dbo.WeeklyPacketPlan;
GO