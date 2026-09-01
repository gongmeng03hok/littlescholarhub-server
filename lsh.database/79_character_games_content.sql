-- 79_character_games_content.sql
-- Adds a 'Character Building Games' category to the existing always-on
-- 'character' subject_area for every grade (TK-6th) — no schema or proc
-- changes needed, reuses dbo.PacketSubjectAreas/usp_GetOrCreateWeeklyPacket
-- exactly as-is.
--
-- Each grade gets a pool of 14 games spanning the subject_area's existing
-- themes (growth mindset / 'yet' thinking, manners & respect, honesty and
-- other moral lessons, kindness, and gratitude); target_count=7 (fixed, not
-- the usual ~65% auto-rebalance ratio) means the existing NEWID()-sampling
-- rotation serves a different 7-of-14 combination most weeks a grade's
-- character category is selected, satisfying '7 character games, different
-- set each week' without any manual per-week authoring.
--
-- Each game is ONE PacketQuestions row: prompt carries the Name/Objective/
-- Materials, diagram_type='sequence_steps' carries the Step-by-Step
-- Instructions (already-shipped diagram type, renders as a numbered list in
-- both the app and print — see 63_whole_child_rotation.sql). answer_text
-- carries a short values-focused closing tip for the game.
-- See gen_79_character_games_content.py.

IF NOT EXISTS (SELECT 1 FROM dbo.PacketCategories WHERE subject_area = 'character' AND category_name = N'Character Building Games')
BEGIN
    DECLARE @cat_char_0 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (0, 'character', N'Character Building Games', 'space_heavy', 7, N'Practice being your best self with a fun character-building game!', 0);
    SET @cat_char_0 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_0, N'short_response', N'🌟 Kindness Bingo

Objective: Practice noticing and doing simple kind acts with the help of a grown-up.

Materials: Paper with 4 simple kindness pictures drawn or printed | Crayon or sticker to mark squares

Follow the steps below to play!', NULL, N'Every kind act — big or small — makes someone''s day a little brighter.', 1, N'sequence_steps', N'{"steps": ["Grown-up draws (or shows) 4 simple kindness pictures on paper, like sharing, hugging, saying thank you, and helping clean up.", "Do one kind thing from the paper with a grown-up''s help.", "Mark that square with a crayon or sticker.", "Try to mark all 4 squares by the end of the day!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_0, N'short_response', N'🧸 Share the Toy

Objective: Practice sharing a favorite toy and taking turns with a friend or grown-up.

Materials: 1 favorite toy

Follow the steps below to play!', NULL, N'Sharing turns a fun toy into an even more fun game together.', 2, N'sequence_steps', N'{"steps": ["Sit together with a grown-up or friend and one toy.", "Play with the toy for a little while, then say ''your turn'' and hand it over.", "Wait patiently while your friend plays.", "Trade back and forth a few times, cheering for each other."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_0, N'short_response', N'🙏 Thank You Circle

Objective: Practice saying thank you and naming one thing you''re happy about.

Materials: None — just a small circle of family or friends

Follow the steps below to play!', NULL, N'Noticing happy little things helps your heart feel warm and full.', 3, N'sequence_steps', N'{"steps": ["Sit together in a circle with a grown-up.", "Take turns saying one thing you''re happy or thankful for, like ''my blanket'' or ''my dog.''", "A grown-up can help younger friends think of an idea.", "Clap gently for each person after they share."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_0, N'short_response', N'🖐️ Thankful Hand Trace

Objective: Practice naming things you''re grateful for using your own hand as a guide.

Materials: Paper | Crayon

Follow the steps below to play!', NULL, N'You have five thankful things right at your fingertips.', 4, N'sequence_steps', N'{"steps": ["Trace your hand on paper with a grown-up''s help.", "Name one thing you''re thankful for on each finger.", "A grown-up can write or draw a small picture for each one.", "Show your thankful hand to someone and tell them about it!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_0, N'short_response', N'🐰 Honest Bunny Says

Objective: Practice telling the truth about who did something, with a grown-up''s gentle guidance.

Materials: A stuffed animal or puppet (any toy works)

Follow the steps below to play!', NULL, N'Telling the truth, even about small things, makes you a trusted friend.', 5, N'sequence_steps', N'{"steps": ["Grown-up holds up a stuffed animal and makes up a silly little mix-up, like ''who moved the blocks?''", "Practice saying ''I did it!'' in a brave, honest voice.", "The grown-up gives a big smile and says thank you for being honest.", "Try a new silly mix-up and practice again."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_0, N'short_response', N'🧩 Puzzle Piece Confession

Objective: Practice admitting a small mistake honestly with a grown-up''s support.

Materials: A simple puzzle (a few large pieces)

Follow the steps below to play!', NULL, N'Speaking up honestly, even about a mix-up, helps solve problems together.', 6, N'sequence_steps', N'{"steps": ["Grown-up hides one puzzle piece before starting.", "Try to finish the puzzle and notice a piece is missing.", "Practice saying ''I think a piece is missing, can you help me find it?'' honestly.", "Find the piece together and finish the puzzle!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_0, N'short_response', N'🌈 Not Yet Game

Objective: Practice turning ''I can''t'' into ''I can''t YET'' with a cheerful grown-up-led game.

Materials: None — just a grown-up and a willing helper

Follow the steps below to play!', NULL, N'The word ''yet'' means you''re still learning — and that''s exciting!', 7, N'sequence_steps', N'{"steps": ["Grown-up says a simple thing, like ''I can''t tie my shoe.''", "Together, add the magic word: ''I can''t tie my shoe... YET!''", "Cheer loudly every time you add ''yet!''", "Try it with a few more simple ''I can''t'' ideas."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_0, N'short_response', N'🌱 Little Seed, Big Try

Objective: Practice connecting trying hard things with the idea of slowly growing and improving.

Materials: Paper | Crayon (to draw a seed and a plant)

Follow the steps below to play!', NULL, N'Just like a seed, trying hard things helps you grow a little every day.', 8, N'sequence_steps', N'{"steps": ["Draw a tiny seed on paper.", "Try something a little bit tricky, like stacking blocks or hopping on one foot.", "Each time you try, draw the seed growing a little taller.", "Celebrate when your drawing grows into a full little plant!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_0, N'short_response', N'🙋 Please & Thank You Puppet Show

Objective: Practice using polite words like please and thank you in a playful puppet show.

Materials: 2 puppets or stuffed animals (or your own hands)

Follow the steps below to play!', NULL, N'Please and thank you are like little gifts you can give with your words.', 9, N'sequence_steps', N'{"steps": ["Grown-up and child each hold a puppet.", "Act out a simple scene, like asking to borrow a crayon.", "Practice having the puppets say ''please'' when asking and ''thank you'' after.", "Switch puppets and try a new polite scene."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_0, N'short_response', N'🎁 Please Pass It Game

Objective: Practice using polite words while passing an object around a small group.

Materials: 1 soft object to pass, like a stuffed animal or ball

Follow the steps below to play!', NULL, N'Polite words make sharing feel warm and friendly.', 10, N'sequence_steps', N'{"steps": ["Sit in a small circle with family or friends.", "Ask, ''Please may I have it?'' before it''s passed to you.", "Say ''thank you'' when you receive it.", "Pass it to the next person and keep going around the circle."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_0, N'short_response', N'🐢 Slow and Steady Stack

Objective: Practice patience and trying again when a block tower falls down.

Materials: Soft blocks or stackable cups

Follow the steps below to play!', NULL, N'Going slow and trying again is its own kind of winning.', 11, N'sequence_steps', N'{"steps": ["Stack blocks one at a time, going slow and steady.", "If the tower falls, take a deep breath together.", "Say ''let''s try again!'' and start restacking.", "Celebrate however tall your tower gets."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_0, N'short_response', N'🧱 Block Tower Restart

Objective: Practice a cheerful attitude about starting over after a small setback.

Materials: Soft blocks

Follow the steps below to play!', NULL, N'Every tumble is just a chance to build again.', 12, N'sequence_steps', N'{"steps": ["Build a tower together as tall as you can.", "When it tumbles down (it will!), clap and say ''oops, let''s rebuild!''", "Build it again, maybe a little differently this time.", "Keep rebuilding together as many times as you''d like."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_0, N'short_response', N'🤗 Comfort a Friend Game

Objective: Practice noticing when someone is sad and offering comfort.

Materials: A stuffed animal to pretend is sad

Follow the steps below to play!', NULL, N'A caring word or a gentle hug can help a sad friend feel better.', 13, N'sequence_steps', N'{"steps": ["Grown-up holds a stuffed animal and says it feels sad.", "Think of one kind thing to say or do, like a gentle hug or ''I''m here for you.''", "Give the stuffed animal your kind words or a hug.", "Talk about how the stuffed animal (and you!) might feel better now."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_0, N'short_response', N'🐻 Comfort Bear Circle

Objective: Practice giving kind, comforting words to others in a group.

Materials: 1 stuffed bear (or any stuffed animal)

Follow the steps below to play!', NULL, N'Kind words are a wonderful gift to share with anyone who needs them.', 14, N'sequence_steps', N'{"steps": ["Sit in a small circle and pass around the stuffed bear.", "Pretend the bear is feeling a little sad today.", "Each person says one kind, comforting thing to the bear when it''s their turn.", "Give the bear a group hug at the end!"]}');

    DECLARE @cat_char_1 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (1, 'character', N'Character Building Games', 'space_heavy', 7, N'Practice being your best self with a fun character-building game!', 0);
    SET @cat_char_1 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_1, N'short_response', N'💛 Kindness Bingo Walk

Objective: Practice noticing and doing simple kind acts around the house or classroom.

Materials: Paper bingo card with 4-6 pictures of kind acts | Crayon or stickers

Follow the steps below to play!', NULL, N'Kindness is even more fun when you go looking for chances to share it.', 1, N'sequence_steps', N'{"steps": ["Look at the pictures on your kindness bingo card (share, say thank you, help clean up, give a compliment).", "Walk around with a grown-up looking for chances to do each kind act.", "Mark off a square every time you complete one.", "See if you can fill the whole card by bedtime!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_1, N'short_response', N'🍪 Kind Cookie Pass

Objective: Practice offering to share and thinking of others first.

Materials: A pretend plate of treats (drawn, or use blocks/toys as pretend cookies)

Follow the steps below to play!', NULL, N'Offering first is a simple way to show someone you''re thinking of them.', 2, N'sequence_steps', N'{"steps": ["Set out a pretend plate of treats with a grown-up.", "Before taking one for yourself, offer the plate to someone else first.", "Practice saying ''would you like one?'' in a friendly voice.", "Take turns being the one who offers the plate."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_1, N'short_response', N'🌻 Gratitude Petal Game

Objective: Practice naming several things you''re grateful for using a growing paper flower.

Materials: Paper | Crayon or scissors (grown-up can help cut petals)

Follow the steps below to play!', NULL, N'The more you notice to be grateful for, the fuller your flower grows.', 3, N'sequence_steps', N'{"steps": ["Draw or cut out a flower center on paper.", "Name one thing you''re grateful for and add a petal for it.", "Keep naming grateful things and adding petals.", "Count your petals together when your flower is full!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_1, N'short_response', N'🎈 Gratitude Balloon Pop

Objective: Practice sharing something you''re grateful for after a fun little surprise.

Materials: 2-3 balloons with small paper prompts inside (or paper slips in a bag if no balloons)

Follow the steps below to play!', NULL, N'A little surprise makes sharing gratitude even more fun.', 4, N'sequence_steps', N'{"steps": ["Grown-up puts a small gratitude prompt inside each balloon before blowing it up (or use paper slips in a bag).", "Pop a balloon (or pick a slip) gently.", "Read the prompt and answer it, like ''name someone who helps you.''", "Pop or pick another and keep sharing!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_1, N'short_response', N'🐷 Piggy Bank Honesty Game

Objective: Practice deciding to tell the truth about a found item.

Materials: 1 play coin or small toy

Follow the steps below to play!', NULL, N'Speaking up honestly about a find is one of the kindest things you can do.', 5, N'sequence_steps', N'{"steps": ["Grown-up ''hides'' a play coin somewhere in the room before you start.", "Find the coin during play.", "Practice saying ''I found this, whose is it?'' instead of keeping it quietly.", "Talk about how good it feels to be honest about what you find."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_1, N'short_response', N'🎲 Honest Dice Game

Objective: Practice choosing the honest response in simple everyday scenarios.

Materials: 1 die (or a coin to flip) | 3-6 simple scenario cards read aloud by a grown-up

Follow the steps below to play!', NULL, N'Even a small accident is easier to fix when you''re honest about it.', 6, N'sequence_steps', N'{"steps": ["Grown-up reads a simple scenario, like ''you broke a crayon by accident.''", "Roll the die (or flip the coin) to pick between two choices: tell what happened, or stay quiet.", "Talk about why telling what happened is the honest choice.", "Try a new scenario and roll again."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_1, N'short_response', N'🐣 Hatching the Yet Egg

Objective: Practice using the word ''yet'' to turn a hard task into an exciting challenge.

Materials: Paper egg shape (drawn or cut out) | Crayon

Follow the steps below to play!', NULL, N'Every try cracks the egg a little more open toward ''I can!''', 7, N'sequence_steps', N'{"steps": ["Draw a big egg shape on paper.", "Try something a little tricky, like hopping five times in a row.", "Each time you try, color in a crack on the egg.", "When the egg ''hatches,'' celebrate — you didn''t do it before, but now you''re getting closer!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_1, N'short_response', N'🧩 One More Try Puzzle

Objective: Practice saying an encouraging ''yet'' phrase when a task feels tricky.

Materials: A simple puzzle (chunky pieces)

Follow the steps below to play!', NULL, N'Saying ''yet'' out loud reminds your brain that trying pays off.', 8, N'sequence_steps', N'{"steps": ["Start working on the puzzle together.", "If a piece is tricky, say out loud: ''I can''t find this piece... yet!''", "Keep trying a little longer before asking for help.", "Cheer loudly when the puzzle is finished!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_1, N'short_response', N'🎭 Manners Charades

Objective: Practice recognizing polite behaviors by acting them out.

Materials: Index cards with simple manners drawn or written (grown-up can read them aloud)

Follow the steps below to play!', NULL, N'Good manners are easy to spot once you know what to look for.', 9, N'sequence_steps', N'{"steps": ["Grown-up picks a manners card, like ''saying please'' or ''holding the door.''", "Act out the polite behavior without talking.", "Others guess which good manner is being shown.", "Take turns picking a new card and acting it out."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_1, N'short_response', N'👋 Greeting Game

Objective: Practice greeting others politely in different pretend situations.

Materials: None — just a willing partner

Follow the steps below to play!', NULL, N'A warm hello or goodbye can make someone''s whole day better.', 10, N'sequence_steps', N'{"steps": ["Pretend to meet someone new, like a new neighbor or a friend''s grown-up.", "Practice saying ''hello, nice to meet you'' with a smile.", "Practice saying a polite ''goodbye, see you later!'' too.", "Try a few different pretend meetings and greetings."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_1, N'short_response', N'🎯 Bullseye of Effort

Objective: Practice trying multiple times at a toss game, no matter where the toss lands.

Materials: A soft ball or beanbag | A hoop or bucket target

Follow the steps below to play!', NULL, N'Every toss — hit or miss — is a chance to get a little better.', 11, N'sequence_steps', N'{"steps": ["Stand a few steps from the target.", "Toss the ball toward the target.", "Whether you hit it or miss it, say ''good try!'' and toss again.", "Keep tossing several times, celebrating each attempt."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_1, N'short_response', N'🐌 Snail Race Patience Game

Objective: Practice patience by racing as slowly as possible instead of as fast as possible.

Materials: Open floor or yard space | 2 markers for start/finish

Follow the steps below to play!', NULL, N'Going slow and steady takes just as much focus as going fast.', 12, N'sequence_steps', N'{"steps": ["Line up at the start marker.", "On ''go,'' move as slowly as a snail toward the finish — no rushing!", "The last one to reach the finish line wins.", "Try again and see who can go even slower and steadier."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_1, N'short_response', N'🦸 Be a Buddy Game

Objective: Practice including a friend who might be feeling left out.

Materials: 2-3 simple scenario pictures or descriptions (read aloud by a grown-up)

Follow the steps below to play!', NULL, N'One small invitation can turn someone''s lonely moment into a happy one.', 13, N'sequence_steps', N'{"steps": ["Grown-up describes a simple scene, like ''a friend is sitting alone at recess.''", "Think of one kind way to include them, like inviting them to play.", "Act out walking over and saying your kind invitation.", "Talk about how the left-out friend might feel afterward."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_1, N'short_response', N'🧩 Everyone Gets a Turn Game

Objective: Practice making sure everyone in a group gets included and gets a turn.

Materials: 1 simple toy or game with turns (like rolling a ball back and forth)

Follow the steps below to play!', NULL, N'A game is more fun for everyone when nobody gets left out.', 14, N'sequence_steps', N'{"steps": ["Play a simple turn-taking game in a small group.", "Before starting, name everyone who should get a turn.", "Check off (or count) each person''s turn as you go.", "Celebrate together once everyone has had a turn!"]}');

    DECLARE @cat_char_2 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (2, 'character', N'Character Building Games', 'space_heavy', 7, N'Practice being your best self with a fun character-building game!', 0);
    SET @cat_char_2 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_2, N'short_response', N'🎁 Kindness Coupon Game

Objective: Practice planning and giving a kind act to someone in your family.

Materials: Paper cut into small coupon shapes | Pencil or crayon

Follow the steps below to play!', NULL, N'A kindness coupon is a promise — and keeping it feels great.', 1, N'sequence_steps', N'{"steps": ["Draw or write 3-4 simple kindness coupons, like ''I''ll help set the table'' or ''free hug.''", "Decorate each coupon.", "Give one coupon to a family member.", "Follow through and complete the kind act on the coupon!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_2, N'short_response', N'🎨 Kindness Rainbow

Objective: Practice completing a full week of kind acts to build a colorful rainbow.

Materials: Paper with a rainbow outline | Crayons

Follow the steps below to play!', NULL, N'Each kind act adds a little more color to your day.', 2, N'sequence_steps', N'{"steps": ["Draw a big rainbow outline with several colored stripes.", "Do one kind act, then color in one stripe of the rainbow.", "Keep doing kind acts and coloring stripes over the next few days.", "Celebrate when your whole rainbow is colored in!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_2, N'short_response', N'📝 Gratitude Jar

Objective: Practice writing down and sharing things you''re grateful for.

Materials: A jar or box | Small paper slips | Pencil

Follow the steps below to play!', NULL, N'A jar full of grateful notes is a jar full of happy reminders.', 3, N'sequence_steps', N'{"steps": ["Write (or draw) one thing you''re grateful for on a small slip of paper.", "Fold it and drop it in the jar.", "Add a new slip every day for a week.", "At the end of the week, read them all out loud together."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_2, N'short_response', N'🌟 Gratitude Star Chart

Objective: Practice noticing and recording things you''re thankful for throughout a day.

Materials: Paper chart with empty stars | Sticker or crayon

Follow the steps below to play!', NULL, N'Gratitude gets easier to spot the more you practice looking for it.', 4, N'sequence_steps', N'{"steps": ["Draw or print a chart with 5 empty stars.", "Each time you notice something you''re grateful for, color or sticker a star.", "Say the grateful thing out loud when you fill each star.", "See if you can fill all 5 stars by the end of the day!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_2, N'short_response', N'🎭 Truth or Tale

Objective: Practice telling the difference between an honest choice and a dishonest one in short scenarios.

Materials: 4-6 short scenario cards (a grown-up can write or read these aloud)

Follow the steps below to play!', NULL, N'Doing the honest thing when no one''s watching shows real character.', 5, N'sequence_steps', N'{"steps": ["Listen to a short scenario, like ''you spilled juice and no one saw.''", "Decide what the honest choice would be.", "Act out or say out loud what you would do and say.", "Talk about why the honest choice matters, even when no one is watching."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_2, N'short_response', N'🧵 Tell the Truth Trail

Objective: Practice choosing honesty by moving forward along a simple path game.

Materials: Chalk or tape to mark a path with 6-8 steps | Scenario cards

Follow the steps below to play!', NULL, N'Every honest choice moves you one step closer to being trusted.', 6, N'sequence_steps', N'{"steps": ["Draw or mark a path with several steps toward a finish line.", "Read a scenario card at each step and choose the honest response.", "If you pick the honest choice, move forward one step.", "Reach the finish line by choosing honesty the whole way!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_2, N'short_response', N'💪 Turn It Into Yet

Objective: Practice flipping ''I can''t'' statements into ''yet'' statements with a next step.

Materials: 4-5 cards with simple ''I can''t...'' statements written or drawn

Follow the steps below to play!', NULL, N'Adding ''yet'' turns a stuck feeling into a starting point.', 7, N'sequence_steps', N'{"steps": ["Pick a card and read the ''I can''t...'' statement out loud.", "Add the word ''yet'' to the end of the sentence.", "Think of one small step you could try to get closer to ''I can.''", "Pick another card and try again."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_2, N'short_response', N'🎈 Yet Balloon Bounce

Objective: Practice pairing a physical game with positive ''can''t yet'' self-talk.

Materials: 1 balloon

Follow the steps below to play!', NULL, N'Turning ''can''t'' into ''yet'' keeps your thinking bouncing in a good direction.', 8, N'sequence_steps', N'{"steps": ["Bounce the balloon gently in the air with your hand.", "Each time you bounce it, say a ''can''t yet'' statement, like ''I can''t do a cartwheel... yet!''", "Keep bouncing and adding new ''yet'' statements.", "See how many bounces (and ''yets'') you can do in a row!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_2, N'short_response', N'📞 Phone Manners Role Play

Objective: Practice polite greetings, listening, and goodbyes during a pretend phone call.

Materials: A toy phone (or just your hand)

Follow the steps below to play!', NULL, N'Polite listening is just as important as polite talking.', 9, N'sequence_steps', N'{"steps": ["Pretend to call a friend or family member.", "Practice a polite greeting, like ''Hello, this is [your name].''", "Listen without interrupting while your partner talks.", "End the call with a polite goodbye, like ''Thanks for talking, bye!''"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_2, N'short_response', N'🙊 Interrupting Bell Game

Objective: Practice waiting for your turn to speak instead of interrupting.

Materials: A small bell or a hand signal (like a raised hand)

Follow the steps below to play!', NULL, N'Waiting your turn to speak shows a friend that their words matter too.', 10, N'sequence_steps', N'{"steps": ["Have a short conversation with a partner about your day.", "If you feel the urge to interrupt, use the bell or raised hand signal instead of speaking.", "Wait until your partner finishes their sentence before you talk.", "Switch — let your partner practice waiting too."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_2, N'short_response', N'🧵 String Untangle Challenge

Objective: Practice staying patient and persistent while untangling a simple knot.

Materials: A length of soft string or yarn, lightly knotted

Follow the steps below to play!', NULL, N'Patience untangles more knots than frustration ever will.', 11, N'sequence_steps', N'{"steps": ["Start with a gently tangled piece of string or yarn.", "Work slowly to untangle it, one loop at a time.", "If you feel frustrated, take a breath and keep trying.", "Celebrate when the string is completely untangled!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_2, N'short_response', N'🎯 Three Tries Challenge

Objective: Practice noticing improvement across several attempts at the same task.

Materials: A simple task, like tossing a beanbag into a bucket

Follow the steps below to play!', NULL, N'Trying again with a small change is how skills grow.', 12, N'sequence_steps', N'{"steps": ["Try the task once and notice how it goes.", "Try it a second time, thinking about one small thing to do differently.", "Try it a third time and compare to your first try.", "Talk about what got better between try one and try three."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_2, N'short_response', N'🌈 New Friend Welcome Game

Objective: Practice role-playing a warm welcome for someone new to a group.

Materials: None — just a partner or small group

Follow the steps below to play!', NULL, N'A warm welcome can turn a nervous new friend into a happy one.', 13, N'sequence_steps', N'{"steps": ["One person pretends to be new to the group, standing a little apart.", "The others practice walking over and saying a friendly welcome.", "Invite the ''new friend'' to join your game or activity.", "Switch roles so everyone gets to practice welcoming."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_2, N'short_response', N'🫱 Helping Hand Relay

Objective: Practice stopping to help a teammate before continuing a game.

Materials: 2 cones or markers | A small obstacle (like a hula hoop to step through)

Follow the steps below to play!', NULL, N'A good teammate always makes time to help, even mid-race.', 14, N'sequence_steps', N'{"steps": ["Set up a simple obstacle path between two markers.", "One player pretends to get ''stuck'' partway through.", "The next player must stop and help them before either continues.", "Take turns being the one who gets stuck and the one who helps."]}');

    DECLARE @cat_char_3 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (3, 'character', N'Character Building Games', 'space_heavy', 7, N'Practice being your best self with a fun character-building game!', 0);
    SET @cat_char_3 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_3, N'short_response', N'🐾 Compliment Circle

Objective: Practice giving and receiving genuine compliments in a group.

Materials: None — just a small group

Follow the steps below to play!', NULL, N'A genuine compliment costs nothing but can mean everything to someone.', 1, N'sequence_steps', N'{"steps": ["Sit or stand in a circle.", "Take turns giving the person next to you a genuine compliment.", "Say thank you when you receive a compliment.", "Keep going around the circle until everyone has given and received one."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_3, N'short_response', N'🎡 Kindness Wheel Spin

Objective: Practice completing a randomly chosen act of kindness.

Materials: A paper spinner (or die) labeled with 4-6 kind acts

Follow the steps below to play!', NULL, N'Letting the spinner choose can lead you to kind acts you might not have picked yourself.', 2, N'sequence_steps', N'{"steps": ["Make a simple paper spinner with kind acts written around the edge, like ''give a compliment'' or ''help without being asked.''", "Spin it to land on a kind act.", "Go complete that act sometime today.", "Spin again tomorrow for a new kind act to try!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_3, N'short_response', N'💌 Thank-You Note Relay

Objective: Practice expressing gratitude in writing to someone who has helped you.

Materials: Paper | Pencil or crayons

Follow the steps below to play!', NULL, N'A written thank-you can be kept and reread long after the moment has passed.', 3, N'sequence_steps', N'{"steps": ["Think of someone who has helped or done something kind for you recently.", "Write (or draw) them a short thank-you note.", "Deliver the note to them yourself.", "Notice how it feels to make someone smile with your words."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_3, N'short_response', N'🎤 Thankful Interview Duo

Objective: Practice asking and answering questions about gratitude with a partner.

Materials: None — just a partner

Follow the steps below to play!', NULL, N'Asking someone what they''re grateful for is a great way to get to know them better.', 4, N'sequence_steps', N'{"steps": ["Pair up with a partner.", "Take turns asking, ''What is one thing you''re thankful for today, and why?''", "Listen carefully to your partner''s answer.", "Share what you learned about each other''s answers with the group."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_3, N'short_response', N'🕵️‍♀️ Honesty Detective

Objective: Practice identifying the honest choice in short everyday scenario cards.

Materials: 5-6 scenario cards describing small honesty dilemmas

Follow the steps below to play!', NULL, N'Being an honesty detective means noticing the honest path even when it''s not obvious.', 5, N'sequence_steps', N'{"steps": ["Read a scenario card, like ''you got extra change back at the store by mistake.''", "Decide what the honest choice would be and why.", "Act out how you would handle it honestly.", "Move to the next scenario card and repeat."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_3, N'short_response', N'🔍 Spot the Fib Game

Objective: Practice noticing when a short story doesn''t add up and imagining the honest version.

Materials: 3-4 short made-up stories with an inconsistency (read aloud by a grown-up or partner)

Follow the steps below to play!', NULL, N'Noticing when something doesn''t add up is the first step to choosing honesty yourself.', 6, N'sequence_steps', N'{"steps": ["Listen to a short story that has a small inconsistency, like someone''s excuse not quite matching the facts.", "Try to spot what doesn''t add up.", "Talk about what the honest version of the story might sound like.", "Try another story and spot the fib again."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_3, N'short_response', N'🧗 Challenge Ladder Game

Objective: Practice attempting increasingly difficult challenges while celebrating effort at every level.

Materials: A simple list of 4-5 challenges in order of difficulty (like hop on one foot, then hop and clap, then hop and spin)

Follow the steps below to play!', NULL, N'Every rung you attempt — even a wobbly one — is real progress.', 7, N'sequence_steps', N'{"steps": ["Try the easiest challenge on your ''ladder'' first.", "Whether you succeed or not, celebrate the attempt and move to the next rung.", "Keep climbing the ladder of harder challenges.", "Talk about which rung felt hardest and why you kept climbing anyway."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_3, N'short_response', N'🖍️ Mistake Art Game

Objective: Practice turning a mistake into something new instead of feeling upset about it.

Materials: Paper | Crayons or markers

Follow the steps below to play!', NULL, N'A mistake is often just the start of a different — sometimes better — idea.', 8, N'sequence_steps', N'{"steps": ["Start drawing a picture.", "On purpose (or by accident), make a mistake mark on the paper.", "Turn that mistake into a new part of the drawing, like turning a smudge into a cloud.", "Talk about how mistakes can lead somewhere unexpected and good."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_3, N'short_response', N'🍽️ Table Manners Challenge

Objective: Practice recognizing and demonstrating good table manners.

Materials: A pretend table setting (plates, napkin, utensils — real or drawn)

Follow the steps below to play!', NULL, N'Good table manners help everyone enjoy the meal together.', 9, N'sequence_steps', N'{"steps": ["Set up a pretend meal at the table.", "Act out good table manners: napkin in lap, asking to pass food, chewing with your mouth closed.", "Have a partner act out one manners ''mistake'' for you to spot and gently correct.", "Switch roles and try spotting a different mistake."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_3, N'short_response', N'🧑‍🤝‍🧑 Personal Space Game

Objective: Practice recognizing and respecting others'' personal space during movement.

Materials: Open space | Hula hoops (optional, one per player)

Follow the steps below to play!', NULL, N'Respecting someone''s space is a quiet but powerful way to show respect.', 10, N'sequence_steps', N'{"steps": ["If using hoops, each player stands inside their own hoop as their ''personal space bubble.''", "Move around the space, being careful not to bump into anyone else''s bubble.", "Practice asking, ''Is it okay if I stand here?'' before getting close to a friend.", "Talk about why respecting space helps everyone feel comfortable."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_3, N'short_response', N'🧩 Puzzle Persistence Challenge

Objective: Practice using strategies to keep trying during a timed puzzle challenge.

Materials: A puzzle with a moderate number of pieces | A timer (optional)

Follow the steps below to play!', NULL, N'Persistence isn''t about never getting stuck — it''s about trying a new way when you do.', 11, N'sequence_steps', N'{"steps": ["Set a friendly time goal (or no timer at all) and start the puzzle.", "If you get stuck, try a new strategy, like sorting edge pieces first.", "Take a short breather if frustrated, then come back to it.", "Celebrate finishing, no matter how long it took."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_3, N'short_response', N'🏆 Effort Over Outcome Game

Objective: Practice measuring success by effort and improvement rather than winning alone.

Materials: 3-4 simple mini-challenges (like tossing, balancing, or hopping tasks)

Follow the steps below to play!', NULL, N'The score that matters most is how much effort you gave, not just the result.', 12, N'sequence_steps', N'{"steps": ["Try each mini-challenge and notice how many attempts it takes.", "Score yourself on effort (did you keep trying?) rather than just success.", "Compare your second attempt at each challenge to your first.", "Celebrate the challenge where you showed the most improvement."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_3, N'short_response', N'🤝 Standing Up Kindly

Objective: Practice standing up for a friend kindly, without being unkind back.

Materials: 2-3 short scenario cards about a friend being teased

Follow the steps below to play!', NULL, N'Standing up for a friend works best when it''s done with kindness, not anger.', 13, N'sequence_steps', N'{"steps": ["Read a scenario where a friend is being teased or left out.", "Think of a kind, firm way to stand up for them, like ''that''s not okay, let''s go.''", "Act out saying your kind, firm response.", "Talk about why standing up kindly is more powerful than fighting back unkindly."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_3, N'short_response', N'🛡️ Kind Words Shield

Objective: Practice responding to teasing with calm, kind, and confident words.

Materials: None — just a partner

Follow the steps below to play!', NULL, N'A calm, kind response is a strong shield against unkind words.', 14, N'sequence_steps', N'{"steps": ["Partner gently pretends to tease about something silly and harmless.", "Practice responding calmly with a kind, confident phrase, like ''that''s just how I am, and that''s okay.''", "Switch roles so both partners get to practice.", "Talk about how staying calm can take away the sting of teasing."]}');

    DECLARE @cat_char_4 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (4, 'character', N'Character Building Games', 'space_heavy', 7, N'Practice being your best self with a fun character-building game!', 0);
    SET @cat_char_4 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_4, N'short_response', N'🕵️ Secret Kindness Mission

Objective: Practice performing an anonymous kind act and reflecting on how it felt.

Materials: A jar or bag with 4-5 kindness mission slips

Follow the steps below to play!', NULL, N'Kindness done in secret is just as meaningful — sometimes even more so.', 1, N'sequence_steps', N'{"steps": ["Write 4-5 kindness mission ideas on slips of paper, like ''compliment someone you don''t usually talk to.''", "Draw one mission from the jar without others seeing.", "Complete the mission secretly, without getting credit.", "Reflect afterward: how did it feel to do something kind without anyone knowing it was you?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_4, N'short_response', N'🎁 Anonymous Kindness Notes

Objective: Practice writing kind, encouraging notes for others without expecting credit.

Materials: Small paper slips | Pencil

Follow the steps below to play!', NULL, N'The best kindness sometimes asks for nothing in return, not even a thank-you.', 2, N'sequence_steps', N'{"steps": ["Think of 2-3 people who could use a kind or encouraging note.", "Write a short, genuine note for each person.", "Deliver the notes anonymously, like slipping them somewhere the person will find them.", "Talk about why kindness doesn''t need to be noticed to matter."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_4, N'short_response', N'🔍 Gratitude Scavenger Hunt

Objective: Practice noticing and appreciating things around you that you''re grateful for.

Materials: Paper | Pencil

Follow the steps below to play!', NULL, N'Gratitude is easier to find when you go looking for it on purpose.', 3, N'sequence_steps', N'{"steps": ["Make a quick list of 5 categories, like ''something that makes you comfortable'' or ''someone who helps you.''", "Search your home or room for an item or person that fits each category.", "Write down or sketch what you found for each one.", "Share your list with someone and explain why each item matters to you."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_4, N'short_response', N'🔗 Gratitude Chain Reaction

Objective: Practice connecting the things you''re grateful for to the people who provide them.

Materials: Paper strips | Tape or a stapler

Follow the steps below to play!', NULL, N'Every link in your chain is a reminder that gratitude connects us to others.', 4, N'sequence_steps', N'{"steps": ["On each paper strip, write something you''re grateful for and the person connected to it.", "Loop and tape (or staple) the strips together into a growing paper chain.", "Add a new link every day for several days.", "Hang up your finished chain as a reminder of everyone who helps you."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_4, N'short_response', N'🎬 The Broken Vase Scenario

Objective: Practice choosing to admit a mistake honestly instead of hiding it.

Materials: None — just imagination and a partner

Follow the steps below to play!', NULL, N'Owning a mistake right away is almost always easier than carrying the secret.', 5, N'sequence_steps', N'{"steps": ["Act out a scenario: you accidentally broke something and no one saw it happen.", "Practice one version where you hide the mistake, and talk about how that might feel later.", "Practice a second version where you honestly admit it right away.", "Discuss which choice leads to more trust in the long run, even if it''s harder in the moment."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_4, N'short_response', N'🎭 Confess & Repair Role Play

Objective: Practice not just admitting a mistake honestly, but also making it right.

Materials: 2-3 scenario cards describing a mistake that affected someone else

Follow the steps below to play!', NULL, N'Real honesty includes both telling the truth and trying to make things right.', 6, N'sequence_steps', N'{"steps": ["Read a scenario, like accidentally losing a friend''s borrowed item.", "Practice honestly telling the person what happened.", "Go a step further — think of one way to repair or make up for the mistake.", "Act out both the honest confession and the repair plan."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_4, N'short_response', N'🔄 Flip the Thought

Objective: Practice recognizing fixed-mindset thoughts and flipping them into growth-mindset ones.

Materials: 5-6 cards with fixed-mindset statements written on them

Follow the steps below to play!', NULL, N'The thought you choose to believe shapes how hard you''re willing to try.', 7, N'sequence_steps', N'{"steps": ["Read a fixed-mindset statement, like ''I''m just bad at this.''", "Flip it into a growth-mindset version, like ''I''m still learning this.''", "Say both versions out loud and notice how they feel different.", "Try flipping a few more statements with a partner."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_4, N'short_response', N'🧠 Brain Grows Stronger Game

Objective: Practice a new physical skill and connect the effort to how the brain grows through practice.

Materials: 2-3 soft scarves or small balls for a simple juggling-style challenge

Follow the steps below to play!', NULL, N'Feeling awkward at something new is a sign your brain is busy growing.', 8, N'sequence_steps', N'{"steps": ["Try a brand-new small challenge, like juggling two soft scarves.", "Notice that it feels awkward and hard at first — that''s expected!", "Keep practicing for a few minutes, tracking small improvements.", "Talk about how your brain builds new pathways every time you practice something hard."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_4, N'short_response', N'👂 Listening Ears Challenge

Objective: Practice active listening and respectful eye contact during a partner conversation.

Materials: None — just a partner

Follow the steps below to play!', NULL, N'Really listening tells someone their words matter to you.', 9, N'sequence_steps', N'{"steps": ["Partner up and take turns being the speaker and the listener.", "The speaker shares something about their day for one minute.", "The listener practices eye contact, nodding, and not interrupting.", "Switch roles, then talk about what good listening felt like from both sides."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_4, N'short_response', N'📖 Manners Story Fix-It

Objective: Practice identifying rude behavior in a story and rewriting it politely.

Materials: A short story with a rude behavior moment (written or read aloud)

Follow the steps below to play!', NULL, N'Noticing rude behavior in a story helps you recognize — and choose against — it in real life.', 10, N'sequence_steps', N'{"steps": ["Read or listen to a short story where a character behaves rudely.", "Identify exactly what was impolite about their behavior.", "Rewrite or act out the scene with a polite version instead.", "Compare how the polite version might change how others in the story feel."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_4, N'short_response', N'🏆 Effort Medal Challenge

Objective: Practice completing a series of small challenges and being rewarded for effort and improvement.

Materials: 3-4 mini physical or mental challenges | Paper medals (drawn or cut out)

Follow the steps below to play!', NULL, N'A medal for effort matters just as much as a medal for winning.', 11, N'sequence_steps', N'{"steps": ["Attempt each mini-challenge, like a balance test or a quick math puzzle.", "After each one, award yourself a paper medal based on effort and improvement, not just success.", "Reflect on which challenge took the most perseverance.", "Display your medals as a reminder of your effort."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_4, N'short_response', N'📈 Practice Makes Progress Chart

Objective: Practice tracking improvement at a skill over multiple attempts.

Materials: Paper | Pencil | A simple skill to practice, like tossing a ball into a bucket

Follow the steps below to play!', NULL, N'A chart of your tries shows proof that practice really does help.', 12, N'sequence_steps', N'{"steps": ["Try the skill and record your result, like how many tosses out of five went in.", "Practice the skill a few more times, recording each result on your chart.", "Look at your chart to see how your numbers changed.", "Talk about what practice did for your results, even without practicing for long."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_4, N'short_response', N'🧭 Include Everyone Challenge

Objective: Practice noticing who''s left out in a group setting and finding a way to include them.

Materials: 3-4 scenario cards about group activities where someone is unintentionally excluded

Follow the steps below to play!', NULL, N'Inclusion often starts with simply noticing who isn''t in the circle yet.', 13, N'sequence_steps', N'{"steps": ["Read a scenario, like a group project where one person wasn''t asked to join.", "Brainstorm a specific way to include that person going forward.", "Act out approaching them and offering a genuine invitation.", "Discuss how noticing exclusion — even unintentional — is the first step to fixing it."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_4, N'short_response', N'💝 Plan a Kind Act Challenge

Objective: Practice planning a deliberate, thoughtful kind act for someone who might need it and reflecting on its impact.

Materials: Paper | Pencil

Follow the steps below to play!', NULL, N'A little planning can turn kindness from an accident into something truly meaningful.', 14, N'sequence_steps', N'{"steps": ["Think of someone who might be having a hard week and could use some support.", "Plan a specific, thoughtful kind act just for them.", "Carry out your planned act of kindness.", "Reflect afterward: how did planning ahead change the impact of your kindness?"]}');

    DECLARE @cat_char_5 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (5, 'character', N'Character Building Games', 'space_heavy', 7, N'Practice being your best self with a fun character-building game!', 0);
    SET @cat_char_5 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_5, N'short_response', N'📣 Kindness Ripple Challenge

Objective: Practice thinking through how one kind act might inspire a chain reaction of kindness in others.

Materials: Paper | Pencil

Follow the steps below to play!', NULL, N'Kindness rarely stops with just one person — it tends to ripple outward.', 1, N'sequence_steps', N'{"steps": ["Do one genuine kind act for someone today.", "Imagine (or ask, if possible) whether your kind act inspired them to do something kind for someone else.", "Sketch or write out the possible ''ripple'' — who might your kindness reach beyond the first person?", "Discuss with a group: how far do you think a single kind act can really travel?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_5, N'short_response', N'🎯 Kindness Impact Challenge

Objective: Practice planning a deliberate act of kindness aimed at real impact, then reflecting on the outcome.

Materials: Paper | Pencil

Follow the steps below to play!', NULL, N'The most meaningful kindness is often shaped around what someone actually needs.', 2, N'sequence_steps', N'{"steps": ["Identify someone whose day could genuinely be improved by a kind act.", "Plan a specific act that fits what that person actually needs (not just what''s easiest for you).", "Carry out your planned kind act.", "Reflect and discuss: did the impact match what you expected? What did you learn?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_5, N'short_response', N'🎙️ Gratitude Interview

Objective: Practice interviewing someone about what they''re grateful for and reflecting on their answer.

Materials: Paper | Pencil | A few interview questions

Follow the steps below to play!', NULL, N'Asking someone about their gratitude often reveals what really matters to them.', 3, N'sequence_steps', N'{"steps": ["Prepare 2-3 questions about gratitude, like ''what''s something you''re grateful for that most people wouldn''t guess?''", "Interview a family member or friend, writing down their answers.", "Share what surprised you most about their answers.", "Discuss as a group how gratitude can look different from person to person."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_5, N'short_response', N'🗓️ Gratitude Countdown Reflection

Objective: Practice a week-long gratitude habit and reflecting on patterns in what you noticed.

Materials: Paper | Pencil

Follow the steps below to play!', NULL, N'A week of tracked gratitude often shows you what you value most, even if you hadn''t noticed before.', 4, N'sequence_steps', N'{"steps": ["Each day for a week, write one thing you''re grateful for and one sentence about why.", "At the end of the week, review your full list.", "Look for patterns — do certain people, places, or moments show up often?", "Discuss what your patterns reveal about what truly matters to you."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_5, N'short_response', N'🧩 The Group Project Dilemma

Objective: Practice role-playing an honesty dilemma about fairly representing group work contributions.

Materials: 1 scenario card describing a group project where contributions were uneven

Follow the steps below to play!', NULL, N'Honesty about group work protects fairness for everyone, including the person who did less.', 5, N'sequence_steps', N'{"steps": ["Read the scenario: a group project is being graded, but one member did much less work than the others.", "Role-play a conversation about how to honestly represent everyone''s contribution.", "Discuss different honest approaches — talking to the teacher, talking to the group member directly, or something else.", "As a group, discuss which approach balances honesty with fairness and kindness best."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_5, N'short_response', N'🎲 Honesty Choices Card Game

Objective: Practice ranking honesty dilemmas by difficulty and discussing strategies for tackling hard ones.

Materials: 6-8 more advanced honesty scenario cards

Follow the steps below to play!', NULL, N'The hardest honest choices are often the ones that matter most.', 6, N'sequence_steps', N'{"steps": ["Read through advanced scenarios, like ''a friend asks you to cover for them.''", "Rank the scenarios from easiest to hardest to handle honestly.", "For the hardest scenario, brainstorm as a group what an honest, respectful response could sound like.", "Discuss why some honest choices feel riskier to your friendships than others."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_5, N'short_response', N'📈 Yet Journey Map

Objective: Practice mapping out the practice steps needed to move from ''can''t'' to ''can'' for a real skill.

Materials: Paper | Pencil

Follow the steps below to play!', NULL, N'A map from ''can''t'' to ''can'' makes a big goal feel like a series of doable steps.', 7, N'sequence_steps', N'{"steps": ["Pick a real skill you can''t do yet, but would like to learn.", "Map out 4-5 small steps that could help you get closer to ''can.''", "Try the first step on your map today.", "Discuss with a partner: which step do you think will be hardest, and why?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_5, N'short_response', N'🎤 Growth Mindset Debate

Objective: Practice defending a growth-mindset viewpoint in a friendly debate about ability and effort.

Materials: A list of debate statements about talent vs. effort

Follow the steps below to play!', NULL, N'Arguing for a growth mindset out loud can help you believe it a little more yourself.', 8, N'sequence_steps', N'{"steps": ["Read a statement, like ''some people are just naturally good at things and others aren''t.''", "Take the growth-mindset side of the debate and argue that effort and practice matter most.", "Listen to a partner''s counterpoints and respond respectfully.", "Reflect afterward: did arguing for growth mindset change how you think about your own challenges?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_5, N'short_response', N'💬 Respectful Disagreement Game

Objective: Practice disagreeing with someone''s opinion while remaining fully respectful of them.

Materials: A list of mild opinion topics | Respectful phrase starter cards

Follow the steps below to play!', NULL, N'Respectful disagreement lets you keep the relationship even when you don''t keep the same opinion.', 9, N'sequence_steps', N'{"steps": ["Pick a mild opinion topic to discuss with a partner.", "When you disagree, use a respectful phrase starter, like ''I understand why you think that, and here''s my view...''", "Practice fully hearing your partner''s point before responding.", "Discuss how the conversation might have gone differently without respectful language."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_5, N'short_response', N'🌐 Digital Manners Challenge

Objective: Practice deciding on and role-playing respectful responses in online/digital scenario cards.

Materials: 4-5 scenario cards about texting or online comments

Follow the steps below to play!', NULL, N'The words you type carry just as much weight as the words you say out loud.', 10, N'sequence_steps', N'{"steps": ["Read a digital scenario, like receiving a rude comment on a group chat.", "Decide on a respectful, level-headed way to respond (or choose not to respond).", "Role-play typing out (or saying aloud) your respectful response.", "Discuss as a group why digital manners matter just as much as in-person manners."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_5, N'short_response', N'🔄 Setback Comeback Game

Objective: Practice brainstorming and acting out thoughtful responses to real-feeling setback scenarios.

Materials: 4-5 setback scenario cards, like not making a team or getting a low grade despite effort

Follow the steps below to play!', NULL, N'A good comeback response takes the setback seriously and still finds a way forward.', 11, N'sequence_steps', N'{"steps": ["Read a setback scenario card aloud.", "Brainstorm 2-3 different ways someone could respond, from unhelpful to helpful.", "Act out the most helpful, perseverance-focused response.", "Discuss as a group what makes a comeback response actually helpful rather than just positive-sounding."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_5, N'short_response', N'🎯 Long-Term Goal Challenge

Objective: Practice setting a personal goal, planning practice steps, and discussing what perseverance looks like over time.

Materials: Paper | Pencil

Follow the steps below to play!', NULL, N'Perseverance over weeks looks different than perseverance in a single moment — both matter.', 12, N'sequence_steps', N'{"steps": ["Set a small personal goal you''d like to improve at over the next couple of weeks.", "Plan out a few practice steps and roughly when you''ll do them.", "Check in on your progress after a few days.", "Discuss with a partner or group: what does perseverance look like when progress is slow?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_5, N'short_response', N'🎭 Ally Role Play

Objective: Practice role-playing being an upstander who supports a peer during a conflict, rather than staying a bystander.

Materials: 2-3 scenario cards describing a peer conflict or unkind moment

Follow the steps below to play!', NULL, N'Being an upstander doesn''t require being loud — it just requires being willing to act.', 13, N'sequence_steps', N'{"steps": ["Read a scenario where someone is being treated unkindly by a peer.", "Discuss the difference between a bystander (who watches) and an upstander (who helps).", "Role-play an upstander response, like calmly saying ''that''s not okay'' or checking in with the person afterward.", "Discuss as a group why being an upstander can feel hard, and what makes it easier to do."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_5, N'short_response', N'🧩 Team Trust Challenge

Objective: Practice a cooperative trust-building challenge and reflecting on how to support teammates.

Materials: A blindfold (or closed eyes) | A simple safe obstacle path (cones or soft objects)

Follow the steps below to play!', NULL, N'Trust is built through small moments of clear communication and follow-through.', 14, N'sequence_steps', N'{"steps": ["Set up a simple, safe obstacle path.", "One partner closes their eyes (or wears a blindfold) while the other gives verbal directions through the path.", "Switch roles so both partners experience guiding and trusting.", "Discuss afterward: what helped you trust your partner, and how can you be that kind of trustworthy teammate for others?"]}');

    DECLARE @cat_char_6 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (6, 'character', N'Character Building Games', 'space_heavy', 7, N'Practice being your best self with a fun character-building game!', 0);
    SET @cat_char_6 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_6, N'short_response', N'🌟 Random Acts Planning Game

Objective: Practice brainstorming and planning kind acts for people outside your usual circle of friends.

Materials: Paper | Pencil

Follow the steps below to play!', NULL, N'Stepping outside your usual circle is where kindness can have the most unexpected impact.', 1, N'sequence_steps', N'{"steps": ["Brainstorm a list of 5-6 random acts of kindness aimed at people you don''t usually interact with.", "Choose one that feels genuinely doable and meaningful.", "Carry out your chosen act of kindness this week.", "Discuss afterward: why can kindness toward strangers or new people feel different than kindness toward close friends?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_6, N'short_response', N'🧭 Kindness Priorities Discussion

Objective: Practice discussing and ranking different kind acts by their potential impact, and choosing where to focus your effort.

Materials: 6-8 kind-act scenario cards of varying scale (small daily kindness vs. bigger organized efforts)

Follow the steps below to play!', NULL, N'Both small daily kindness and big planned kindness matter — the key is actually doing one.', 2, N'sequence_steps', N'{"steps": ["Read through the kind-act scenario cards as a group.", "Discuss and rank them by how much of an impact each might have, and how much effort each takes.", "Debate: is a small daily kindness more valuable than a big occasional one?", "Choose one from the list to actually put into action this week."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_6, N'short_response', N'🌍 Gratitude Perspective Challenge

Objective: Practice finding something to be grateful for within a genuinely frustrating or difficult situation.

Materials: 3-4 scenario cards describing a mildly frustrating or difficult situation

Follow the steps below to play!', NULL, N'Gratitude doesn''t erase a hard moment, but it can change how much power that moment has over you.', 3, N'sequence_steps', N'{"steps": ["Read a frustrating scenario card, like a canceled plan or a tough loss in a game.", "Brainstorm something — even something small — to be grateful for within that situation.", "Share your reframed perspective with the group.", "Discuss: does finding gratitude in a hard moment change how it feels, or just how you think about it?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_6, N'short_response', N'🔁 Gratitude vs. Complaint Tally

Objective: Practice noticing the balance between gratitude and complaint in your own everyday thinking.

Materials: Paper | Pencil

Follow the steps below to play!', NULL, N'Noticing your own gratitude-to-complaint ratio is the first step to shifting it.', 4, N'sequence_steps', N'{"steps": ["For one day, keep a simple tally of moments you complain about something versus moments you feel grateful for something.", "At the end of the day, compare your two tallies.", "Discuss what surprised you about the balance.", "Set a small goal for shifting the balance a little more toward gratitude tomorrow."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_6, N'short_response', N'🗣️ Integrity Under Pressure

Objective: Practice discussing and role-playing a complex honesty dilemma involving peer pressure.

Materials: 1-2 layered scenario cards, like a friend cheating and asking you not to tell

Follow the steps below to play!', NULL, N'Integrity under pressure is harder than integrity when it''s easy — and that''s exactly when it counts most.', 5, N'sequence_steps', N'{"steps": ["Read a layered scenario where staying honest could put a friendship at risk.", "Discuss as a group the different possible responses and their consequences.", "Role-play the response that best balances honesty with care for the friendship.", "Reflect: what makes integrity harder to hold onto when there''s real social pressure involved?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_6, N'short_response', N'🧭 Honesty Compass Discussion

Objective: Practice mapping out different honest responses to a layered ethical dilemma and discussing trade-offs.

Materials: 1-2 layered ethical dilemma cards (e.g., a small ''white lie'' vs. a harmful lie)

Follow the steps below to play!', NULL, N'Not every honesty dilemma has one perfect answer — but thinking it through carefully always helps.', 6, N'sequence_steps', N'{"steps": ["Read a layered dilemma involving different shades of honesty.", "As a group, map out at least 2-3 different honest responses and what each might lead to.", "Discuss whether all lies are equally serious, and why or why not.", "Reflect individually: what''s your own ''honesty compass'' — the values that guide your choice?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_6, N'short_response', N'🧠 Fixed vs Growth Sorting Challenge

Objective: Practice sorting statements into fixed vs. growth mindset categories and discussing how to shift fixed thinking.

Materials: 8-10 mindset statement cards

Follow the steps below to play!', NULL, N'Recognizing a fixed-mindset thought is the first step to being able to change it.', 7, N'sequence_steps', N'{"steps": ["Sort each statement card into a ''fixed mindset'' or ''growth mindset'' pile.", "For each fixed-mindset statement, discuss as a group how you could reframe it.", "Pick the fixed-mindset statement that feels most familiar to your own thinking.", "Discuss and write your own reframed version of it."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_6, N'short_response', N'📊 Growth Mindset Self-Audit

Objective: Practice honestly reflecting on your own mindset patterns across different areas of life.

Materials: Paper | Pencil

Follow the steps below to play!', NULL, N'A growth mindset isn''t all-or-nothing — most people have it in some areas and not others.', 8, N'sequence_steps', N'{"steps": ["List 3-4 areas of your life, like sports, school subjects, or a hobby.", "For each area, honestly rate whether your self-talk leans more fixed or growth mindset.", "Pick the area with the most fixed-mindset thinking and write one growth-mindset phrase to try using there.", "Discuss with a partner: which area was hardest to be honest about, and why?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_6, N'short_response', N'🌐 Netiquette Scenario Challenge

Objective: Practice discussing and deciding respectful responses to realistic online communication scenarios.

Materials: 4-5 realistic scenario cards about texting or online comments

Follow the steps below to play!', NULL, N'Respect online takes more intention because you can''t see the other person''s face — so give it extra care.', 9, N'sequence_steps', N'{"steps": ["Read a scenario, like seeing a harsh comment posted about a classmate online.", "Discuss as a group what a respectful, responsible response could look like.", "Role-play typing out (or saying aloud) that respectful response.", "Reflect: why can it feel easier to be unkind online than in person, and what can you do about that?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_6, N'short_response', N'🗳️ Respectful Disagreement Panel

Objective: Practice holding a structured, respectful discussion on a topic with differing opinions.

Materials: A mild discussion topic with multiple valid viewpoints | Discussion ground rules (written or discussed beforehand)

Follow the steps below to play!', NULL, N'A respectful discussion isn''t about avoiding disagreement — it''s about disagreeing well.', 10, N'sequence_steps', N'{"steps": ["As a group, agree on respectful discussion ground rules, like no interrupting and using ''I'' statements.", "Discuss a topic where people are likely to have different opinions.", "Practice acknowledging a good point from someone you disagree with before responding.", "Reflect afterward: how did the ground rules change the tone of the discussion?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_6, N'short_response', N'🎯 Long-Term Goal Challenge: Team Edition

Objective: Practice supporting a teammate''s long-term goal and discussing what perseverance looks like as a group effort.

Materials: Paper | Pencil

Follow the steps below to play!', NULL, N'Perseverance is often easier when someone else is cheering you on and checking in.', 11, N'sequence_steps', N'{"steps": ["Pair up and each share a personal goal you''re working toward.", "Brainstorm one specific way you could support your partner''s perseverance over the next couple of weeks.", "Check in with each other partway through to see how it''s going.", "Discuss as a group: how does having someone else''s support change your own perseverance?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_6, N'short_response', N'🔁 Setback Reframe Discussion

Objective: Practice reframing a real or realistic setback as a source of useful information rather than just a failure.

Materials: Paper | Pencil

Follow the steps below to play!', NULL, N'A setback reframed as a lesson is far less likely to stop you the next time.', 12, N'sequence_steps', N'{"steps": ["Think of a real setback you''ve experienced (or use a realistic example scenario).", "Write down what the setback might have taught you, even if it didn''t feel that way at the time.", "Share your reframed setback with a partner or group.", "Discuss: does reframing a setback change how likely you are to try again?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_6, N'short_response', N'⚖️ Upstander Dilemma Discussion Game

Objective: Practice discussing complex scenarios about witnessing unkindness and weighing different upstander responses.

Materials: 3-4 layered scenario cards about witnessing unkind behavior

Follow the steps below to play!', NULL, N'There''s more than one way to be an upstander — the best one is the one you can actually follow through on.', 13, N'sequence_steps', N'{"steps": ["Read a layered scenario where stepping in could be risky or awkward.", "Discuss as a group at least 2-3 different ways someone could respond as an upstander.", "Weigh the pros and cons of each response — which balances courage and safety best?", "Reflect individually: which response would actually feel realistic for you to try?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_6, N'short_response', N'🧩 Team Trust Challenge: Reflection Edition

Objective: Practice a cooperative trust exercise followed by a deeper group discussion on supporting teammates.

Materials: A blindfold (or closed eyes) | A simple safe obstacle path

Follow the steps below to play!', NULL, N'Trust between teammates is built the same way every time — through clear words and follow-through.', 14, N'sequence_steps', N'{"steps": ["Set up a safe obstacle path and pair up, with one partner guiding the other (eyes closed) through it using only words.", "Switch roles so both partners experience trusting and guiding.", "As a full group, discuss what specific communication helped build trust fastest.", "Reflect: how can these same trust-building habits show up in a real team or friend group?"]}');

    DECLARE @cat_char_7 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (7, 'character', N'Character Building Games', 'space_heavy', 7, N'Practice being your best self with a fun character-building game!', 0);
    SET @cat_char_7 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_7, N'short_response', N'🌟 Random Acts Planning Game II

Objective: Practice brainstorming, choosing, and following through on a bigger act of kindness with a clear plan.

Materials: Paper | Pencil

Follow the steps below to play!', NULL, N'The kind acts that take the most planning often create the biggest impact.', 1, N'sequence_steps', N'{"steps": ["Brainstorm a list of kind acts that would require some planning to pull off, like organizing a small collection for a cause.", "Choose one and outline the steps needed to make it happen.", "Carry out at least the first step this week.", "Discuss as a group: what makes a planned act of kindness feel different from a spontaneous one?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_7, N'short_response', N'🧭 Kindness Priorities Debate

Objective: Practice debating and defending different views on how kindness effort should be prioritized.

Materials: 6-8 kind-act scenario cards of varying scale

Follow the steps below to play!', NULL, N'Debating kindness helps you see there''s more than one right way to show it.', 2, N'sequence_steps', N'{"steps": ["Split into two small groups, each defending a different view: ''small daily kindness matters most'' vs. ''big planned kindness matters most.''", "Each group makes its best case using the scenario cards as evidence.", "Come back together and discuss where the two views actually overlap.", "Agree as a group on one kind act — small or big — to actually carry out this week."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_7, N'short_response', N'🌍 Gratitude Under Pressure

Objective: Practice finding genuine gratitude within a more serious or emotionally complex situation.

Materials: 3-4 scenario cards describing a more significant setback or disappointment

Follow the steps below to play!', NULL, N'Real gratitude doesn''t require pretending hard things don''t hurt — it can sit right beside them.', 3, N'sequence_steps', N'{"steps": ["Read a scenario describing a real disappointment, like not getting picked for something you worked hard for.", "Discuss as a group why forced positivity (''just be grateful!'') can sometimes feel dismissive.", "Brainstorm genuine, honest gratitude that can coexist with disappointment, not replace it.", "Reflect: how is ''gratitude alongside disappointment'' different from ''gratitude instead of it''?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_7, N'short_response', N'🔁 Gratitude Ripple Mapping

Objective: Practice tracing how one act of gratitude or appreciation can influence a wider circle of people.

Materials: Paper | Pencil

Follow the steps below to play!', NULL, N'Gratitude often traces back further than the one person right in front of you.', 4, N'sequence_steps', N'{"steps": ["Pick one person you''re grateful for and map out how their help reached you (who helped them along the way?).", "Sketch a simple diagram showing the chain of people connected to that one moment of gratitude.", "Share your map with the group and discuss what surprised you.", "Consider: who might be at the start of a ripple that eventually reaches you without you even realizing it?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_7, N'short_response', N'🗣️ Integrity Under Pressure: Peer Panel

Objective: Practice discussing multiple realistic honesty-under-pressure dilemmas as a panel and comparing responses.

Materials: 2-3 layered scenario cards involving peer pressure and honesty

Follow the steps below to play!', NULL, N'Hearing how others handle the same hard choice can give you more tools for your own.', 5, N'sequence_steps', N'{"steps": ["Split into small groups, each assigned a different layered honesty dilemma.", "Each group discusses and prepares their best honest, respectful response.", "Present your group''s scenario and response to the full group as a short ''panel.''", "Compare responses across groups: what approaches came up again and again?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_7, N'short_response', N'🧭 Honesty Compass: Real-World Edition

Objective: Practice applying an honesty framework to a dilemma drawn from real or realistic everyday situations.

Materials: 1-2 realistic dilemma cards drawn from school, friendship, or online situations

Follow the steps below to play!', NULL, N'The best honesty compass considers not just what''s true, but who it affects.', 6, N'sequence_steps', N'{"steps": ["Read a realistic dilemma involving honesty and competing loyalties.", "As a group, identify who could be affected by each possible honest response.", "Choose the response that best balances honesty, fairness, and care for others.", "Reflect individually: has something like this ever actually happened to you, and what did you do?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_7, N'short_response', N'🧠 Fixed vs Growth: Real Talk Edition

Objective: Practice identifying fixed-mindset language in real conversations and practicing a growth-mindset reply.

Materials: Paper | Pencil

Follow the steps below to play!', NULL, N'Catching fixed-mindset language in real conversations — not just on cards — is where the real practice happens.', 7, N'sequence_steps', N'{"steps": ["Recall a recent moment when you or someone around you said something fixed-mindset, like ''I''m just not a math person.''", "Write down what a growth-mindset reply could have sounded like instead.", "Practice saying that growth-mindset reply out loud with a partner.", "Discuss: how might that small change in language have changed the rest of the conversation?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_7, N'short_response', N'📊 Growth Mindset Self-Audit: Deep Dive

Objective: Practice a more detailed reflection connecting mindset patterns to specific past challenges and future plans.

Materials: Paper | Pencil

Follow the steps below to play!', NULL, N'Planning your growth-mindset self-talk ahead of time makes it easier to use when you actually need it.', 8, N'sequence_steps', N'{"steps": ["Think of a specific challenge you faced this year and how you talked to yourself about it.", "Rate how fixed or growth-mindset your self-talk was during that challenge.", "Write one sentence describing how you''d like to talk to yourself the next time something similar happens.", "Share with a partner and discuss what makes it hard to remember to use growth-mindset self-talk in the moment."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_7, N'short_response', N'🌐 Netiquette Case Studies

Objective: Practice analyzing realistic digital-communication case studies and proposing thoughtful, respectful responses.

Materials: 4-5 detailed realistic case-study scenarios about group chats, comments, or messaging

Follow the steps below to play!', NULL, N'Thinking through digital dilemmas ahead of time makes it easier to respond well in the actual moment.', 9, N'sequence_steps', N'{"steps": ["Read a detailed case study involving a digital communication conflict or gray area.", "Discuss in small groups what a respectful, responsible response could look like, and why.", "Consider more than one option and weigh their pros and cons.", "Present your group''s recommended response and reasoning to the full group."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_7, N'short_response', N'🗳️ Respectful Disagreement Panel: Cross Views

Objective: Practice representing and respectfully defending a viewpoint you don''t personally hold, to build empathy for other perspectives.

Materials: A mild discussion topic with multiple valid viewpoints | Assigned viewpoint cards

Follow the steps below to play!', NULL, N'Respectfully arguing a view you don''t hold is one of the fastest ways to build empathy for people who do.', 10, N'sequence_steps', N'{"steps": ["Each participant is assigned a viewpoint to argue, which may not be their own personal opinion.", "Prepare your best respectful case for your assigned viewpoint.", "Hold a structured discussion where each side is heard fully before responding.", "Reflect afterward: did arguing a different viewpoint change how you understand people who hold it?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_7, N'short_response', N'🎯 Long-Term Goal Challenge: Mentor Edition

Objective: Practice mentoring a younger student or peer through a small perseverance challenge and reflecting on what good mentoring looks like.

Materials: Paper | Pencil

Follow the steps below to play!', NULL, N'Helping someone else persevere often teaches you just as much about your own perseverance.', 11, N'sequence_steps', N'{"steps": ["Pair up with a younger student or peer working on a goal of their own.", "Offer specific, encouraging support and check in on their progress over a set period.", "Reflect on what kind of support actually helped them keep going.", "Discuss as a group: how is mentoring someone else''s perseverance different from managing your own?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_7, N'short_response', N'🔁 Setback Reframe Discussion: Long View

Objective: Practice reframing a setback with a longer-term perspective, considering how it might look a year from now.

Materials: Paper | Pencil

Follow the steps below to play!', NULL, N'Most setbacks look smaller from a year away than they do in the moment.', 12, N'sequence_steps', N'{"steps": ["Think of a real or realistic setback and write down how it feels right now.", "Imagine looking back on this setback a year from now — write what you think you might say about it then.", "Compare the two perspectives and discuss what changed.", "Share with a partner: does imagining the long view make the setback feel any different today?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_7, N'short_response', N'⚖️ Upstander Dilemma: Escalation Edition

Objective: Practice discussing a multi-step scenario where the right upstander response may need to change as a situation escalates.

Materials: 2-3 multi-part scenario cards where an unkind situation escalates over several steps

Follow the steps below to play!', NULL, N'Knowing when to ask a trusted adult for help is itself a form of courage, not a failure to handle it alone.', 13, N'sequence_steps', N'{"steps": ["Read a scenario that unfolds in stages, starting mild and becoming more serious.", "At each stage, discuss as a group what an upstander response could look like — and whether it needs to change.", "Identify the point where getting a trusted adult involved becomes the right call.", "Reflect: how do you decide when to handle something yourself versus when to ask for help?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_char_7, N'short_response', N'🧩 Team Trust Challenge: Leadership Edition

Objective: Practice leading a small team through a cooperative trust challenge and reflecting on what made your leadership effective.

Materials: A blindfold (or closed eyes) | A simple safe obstacle path | 3-4 teammates

Follow the steps below to play!', NULL, N'Clear, calm communication is one of the fastest ways to earn a team''s trust.', 14, N'sequence_steps', N'{"steps": ["As the designated leader, guide a small blindfolded team one at a time through a safe obstacle path using only clear verbal directions.", "Rotate the leader role so everyone gets a turn leading and being guided.", "As a group, discuss which leader''s directions were easiest to follow, and why.", "Reflect: what does this exercise teach about the kind of communication that earns a team''s trust?"]}');

END
GO

DELETE FROM dbo.WeeklyPacketPlan;
GO