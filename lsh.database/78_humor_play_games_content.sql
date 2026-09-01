-- 78_humor_play_games_content.sql
-- Adds a 'Silly Games & Giggles' category to the existing always-on
-- 'humor_play' subject_area for every grade (TK-6th) — no schema or proc
-- changes needed, reuses dbo.PacketSubjectAreas/usp_GetOrCreateWeeklyPacket
-- exactly as-is.
--
-- Each grade gets a pool of 14 games; target_count=7 (fixed, not the usual
-- ~65% auto-rebalance ratio) means the existing NEWID()-sampling rotation
-- serves a different 7-of-14 combination most weeks a grade's humor_play
-- category is selected, satisfying "7 silly games, different set each week"
-- without any manual per-week authoring.
--
-- Each game is ONE PacketQuestions row: prompt carries the Name/Objective/
-- Materials, diagram_type='sequence_steps' carries the Step-by-Step
-- Instructions (already-shipped diagram type, renders as a numbered list in
-- both the app and print). answer_text carries a short closing tip.
-- See gen_78_humor_play_games_content.py.

IF NOT EXISTS (SELECT 1 FROM dbo.PacketCategories WHERE subject_area = 'humor_play' AND category_name = N'Silly Games & Giggles')
BEGIN
    DECLARE @cat_humor_0 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (0, 'humor_play', N'Silly Games & Giggles', 'space_heavy', 7, N'Get ready to laugh with a silly game this week!', 0);
    SET @cat_humor_0 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_0, N'short_response', N'🐵 Silly Face Mirror

Objective: Practice copying a partner''s funny facial expressions face-to-face.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'The sillier the face, the better — there''s no such thing as too silly here!', 1, N'sequence_steps', N'{"steps": ["Grown-up sits face-to-face with a child.", "Grown-up makes a silly face (crossed eyes, puffed cheeks, big grin).", "Child copies the silly face back as closely as they can.", "Take turns being the ''face maker'' and see how many silly faces you can invent!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_0, N'short_response', N'🐄 Guess That Animal Sound

Objective: Practice listening and guessing which animal made a silly sound.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'There are no wrong guesses in this game — every guess earns a laugh.', 2, N'sequence_steps', N'{"steps": ["Grown-up (or a player) picks a secret animal and makes its sound out loud.", "Everyone else guesses which animal it is.", "Whoever guesses right gets to pick the next animal sound.", "Try extra silly or extra tiny versions of the sound for more giggles!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_0, N'short_response', N'🎈 Catch-the-Giggle Circle

Objective: Practice sharing a laugh with the whole group in a circle.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'It''s okay if the real giggles take over — that means it''s working!', 3, N'sequence_steps', N'{"steps": ["Everyone sits in a circle.", "Grown-up starts with one big silly laugh: ''Ha!''", "Pass the laugh around the circle, each child adding their own giggle sound.", "See if you can make it all the way around before everyone bursts into real giggles!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_0, N'short_response', N'🦆 Waddle Parade

Objective: Practice walking like different animals in a silly parade line.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'The wobblier the waddle, the more the parade laughs.', 4, N'sequence_steps', N'{"steps": ["Grown-up picks the first animal, like a waddling duck.", "Everyone lines up and waddles behind the leader.", "After a lap, pick a new animal walk (elephant stomp, bunny hop, crab scuttle).", "Take turns being the parade leader who picks the next animal!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_0, N'short_response', N'🐻 Big Voice, Tiny Voice

Objective: Practice switching between a big growly voice and a tiny squeaky voice.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'Try squishing your voice smaller and smaller until it disappears into a squeak.', 5, N'sequence_steps', N'{"steps": ["Grown-up says a simple word like ''hello'' in a big bear growl.", "Everyone growls ''hello'' back as loud and big as they can.", "Now say ''hello'' again in the tiniest mouse squeak you can make.", "Keep switching between big and tiny voices for silly words!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_0, N'short_response', N'🙈 Peekaboo Surprise Face

Objective: Practice hiding and revealing a silly surprise face to make a friend giggle.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'Try a new silly face every single time — surprise is half the fun.', 6, N'sequence_steps', N'{"steps": ["One player covers their eyes or hides behind their hands.", "They count ''one, two, three'' out loud.", "On ''three,'' they uncover their face making the silliest surprise face they can.", "Take turns being the surprise-face player!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_0, N'short_response', N'🐸 Hop-Like-a-Frog Says

Objective: Practice listening carefully while copying a leader''s silly animal moves.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'Ribbit as loud as you like while you hop — it makes it extra silly.', 7, N'sequence_steps', N'{"steps": ["Grown-up is the leader and calls out silly animal moves, like ''hop like a frog!''", "Everyone does the silly move together.", "Only move when the leader says an animal — freeze if they just say a move with no animal!", "Take turns being the leader and inventing new silly animal moves."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_0, N'short_response', N'🎭 Funny Face Freeze Dance

Objective: Practice dancing freely and freezing in a silly face when the music stops.

Materials: Music player or phone with speaker

Follow the steps below to play!', NULL, N'Hold your freeze face as long as you can without giggling it away.', 8, N'sequence_steps', N'{"steps": ["Turn on fun music and dance around in a silly way.", "A grown-up pauses the music without warning.", "Everyone freezes instantly, holding their silliest face.", "Turn the music back on and keep dancing until the next freeze!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_0, N'short_response', N'🐷 Oink-Along Story

Objective: Practice listening for a cue word and making an animal sound at just the right moment.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'Listen closely — the cue word can sneak up on you!', 9, N'sequence_steps', N'{"steps": ["Grown-up picks an animal sound, like ''oink,'' for everyone to make.", "Grown-up tells a simple silly story out loud, like ''Once there was a piggy who loved mud puddles...''", "Every time the grown-up says ''piggy,'' everyone shouts ''oink!''", "Try a new animal and sound for the next silly story!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_0, N'short_response', N'🤪 Copy My Silly Move

Objective: Practice copying a partner''s silly body movement exactly.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'It''s okay to forget a move and make up a new silly one instead.', 10, N'sequence_steps', N'{"steps": ["One player invents a silly move, like wiggling their arms and sticking out their tongue.", "Everyone else copies the move together.", "The first player adds one more silly move onto the first.", "Keep copying and adding new silly moves as long as everyone can remember them!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_0, N'short_response', N'🎨 Silly Picture Clue Hunt

Objective: Practice matching a simple spoken clue to a hidden silly picture.

Materials: 3-4 simple animal or object pictures | Tape (to hide the pictures)

Follow the steps below to play!', NULL, N'Acting out the clue with sounds and movements makes it even easier to solve.', 11, N'sequence_steps', N'{"steps": ["Grown-up hides a few simple pictures around the room ahead of time.", "Grown-up gives an easy clue, like ''I say quack and swim in water.''", "Children search for the picture that matches the clue.", "Celebrate with a silly cheer every time a picture is found!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_0, N'short_response', N'😂 Tiny Tickle Countdown

Objective: Practice holding a calm, still face for a few silly seconds before laughing.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'It''s okay to laugh early — this game is really just an excuse to giggle.', 12, N'sequence_steps', N'{"steps": ["Everyone makes their most serious, calm face.", "Grown-up counts down from 3 while making silly faces.", "At ''zero,'' everyone lets their giggles out all at once!", "Try counting down again and see who can stay calm the longest."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_0, N'short_response', N'🗣️ Silly Hello Voices

Objective: Practice greeting friends using a different funny voice each time.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'The silliest voices are usually the ones that surprise even you.', 13, N'sequence_steps', N'{"steps": ["Everyone stands in a circle.", "One player says ''hello'' to the group in a silly voice (robot, opera singer, tiny mouse).", "Everyone says ''hello'' back in that same silly voice.", "Pass the silly voice around the circle so everyone gets a turn choosing!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_0, N'short_response', N'🐘 Trunk Trumpet Walk

Objective: Practice combining a silly walk with a silly sound using a pretend elephant trunk.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'The bigger the trumpet sound, the bigger the elephant giggles.', 14, N'sequence_steps', N'{"steps": ["Everyone links their arms together in front like a long elephant trunk.", "Stomp around slowly like a big elephant.", "Every few steps, lift your ''trunk'' and make a big trumpet sound: ''PAAAA!''", "Take turns leading the elephant parade around the room."]}');

    DECLARE @cat_humor_1 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (1, 'humor_play', N'Silly Games & Giggles', 'space_heavy', 7, N'Get ready to laugh with a silly game this week!', 0);
    SET @cat_humor_1 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_1, N'short_response', N'🙉 Animal Sound Charades

Objective: Practice acting out an animal using only sounds and movements for others to guess.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'Big movements and loud sounds make the guessing even more fun.', 1, N'sequence_steps', N'{"steps": ["One player silently picks an animal in their head.", "They act it out using only sounds and movement — no talking!", "Everyone else calls out guesses until someone gets it right.", "The winner picks the next animal to act out."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_1, N'short_response', N'🎈 Silly Face Freeze Dance

Objective: Practice dancing and freezing in a silly pose the instant the music stops.

Materials: Music player or phone with speaker

Follow the steps below to play!', NULL, N'Try a brand new silly pose every single freeze.', 2, N'sequence_steps', N'{"steps": ["Turn on music and dance around in the silliest way you can.", "A player (or grown-up) pauses the music without warning.", "Freeze immediately in your silliest pose.", "Start the music again and keep dancing until the next freeze!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_1, N'short_response', N'🐸 Hop-and-Croak Relay

Objective: Practice moving quickly like a frog while taking turns in a relay line.

Materials: 2 cones or markers (start/finish)

Follow the steps below to play!', NULL, N'The louder the croak, the funnier the frog hop looks.', 3, N'sequence_steps', N'{"steps": ["Set two markers a short distance apart.", "First player hops like a frog to the far marker while croaking loudly.", "Hop back and tag the next player''s hand.", "Keep going until everyone has had a hopping, croaking turn!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_1, N'short_response', N'🤭 Giggle Chain

Objective: Practice passing a laugh around a circle without breaking the chain.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'Real laughing is allowed to interrupt the chain at any time — that''s the whole point.', 4, N'sequence_steps', N'{"steps": ["Everyone sits in a circle.", "The first player says ''Ha!'' and looks at the next player.", "That player adds another ''Ha!'' — ''Ha, ha!'' — and passes it on.", "Keep adding a ''ha'' around the circle and see how long the chain gets before everyone bursts out laughing for real!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_1, N'short_response', N'🦁 Roar-Like-a-Lion Says

Objective: Practice listening carefully in a silly animal version of a classic following game.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'Listening carefully is the real trick — the roaring is just the reward.', 5, N'sequence_steps', N'{"steps": ["One player is the Leader and calls out silly animal actions.", "If the Leader says ''Lion says roar!'' everyone roars.", "If the Leader just says ''roar!'' with no ''Lion says'' — stay quiet and still!", "Take turns being the Leader and inventing new animal commands."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_1, N'short_response', N'🎭 Mirror Match Funny Faces

Objective: Practice mirroring a partner''s silly facial expressions at the exact same time.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'Moving slowly makes it easier — and funnier — for your mirror partner to keep up.', 6, N'sequence_steps', N'{"steps": ["Pair up and stand facing your partner.", "One partner is the ''mirror leader'' and slowly makes silly faces.", "The other partner copies each face like a mirror reflection.", "Switch who is the leader after a minute and try new faces!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_1, N'short_response', N'🐥 Cluck-and-Guess Riddle Hunt

Objective: Practice solving very easy animal riddles using sound and picture clues.

Materials: 3-4 simple riddle cards with animal pictures on the back

Follow the steps below to play!', NULL, N'Acting out the animal sound while you guess makes the riddle even easier.', 7, N'sequence_steps', N'{"steps": ["Grown-up reads an easy riddle out loud, like ''I say cluck and lay eggs in a nest — who am I?''", "Everyone calls out their guess.", "Flip the card over to reveal the picture and see who was right.", "Move on to the next silly riddle!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_1, N'short_response', N'🚶 Silly Walk Parade

Objective: Practice inventing and following different silly ways of walking.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'The wobblier and slower the walk, the sillier it looks to everyone watching.', 8, N'sequence_steps', N'{"steps": ["One player invents a silly walk, like tiptoeing backward or marching sideways.", "Everyone lines up and follows behind, copying the walk.", "After a lap around the room, a new player invents the next silly walk.", "Keep going until everyone has led a silly walk!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_1, N'short_response', N'🗣️ Robot Talk Challenge

Objective: Practice speaking in a funny robot voice while giving simple instructions.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'Short, choppy robot words make the voice even funnier.', 9, N'sequence_steps', N'{"steps": ["One player becomes the ''Robot'' and can only talk in a stiff, choppy robot voice.", "Another player asks the Robot to do a simple silly action, like ''Robot, wave your arms!''", "The Robot answers ''BEEP. DOING. IT. NOW.'' and does the action.", "Take turns being the Robot!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_1, N'short_response', N'🎪 Clown Nose Copycat

Objective: Practice copying a silly circus-clown walk and wave in a copycat chain.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'It''s more fun to laugh at a forgotten move than to worry about getting it perfect.', 10, N'sequence_steps', N'{"steps": ["One player pretends to be a circus clown, doing a big silly wave and a bouncy walk.", "The next player copies it exactly, then adds one more silly clown move.", "Keep passing the clown routine around the group, each person adding a move.", "See how many silly clown moves the whole group can remember and repeat in order!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_1, N'short_response', N'🤪 Wiggle Worm Dance

Objective: Practice wiggling and moving low to the ground like a silly worm.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'Wiggling in slow motion is somehow even funnier than wiggling fast.', 11, N'sequence_steps', N'{"steps": ["Everyone lies down or crouches low to the ground.", "Wiggle across the floor like a silly worm, no hands or feet allowed!", "Race to a finish line while wiggling as fast as you can.", "Try wiggling in slow motion for extra giggles on the way back."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_1, N'short_response', N'😆 Bubble Laugh Pop

Objective: Practice laughing out loud each time you pop a floating bubble.

Materials: Bubble solution and wand

Follow the steps below to play!', NULL, N'A silly laugh sound for every single pop makes this twice as fun.', 12, N'sequence_steps', N'{"steps": ["A grown-up blows a big batch of bubbles into the air.", "Every time you pop a bubble, let out your silliest laugh sound.", "Try popping with your elbow, your knee, or your nose for extra-silly laughs.", "Blow a new batch and keep the giggles going!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_1, N'short_response', N'🐒 Monkey-See Monkey-Do Chain

Objective: Practice remembering and repeating a growing chain of silly monkey moves.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'Forgetting a move and inventing a brand new one is half the fun.', 13, N'sequence_steps', N'{"steps": ["First player does one silly monkey move, like scratching their head and hooting.", "Next player copies that move, then adds a new monkey move of their own.", "Keep going around the circle, each player repeating the whole chain plus one more move.", "See how long a silly monkey chain the whole group can build!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_1, N'short_response', N'🎨 Silly Sound Guessing Game

Objective: Practice guessing a silly hidden object or animal from clues about the funny sound it makes.

Materials: A few household objects that make funny sounds (optional)

Follow the steps below to play!', NULL, N'The stranger the sound you can make, the trickier — and funnier — the guessing gets.', 14, N'sequence_steps', N'{"steps": ["One player thinks of something silly that makes a funny sound (a bouncy ball, a quacking duck, a squeaky door).", "They make just the sound, no words allowed.", "Everyone else guesses what it could be.", "Whoever guesses correctly picks the next silly sound!"]}');

    DECLARE @cat_humor_2 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (2, 'humor_play', N'Silly Games & Giggles', 'space_heavy', 7, N'Get ready to laugh with a silly game this week!', 0);
    SET @cat_humor_2 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_2, N'short_response', N'😂 Giggle Freeze Tag

Objective: Practice running and freezing in silly poses during a laughter-themed tag game.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'Funny faces work better than tickling for unfreezing a friend.', 1, N'sequence_steps', N'{"steps": ["One player is ''It'' and gently tags others while everyone runs around.", "When tagged, freeze immediately in the silliest pose you can hold.", "You can be unfrozen if another player makes you laugh without touching you!", "Play until everyone is either frozen or giggling too hard to keep going."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_2, N'short_response', N'🃏 Would-You-Rather Silly Showdown

Objective: Practice choosing between two silly options and explaining your reasoning out loud.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'The sillier and more impossible the choice, the better the explanations get.', 2, N'sequence_steps', N'{"steps": ["One player asks a silly ''would you rather'' question, like ''Would you rather have spaghetti hair or jelly shoes?''", "Everyone picks a side of the room based on their answer.", "Take turns explaining why you picked your silly choice.", "The asker becomes the next player to think up a silly question!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_2, N'short_response', N'🐸 Ribbit Relay Race

Objective: Practice passing a silly sound quickly around a circle without dropping it.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'Practice a couple of slow rounds first before racing for real speed.', 3, N'sequence_steps', N'{"steps": ["Everyone stands or sits in a circle.", "The first player turns to a neighbor and says ''ribbit!'' as fast as they can.", "That neighbor passes ''ribbit!'' to the next person immediately.", "Time how fast the ribbit can travel all the way around the circle — then try to beat your best time!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_2, N'short_response', N'🧩 Easy Riddle Treasure Hunt

Objective: Practice solving simple riddles that lead to a hidden silly prize.

Materials: 3-4 written riddle clue cards | A small hidden prize or marker

Follow the steps below to play!', NULL, N'Reading the riddle twice out loud often makes the answer pop into your head.', 4, N'sequence_steps', N'{"steps": ["Grown-up hides riddle cards around the room or yard, each leading to the next.", "Read the first riddle out loud and solve it together, like ''I have hands but no fingers, and I tell you when to go outside and play — what am I?'' (a clock).", "Follow the answer to find the next riddle card.", "Solve all the riddles to find the hidden silly prize at the end!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_2, N'short_response', N'🗣️ Silly Voice Storytime

Objective: Practice retelling a familiar story using a different funny voice for each character.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'Committing fully to your silly voice — even for one word — makes the whole story funnier.', 5, N'sequence_steps', N'{"steps": ["Pick a simple story everyone knows, like a trip to the park.", "Assign each player a character and a silly voice to use (squeaky, deep, robotic).", "Tell the story together, each player speaking their lines in their silly voice.", "Retell it again and swap voices for a whole new silly version!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_2, N'short_response', N'🚶 Wacky Walk Obstacle

Objective: Practice moving through a simple obstacle course using a different silly walk at each station.

Materials: 3-4 cones or markers

Follow the steps below to play!', NULL, N'Going slowly on the backward-walk station keeps everyone safely on course.', 6, N'sequence_steps', N'{"steps": ["Set up 3-4 stations marked by cones.", "At each station, use a different silly walk (crab walk, tiptoe, giant steps, backward walk).", "Go through the whole course from start to finish.", "Race a friend through the course using the same silly walks!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_2, N'short_response', N'🤐 Silent Giggle Challenge

Objective: Practice staying quiet and still while a partner tries to make you laugh without touching or talking.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'Slow, exaggerated silly faces are usually harder to resist than fast ones.', 7, N'sequence_steps', N'{"steps": ["Pair up and sit facing each other.", "One partner tries to make the other laugh using only silly faces and gestures — no talking or touching allowed.", "The other partner tries to keep a completely straight face.", "Switch roles after the first laugh!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_2, N'short_response', N'🎭 Freeze-Frame Funny Pose

Objective: Practice inventing and holding a silly pose the instant a signal is given.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'The more dramatic your freeze, the funnier the whole group photo looks.', 8, N'sequence_steps', N'{"steps": ["Everyone moves around the room normally.", "When the leader shouts a silly theme, like ''superhero!'' or ''scared cat!'' — freeze into that pose instantly.", "Hold the pose for 5 seconds while everyone looks around at each other''s poses.", "Unfreeze and try a brand new silly theme!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_2, N'short_response', N'🐒 Copycat Chain

Objective: Practice remembering and repeating a growing sequence of silly actions.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'Laughing when you forget a move is way more fun than stressing about it.', 9, N'sequence_steps', N'{"steps": ["First player does one silly action, like a wiggly wave.", "Second player repeats that action and adds a new silly one.", "Keep going around the group, repeating the whole chain each time and adding one more move.", "See how long a silly chain the whole group can remember together!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_2, N'short_response', N'🧢 Mystery Hat Charades

Objective: Practice acting out a silly word or phrase without speaking for others to guess.

Materials: Small slips of paper with silly words written on them (cat, robot, pizza, superhero) | A hat or bowl to hold the slips

Follow the steps below to play!', NULL, N'Big, exaggerated movements are always easier — and funnier — to guess than small ones.', 10, N'sequence_steps', N'{"steps": ["Write a few silly words on slips of paper and put them in a hat.", "One player draws a slip and acts it out silently for the group.", "Everyone else calls out guesses until someone gets it right.", "The guesser draws the next slip and acts out a new silly word!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_2, N'short_response', N'🍌 Punny Fruit Basket

Objective: Practice trading places quickly while listening for a silly fruit-based signal word.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'Peeking at an empty chair before you move helps you swap safely and quickly.', 11, N'sequence_steps', N'{"steps": ["Sit in a circle of chairs, one fewer chair than the number of players.", "The player without a chair calls out a fruit, like ''banana!'' — everyone with that assigned fruit swaps seats.", "Call ''fruit basket!'' and everyone must swap seats at once!", "Whoever is left without a chair calls the next fruit."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_2, N'short_response', N'🎨 Silly Sketch Telephone

Objective: Practice drawing a silly phrase and passing it along to see how it changes.

Materials: Paper and pencils for each player

Follow the steps below to play!', NULL, N'Drawing fast and silly (not perfectly) makes the changes even funnier to reveal.', 12, N'sequence_steps', N'{"steps": ["The first player writes a short silly sentence at the top of a paper, like ''A dancing pickle wears roller skates.''", "Fold the sentence back so only it shows, pass to the next player, who draws a picture of it.", "Fold the drawing back so only the picture shows, pass along, and the next player writes what they think it shows.", "Keep going around, then unfold the whole paper and read the silly changes out loud!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_2, N'short_response', N'🔤 Silly Sentence Chain

Objective: Practice building a long silly sentence together, one word at a time.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'Adding an unexpected word on purpose usually gets the biggest laugh.', 13, N'sequence_steps', N'{"steps": ["The first player says one word to start a sentence, like ''A.''", "The next player adds one more word, like ''A giant.''", "Keep adding one word each turn, trying to make the sentence as silly as possible.", "When the sentence gets too silly to continue, read the whole thing out loud together and start a new one!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_2, N'short_response', N'🧠 Brain Tickler Riddle Hunt

Objective: Practice solving a set of easy riddles as a team, one at a time.

Materials: 4-5 written riddle cards

Follow the steps below to play!', NULL, N'Saying the riddle slowly, word by word, helps the clues stand out.', 14, N'sequence_steps', N'{"steps": ["Lay out 4-5 easy riddle cards face down.", "Take turns flipping a card and reading the riddle out loud, like ''What has a face and hands but cannot clap?'' (a clock).", "Everyone guesses together before flipping to check the answer.", "See how many riddles the group can solve without a single hint!"]}');

    DECLARE @cat_humor_3 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (3, 'humor_play', N'Silly Games & Giggles', 'space_heavy', 7, N'Get ready to laugh with a silly game this week!', 0);
    SET @cat_humor_3 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_3, N'short_response', N'🤣 Laugh Attack Circle

Objective: Practice starting and catching a wave of laughter passed around a circle.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'Fake laughing almost always turns into real laughing within a few seconds.', 1, N'sequence_steps', N'{"steps": ["Sit in a circle and hold hands or link elbows.", "The first player starts laughing on purpose, as big and silly as they can.", "Each person joins in one at a time, going around the circle.", "See how long the whole group can keep the laugh attack going before it turns into real giggles!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_3, N'short_response', N'🃏 Silly Would-You-Rather Tournament

Objective: Practice comparing two silly options and defending a choice in a bracket-style challenge.

Materials: Paper and pencil (to track the bracket, optional)

Follow the steps below to play!', NULL, N'Wild, unexpected reasons usually win more votes than logical ones.', 2, N'sequence_steps', N'{"steps": ["Come up with 4 or 8 silly ''would you rather'' questions ahead of time.", "Two players face off on one question at a time, each explaining their pick.", "The group votes on whose reasoning was funnier or more convincing.", "Winners move on to the next round until one champion silly answer remains!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_3, N'short_response', N'🧩 Riddle Relay Race

Objective: Practice solving riddles quickly as a team member races to the next clue.

Materials: 4-5 riddle cards | 2 cones (start/finish)

Follow the steps below to play!', NULL, N'Reading the riddle out loud on the run helps you start solving before you even stop.', 3, N'sequence_steps', N'{"steps": ["Split into two teams, each with an identical set of riddle cards at the far cone.", "First racer runs to the cone, solves one riddle, and races back to tag the next teammate.", "That teammate runs out to solve the next riddle in the pile.", "First team to solve every riddle correctly wins the relay!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_3, N'short_response', N'🎤 Open Mic Giggles

Objective: Practice telling an original silly joke to a group and delivering the punchline with good timing.

Materials: A spoon or stick as a pretend microphone (optional)

Follow the steps below to play!', NULL, N'A short pause right before the funny part almost always makes it land better.', 4, N'sequence_steps', N'{"steps": ["Each player thinks up one short, original silly joke ahead of time.", "Take turns stepping up to the ''mic'' and telling your joke to the group.", "Pause right before the punchline to build up the laugh.", "Give every joke-teller a round of applause, no matter what!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_3, N'short_response', N'🚶 Silly Walk This Way

Objective: Practice inventing an original silly walk and teaching it to the group.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'Naming your silly walk out loud, like ''the noodle stomp,'' makes it even funnier.', 5, N'sequence_steps', N'{"steps": ["Each player invents their own brand-new silly walk.", "Take turns demonstrating your walk while everyone else copies it exactly.", "Line up and do a full silly-walk parade combining everyone''s inventions.", "Vote (just for fun) on the wobbliest walk of the day!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_3, N'short_response', N'🗣️ Voice Swap Storytelling

Objective: Practice telling a group story while randomly swapping silly voices on command.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'The best swaps happen mid-sentence, right when it''s least expected.', 6, N'sequence_steps', N'{"steps": ["One player starts telling a simple made-up story out loud.", "At any moment, another player can call out ''swap!'' and the storyteller must switch to a brand-new silly voice.", "Keep the story going, swapping voices every time someone calls it.", "Take turns being the storyteller!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_3, N'short_response', N'🙊 Straight Face Challenge

Objective: Practice keeping a calm, serious face while a partner tells silly jokes.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'Answering in a serious voice, even to something silly, is the real challenge here.', 7, N'sequence_steps', N'{"steps": ["Pair up, facing each other.", "One partner tells silly jokes or makes goofy comments, trying to get a laugh.", "The other partner tries to answer only in a flat, serious voice without cracking a smile.", "Switch roles after the first laugh — or after a full minute if nobody breaks!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_3, N'short_response', N'🎭 Statue of Silliness

Objective: Practice freezing into an increasingly silly pose each round without moving.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'Small changes each round — like one raised eyebrow — build up to something very silly.', 8, N'sequence_steps', N'{"steps": ["Everyone starts in a normal standing pose.", "On ''freeze,'' everyone locks into a slightly sillier version of their pose than last round.", "After a few seconds, unfreeze and get ready for the next, even sillier round.", "Keep going until someone''s pose is so silly the whole group has to laugh!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_3, N'short_response', N'🐒 Copy Cat Commander

Objective: Practice giving and following a growing sequence of silly commands from memory.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'Doing the actions along with saying them out loud helps everyone remember the sequence.', 9, N'sequence_steps', N'{"steps": ["One player is the ''Commander'' and gives one silly command, like ''flap like a chicken.''", "Everyone does it, then the Commander adds a second command onto the first.", "Keep adding commands, repeating the whole sequence each round.", "See how many silly commands the group can remember in a row!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_3, N'short_response', N'🧢 Mystery Hat Charades

Objective: Practice acting out a trickier silly phrase without speaking, using only gestures.

Materials: Slips of paper with silly phrases (a dancing robot, a sneezing dinosaur) | A hat or bowl

Follow the steps below to play!', NULL, N'Acting out one word at a time, then combining them, makes tricky phrases easier to guess.', 10, N'sequence_steps', N'{"steps": ["Write several two- or three-word silly phrases on slips and place them in a hat.", "One player draws a slip and acts out the whole phrase silently.", "The group calls out guesses until the full phrase is solved.", "Take turns drawing and acting until the hat is empty!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_3, N'short_response', N'🍎 Punny Show-and-Tell

Objective: Practice making up a silly pun about an everyday object.

Materials: A random household object per player (or picture of one)

Follow the steps below to play!', NULL, N'Puns about the object''s shape, sound, or use are usually the easiest to think of.', 11, N'sequence_steps', N'{"steps": ["Each player picks (or is given) a random everyday object.", "Think of one silly pun or wordplay joke about that object.", "Take turns showing the object and telling your pun to the group.", "Vote (just for fun) on the punniest joke of the round!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_3, N'short_response', N'🎨 Doodle Down the Line

Objective: Practice drawing and guessing a chain of silly phrases as they change down the line.

Materials: Paper and pencils for each player

Follow the steps below to play!', NULL, N'Quick, rough sketches usually lead to funnier mix-ups than careful drawings.', 12, N'sequence_steps', N'{"steps": ["The first player writes a short silly sentence at the top of the paper.", "Fold it over, pass it on, and the next player draws a quick picture of just that sentence.", "Fold the drawing over, pass it on, and the next player writes what they think the picture shows.", "Keep going, then unfold the whole chain and read how silly it became!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_3, N'short_response', N'🔤 Add-a-Word Story Battle

Objective: Practice building a long, silly story as a team, one word at a time, without breaking the flow.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'Adding a surprising word, even if it doesn''t quite fit, often makes the story funnier.', 13, N'sequence_steps', N'{"steps": ["Split into two small teams.", "Each team builds its own silly story together, one word per player added in turn.", "After 2 minutes, both teams read their finished silly stories out loud.", "Vote (just for fun) on which team''s story turned out sillier!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_3, N'short_response', N'🧠 Brain Tickler Riddle Battle

Objective: Practice solving trickier riddles quickly in a friendly team competition.

Materials: 6-8 riddle cards of medium difficulty

Follow the steps below to play!', NULL, N'Thinking about what the riddle does NOT mean can help rule out wrong guesses fast.', 14, N'sequence_steps', N'{"steps": ["Split into two teams.", "Read one riddle at a time out loud to both teams, like ''The more you take, the more you leave behind — what am I?'' (footsteps).", "First team to shout the correct answer earns a point.", "Team with the most points after all riddles wins the Brain Tickler Battle!"]}');

    DECLARE @cat_humor_4 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (4, 'humor_play', N'Silly Games & Giggles', 'space_heavy', 7, N'Get ready to laugh with a silly game this week!', 0);
    SET @cat_humor_4 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_4, N'short_response', N'🎤 Joke Slam Showdown

Objective: Practice telling an original joke with clear timing and a strong punchline delivery.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'The exact same joke can land differently depending on how slowly you build up to it.', 1, N'sequence_steps', N'{"steps": ["Each player writes or thinks up one original joke ahead of time.", "Take turns performing your joke for the group, pausing before the punchline.", "The group rates each joke with a silly cheer level (giggle, chuckle, or full laugh).", "After everyone has gone, talk about which delivery style got the biggest laughs!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_4, N'short_response', N'🧠 Riddle Master Challenge

Objective: Practice solving multi-step riddles that require careful listening and logical thinking.

Materials: 6-8 riddle cards of increasing difficulty

Follow the steps below to play!', NULL, N'Reading a riddle twice — once fast, once slow — often reveals a clue you missed the first time.', 2, N'sequence_steps', N'{"steps": ["Arrange riddle cards from easiest to hardest.", "Take turns reading a riddle aloud and giving the group 30 seconds to solve it silently.", "Reveal the answer and award a point to anyone who got it right.", "See who becomes the Riddle Master with the most points by the hardest riddle!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_4, N'short_response', N'🃏 Would You Rather Debate Club

Objective: Practice defending a silly opinion with real reasons in a mini debate format.

Materials: A few written silly ''would you rather'' prompts

Follow the steps below to play!', NULL, N'Committing fully and seriously to a silly argument is what makes it funniest.', 3, N'sequence_steps', N'{"steps": ["Pick a silly would-you-rather prompt, like ''Would you rather talk backward forever or whisper everything you say?''", "Split into two sides based on your answer.", "Each side gets one minute to argue why their silly choice is actually the better one.", "Hold a friendly vote on which side gave the funniest, most convincing argument!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_4, N'short_response', N'🙊 Poker Face Contest

Objective: Practice maintaining a completely neutral expression while classmates try to make you laugh.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'Staring slightly past someone''s face instead of directly at their eyes can help you keep a straight face.', 4, N'sequence_steps', N'{"steps": ["One player sits in the ''hot seat'' and must keep a totally straight face.", "Other players take turns (30 seconds each) trying to make them laugh using only words and expressions — no touching.", "If the hot-seat player laughs, whoever caused it takes the next turn in the hot seat.", "See who can hold the longest poker face streak!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_4, N'short_response', N'😂 Pun Battle Royale

Objective: Practice thinking up original puns quickly on a given topic under friendly pressure.

Materials: A hat or bowl with topic slips (food, animals, weather, school)

Follow the steps below to play!', NULL, N'Thinking of a word that sounds like another word on the topic is the fastest way to find a pun.', 5, N'sequence_steps', N'{"steps": ["Draw a topic slip from the hat, like ''food.''", "Going around the circle, each player has 10 seconds to say an original pun about that topic.", "If you can''t think of one in time, you''re out for that round — everyone else keeps going.", "Draw a new topic each round until only the Pun Champion remains!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_4, N'short_response', N'🚶 Silly Walk Inventors

Objective: Practice designing, naming, and demonstrating an original silly walk with a backstory.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'A ridiculous backstory almost always makes a silly walk funnier than the walk alone.', 6, N'sequence_steps', N'{"steps": ["Each player invents a brand-new silly walk and gives it a funny name and backstory (e.g., ''the melting popsicle shuffle'').", "Take turns demonstrating your walk and explaining its silly backstory.", "Everyone tries out each other''s silly walks.", "Vote (just for fun) on the most creative silly walk invention!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_4, N'short_response', N'🗣️ Voice-Over Theater

Objective: Practice dubbing a silent scene with original silly dialogue and character voices.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'Exaggerating the character''s emotions in your voice makes the dubbed dialogue funnier.', 7, N'sequence_steps', N'{"steps": ["Two players act out a short silent scene (like arguing over the last snack) with no talking.", "A third player provides live silly voice-over dialogue for both characters.", "Switch roles so everyone gets a turn as an actor and as the voice-over artist.", "Perform your favorite scene again for an encore!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_4, N'short_response', N'🎭 Freeze Frame Comedy

Objective: Practice creating and narrating a funny frozen scene with a partner.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'The most unexpected explanation for a pose is usually the funniest one.', 8, N'sequence_steps', N'{"steps": ["Two or three players freeze into a random silly pose together, like a group photo.", "The rest of the group makes up a funny story about what''s happening in the ''photo.''", "The frozen players can add one silly sound effect without moving.", "Switch who freezes and who narrates for the next round!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_4, N'short_response', N'🧩 Escape the Giggle Room

Objective: Practice solving a chain of riddles under a friendly time limit to ''escape'' the game.

Materials: 4-5 connected riddle clues | A timer or stopwatch

Follow the steps below to play!', NULL, N'Talking through each clue out loud as a group usually leads to the answer faster than solving alone.', 9, N'sequence_steps', N'{"steps": ["Set up 4-5 riddles where each answer points to the next clue''s hiding spot.", "Start the timer and work together to solve the first riddle.", "Follow each answer to find the next riddle until you reach the final one.", "Beat the clock to ''escape'' — then reset and try to beat your best time!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_4, N'short_response', N'🍕 Punny Menu Madness

Objective: Practice inventing silly pun-based menu items for a pretend restaurant.

Materials: Paper and pencil

Follow the steps below to play!', NULL, N'Combining two ordinary words into one silly new word is the easiest way to build a menu pun.', 10, N'sequence_steps', N'{"steps": ["As a group, invent a pretend restaurant with a silly theme.", "Each player writes 1-2 pun-based menu items, like ''Ribbit Soup'' or ''Moo-shroom Pizza.''", "Take turns reading your menu items aloud like a waiter presenting specials.", "Combine everyone''s items into one giant silly menu and read the whole thing together!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_4, N'short_response', N'🎪 Story Chain Circus

Objective: Practice building a long, silly circus-themed story together one sentence at a time.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'Adding an unexpected circus character mid-story usually gets the biggest laugh.', 11, N'sequence_steps', N'{"steps": ["The first player starts a silly circus story with one sentence, like ''The tightrope-walking elephant forgot her tutu.''", "Each player adds one new sentence, keeping the story going and getting sillier.", "Keep circling the group until the story reaches a silly ending.", "Retell the whole finished story together from the start!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_4, N'short_response', N'🧢 Mystery Object Charades

Objective: Practice acting out a silly imagined use for a mystery object without naming or speaking about it.

Materials: Small slips describing silly imaginary objects (a shrinking umbrella, a talking sandwich) | A hat or bowl

Follow the steps below to play!', NULL, N'Reacting to the object''s imaginary silly features (like it shrinking or talking back) gives the best clues.', 12, N'sequence_steps', N'{"steps": ["Write silly imaginary object descriptions on slips and place them in a hat.", "One player draws a slip and acts out using the object silently.", "The group guesses what the mystery object is and how it''s being used.", "Take turns until every silly object has been acted out!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_4, N'short_response', N'🔤 Wordplay Wizard

Objective: Practice spotting and creating wordplay by swapping first sounds between two words.

Materials: Paper and pencil (optional)

Follow the steps below to play!', NULL, N'Starting with two words that begin with different sounds makes the swap easiest to guess.', 13, N'sequence_steps', N'{"steps": ["One player says two ordinary words, like ''silly dog.''", "Swap the first sounds to make a new silly phrase: ''dilly sog.''", "Everyone tries to guess the original phrase from the swapped version.", "Take turns creating and guessing new silly word swaps!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_4, N'short_response', N'🏆 Comedy Club Tournament

Objective: Practice performing an original joke or short bit in a friendly bracket-style competition.

Materials: Paper and pencil (to track the bracket, optional)

Follow the steps below to play!', NULL, N'Confidence in your delivery matters just as much as the joke itself.', 14, N'sequence_steps', N'{"steps": ["Each player prepares one short original joke or silly bit ahead of time.", "Perform head-to-head against one other player; the group votes on the funnier bit.", "Winners advance to the next round until a Comedy Club Champion is crowned.", "Give the runner-up a round of applause too — everyone made it funnier!"]}');

    DECLARE @cat_humor_5 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (5, 'humor_play', N'Silly Games & Giggles', 'space_heavy', 7, N'Get ready to laugh with a silly game this week!', 0);
    SET @cat_humor_5 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_5, N'short_response', N'🎤 Stand-Up Spotlight

Objective: Practice performing a short original stand-up bit with confident pacing and stage presence.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'A well-placed pause often gets a bigger laugh than rushing straight to the punchline.', 1, N'sequence_steps', N'{"steps": ["Each performer prepares 2-3 original one-liners or a short silly story ahead of time.", "Take the ''spotlight'' one at a time and perform your full bit for the group.", "Use pauses, facial expressions, and timing to land each joke.", "After everyone performs, share one thing you noticed that made a bit especially funny!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_5, N'short_response', N'🧠 Riddle Relay Championship

Objective: Practice solving increasingly tricky riddles under time pressure as part of a relay team.

Materials: 8-10 riddle cards ranked by difficulty | 2 cones (start/finish)

Follow the steps below to play!', NULL, N'Assigning each teammate a riddle ''specialty'' (wordplay, math, animals) ahead of time can speed up the relay.', 2, N'sequence_steps', N'{"steps": ["Split into two teams with an identical stack of riddles at the far cone.", "One runner at a time races out, solves a riddle correctly, and races back to send the next runner.", "If a runner can''t solve it in 20 seconds, they must race back and let a teammate try next.", "First team to correctly solve every riddle in order wins the championship!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_5, N'short_response', N'🃏 Would You Rather Debate League

Objective: Practice building a persuasive, funny argument for a silly choice in a structured debate format.

Materials: A list of silly would-you-rather prompts

Follow the steps below to play!', NULL, N'One well-timed silly example beats three vague reasons in a debate.', 3, N'sequence_steps', N'{"steps": ["Draw a silly would-you-rather prompt and split into two debate teams by choice.", "Each team gets 90 seconds to prepare three funny reasons supporting their side.", "Present your arguments back and forth, then let the group vote for the funnier case.", "Play multiple rounds and track which team wins the most debates!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_5, N'short_response', N'🙊 Stone-Face Standoff

Objective: Practice holding a neutral expression under increasingly silly pressure in a head-to-head format.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'Responding to silliness with an even more serious, deadpan reply throws opponents off.', 4, N'sequence_steps', N'{"steps": ["Two players face off, sitting knee to knee.", "Take turns saying the silliest thing you can think of to try to break your opponent''s straight face.", "No touching allowed — words and expressions only.", "Whoever laughs first loses that round; play best two out of three!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_5, N'short_response', N'😂 Pun-slinger Duel

Objective: Practice quickly generating original puns in a fast-paced back-and-forth challenge.

Materials: A hat or bowl with topic slips

Follow the steps below to play!', NULL, N'Listening closely to your opponent''s last pun can spark your next one.', 5, N'sequence_steps', N'{"steps": ["Two players face off on a drawn topic, like ''space'' or ''sports.''", "Take turns saying one original pun about the topic within 5 seconds.", "Keep going back and forth until one player can''t think of a new pun in time.", "The group votes on the funniest single pun from the whole duel!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_5, N'short_response', N'🚶 Invent-a-Walk Challenge

Objective: Practice designing an original silly walk that tells a mini physical-comedy story.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'Adding one unexpected twist partway through the walk makes the mini story land better.', 6, N'sequence_steps', N'{"steps": ["Each player invents a silly walk that acts out a tiny story, like someone stepping on gum, then bubblegum-stretching away.", "Perform your walk for the group without explaining it first.", "Everyone guesses the mini story your walk was telling.", "Reveal the real story and see how close the guesses were!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_5, N'short_response', N'🗣️ Dubbing Theater

Objective: Practice improvising silly character voices to dub a partner''s silent physical performance.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'Matching your voice-over''s emotion to the actor''s exaggerated expression sells the joke.', 7, N'sequence_steps', N'{"steps": ["Two players silently act out a short scene with big, clear physical expressions.", "Two other players provide live improvised dialogue and sound effects for them.", "Switch roles after each scene so everyone dubs and everyone acts.", "Vote (just for fun) on the funniest dubbed scene of the day!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_5, N'short_response', N'🎭 Comedy Freeze Improv

Objective: Practice building an improvised silly scene that starts from a random frozen pose.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'Saying ''yes, and...'' to your scene partner''s ideas keeps the improvised comedy flowing.', 8, N'sequence_steps', N'{"steps": ["Two players freeze in a random silly connected pose.", "On ''action,'' they must instantly improvise a scene that explains why they''re in that pose.", "Play the scene for about 30 seconds, then freeze again in a new pose to end it.", "Rotate players and try a brand-new random pose each round!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_5, N'short_response', N'🧩 Riddle Escape Challenge

Objective: Practice working as a team to solve a connected chain of tricky riddles before time runs out.

Materials: 5-6 connected riddle clues | A timer

Follow the steps below to play!', NULL, N'If a riddle stumps the group, move on and come back to it — a fresh look often reveals the answer.', 9, N'sequence_steps', N'{"steps": ["Set up a chain of riddles where solving one reveals where to find the next.", "Set a team time limit, like 8 minutes, and start the timer together.", "Work together, discussing possible answers before committing to one.", "''Escape'' by solving the final riddle before time runs out — then try to beat your record!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_5, N'short_response', N'🍕 Menu Pun Chef

Objective: Practice writing a full themed menu of clever original food puns.

Materials: Paper and pencil

Follow the steps below to play!', NULL, N'The best food puns usually combine a real ingredient with a matching sound-alike word.', 10, N'sequence_steps', N'{"steps": ["Pick a silly restaurant theme as a group, like a superhero diner or a dinosaur bakery.", "Each ''chef'' writes 2-3 pun-based dishes that fit the theme.", "Present your dishes to the group like a menu tasting, explaining the pun in each name.", "Combine everyone''s dishes into one finished silly menu and read it aloud together!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_5, N'short_response', N'🎪 Circus Story Builder

Objective: Practice collaboratively building a detailed, silly circus story with a clear silly twist ending.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'Planting a small silly detail early in the story makes a great twist to bring back at the end.', 11, N'sequence_steps', N'{"steps": ["As a group, decide on the circus setting and main silly character together.", "Take turns adding a sentence, building rising silliness toward a twist.", "The last player must deliver a silly twist ending to wrap up the story.", "Retell the full story from start to finish for a final laugh!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_5, N'short_response', N'🧢 Mystery Bag Charades

Objective: Practice using a real hidden object as inspiration for an invented, silly-use charades scene.

Materials: A bag with a few random small objects inside | A hat or bowl (optional)

Follow the steps below to play!', NULL, N'Committing fully to the imaginary use — even if it makes no logical sense — gets the biggest laughs.', 12, N'sequence_steps', N'{"steps": ["One player reaches into the bag without looking and pulls out an object.", "Without naming it, act out a silly, made-up use for the object (not its real use).", "The group guesses the silly imagined use, then reveals what the object actually is.", "Take turns pulling new objects and inventing new silly uses!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_5, N'short_response', N'🔤 Word Twist Championship

Objective: Practice quickly rearranging or altering words to create original silly new phrases.

Materials: Paper and pencil (optional)

Follow the steps below to play!', NULL, N'Swapping just one or two letters at a time usually creates the silliest, most sayable twists.', 13, N'sequence_steps', N'{"steps": ["One player says an ordinary phrase, like ''happy birthday.''", "The next player has 10 seconds to twist it into something silly, like ''nappy dirtday.''", "Keep the twisting phrase going around the group, building on the last twist.", "See how far the phrase can twist before it becomes impossible to say out loud!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_5, N'short_response', N'🏆 Giggle Games Tournament

Objective: Practice competing across several silly mini-games in a single combined tournament.

Materials: Whatever materials the chosen mini-games need (see other Silly Games entries)

Follow the steps below to play!', NULL, N'Awarding bonus points for ''funniest moment'' keeps the tournament about laughs, not just winning.', 14, N'sequence_steps', N'{"steps": ["Pick 3-4 favorite silly games from this list to combine into one tournament.", "Play each mini-game for a set time, awarding points for wins or funniest moments.", "Track total points across all mini-games on a simple scoreboard.", "Whoever has the most points after all rounds is crowned Giggle Games Champion!"]}');

    DECLARE @cat_humor_6 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (6, 'humor_play', N'Silly Games & Giggles', 'space_heavy', 7, N'Get ready to laugh with a silly game this week!', 0);
    SET @cat_humor_6 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_6, N'short_response', N'🎤 Open Mic Comedy Night

Objective: Practice writing and performing a polished short comedy set with a clear structure.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'Ending on your strongest joke, not your weakest, leaves the audience laughing as you finish.', 1, N'sequence_steps', N'{"steps": ["Each performer writes a short set with an opening joke, a middle bit, and a strong closing line.", "Introduce yourself to the ''audience'' before performing your full set.", "Perform with confident pacing, using pauses and expressions to land each joke.", "After Open Mic Night, discuss as a group what made the strongest sets work."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_6, N'short_response', N'🧠 Riddle Master''s Gauntlet

Objective: Practice solving a full sequence of increasingly difficult riddles without any hints.

Materials: 10-12 riddle cards ranked from easy to very tricky

Follow the steps below to play!', NULL, N'The hardest riddles often hide their trick in a word that seems to mean something obvious but doesn''t.', 2, N'sequence_steps', N'{"steps": ["Arrange the riddles from easiest to hardest, forming a ''gauntlet.''", "Work through the sequence, solving each riddle before moving to the next.", "If a riddle stumps the group for over a minute, you may skip it once and come back later.", "See how far through the gauntlet the group can get with the fewest skips!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_6, N'short_response', N'🃏 Would You Rather Grand Debate

Objective: Practice constructing and delivering a multi-point persuasive argument for a silly position.

Materials: A list of especially tricky silly would-you-rather prompts

Follow the steps below to play!', NULL, N'A rebuttal that turns the other side''s own point into a joke usually wins over the crowd.', 3, N'sequence_steps', N'{"steps": ["Draw a genuinely tough silly prompt and split into two sides.", "Each side prepares a 2-minute opening argument with at least three distinct points.", "Present arguments, then take one round of rebuttals responding to the other side.", "Hold a final vote for the Grand Debate winner based on humor and persuasiveness!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_6, N'short_response', N'🙊 Iron Face Challenge

Objective: Practice sustaining total composure through an extended round of group silliness.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'Focusing on breathing slowly and evenly helps hold a straight face longer than trying to think of nothing.', 4, N'sequence_steps', N'{"steps": ["One player sits in the center as the ''Iron Face'' contestant.", "The rest of the group takes turns, one at a time, trying to break their composure for 15 seconds each.", "No touching — only words, faces, and sounds are allowed.", "See how many rounds in a row the Iron Face contestant can survive before cracking!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_6, N'short_response', N'😂 Pun Championship Series

Objective: Practice generating high-quality original puns across multiple themed rounds of competition.

Materials: A list of varied topic categories

Follow the steps below to play!', NULL, N'The strongest puns usually play on a word with two very different meanings, not just similar sounds.', 5, N'sequence_steps', N'{"steps": ["Play several rounds, each on a new topic category (school, sports, weather, animals).", "In each round, players take turns offering one original pun until someone can''t continue.", "Award a round win to the last player standing in each category.", "Whoever wins the most rounds overall becomes the Pun Champion of the series!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_6, N'short_response', N'🚶 Silly Walk Olympics

Objective: Practice designing and performing original silly walks judged across multiple creative categories.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'A silly walk with a clear character or backstory tends to score higher than movement alone.', 6, N'sequence_steps', N'{"steps": ["As a group, agree on 3 judging categories, like ''most creative,'' ''wobbliest,'' and ''best story.''", "Each player performs one original silly walk for all three categories.", "The group scores each walk out loud (just for fun) in each category.", "Add up scores across categories to crown the Silly Walk Olympics champion!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_6, N'short_response', N'🗣️ Voice Actor Showdown

Objective: Practice performing multiple distinct silly character voices within a single improvised scene.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'Changing your posture and where you''re looking, not just your voice, makes each character clearer.', 7, N'sequence_steps', N'{"steps": ["One player performs a short improvised scene playing at least three different silly characters.", "Switch clearly between voices, postures, and expressions for each character.", "The group guesses when a new character has entered the scene.", "Take turns performing your own multi-character showdown scene!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_6, N'short_response', N'🎭 Improv Freeze Theater

Objective: Practice building and quickly rebuilding improvised silly scenes triggered by random freezes.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'Justifying the frozen pose with the most unexpected explanation usually kicks off the funniest new scene.', 8, N'sequence_steps', N'{"steps": ["Two players start an improvised silly scene based on a suggestion from the group.", "At any point, another player can shout ''freeze!'' and tap one performer to swap in.", "The new player must start a brand-new scene from the exact frozen pose.", "Keep freezing and swapping to build a whole chain of connected silly scenes!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_6, N'short_response', N'🧩 The Riddle Vault

Objective: Practice cracking a themed sequence of riddles that unlock a final ''vault'' answer.

Materials: 6-8 themed riddle clues building toward one final answer | A timer

Follow the steps below to play!', NULL, N'Writing down each partial clue as you solve it helps the team spot the final pattern faster.', 9, N'sequence_steps', N'{"steps": ["Design (or use) a set of riddles that each reveal a piece of a bigger final answer.", "Work through the riddles as a team, combining clues as you solve them.", "Race the timer to figure out the final ''vault'' answer before time runs out.", "Reset with a new riddle theme and try to beat your best time!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_6, N'short_response', N'🍕 Chef''s Pun Kitchen

Objective: Practice pitching an entire silly pun-themed restaurant concept, not just individual items.

Materials: Paper and pencil

Follow the steps below to play!', NULL, N'A consistent theme across every pun (all fish puns, all space puns) makes the whole menu funnier together.', 10, N'sequence_steps', N'{"steps": ["Teams design a full themed restaurant with a name, 5-6 pun menu items, and one silly slogan.", "Prepare a short ''pitch'' presenting your restaurant concept to the group.", "Present your Chef''s Pun Kitchen concept, explaining each pun.", "Vote (just for fun) on the most creative overall restaurant pitch!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_6, N'short_response', N'🎪 Collaborative Comedy Circus

Objective: Practice co-writing and performing a short, structured silly circus sketch as a team.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'Giving each character just one clear silly trait makes the whole sketch easier to follow and funnier.', 11, N'sequence_steps', N'{"steps": ["As a team, plan a short circus-themed sketch with a beginning, silly middle, and punchline ending.", "Assign each teammate a silly circus character role.", "Rehearse once, then perform the full sketch for the group.", "Take a bow together and discuss what got the biggest laughs!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_6, N'short_response', N'🧢 Charades Championship

Objective: Practice acting out challenging silly phrases under a strict time limit in a scored competition.

Materials: 12-15 challenging silly phrase slips | A hat or bowl | A timer

Follow the steps below to play!', NULL, N'Acting out a rhyming clue or a ''sounds like'' gesture can unstick a team on a tricky phrase.', 12, N'sequence_steps', N'{"steps": ["Split into two teams, each taking turns acting out slips within 60 seconds.", "The acting player''s team shouts guesses; correct guesses score a point.", "Switch teams after each turn until all slips are used.", "Team with the most correct guesses wins the Charades Championship!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_6, N'short_response', N'🔤 Wordsmith Wit Battle

Objective: Practice inventing clever original wordplay quickly under a competitive back-and-forth format.

Materials: A list of challenge word pairs (optional)

Follow the steps below to play!', NULL, N'Building directly off your opponent''s last twist, instead of starting fresh, often produces the wittiest line.', 13, N'sequence_steps', N'{"steps": ["Two players face off with a given word or short phrase.", "Take turns building an original witty wordplay twist on it within 10 seconds.", "Keep going until one player can''t top the last twist in time.", "The group judges the wittiest overall exchange after several matchups!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_6, N'short_response', N'🏆 Ultimate Giggle Tournament

Objective: Practice competing across a full slate of silly mini-games combined into one big tournament event.

Materials: Whatever materials the chosen mini-games need (see other Silly Games entries)

Follow the steps below to play!', NULL, N'Mixing fast games with slower ones keeps the whole tournament''s energy — and laughter — balanced.', 14, N'sequence_steps', N'{"steps": ["As a group, select 4-5 favorite silly games to combine into a tournament bracket.", "Play each mini-game, awarding points for performance and for the group''s favorite funny moments.", "Keep a running scoreboard across all events.", "Crown the player or team with the most total points as Ultimate Giggle Champion!"]}');

    DECLARE @cat_humor_7 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (7, 'humor_play', N'Silly Games & Giggles', 'space_heavy', 7, N'Get ready to laugh with a silly game this week!', 0);
    SET @cat_humor_7 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_7, N'short_response', N'🎤 Comedy Open Mic Finals

Objective: Practice refining and performing a polished comedy set based on peer feedback.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'The single biggest improvement between a first try and a great set is usually pacing, not new jokes.', 1, N'sequence_steps', N'{"steps": ["Each performer writes and rehearses a short comedy set with a clear opening, middle, and closer.", "Perform an early version for one partner and get quick feedback on pacing and clarity.", "Revise your set based on the feedback.", "Perform your final polished set for the whole group at the ''Finals''!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_7, N'short_response', N'🧠 Riddle Grandmaster Gauntlet

Objective: Practice solving an extended, multi-tier sequence of increasingly complex riddles.

Materials: 12-15 riddle cards across three difficulty tiers

Follow the steps below to play!', NULL, N'Grandmaster-level riddles often rely on a word with a double meaning — read the riddle for both meanings before answering.', 2, N'sequence_steps', N'{"steps": ["Organize riddles into three tiers: warm-up, challenge, and grandmaster level.", "Work through each tier in order, only advancing once the current tier is solved.", "Track how many riddles are solved without needing a hint.", "See how deep into the grandmaster tier the group can reach!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_7, N'short_response', N'🃏 Would You Rather World Championship

Objective: Practice running a full multi-round debate tournament arguing silly hypothetical positions.

Materials: A bracket of silly would-you-rather prompts | Paper to track the bracket

Follow the steps below to play!', NULL, N'Arguing a position you don''t actually agree with often produces funnier, more creative reasoning.', 3, N'sequence_steps', N'{"steps": ["Set up a bracket of several silly would-you-rather matchups.", "Each round, both sides get one minute to argue their assigned silly position, regardless of personal preference.", "The group votes each matchup forward to the next round.", "Crown a World Champion debater after the final round!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_7, N'short_response', N'🙊 Unshakeable Face Challenge

Objective: Practice maintaining composure through an extended, high-pressure group silliness gauntlet.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'Reacting with an exaggerated deadpan ''that was fine'' after each attempt often frustrates (and amuses) the group.', 4, N'sequence_steps', N'{"steps": ["One contestant sits in the center chair as the group forms a circle around them.", "Going around the circle, each player gets one uninterrupted attempt to break the contestant''s composure.", "No touching — only words, sounds, and expressions are allowed.", "Whoever finally breaks the contestant''s face becomes the next contestant!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_7, N'short_response', N'😂 Pun Wars: Final Round

Objective: Practice sustaining rapid original pun creation across a long, high-pressure elimination round.

Materials: A list of challenging topic categories

Follow the steps below to play!', NULL, N'Listening for a double meaning hiding in the topic word itself is the fastest way to keep the streak alive.', 5, N'sequence_steps', N'{"steps": ["Everyone stands in a circle around one shared topic category.", "Going around, each player has 5 seconds to add a new original pun before being eliminated for hesitating or repeating.", "Keep circling faster and faster as fewer players remain.", "The last player still generating original puns wins the Final Round!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_7, N'short_response', N'🚶 Silly Walk Invention Lab

Objective: Practice engineering an original silly walk with a clear concept, name, and performance arc.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'A walk that tells a tiny story from start to finish is almost always funnier than one silly motion repeated.', 6, N'sequence_steps', N'{"steps": ["Each ''inventor'' designs a silly walk with a beginning, a silly complication, and a resolution (like tripping, recovering with extra flair, and finishing triumphantly).", "Name your invention and give it a one-sentence pitch.", "Perform the full silly-walk arc for the group.", "Vote (just for fun) on the most creative complete performance!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_7, N'short_response', N'🗣️ Dub-Over Film Festival

Objective: Practice performing polished, distinct improvised voice-overs for a series of silent scenes.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'Voice-over performers who commit to a strong character choice immediately, rather than hedging, get the biggest laughs.', 7, N'sequence_steps', N'{"steps": ["Small groups each prepare one short silent scene with clear, exaggerated physical action.", "A different group provides live improvised voice-over dialogue for each scene, without rehearsing together first.", "Perform all the scenes back to back like a mini film festival.", "Vote (just for fun) on the funniest dub-over pairing of the festival!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_7, N'short_response', N'🎭 Improv Comedy League

Objective: Practice running a full round-robin of improvised silly scenes with rotating team assignments.

Materials: A list of silly scene-starter prompts

Follow the steps below to play!', NULL, N'Accepting a scene partner''s silly idea and building on it always beats trying to redirect the scene your own way.', 8, N'sequence_steps', N'{"steps": ["Split into small improv teams and set up a round-robin schedule.", "Each round, one team performs a 1-2 minute improvised scene from a random silly prompt.", "The ''audience'' teams score each scene (just for fun) on creativity and laughs.", "Total scores across all rounds to crown the Improv Comedy League winner!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_7, N'short_response', N'🧩 The Riddle Vault Heist

Objective: Practice collaboratively cracking a complex, multi-layered riddle sequence against a shared time limit.

Materials: 8-10 layered riddle clues building toward a final combination | A timer

Follow the steps below to play!', NULL, N'Solving riddles in parallel and combining answers is almost always faster than solving them one at a time as a group.', 9, N'sequence_steps', N'{"steps": ["Design (or use) a sequence of riddles where each solved answer contributes one part of a final code.", "As a team, divide up riddles to solve in parallel, then regroup to combine the pieces.", "Race the timer to assemble the complete final code from all the riddle answers.", "''Crack the vault'' before time runs out, then try a new sequence to beat your record!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_7, N'short_response', N'🍕 Master Chef Puns

Objective: Practice pitching a complete pun-based menu concept and defending it in a mock judging panel.

Materials: Paper and pencil

Follow the steps below to play!', NULL, N'Sticking to one strict pun theme across every course usually impresses judges more than scattered random puns.', 10, N'sequence_steps', N'{"steps": ["Teams design a full themed restaurant menu (appetizers, mains, desserts) built entirely around one pun category.", "Prepare a short pitch explaining the theme and reading a few standout puns.", "Present to the group acting as judges, who can ask one question per pitch.", "Judges vote (just for fun) on the most consistent and creative pun menu!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_7, N'short_response', N'🎪 Epic Story Circus

Objective: Practice co-authoring a longer, structured silly story with planned rising action and a payoff twist.

Materials: None — just a group of players and some giggles

Follow the steps below to play!', NULL, N'Planning the twist ending before telling the middle lets you plant small silly clues along the way.', 11, N'sequence_steps', N'{"steps": ["As a group, outline a circus story with a beginning, three rising silly events, and a twist ending.", "Assign each player one section to tell in detail when it''s their turn.", "Tell the full story in order, each player building on exactly what came before.", "Perform a dramatic retelling of the whole finished story for a final laugh!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_7, N'short_response', N'🧢 Charades Championship League

Objective: Practice acting out especially challenging silly phrases under strict scoring rules across a league format.

Materials: 15-20 challenging silly phrase slips | A hat or bowl | A timer

Follow the steps below to play!', NULL, N'Breaking a hard phrase into syllables and acting each one separately usually cracks it faster than acting it whole.', 12, N'sequence_steps', N'{"steps": ["Split into teams and set a league schedule where every team plays every other team once.", "Each match, act out slips within 60 seconds, scoring a point per correct guess.", "Track wins across the whole league on a standings sheet.", "Team with the best overall record after the full league wins the championship!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_7, N'short_response', N'🔤 Wit & Wordplay Duel

Objective: Practice sustaining a witty, structured wordplay exchange with a clear scoring format.

Materials: A list of challenge words or phrases | Paper to track points (optional)

Follow the steps below to play!', NULL, N'A twist that plays on the word''s rhythm or sound, not just its meaning, often scores extra laughs.', 13, N'sequence_steps', N'{"steps": ["Two players are given the same starting word or phrase.", "Alternate turns building an original witty twist on it, with the group awarding a point for the wittier twist each round.", "Play a set number of rounds (like 5) per duel.", "Whoever has the most points at the end wins the duel — then face a new challenger!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_humor_7, N'short_response', N'🏆 Grand Giggle Games

Objective: Practice organizing and competing in a full multi-event tournament that brings together a season''s worth of silly game skills.

Materials: Whatever materials the chosen mini-games need (see other Silly Games entries)

Follow the steps below to play!', NULL, N'Closing the day by replaying everyone''s single funniest moment is the best way to end the Grand Games.', 14, N'sequence_steps', N'{"steps": ["As a group, select 5-6 favorite silly games from across the whole Silly Games category to form the Grand Games.", "Play each event, awarding points for performance and audience-choice funniest moments.", "Keep a full scoreboard across every event of the day.", "Crown the overall Grand Giggle Games champion and celebrate everyone''s funniest moments!"]}');

END
GO

DELETE FROM dbo.WeeklyPacketPlan;
GO