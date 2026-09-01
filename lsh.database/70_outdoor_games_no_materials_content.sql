-- 70_outdoor_games_no_materials_content.sql
-- Extends the existing 'Outdoor Games' category (see 68/69) with 7 more
-- games per grade (21 -> 28), every one playable with ZERO materials — just
-- kids, voices, and open space, no equipment or setup of any kind.
--
-- Appends to the SAME per-grade PacketCategories row (looked up, not
-- re-created) with sort_order continuing from 22. target_count stays at 7.
-- See gen_70_outdoor_games_no_materials_content.py.

IF NOT EXISTS (
    SELECT 1 FROM dbo.PacketQuestions q
    JOIN dbo.PacketCategories c ON c.category_id = q.category_id
    WHERE c.category_name = 'Outdoor Games' AND c.grade_id = 0 AND q.sort_order = 22
)
BEGIN
    DECLARE @cat_nm_0 INT;
    SELECT @cat_nm_0 = category_id FROM dbo.PacketCategories WHERE grade_id = 0 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_0, N'short_response', N'🙈 Hide and Seek

Objective: Practice counting and finding hidden friends using only your eyes and ears.

Materials: None — just kids and a safe space to hide in!

Follow the steps below to play!', NULL, N'Only hide in spots a grown-up says are safe and allowed.', 22, N'sequence_steps', N'{"steps": ["One player is the ''Seeker'' and closes their eyes, counting to 10.", "Everyone else finds a hiding spot.", "The Seeker calls ''Ready or not, here I come!'' and looks for everyone.", "The first person found becomes the next Seeker!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_0, N'short_response', N'🪞 Copy Cat

Objective: Practice careful watching by copying a leader''s movements exactly.

Materials: None — just kids standing face to face!

Follow the steps below to play!', NULL, N'Move slowly and gently so your partner can copy safely.', 23, N'sequence_steps', N'{"steps": ["Pair up, facing a partner.", "One partner is the ''Leader'' and makes slow movements (raising an arm, making a face).", "The other partner copies exactly, like a mirror.", "Switch roles after a minute!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_0, N'short_response', N'🦁 Animal Sound Guess

Objective: Practice listening and guessing which animal sound a friend is making.

Materials: None — just voices!

Follow the steps below to play!', NULL, N'Take turns and listen quietly while someone else is making their sound.', 24, N'sequence_steps', N'{"steps": ["One player thinks of an animal and makes its sound (roar, moo, quack).", "Everyone else guesses which animal it is.", "Whoever guesses right gets to make the next animal sound.", "Keep going through as many animals as you can think of!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_0, N'short_response', N'🚶 Silly Walk Parade

Objective: Practice inventing and following different silly ways of walking.

Materials: None — just kids and open space to walk in!

Follow the steps below to play!', NULL, N'Walk in an open space with nothing to trip over.', 25, N'sequence_steps', N'{"steps": ["One player leads the parade with a silly walk (like a robot, a crab, or tiptoes).", "Everyone follows behind, copying the silly walk.", "After a bit, the leader moves to the back and a new leader starts a new silly walk.", "Keep parading with new silly walks!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_0, N'short_response', N'🦊 What Time Is It, Mr. Fox?

Objective: Practice counting and quick reactions in a classic chasing game.

Materials: None — just kids and open space!

Follow the steps below to play!', NULL, N'Only take the number of steps called, and stop chasing once someone reaches home base.', 26, N'sequence_steps', N'{"steps": ["One player is ''Mr. Fox'' and stands at one end of the space, back turned.", "Everyone else calls out, ''What time is it, Mr. Fox?''", "Mr. Fox calls back a number (like ''3 o''clock'') and everyone takes that many steps toward him.", "If Mr. Fox ever calls ''Dinner time!'' he turns and chases everyone back to the start line!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_0, N'short_response', N'👍 Thumbs Up, Thumbs Down

Objective: Practice sharing opinions quickly using a simple thumbs signal.

Materials: None — just thumbs!

Follow the steps below to play!', NULL, N'It''s okay for friends to disagree — everyone''s thumb answer is welcome.', 27, N'sequence_steps', N'{"steps": ["One player calls out a simple statement (''Ice cream is yummy!'').", "Everyone shows thumbs up if they agree, thumbs down if they don''t, or sideways if they''re not sure.", "Talk about why people felt differently.", "Take turns calling out new statements!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_0, N'short_response', N'🤫 Freeze and Listen

Objective: Practice staying still and noticing quiet sounds around you.

Materials: None — just quiet ears!

Follow the steps below to play!', NULL, N'Stand somewhere safe and steady before closing your eyes.', 28, N'sequence_steps', N'{"steps": ["Everyone freezes completely still and closes their eyes.", "Listen quietly for 30 seconds, noticing every sound you can hear.", "Open your eyes and take turns sharing one sound you heard.", "Try again in a different spot — did you hear something new?"]}');

    DECLARE @cat_nm_1 INT;
    SELECT @cat_nm_1 = category_id FROM dbo.PacketCategories WHERE grade_id = 1 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_1, N'short_response', N'🙈 Hide and Seek: Team Edition

Objective: Practice teamwork by hiding together in small groups and staying quiet.

Materials: None — just kids and a safe space!

Follow the steps below to play!', NULL, N'Only hide in spots a grown-up says are safe and allowed.', 22, N'sequence_steps', N'{"steps": ["One player is the Seeker and counts to 15 with eyes closed.", "Everyone else hides together in pairs or small groups.", "Groups must stay together and stay quiet the whole time.", "The first group found becomes the new Seekers!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_1, N'short_response', N'✂️ Rock Paper Scissors Tournament

Objective: Practice quick decision-making in a bracket-style rock-paper-scissors competition.

Materials: None — just hands!

Follow the steps below to play!', NULL, N'Show your hand signal gently — no fast or forceful arm movements.', 23, N'sequence_steps', N'{"steps": ["Pair up and play rock-paper-scissors — best 2 out of 3 wins the match.", "Winners move on to play another winner.", "Keep playing until only one champion remains!", "Cheer for every match along the way."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_1, N'short_response', N'🪞 Mirror Me

Objective: Practice focus and body control by mirroring a partner''s slow movements.

Materials: None — just kids facing each other!

Follow the steps below to play!', NULL, N'Move slowly and smoothly so your partner can follow safely.', 24, N'sequence_steps', N'{"steps": ["Pair up, standing face to face.", "One partner slowly moves their arms, head, or body.", "The other partner mirrors every movement exactly, like a reflection.", "Switch roles after a minute — no talking allowed while mirroring!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_1, N'short_response', N'📞 Whisper Down the Lane

Objective: Practice careful listening and speaking clearly in a message-passing chain.

Materials: None — just a line of friends!

Follow the steps below to play!', NULL, N'Whisper gently and keep a comfortable distance from each other''s ears.', 25, N'sequence_steps', N'{"steps": ["Stand in a line or circle.", "The first player whispers a short phrase into the next person''s ear.", "Each person whispers what they heard to the next, all the way down the line.", "The last player says the phrase out loud — compare it to the original!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_1, N'short_response', N'🎭 Animal Charades

Objective: Practice acting out and guessing animals without using words.

Materials: None — just bodies and imagination!

Follow the steps below to play!', NULL, N'Act out animals safely — no rough movements or bumping into others.', 26, N'sequence_steps', N'{"steps": ["One player silently acts out an animal using only movements and sounds are not allowed.", "Everyone else guesses which animal it is.", "Whoever guesses correctly acts out the next animal.", "Keep going through as many animals as you can act out!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_1, N'short_response', N'🏃 Classic Tag

Objective: Practice running, dodging, and quick tagging in the simplest chasing game.

Materials: None — just kids and open space!

Follow the steps below to play!', NULL, N'Tag gently with an open hand, and play in a wide open space.', 27, N'sequence_steps', N'{"steps": ["One player is ''It.''", "''It'' chases the others, trying to tag someone.", "Whoever gets tagged becomes the new ''It.''", "Keep playing and switching who''s ''It''!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_1, N'short_response', N'🐍 Follow the Snake

Objective: Practice moving together as a connected group, following a winding leader.

Materials: None — just a line of friends holding shoulders!

Follow the steps below to play!', NULL, N'Move slowly enough that the whole line can stay connected safely.', 28, N'sequence_steps', N'{"steps": ["Line up, each player placing hands on the shoulders of the person in front.", "The front player (the snake''s head) leads the line in a winding path.", "The whole line must move together without breaking apart.", "Switch who leads the snake after a lap!"]}');

    DECLARE @cat_nm_2 INT;
    SELECT @cat_nm_2 = category_id FROM dbo.PacketCategories WHERE grade_id = 2 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_2, N'short_response', N'🥫 Sardines

Objective: Practice sneaking and squeezing together in a reverse hide-and-seek game.

Materials: None — just kids and a safe space to hide in!

Follow the steps below to play!', NULL, N'Only hide in spots a grown-up allows, and squeeze in gently, not roughly.', 22, N'sequence_steps', N'{"steps": ["One player hides while everyone else counts to 20 with eyes closed.", "Everyone splits up to search for the hider.", "When you find the hider, quietly squeeze into the hiding spot with them (no telling others!).", "The last person still searching alone becomes the next hider!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_2, N'short_response', N'👍 Thumb War Tournament

Objective: Compete in a friendly thumb-wrestling tournament using only hands.

Materials: None — just hands!

Follow the steps below to play!', NULL, N'Keep it gentle and fun — no squeezing hands too hard.', 23, N'sequence_steps', N'{"steps": ["Pair up and lock hands, thumbs up.", "Say the countdown together, then try to pin your partner''s thumb down.", "Best 2 out of 3 wins the match and moves on to face another winner.", "Keep playing until a tournament champion is crowned!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_2, N'short_response', N'📋 Categories Game

Objective: Practice quick thinking by naming items in a category before time runs out.

Materials: None — just voices and quick thinking!

Follow the steps below to play!', NULL, N'Be patient and encouraging if a friend needs a little extra time to think.', 24, N'sequence_steps', N'{"steps": ["Pick a category, like ''animals'' or ''foods.''", "Take turns naming one item in that category without repeating.", "If you can''t think of one in 5 seconds, you''re out for that round!", "Pick a new category and play again."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_2, N'short_response', N'🗿 Grandma''s Footsteps

Objective: Practice sneaking quietly toward a goal without being caught moving.

Materials: None — just kids and open space!

Follow the steps below to play!', NULL, N'Move carefully and stop instantly when Grandma turns around.', 25, N'sequence_steps', N'{"steps": ["One player (''Grandma'') stands at one end, facing away from the group.", "Everyone else starts at the other end, trying to sneak closer.", "Grandma can turn around any time — anyone caught moving must go back to start!", "First player to tag Grandma without being caught wins and becomes the new Grandma!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_2, N'short_response', N'🕵️ I Spy

Objective: Practice describing and guessing objects using colors and clues.

Materials: None — just eyes and voices!

Follow the steps below to play!', NULL, N'Pick objects that are safely visible from where everyone is standing.', 26, N'sequence_steps', N'{"steps": ["One player picks an object they can see and says, ''I spy with my little eye, something that is [color]!''", "Everyone else guesses what the object is.", "Whoever guesses correctly picks the next object.", "Keep playing with new objects and clues!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_2, N'short_response', N'🦶 Hop and Count

Objective: Practice counting and balance by hopping a set number of times on one foot.

Materials: None — just kids and open space!

Follow the steps below to play!', NULL, N'Hop on grass or a soft surface in case you lose your balance.', 27, N'sequence_steps', N'{"steps": ["Call out a number, like ''5.''", "Everyone hops on one foot that many times, counting out loud together.", "Switch to the other foot and try a new number.", "See who can hop the highest number without losing balance!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_2, N'short_response', N'🎭 Charades Relay

Objective: Work in teams to act out and guess words as fast as possible.

Materials: None — just bodies and imagination!

Follow the steps below to play!', NULL, N'Act safely — no bumping into teammates while acting things out.', 28, N'sequence_steps', N'{"steps": ["Split into 2 teams; one player from each team acts out a word (an animal, an action) silently.", "Their team tries to guess the word as fast as possible.", "Once guessed correctly, the next player on that team acts out a new word.", "First team to get through 5 words wins!"]}');

    DECLARE @cat_nm_3 INT;
    SELECT @cat_nm_3 = category_id FROM dbo.PacketCategories WHERE grade_id = 3 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_3, N'short_response', N'🌋 The Floor Is Lava

Objective: Practice balance and quick thinking by staying off the ''lava'' floor.

Materials: None — just kids and any safe furniture/steps already around!

Follow the steps below to play!', NULL, N'Only climb onto sturdy, safe surfaces — never anything wobbly or high.', 22, N'sequence_steps', N'{"steps": ["Someone calls out, ''The floor is lava!''", "Everyone must get off the ground onto a safe spot (a step, a low wall, a curb) within 5 seconds.", "Stay off the ''lava'' until someone calls, ''All clear!''", "Call ''Lava!'' again at a random moment and see who reacts fastest!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_3, N'short_response', N'❓ 20 Questions

Objective: Practice asking smart yes-or-no questions to guess a secret item.

Materials: None — just voices and clever thinking!

Follow the steps below to play!', NULL, N'Be patient with each other''s questions and guesses.', 23, N'sequence_steps', N'{"steps": ["One player thinks of an object and keeps it secret.", "Everyone else takes turns asking yes-or-no questions to narrow it down.", "After 20 questions (or fewer), guess what the object is!", "Whoever guesses correctly (or asks the most helpful questions) picks the next object."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_3, N'short_response', N'👀 Staring Contest Tournament

Objective: Practice self-control and focus in a silly staring-contest competition.

Materials: None — just eyes!

Follow the steps below to play!', NULL, N'Keep a comfortable distance apart while staring.', 24, N'sequence_steps', N'{"steps": ["Pair up and face each other.", "Stare into each other''s eyes without blinking or laughing.", "Whoever blinks or laughs first loses that round.", "Winners face other winners until a champion is crowned!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_3, N'short_response', N'🤔 Would You Rather

Objective: Practice sharing opinions and explaining reasoning with fun hypothetical choices.

Materials: None — just imagination and voices!

Follow the steps below to play!', NULL, N'Keep questions kind and silly, not something that could hurt feelings.', 25, N'sequence_steps', N'{"steps": ["One player asks a ''Would you rather...'' question with two silly options.", "Everyone picks a side and explains why.", "Talk about who picked what and why.", "Take turns asking new ''Would you rather'' questions!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_3, N'short_response', N'🎬 Silent Charades Battle

Objective: Compete in teams to guess acted-out words the fastest, using only movement.

Materials: None — just bodies and imagination!

Follow the steps below to play!', NULL, N'Act safely with enough space so you don''t bump into anyone.', 26, N'sequence_steps', N'{"steps": ["Split into 2 teams. One player from each team gets a secret word (an activity, an animal).", "Act it out silently — no talking or sound effects allowed!", "Your team shouts guesses until they get it right.", "Fastest team to guess 5 words in a row wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_3, N'short_response', N'🗣️ Story Starters

Objective: Build a silly group story together, one sentence at a time.

Materials: None — just imagination and voices!

Follow the steps below to play!', NULL, N'Keep the story kind and fun — everyone''s sentence gets a turn.', 27, N'sequence_steps', N'{"steps": ["The first player starts a story with one sentence (''Once there was a dragon who loved pizza...'').", "Each player adds one more sentence, building on what came before.", "Keep going around the circle, making the story sillier each time!", "End the story together when it feels complete."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_3, N'short_response', N'😉 Wink Detective

Objective: Practice careful observation to spot a secret ''winker'' before getting caught.

Materials: None — just eyes and a group of friends!

Follow the steps below to play!', NULL, N'Keep it gentle and fun — no one actually leaves the game, just plays along.', 28, N'sequence_steps', N'{"steps": ["One player is secretly chosen as the ''Detective'' (others don''t know who).", "One other player is secretly the ''Winker,'' chosen without others seeing.", "The Winker secretly winks at people, who then playfully pretend to be ''out.''", "The Detective watches closely and tries to guess who the Winker is before too many people are ''out''!"]}');

    DECLARE @cat_nm_4 INT;
    SELECT @cat_nm_4 = category_id FROM dbo.PacketCategories WHERE grade_id = 4 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_4, N'short_response', N'🕵️ 20 Questions Detective

Objective: Use strategic yes-or-no questions to narrow down and guess a secret item efficiently.

Materials: None — just voices and strategy!

Follow the steps below to play!', NULL, N'Take turns fairly so everyone gets a chance to ask questions.', 22, N'sequence_steps', N'{"steps": ["One player secretly picks a category (person, place, or thing) and an item within it.", "Everyone else asks yes-or-no questions, starting broad (''Is it alive?'') and narrowing down.", "Try to guess the item using as few questions as possible.", "Whoever guesses correctly (or asks the smartest question) picks the next item!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_4, N'short_response', N'📖 Story Chain

Objective: Build a creative story together, adding one sentence at a time in order.

Materials: None — just imagination and voices!

Follow the steps below to play!', NULL, N'Keep the story kind — everyone''s contribution should build up the fun, not tear it down.', 23, N'sequence_steps', N'{"steps": ["The first player starts a story with one sentence.", "Going around the circle, each player adds exactly one sentence, keeping the story making sense.", "Try to build toward an interesting ending as a group.", "After a set number of rounds, the last player wraps up the story!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_4, N'short_response', N'🤥 Two Truths and a Lie

Objective: Practice sharing facts about yourself and spotting a friend''s fib.

Materials: None — just voices and honesty (mostly)!

Follow the steps below to play!', NULL, N'Keep statements kind and appropriate — this is about fun facts, not embarrassing secrets.', 24, N'sequence_steps', N'{"steps": ["Each player thinks of 2 true things about themselves and 1 made-up thing.", "Say all 3 out loud, in any order, without hinting which is the lie.", "Everyone else guesses which one is the lie.", "Reveal the answer, then let the next player share their 3 statements!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_4, N'short_response', N'🌋 The Floor Is Lava: Team Edition

Objective: Work together as a team to help everyone reach safety before the lava spreads.

Materials: None — just kids and any safe furniture/steps already around!

Follow the steps below to play!', NULL, N'Only climb onto sturdy, safe surfaces, and help each other carefully — no pushing.', 25, N'sequence_steps', N'{"steps": ["Someone calls, ''The floor is lava!'' and everyone scrambles to safe spots.", "This time, the whole TEAM must be off the ground within 10 seconds — help each other!", "If anyone is still on the ''lava'' when time''s up, the whole team must start over.", "Try again and see if your team can beat your own best time!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_4, N'short_response', N'🎭 Emotion Charades

Objective: Practice recognizing and expressing different emotions through acting.

Materials: None — just faces, bodies, and imagination!

Follow the steps below to play!', NULL, N'Act out emotions safely, without exaggerated movements that could bump others.', 26, N'sequence_steps', N'{"steps": ["One player picks a secret emotion (excited, nervous, surprised, proud) and acts it out silently.", "Everyone else guesses which emotion is being shown.", "Talk about what body language or facial expressions gave it away.", "Take turns acting out new emotions!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_4, N'short_response', N'🤝 Human Knot

Objective: Work together as a team to untangle a human knot using only communication and careful movement.

Materials: None — just a group of friends standing in a circle!

Follow the steps below to play!', NULL, N'Move slowly and gently — never pull or twist arms to force the untangling.', 27, N'sequence_steps', N'{"steps": ["Stand in a circle and reach across to hold two different people''s hands (not the people next to you).", "Without letting go, work together to untangle into one big circle (or a few connected circles).", "Talk through it as a team — who needs to step over or under whom?", "Celebrate once you''re untangled!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_4, N'short_response', N'🗣️ Categories Speed Round

Objective: Practice quick recall by naming items in a category before a countdown ends.

Materials: None — just voices and quick thinking!

Follow the steps below to play!', NULL, N'Be encouraging if a friend needs a little extra time to think.', 28, N'sequence_steps', N'{"steps": ["Pick a category (countries, sports, foods) and a letter of the alphabet.", "Take turns naming something in that category starting with that letter within 5 seconds.", "If you can''t think of one in time, you''re out for that round.", "Change the category or letter and keep playing!"]}');

    DECLARE @cat_nm_5 INT;
    SELECT @cat_nm_5 = category_id FROM dbo.PacketCategories WHERE grade_id = 5 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_5, N'short_response', N'🗣️ Impromptu Debate Circle

Objective: Practice forming and sharing an opinion on the spot, with reasons to support it.

Materials: None — just voices and quick thinking!

Follow the steps below to play!', NULL, N'Keep it friendly — disagreeing about the topic doesn''t mean disagreeing as friends.', 22, N'sequence_steps', N'{"steps": ["One player calls out a light debate topic (''Cats or dogs?'', ''Summer or winter?'').", "Everyone picks a side and has 30 seconds to think of one good reason.", "Take turns sharing your reason — listen respectfully to other sides too.", "Vote at the end on which side made the most convincing case!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_5, N'short_response', N'😉 Wink Detective Championship

Objective: Sharpen observation skills in a faster-paced round of the classic wink-detective game.

Materials: None — just eyes and a group of friends!

Follow the steps below to play!', NULL, N'Keep it lighthearted — being ''out'' just means playing along, not actually leaving.', 23, N'sequence_steps', N'{"steps": ["Secretly choose a Detective and a Winker without others knowing who''s who.", "The Winker discreetly winks at players, who playfully act ''out'' when winked at.", "The Detective has 3 guesses to identify the Winker before too many players are ''out.''", "Play multiple rounds, rotating who gets picked as Detective and Winker!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_5, N'short_response', N'🎬 Silent Movie Charades

Objective: Act out an entire short scene silently, like a character in an old silent film.

Materials: None — just bodies, faces, and imagination!

Follow the steps below to play!', NULL, N'Act dramatically but safely — big expressions, not rough movements.', 24, N'sequence_steps', N'{"steps": ["One player picks a simple scene idea (getting caught in the rain, winning a race).", "Act out the whole scene silently and dramatically, like a silent movie character, with big expressions.", "Everyone else guesses what''s happening.", "Take turns acting out new silent scenes!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_5, N'short_response', N'🌟 Human Bingo Mixer

Objective: Practice social skills by finding classmates who match different fun facts.

Materials: None — just voices and curiosity!

Follow the steps below to play!', NULL, N'Ask questions kindly, and it''s okay if someone doesn''t match — just ask someone else.', 25, N'sequence_steps', N'{"steps": ["Think of 5 fun ''traits'' to look for (has a pet, likes pizza, can whistle, has a sibling, plays a sport).", "Walk around asking classmates questions to find someone who matches each trait.", "When you find a match, remember their name for that trait.", "First to find a match for all 5 traits calls ''Bingo!''"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_5, N'short_response', N'🤝 Human Knot Challenge

Objective: Work as a larger team to untangle a bigger, trickier human knot using only teamwork.

Materials: None — just a group of friends standing in a circle!

Follow the steps below to play!', NULL, N'Move slowly and gently — never yank or twist to force the untangling.', 26, N'sequence_steps', N'{"steps": ["Form a larger circle of 8-10 players, each grabbing two different people''s hands across the circle.", "Without letting go, work together to untangle into one connected shape.", "Communicate clearly — who needs to duck, step over, or turn?", "Time yourselves and see if a second team can untangle faster!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_5, N'short_response', N'🎲 Fortunately, Unfortunately

Objective: Build a silly story together by alternating good news and bad news twists.

Materials: None — just imagination and voices!

Follow the steps below to play!', NULL, N'Keep twists silly and fun, not scary or upsetting.', 27, N'sequence_steps', N'{"steps": ["The first player starts a story sentence with ''Fortunately...'' (something good happens).", "The next player continues with ''Unfortunately...'' (something goes wrong).", "Keep alternating fortunately/unfortunately, building a wild, silly story.", "End the story together when it feels complete!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_5, N'short_response', N'🗿 Freeze Statue Showdown

Objective: Compete to hold the most creative, stable freeze-pose the longest.

Materials: None — just bodies and balance!

Follow the steps below to play!', NULL, N'Choose poses you can actually balance safely — nothing too risky.', 28, N'sequence_steps', N'{"steps": ["On ''go,'' everyone strikes a creative statue pose and freezes.", "Hold your pose without wobbling or moving.", "Anyone who moves or falls out of their pose is out.", "Last statue standing wins the showdown!"]}');

    DECLARE @cat_nm_6 INT;
    SELECT @cat_nm_6 = category_id FROM dbo.PacketCategories WHERE grade_id = 6 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_6, N'short_response', N'🧩 Silent Line-Up Challenge

Objective: Practice nonverbal communication by organizing the group in order without talking.

Materials: None — just a group of friends and no talking!

Follow the steps below to play!', NULL, N'Move calmly while rearranging — no pushing to get into position.', 22, N'sequence_steps', N'{"steps": ["Pick a category to line up by (birthday month, height, alphabetical first name).", "Without speaking at all, figure out how to arrange yourselves in the correct order.", "Use gestures, hand signals, or writing in the air to communicate.", "Once everyone thinks you''re in order, check out loud together!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_6, N'short_response', N'📖 One-Word Story

Objective: Build a story together where each person can only add a single word at a time.

Materials: None — just imagination and voices!

Follow the steps below to play!', NULL, N'Keep words kind and appropriate for the group.', 23, N'sequence_steps', N'{"steps": ["Sit in a circle. The first player says one word to start a story (''Once'').", "Each player adds exactly one more word, going around the circle.", "Keep the story making sense as a group, one word at a time.", "See how long and silly you can make the story before it stops making sense!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_6, N'short_response', N'🗣️ Debate Circle: Advanced

Objective: Practice building a structured argument with reasons and evidence on the spot.

Materials: None — just voices and quick thinking!

Follow the steps below to play!', NULL, N'Debate the ideas, not each other — keep it respectful and friendly.', 24, N'sequence_steps', N'{"steps": ["Pick a debate topic and split into two sides.", "Each side gets 1 minute to prepare 2 reasons supporting their position.", "Present your reasons, then let the other side respond with a counter-point.", "Vote as a group on which side argued most convincingly!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_6, N'short_response', N'🎭 Freeze Frame Tableau

Objective: Work as a group to instantly create a frozen scene representing a given theme.

Materials: None — just bodies and imagination!

Follow the steps below to play!', NULL, N'Choose poses that are safe to hold and won''t bump into others.', 25, N'sequence_steps', N'{"steps": ["Call out a theme (''a busy city street,'' ''a soccer game,'' ''a birthday party'').", "On ''freeze,'' everyone instantly poses to create a frozen scene representing that theme.", "Hold your pose while others guess what''s happening in the scene.", "Call a new theme and freeze into a different tableau!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_6, N'short_response', N'🤝 Trust Walk

Objective: Build trust and communication by guiding a partner safely using only your voice.

Materials: None — just a partner and open space!

Follow the steps below to play!', NULL, N'Guides must speak clearly and stay close in case their partner needs help.', 26, N'sequence_steps', N'{"steps": ["Pair up; one partner closes their eyes (or wears a blindfold), the other guides with words only.", "The guide walks a few steps behind, giving clear directions (''two steps forward, turn slightly left'').", "Navigate a simple safe path together.", "Switch roles and try again — discuss what directions worked best!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_6, N'short_response', N'🧠 Memory Chain

Objective: Practice memory and listening by repeating and adding to a growing list.

Materials: None — just memory and voices!

Follow the steps below to play!', NULL, N'Be encouraging if someone forgets — it''s just part of the fun challenge.', 27, N'sequence_steps', N'{"steps": ["The first player says, ''I packed my bag and in it I put a [item].''", "The next player repeats that item and adds a new one.", "Keep going around, with each player repeating the WHOLE growing list before adding their own item.", "See how long the list can get before someone forgets an item!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_6, N'short_response', N'🤔 Would You Rather Tournament

Objective: Debate and vote through a bracket of silly ''would you rather'' dilemmas.

Materials: None — just imagination and voices!

Follow the steps below to play!', NULL, N'Keep dilemmas silly and fun, respecting that people vote differently.', 28, N'sequence_steps', N'{"steps": ["One player presents a ''Would you rather...'' question with two options.", "Everyone votes and briefly explains their reasoning.", "The majority option ''wins'' and moves to the next round against a new dilemma.", "Keep going through several rounds — track which type of choice wins most often!"]}');

    DECLARE @cat_nm_7 INT;
    SELECT @cat_nm_7 = category_id FROM dbo.PacketCategories WHERE grade_id = 7 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_7, N'short_response', N'🗣️ Formal Debate Showdown

Objective: Practice structured, respectful argument with opening statements, rebuttals, and closing remarks.

Materials: None — just voices, quick thinking, and 2 teams!

Follow the steps below to play!', NULL, N'Debate the ideas respectfully — no interrupting or personal comments.', 22, N'sequence_steps', N'{"steps": ["Split into 2 teams and pick a debate topic.", "Each team gives a 1-minute opening statement with their main points.", "Teams take turns giving 30-second rebuttals responding to the other side.", "Each team gives a short closing statement, then the group votes on the most convincing argument!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_7, N'short_response', N'🧠 Memory Palace Challenge

Objective: Practice memory techniques by linking a growing list of items to a mental journey.

Materials: None — just memory and imagination!

Follow the steps below to play!', NULL, N'Be patient and encouraging — this memory technique takes practice.', 23, N'sequence_steps', N'{"steps": ["Pick a familiar path (like walking from your front door to your room).", "The first player names an item and ''places'' it at the first spot along the path.", "Each player repeats all previous items in order, then adds one more at the next spot.", "See how far along the path (and how many items) your group can remember together!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_7, N'short_response', N'🎭 Improv Scene Building

Objective: Practice quick creative thinking by building an unscripted scene together with a partner.

Materials: None — just imagination, voices, and a partner!

Follow the steps below to play!', NULL, N'Keep scenes kind and appropriate — ''yes, and'' means building up, not tearing down.', 24, N'sequence_steps', N'{"steps": ["Pair up. One player starts a scene with one line (''Welcome to my spaceship!'').", "The partner responds, building on the idea — always saying ''yes, and...'' to add to what''s been said.", "Keep the scene going for a minute, building something increasingly silly and creative.", "Switch partners and start a brand new improvised scene!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_7, N'short_response', N'🤝 Blind Trust Formation

Objective: Work as a full group, using only verbal guidance, to form a specific shape together.

Materials: None — just a group of friends and no peeking!

Follow the steps below to play!', NULL, N'Move slowly with hands slightly out to avoid bumping into each other.', 25, N'sequence_steps', N'{"steps": ["Everyone closes their eyes except for one designated ''Guide.''", "The Guide calls out instructions to help the group form a shape (like a circle or a line) using only words.", "The group listens carefully and moves based only on the Guide''s voice.", "Open your eyes at the end to see how close you got to the shape!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_7, N'short_response', N'📖 Collaborative Mystery Story

Objective: Build a mystery story together, each adding a clue or twist in turn.

Materials: None — just imagination and voices!

Follow the steps below to play!', NULL, N'Keep the mystery fun and age-appropriate — nothing too scary.', 26, N'sequence_steps', N'{"steps": ["The first player sets up a mystery (''The trophy went missing from the school office...'').", "Each player adds a new clue, suspect, or twist, building the mystery together.", "After several rounds, work together to solve the mystery you''ve created!", "See if the ending actually matches all the clues that were given."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_7, N'short_response', N'🧩 Silent Sorting Challenge

Objective: Communicate and organize as a group using only gestures, no talking or writing.

Materials: None — just a group of friends and no talking!

Follow the steps below to play!', NULL, N'Move calmly while rearranging — this is about communication, not speed.', 27, N'sequence_steps', N'{"steps": ["Secretly, everyone is given a number in their head 1 through however many players there are (agree on this before starting silently, e.g. by a quick whisper from a leader).", "Without speaking or showing fingers with numbers, arrange yourselves in the correct numeric order using only gestures.", "Once everyone believes they''re in order, check together out loud.", "Try again with a trickier category to sort by, like the number of letters in your first name!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_nm_7, N'short_response', N'😉 Wink Assassin Tournament

Objective: Sharpen observation and deduction skills in an advanced elimination-style wink-detective game.

Materials: None — just eyes and a group of friends!

Follow the steps below to play!', NULL, N'Keep it lighthearted — being ''eliminated'' just means playfully sitting out that round, not leaving the game.', 28, N'sequence_steps', N'{"steps": ["Secretly assign one player as the ''Assassin'' without anyone else knowing.", "The Assassin discreetly winks at players, who dramatically act ''eliminated'' when winked at.", "One player is the ''Investigator'' and gets 3 total guesses (used at any point) to name the Assassin.", "See if the Investigator solves it before too many players are ''eliminated'' — then pick new roles and play again!"]}');

END
GO

DELETE FROM dbo.WeeklyPacketPlan;
GO