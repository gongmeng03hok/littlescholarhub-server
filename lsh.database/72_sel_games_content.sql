-- 72_sel_games_content.sql
-- Adds a 'SEL Skill-Building Games' category to the existing always-on
-- 'sel' subject_area for every grade (TK-6th) -- no schema or proc changes
-- needed, reuses dbo.PacketSubjectAreas/usp_GetOrCreateWeeklyPacket exactly
-- as-is.
--
-- Each grade gets a pool of 14 games; target_count=7 (fixed, not the usual
-- ~65% auto-rebalance ratio) means the existing NEWID()-sampling rotation
-- serves a different 7-of-14 combination most weeks a grade's sel category
-- is selected, satisfying "7 games, different set each week" without any
-- manual per-week authoring. Structurally follows
-- gen_68_outdoor_games_content.py, the proven template for this content type.
--
-- Each game is ONE PacketQuestions row: prompt carries the Name/Objective/
-- Materials, diagram_type='sequence_steps' carries the Step-by-Step
-- Instructions (already-shipped diagram type, renders as a numbered list in
-- both the app and print).
-- See gen_72_sel_games_content.py.

IF NOT EXISTS (SELECT 1 FROM dbo.PacketCategories WHERE subject_area = 'sel' AND category_name = N'SEL Skill-Building Games')
BEGIN
    DECLARE @cat_sel_0 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (0, 'sel', N'SEL Skill-Building Games', 'space_heavy', 7, N'Play a game that helps you understand feelings and get along with others!', 0);
    SET @cat_sel_0 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_0, N'short_response', N'🎭 Feeling Faces Freeze

Objective: Practice naming a feeling by making a matching face and body when the music stops.

Materials: Music player (phone or speaker)

Follow the steps below to play!', NULL, N'There''s no wrong way to show a feeling -- every face counts.', 1, N'sequence_steps', N'{"steps": ["Grown-up plays music while everyone dances around.", "When the music stops, grown-up calls out a feeling word like ''happy!''", "Everyone freezes and makes that feeling face with their whole body.", "Turn the music back on and try a new feeling next time!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_0, N'short_response', N'👂 Listening Ears Game

Objective: Practice listening carefully to a sound and copying it back together.

Materials: None -- just a grown-up and a quiet space

Follow the steps below to play!', NULL, N'Quiet ears help us hear all the little sounds around us.', 2, N'sequence_steps', N'{"steps": ["Everyone sits in a circle and closes their eyes.", "Grown-up makes a soft sound (a clap, a tap, a hum).", "Everyone opens their eyes and copies the same sound back together.", "Try a new sound each round!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_0, N'short_response', N'🤝 Pass the Squeeze

Objective: Practice taking turns and working together as a group.

Materials: None -- just a group holding hands

Follow the steps below to play!', NULL, N'Teamwork means everyone helps the squeeze keep going.', 3, N'sequence_steps', N'{"steps": ["Everyone holds hands in a circle.", "Grown-up gently squeezes the hand of the child next to them.", "That squeeze gets passed hand to hand all the way around the circle.", "See how fast the squeeze can travel all the way around!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_0, N'short_response', N'🧸 Share the Teddy

Objective: Practice taking turns sharing something with a friend.

Materials: 1 soft stuffed animal or toy

Follow the steps below to play!', NULL, N'Waiting for your turn is a way of being kind to your friends.', 4, N'sequence_steps', N'{"steps": ["Sit in a small circle with a soft toy in the middle.", "Grown-up asks a simple question, like ''What made you smile today?''", "Whoever is holding the toy gets to answer, then gently passes it to the next friend.", "Keep passing until everyone has had a turn."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_0, N'short_response', N'🐢 Turtle Breathing

Objective: Practice slow breathing to feel calm, like a turtle tucking into its shell.

Materials: None

Follow the steps below to play!', NULL, N'Turtle breathing is a trick you can use anytime you feel a big feeling.', 5, N'sequence_steps', N'{"steps": ["Stand tall with arms stretched out like a turtle''s head and legs.", "Take a big slow breath in while pulling your arms and head in like a shell.", "Breathe out slowly while opening back up.", "Repeat 3 times together!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_0, N'short_response', N'🌈 Kind Words Toss

Objective: Practice saying kind words to a friend while playing a gentle toss game.

Materials: 1 soft ball or beanbag

Follow the steps below to play!', NULL, N'Kind words are like little gifts we give with our voice.', 6, N'sequence_steps', N'{"steps": ["Sit or stand in a circle.", "Gently roll or toss the ball to a friend while saying something kind, like ''I like your smile.''", "That friend rolls it to someone new with a kind word.", "Keep going until everyone has gotten a kind word!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_0, N'short_response', N'👀 Watch and Wait

Objective: Practice waiting quietly and watching for a turn signal.

Materials: 1 soft ball

Follow the steps below to play!', NULL, N'Waiting quietly is its own kind of listening.', 7, N'sequence_steps', N'{"steps": ["Two children sit facing each other with a grown-up nearby.", "Grown-up holds up a hand as the ''go'' signal.", "Take turns rolling the ball back and forth only when the hand goes up.", "Practice waiting patiently for your turn to come!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_0, N'short_response', N'🫂 Gentle Hug Circle

Objective: Practice offering comfort to a friend who feels sad.

Materials: None

Follow the steps below to play!', NULL, N'A gentle hug can help a sad feeling feel smaller.', 8, N'sequence_steps', N'{"steps": ["Stand in a circle with a grown-up.", "Grown-up pretends to feel sad and makes a sad face.", "Everyone takes a turn giving a gentle hug or pat on the back to help.", "Talk about how it feels to help a friend feel better."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_0, N'short_response', N'🧩 Build It Together

Objective: Practice working together to build something as a team.

Materials: Soft blocks or stacking cups

Follow the steps below to play!', NULL, N'Great towers are built one turn at a time.', 9, N'sequence_steps', N'{"steps": ["Sit together with a small pile of blocks.", "Take turns adding one block at a time to build a tower.", "Talk about where to put the next piece together.", "Cheer together when the tower is finished!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_0, N'short_response', N'🌤️ Sun and Cloud Feelings

Objective: Practice noticing whether a feeling feels sunny or cloudy inside.

Materials: Paper and crayons (optional)

Follow the steps below to play!', NULL, N'Every kind of weather feeling is okay to have.', 10, N'sequence_steps', N'{"steps": ["Grown-up asks, ''How do you feel right now -- sunny or cloudy?''", "Stretch arms up wide like sunshine for a happy feeling, or curl up small like a cloud for a quiet or sad feeling.", "Show your sunny or cloudy pose to the group.", "Talk about what might turn a cloudy feeling a little more sunny."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_0, N'short_response', N'🐣 Peekaboo Patience

Objective: Practice waiting calmly for a fun surprise.

Materials: A blanket or scarf

Follow the steps below to play!', NULL, N'Waiting can be part of the fun, not just the hard part.', 11, N'sequence_steps', N'{"steps": ["One player hides behind a blanket held by a grown-up.", "Everyone waits quietly and counts to five.", "Grown-up lowers the blanket for a big ''peekaboo!''", "Take turns being the one who hides."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_0, N'short_response', N'🎈 Balloon Feelings Pop

Objective: Practice noticing a feeling word and acting it out together as a group.

Materials: 1 balloon (or soft ball)

Follow the steps below to play!', NULL, N'Feelings come and go, just like a balloon floating by.', 12, N'sequence_steps', N'{"steps": ["Grown-up names a feeling for the pretend ''balloon,'' like excited or mad.", "Everyone acts out that feeling together -- stomping for mad, jumping for excited, slumping for sad.", "Pop back to a calm, still pose after each feeling.", "Try a new feeling balloon each round!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_0, N'short_response', N'🤝 Helping Hands Hunt

Objective: Practice noticing small ways to help a friend.

Materials: None

Follow the steps below to play!', NULL, N'Even tiny helps make a big difference to a friend.', 13, N'sequence_steps', N'{"steps": ["Walk around the room or yard with a grown-up.", "Look for a friend who might need a little help, like picking up a dropped toy.", "Offer to help and say a kind word.", "Talk together about how it felt to help."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_0, N'short_response', N'🗣️ Whisper Down the Circle

Objective: Practice listening closely and passing along a simple message.

Materials: None

Follow the steps below to play!', NULL, N'Careful listening helps messages travel true.', 14, N'sequence_steps', N'{"steps": ["Sit in a circle with a grown-up.", "Grown-up whispers a short, simple word to the first friend.", "Each friend whispers it to the next, all the way around.", "Say the word out loud at the end and see if it matched!"]}');

    DECLARE @cat_sel_1 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (1, 'sel', N'SEL Skill-Building Games', 'space_heavy', 7, N'Play a game that helps you understand feelings and get along with others!', 0);
    SET @cat_sel_1 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_1, N'short_response', N'🎭 Guess My Feeling

Objective: Practice reading a friend''s face to guess how they feel.

Materials: None

Follow the steps below to play!', NULL, N'Faces can tell us a lot about how someone feels inside.', 1, N'sequence_steps', N'{"steps": ["One player makes a feeling face (happy, sad, surprised, mad).", "Friends look closely and guess the feeling out loud.", "The maker says whether they guessed right.", "Take turns being the feeling-face maker."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_1, N'short_response', N'🌬️ Pinwheel Breaths

Objective: Practice slow breathing to calm down using a pretend or real pinwheel.

Materials: A pinwheel (or just pretend to hold one)

Follow the steps below to play!', NULL, N'Slow breaths help big feelings get smaller and easier to handle.', 2, N'sequence_steps', N'{"steps": ["Hold up your pretend pinwheel in front of your face.", "Take a deep breath in through your nose.", "Blow out slowly and gently to make the pinwheel spin.", "Do it three times until you feel calm and steady."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_1, N'short_response', N'🧵 Yarn Web of Kindness

Objective: Practice giving compliments while building a web together as a group.

Materials: 1 ball of yarn or string

Follow the steps below to play!', NULL, N'Kind words connect us just like the yarn does.', 3, N'sequence_steps', N'{"steps": ["Stand in a circle, and the first player holds the end of the yarn.", "Say something kind about a friend, then toss the ball to them while holding your piece.", "That friend says something kind and tosses it to someone new.", "See the web you all made together when everyone has had a turn!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_1, N'short_response', N'🚦 Feelings Stoplight

Objective: Practice noticing if a feeling is calm, getting big, or too big.

Materials: Paper circles or a drawn stoplight (optional)

Follow the steps below to play!', NULL, N'Every color on the stoplight is a normal stop along the way to calm.', 4, N'sequence_steps', N'{"steps": ["Grown-up explains a stoplight: green means calm, yellow means a feeling is growing, red means STOP and breathe.", "Act out each color with your body -- green is standing tall and relaxed, yellow is wiggly, red is freeze and take a breath.", "Practice moving from red back down to green with slow breaths.", "Talk about a time you felt yellow or red."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_1, N'short_response', N'🤝 Handshake Hello

Objective: Practice greeting a friend warmly and paying attention to them.

Materials: None

Follow the steps below to play!', NULL, N'A friendly hello helps everyone feel noticed.', 5, N'sequence_steps', N'{"steps": ["Pair up with a friend.", "Make eye contact and say hello using their name.", "Invent a silly two-step handshake together, like a high five and a fist bump.", "Try your new handshake with a different friend!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_1, N'short_response', N'🧦 Odd Sock Sharing

Objective: Practice solving a simple problem about sharing fairly.

Materials: A few mismatched socks or small toys

Follow the steps below to play!', NULL, N'Fair doesn''t always mean the same -- it means everyone feels okay.', 6, N'sequence_steps', N'{"steps": ["Grown-up presents a pretend problem: only one fun toy, but two friends want it.", "Talk together about fair ideas, like taking turns or trading.", "Try out the idea the group agrees on.", "Talk about how the fair solution felt."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_1, N'short_response', N'🐒 Copy Cat Listening

Objective: Practice listening and copying a friend''s actions exactly.

Materials: None

Follow the steps below to play!', NULL, N'Watching and listening closely helps you remember more.', 7, N'sequence_steps', N'{"steps": ["Pair up, facing each other.", "One friend does 3 simple moves in a row, like clap, spin, wave.", "The other friend watches closely, then copies all 3 moves in order.", "Switch roles and try a new set of moves!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_1, N'short_response', N'🫧 Bubble Breath Calm Down

Objective: Practice calming breathing using real or pretend bubbles.

Materials: Bubble wand and solution (optional)

Follow the steps below to play!', NULL, N'Slow bubble breaths remind our body it''s safe to relax.', 8, N'sequence_steps', N'{"steps": ["Take a slow breath in.", "Blow out gently to make one big, slow bubble, real or pretend.", "Watch the bubble float away, carrying a little bit of a big feeling with it.", "Try again with a new bubble whenever you need to calm down."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_1, N'short_response', N'🧭 Helper of the Day

Objective: Practice looking for chances to help others throughout playtime.

Materials: None

Follow the steps below to play!', NULL, N'Helping others is a skill that grows stronger every time you use it.', 9, N'sequence_steps', N'{"steps": ["Pick one friend to be Helper of the Day.", "That friend looks for small ways to help others during playtime.", "At the end, everyone shares one kind thing the Helper did.", "Take turns so everyone gets a turn to be Helper."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_1, N'short_response', N'🎶 Mirror Move Along

Objective: Practice working together by moving in sync with a partner.

Materials: Music player (optional)

Follow the steps below to play!', NULL, N'Working well together means watching and adjusting to each other.', 10, N'sequence_steps', N'{"steps": ["Face a partner and decide who moves first.", "The first friend makes a slow movement; the partner mirrors it like a reflection.", "Switch who leads after a minute.", "Try moving together at the very same time without a leader!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_1, N'short_response', N'🙋 Raise a Quiet Hand

Objective: Practice waiting for a turn to talk by raising a hand.

Materials: None

Follow the steps below to play!', NULL, N'A raised hand is a polite way to say ''I have something to share.''', 11, N'sequence_steps', N'{"steps": ["Sit together in a group.", "Grown-up asks a fun question, like ''What''s your favorite animal?''", "Raise a quiet hand and wait to be called on before answering.", "Practice listening to each answer before the next person talks."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_1, N'short_response', N'🧺 Sorry and Solved

Objective: Practice saying sorry and fixing a small problem with a friend.

Materials: None

Follow the steps below to play!', NULL, N'Saying sorry and helping fix things shows you care.', 12, N'sequence_steps', N'{"steps": ["Act out a pretend problem, like accidentally bumping into a friend''s tower.", "The player who bumped says ''I''m sorry'' and asks how to help.", "Work together to fix or rebuild what happened.", "Give each other a high five when it''s fixed!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_1, N'short_response', N'🎁 Compliment Basket

Objective: Practice giving and receiving kind compliments.

Materials: A basket or box (optional)

Follow the steps below to play!', NULL, N'Compliments are little gifts that don''t cost anything to give.', 13, N'sequence_steps', N'{"steps": ["Sit in a circle with a pretend basket of kind words.", "Take turns picking a friend and giving them one kind compliment.", "The friend receiving it says thank you.", "Keep going until everyone has given and gotten a compliment."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_1, N'short_response', N'🐌 Slow Motion Feelings Walk

Objective: Practice noticing body feelings by moving in slow motion.

Materials: None

Follow the steps below to play!', NULL, N'Slowing down can help you notice how a feeling really feels.', 14, N'sequence_steps', N'{"steps": ["Grown-up calls out a feeling, like excited or sleepy.", "Walk in super slow motion, showing what that feeling looks like in your body.", "Freeze in your slow-motion pose when the grown-up says ''freeze.''", "Try a new feeling and walk again!"]}');

    DECLARE @cat_sel_2 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (2, 'sel', N'SEL Skill-Building Games', 'space_heavy', 7, N'Play a game that helps you understand feelings and get along with others!', 0);
    SET @cat_sel_2 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_2, N'short_response', N'🎭 Feelings Charades

Objective: Practice recognizing feelings by acting them out without words.

Materials: Index cards with feeling words (or just call them out)

Follow the steps below to play!', NULL, N'You can tell a lot about a feeling just by watching someone''s body.', 1, N'sequence_steps', N'{"steps": ["Write or say feeling words like surprised, proud, or worried.", "One player acts out the feeling using only their face and body -- no talking.", "The group guesses the feeling.", "Take turns until everyone has acted one out."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_2, N'short_response', N'🌀 Calm Down Countdown

Objective: Practice a simple breathing routine to settle a big feeling.

Materials: None

Follow the steps below to play!', NULL, N'Counting your breath gives a big feeling something steady to hold onto.', 2, N'sequence_steps', N'{"steps": ["Stand still and notice how your body feels.", "Breathe in for 4 counts, hold for 2, breathe out for 4.", "Repeat the countdown breathing three times.", "Notice if your body feels any calmer afterward."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_2, N'short_response', N'🧩 Puzzle Partners

Objective: Practice working together to solve a simple puzzle using only words.

Materials: A simple jigsaw puzzle or a picture cut into pieces

Follow the steps below to play!', NULL, N'Describing clearly and listening carefully both matter for teamwork.', 3, N'sequence_steps', N'{"steps": ["Split the puzzle pieces evenly between two partners.", "Take turns describing your pieces without showing them.", "Work together to figure out where each piece goes.", "Put the finished puzzle together as a team!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_2, N'short_response', N'⚖️ Fair Trade Talk

Objective: Practice negotiating a fair solution when two people want the same thing.

Materials: Two different toys or items

Follow the steps below to play!', NULL, N'A good solution usually means both people give a little and get a little.', 4, N'sequence_steps', N'{"steps": ["Pretend both partners want the same item.", "Take turns suggesting fair ideas, like taking turns, splitting time, or trading.", "Agree on one idea together.", "Try it out and check in: did it feel fair to both of you?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_2, N'short_response', N'👂 Listening Detective

Objective: Practice listening closely enough to retell what a partner said.

Materials: None

Follow the steps below to play!', NULL, N'Great listeners can repeat back what they heard, not just wait for their turn.', 5, N'sequence_steps', N'{"steps": ["One partner talks for 30 seconds about their weekend or a favorite thing.", "The listener stays quiet and pays close attention.", "The listener retells back three details they remember.", "Switch roles and try again!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_2, N'short_response', N'🫂 Comfort Corner Role-Play

Objective: Practice comforting a friend who is upset.

Materials: None

Follow the steps below to play!', NULL, N'Sometimes just being there for a friend is the most helpful thing.', 6, N'sequence_steps', N'{"steps": ["One player pretends to feel sad about something small, like losing a game.", "Another player practices comforting them with kind words or a listening ear.", "Switch roles so everyone practices comforting and being comforted.", "Talk about which kind words felt the most helpful."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_2, N'short_response', N'🎯 Feelings Bullseye

Objective: Practice rating how big a feeling is on a simple scale.

Materials: Paper and a pencil or crayon (optional)

Follow the steps below to play!', NULL, N'Naming the size of a feeling helps you know what to do next.', 7, N'sequence_steps', N'{"steps": ["Think of a recent feeling, like being frustrated or excited.", "Rate how big it felt: small, medium, or huge.", "Think of one thing that helped (or could help) that feeling feel smaller or celebrated.", "Share your feeling and idea with a partner if you''d like."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_2, N'short_response', N'🤹 Balance the Turn Circle

Objective: Practice sharing a group activity so everyone gets an equal turn.

Materials: 1 soft ball or beanbag

Follow the steps below to play!', NULL, N'Great group work means noticing who hasn''t had a turn yet.', 8, N'sequence_steps', N'{"steps": ["Sit in a circle and pass a ball around while saying one idea for a story out loud.", "Keep the story going, one sentence per turn, all the way around.", "Notice if anyone hasn''t had a turn yet, and make sure they do.", "See what silly story the whole group created together!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_2, N'short_response', N'🚪 Walk Away and Try Again

Objective: Practice calmly stepping away from a disagreement before trying to solve it.

Materials: None

Follow the steps below to play!', NULL, N'Stepping away for a moment isn''t giving up -- it''s making room for a better solution.', 9, N'sequence_steps', N'{"steps": ["Act out a small disagreement, like both wanting to go first.", "Practice saying ''I need a minute'' and stepping back calmly.", "Take a few breaths, then come back together to talk it out.", "Agree on a solution once you''re both calm."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_2, N'short_response', N'🕵️ Feelings Detective Walk

Objective: Practice noticing feelings in others by watching body language.

Materials: None

Follow the steps below to play!', NULL, N'Checking in with a friend shows you''re paying attention to more than just words.', 10, N'sequence_steps', N'{"steps": ["Walk around the classroom or yard with a partner.", "Quietly notice how classmates seem to be feeling from their faces and bodies.", "Compare notes with your partner about what you noticed.", "Pick one person to check in with and ask how they''re really feeling."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_2, N'short_response', N'🎤 One Mic Rule

Objective: Practice waiting for your turn to speak and giving full attention to whoever is talking.

Materials: An object to act as a pretend microphone, like a marker or block

Follow the steps below to play!', NULL, N'Whoever has the mic deserves everyone''s full attention.', 11, N'sequence_steps', N'{"steps": ["Sit in a small group and pass around a pretend microphone.", "Only the person holding the mic gets to talk.", "Everyone else listens without interrupting.", "Pass the mic to the next speaker when they''re done."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_2, N'short_response', N'🧗 Trust Walk Trail

Objective: Practice trusting a partner''s guidance while navigating with limited sight.

Materials: A blindfold or closed eyes | A few soft obstacles (cushions, cones)

Follow the steps below to play!', NULL, N'Trust grows when directions are clear, calm, and honest.', 12, N'sequence_steps', N'{"steps": ["Set up a few soft obstacles in a small safe area.", "One partner closes their eyes while the other gives calm spoken directions to navigate around them.", "Switch roles after reaching the end.", "Talk about what made you trust (or not trust) your partner''s directions."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_2, N'short_response', N'🎲 Scenario Spinner

Objective: Practice responding kindly and fairly to different social scenarios.

Materials: A few written scenario cards (or spoken prompts)

Follow the steps below to play!', NULL, N'Practicing tricky moments ahead of time makes them easier to handle for real.', 13, N'sequence_steps', N'{"steps": ["Take turns picking a scenario, like ''A friend accidentally breaks your toy.''", "Act out a kind, fair response with a partner.", "The group discusses if the response felt fair and kind.", "Try a different scenario and switch roles."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_2, N'short_response', N'🌟 Strength Spotlight

Objective: Practice noticing and naming a specific strength in a classmate.

Materials: None

Follow the steps below to play!', NULL, N'Specific compliments mean more than general ones like ''you''re nice.''', 14, N'sequence_steps', N'{"steps": ["Sit in a circle; each player picks the person to their right.", "Say one specific strength you notice in them, like ''You''re really patient when we build things.''", "The person receiving it says thank you.", "Continue until everyone has given and received a spotlight."]}');

    DECLARE @cat_sel_3 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (3, 'sel', N'SEL Skill-Building Games', 'space_heavy', 7, N'Play a game that helps you understand feelings and get along with others!', 0);
    SET @cat_sel_3 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_3, N'short_response', N'🎭 Silent Feelings Freeze

Objective: Practice recognizing feelings from body language without any words or sounds.

Materials: None

Follow the steps below to play!', NULL, N'Bodies can ''speak'' feelings just as clearly as words can.', 1, N'sequence_steps', N'{"steps": ["One player silently poses their whole body to show a feeling.", "Everyone else studies the pose and quietly whispers their guess to a neighbor.", "Reveal the feeling and compare guesses.", "Take turns being the silent poser."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_3, N'short_response', N'🌊 Wave Breathing Buddy

Objective: Practice syncing calm breathing with a partner to settle down together.

Materials: None

Follow the steps below to play!', NULL, N'Calm can be contagious -- breathing together helps both people settle.', 2, N'sequence_steps', N'{"steps": ["Sit back-to-back with a partner.", "Breathe in slowly together, feeling each other''s backs rise.", "Breathe out slowly together, like a gentle wave rolling out.", "Repeat for 5 breaths and notice how calm feels when you share it."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_3, N'short_response', N'🏗️ Blindfolded Builders

Objective: Practice giving and following clear instructions to build something as a team.

Materials: Building blocks or cups | A blindfold or closed eyes

Follow the steps below to play!', NULL, N'Clear, patient directions make teamwork possible even without seeing.', 3, N'sequence_steps', N'{"steps": ["One partner closes their eyes; the other can see the blocks.", "The seeing partner gives step-by-step spoken directions to build a small tower.", "The blindfolded partner follows only the words, not any hints.", "Open your eyes together and see how close you got!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_3, N'short_response', N'🧮 Two Sides, One Solution

Objective: Practice hearing both sides of a disagreement before deciding on a fair solution.

Materials: None

Follow the steps below to play!', NULL, N'Understanding both sides of a story is the first step to a fair fix.', 4, N'sequence_steps', N'{"steps": ["Act out a disagreement, like two friends both wanting to pick the game.", "Each side calmly explains their reason without interrupting the other.", "A third player (or the pair together) suggests a compromise.", "Try the compromise and check if it feels fair to both sides."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_3, N'short_response', N'🎙️ Echo Listening Circle

Objective: Practice active listening by restating what a speaker says in your own words.

Materials: None

Follow the steps below to play!', NULL, N'Repeating back what you heard shows a friend you were truly listening.', 5, N'sequence_steps', N'{"steps": ["Sit in a circle; one player shares a short thought or opinion.", "The next player repeats it back in their own words before sharing their own thought.", "Continue around the circle, each person echoing before adding something new.", "Talk about how it felt to be really heard."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_3, N'short_response', N'🤗 Comfort Coach

Objective: Practice offering specific, helpful comfort instead of just saying ''it''s okay.''

Materials: None

Follow the steps below to play!', NULL, N'Specific, curious comfort helps more than a quick ''it''s fine.''', 6, N'sequence_steps', N'{"steps": ["One partner acts out a real-feeling problem, like being left out of a game.", "The other partner practices asking a caring question, like ''What happened?'', before offering comfort.", "Offer one specific helpful idea, not just ''don''t worry about it.''", "Switch roles and try a different scenario."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_3, N'short_response', N'🌡️ Feelings Thermometer Check

Objective: Practice rating and describing feeling intensity using a thermometer scale.

Materials: Paper and pencil (optional)

Follow the steps below to play!', NULL, N'Naming exactly how big a feeling is makes it easier to manage.', 7, N'sequence_steps', N'{"steps": ["Draw or picture a thermometer from 1 (very calm) to 5 (very big feeling).", "Think of a recent moment and mark where your feeling landed.", "Think of one strategy that could help move a hot feeling down a notch.", "Share your thermometer reading with a partner if you want to."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_3, N'short_response', N'🧭 Group Compass Decision

Objective: Practice making a group decision where everyone''s voice counts.

Materials: None (or paper for voting)

Follow the steps below to play!', NULL, N'A good group decision makes everyone feel considered, not just outvoted.', 8, N'sequence_steps', N'{"steps": ["Present the group with a simple choice, like which game to play next.", "Each person shares their pick and one reason why.", "Vote or find a compromise that includes as many preferences as possible.", "Reflect together on whether everyone felt heard, even if they didn''t ''win.''"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_3, N'short_response', N'🛑 Cool-Off Corner Practice

Objective: Practice recognizing when to take a break during a conflict and how to return calmly.

Materials: None

Follow the steps below to play!', NULL, N'Taking a break isn''t avoiding the problem -- it''s preparing to solve it well.', 9, N'sequence_steps', N'{"steps": ["Act out getting frustrated in a small disagreement.", "Practice saying ''I need a cool-off minute'' and stepping to a calm spot.", "Use a calming strategy, like breathing or counting, for one minute.", "Return and finish the conversation calmly."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_3, N'short_response', N'🕵️ Feelings Clue Hunt

Objective: Practice picking up on subtle clues about how someone feels.

Materials: None

Follow the steps below to play!', NULL, N'Tone and body language often say more than the words themselves.', 10, N'sequence_steps', N'{"steps": ["One player thinks of a feeling but doesn''t say it out loud.", "They give three subtle clues using tone of voice, posture, and gestures, no naming the feeling.", "The group tries to guess the feeling from the clues.", "Talk about which clue was the easiest or hardest to read."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_3, N'short_response', N'🎤 No Interrupting Challenge

Objective: Practice letting a speaker finish completely before responding.

Materials: A timer (phone or watch, optional)

Follow the steps below to play!', NULL, N'Waiting for a full stop before jumping in shows real respect for what someone''s saying.', 11, N'sequence_steps', N'{"steps": ["Take turns sharing a short story or opinion for up to one minute.", "Everyone else practices waiting silently until the speaker is fully done.", "After each turn, the next speaker can respond or ask a question.", "Talk about how it felt to not be interrupted."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_3, N'short_response', N'🧗 Trust Walk Obstacle Trail

Objective: Practice trusting a partner''s guidance while navigating with limited sight.

Materials: A blindfold or closed eyes | A few soft obstacles (cushions, cones)

Follow the steps below to play!', NULL, N'Trust grows when directions are clear, calm, and honest.', 12, N'sequence_steps', N'{"steps": ["Set up several soft obstacles in a safe area.", "One partner closes their eyes while the other gives calm spoken directions to navigate around them.", "Switch roles after reaching the end.", "Talk about what made you trust, or not trust, your partner''s directions."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_3, N'short_response', N'🎲 Scenario Spinner Showdown

Objective: Practice responding kindly and fairly to different tricky social scenarios.

Materials: A few written scenario cards (or spoken prompts)

Follow the steps below to play!', NULL, N'Practicing tricky moments ahead of time makes them easier to handle for real.', 13, N'sequence_steps', N'{"steps": ["Take turns picking a scenario, like ''A friend accidentally breaks your favorite pencil.''", "Act out a kind, fair response with a partner.", "The group discusses whether the response felt fair and kind.", "Try a different scenario and switch roles."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_3, N'short_response', N'🌟 Strength Spotlight Circle

Objective: Practice noticing and naming a specific strength in a classmate.

Materials: None

Follow the steps below to play!', NULL, N'Specific compliments mean more than general ones like ''you''re nice.''', 14, N'sequence_steps', N'{"steps": ["Sit in a circle; each player picks the person to their right.", "Say one specific strength you notice in them, like ''You explain things really clearly.''", "The person receiving it says thank you.", "Continue until everyone has given and received a spotlight."]}');

    DECLARE @cat_sel_4 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (4, 'sel', N'SEL Skill-Building Games', 'space_heavy', 7, N'Play a game that helps you understand feelings and get along with others!', 0);
    SET @cat_sel_4 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_4, N'short_response', N'🎭 Emotion Layers Charades

Objective: Practice recognizing that people can feel more than one emotion at once.

Materials: Index cards with two-feeling combos, like ''excited but nervous''

Follow the steps below to play!', NULL, N'It''s normal to feel more than one thing at the same time.', 1, N'sequence_steps', N'{"steps": ["Pick a card with two feelings combined, like ''happy but embarrassed.''", "Act out both feelings blending together using face and body.", "The group guesses both feelings.", "Discuss a real situation where you might feel two things at once."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_4, N'short_response', N'🌀 Reset Routine Design

Objective: Practice designing a personal calm-down routine that actually works for you.

Materials: Paper and pencil

Follow the steps below to play!', NULL, N'A calm-down plan works best when you build it before you need it.', 2, N'sequence_steps', N'{"steps": ["List 3 things that usually help you calm down, like breathing, movement, or quiet time.", "Put them in order to create your own reset routine.", "Test your routine by imagining a frustrating moment and walking through the steps.", "Share your routine with a partner and compare ideas."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_4, N'short_response', N'🏝️ Deserted Island Debate

Objective: Practice negotiating and compromising when a group has limited resources to share.

Materials: 5-6 small item cards, like rope, blanket, flashlight

Follow the steps below to play!', NULL, N'Good negotiation means really listening to reasons, not just repeating your own.', 3, N'sequence_steps', N'{"steps": ["As a stranded group, you can only keep 3 of the 5-6 items.", "Each person argues for which items matter most and why.", "Negotiate together until the group agrees on the final 3.", "Reflect on how the group reached agreement -- voting, trading, or compromise."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_4, N'short_response', N'🎧 Interview Swap

Objective: Practice deep listening by interviewing a partner and then introducing them accurately.

Materials: None (paper optional for notes)

Follow the steps below to play!', NULL, N'The best interviewers remember details because they''re truly listening, not just waiting to talk.', 4, N'sequence_steps', N'{"steps": ["Interview a partner for 2 minutes about something they care about.", "Listen closely and remember a few key details.", "Introduce your partner to the group using only what you remember.", "Partner corrects or confirms anything you got right or missed."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_4, N'short_response', N'⚖️ Mediator for a Minute

Objective: Practice acting as a neutral mediator to help two people solve a disagreement.

Materials: None

Follow the steps below to play!', NULL, N'A good mediator doesn''t take sides -- they help both sides be heard.', 5, N'sequence_steps', N'{"steps": ["Two players act out a realistic disagreement, like disagreeing on project roles.", "A third player acts as mediator, asking each side to explain their view calmly.", "The mediator helps both sides find common ground.", "Rotate roles so everyone practices being the mediator."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_4, N'short_response', N'🔦 Spotlight on Empathy

Objective: Practice imagining a situation from someone else''s point of view.

Materials: A few scenario prompts

Follow the steps below to play!', NULL, N'Imagining someone else''s perspective is the first step toward real empathy.', 6, N'sequence_steps', N'{"steps": ["Read a scenario, like ''A new student doesn''t know anyone at lunch.''", "Each person shares what they think that person might be feeling and needing.", "Brainstorm together one specific way to help.", "Talk about a time someone made you feel welcomed like that."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_4, N'short_response', N'🧩 Silent Sculpture Build

Objective: Practice nonverbal teamwork and reading group cues without talking.

Materials: Building blocks, craft sticks, or similar materials

Follow the steps below to play!', NULL, N'Teamwork often relies on more than just talking -- watching each other matters too.', 7, N'sequence_steps', N'{"steps": ["As a group, agree to build something together without talking at all.", "Use gestures and pointing only to communicate ideas.", "Build for 5 minutes, then reveal and discuss what you made.", "Talk about how it felt to work as a team without words."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_4, N'short_response', N'🎯 Feeling Roots Investigation

Objective: Practice tracing a strong feeling back to its real cause.

Materials: Paper and pencil

Follow the steps below to play!', NULL, N'The first reason for a feeling isn''t always the real one -- digging deeper helps.', 8, N'sequence_steps', N'{"steps": ["Think of a recent strong feeling, like frustration or excitement.", "Ask yourself ''why'' three times in a row to dig past the surface reason.", "Write down what you discover about the real root of the feeling.", "Share your discovery with a partner if you''d like."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_4, N'short_response', N'🗳️ Fair Vote Council

Objective: Practice running a fair group decision process that respects the minority opinion.

Materials: Paper for voting (optional)

Follow the steps below to play!', NULL, N'A fair process matters just as much as a fair outcome.', 9, N'sequence_steps', N'{"steps": ["Present a group choice with at least 3 options.", "Discuss pros and cons of each option together.", "Vote, and if it''s not unanimous, discuss how to make the outcome still feel fair to everyone.", "Reflect on what made the process feel fair (or not)."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_4, N'short_response', N'🕰️ Perspective Time Machine

Objective: Practice retelling a conflict from the other person''s point of view.

Materials: None

Follow the steps below to play!', NULL, N'Telling a story from someone else''s view often changes how you feel about it.', 10, N'sequence_steps', N'{"steps": ["Think of a recent small disagreement you had with someone.", "Retell the story out loud, but from the other person''s perspective.", "A partner listens and asks a clarifying question.", "Talk about what you noticed seeing it from their side."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_4, N'short_response', N'🎙️ Talking Stick Debate

Objective: Practice listening fully to an opposing opinion before responding.

Materials: An object to use as a talking stick

Follow the steps below to play!', NULL, N'Understanding an opinion doesn''t mean you have to agree with it.', 11, N'sequence_steps', N'{"steps": ["Pick a light debate topic, like ''Is recess or lunch more important?''", "Only the person holding the talking stick may speak.", "Before responding, you must first summarize what the last speaker said.", "Pass the stick and continue the respectful debate."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_4, N'short_response', N'🧘 Body Scan Reset

Objective: Practice noticing tension in the body and releasing it on purpose.

Materials: None

Follow the steps below to play!', NULL, N'Your body often holds onto stress before your mind even notices it.', 12, N'sequence_steps', N'{"steps": ["Stand or sit still and slowly notice each body part from head to toe.", "Tense each muscle group for 3 seconds, then release it completely.", "Move through shoulders, hands, legs, and feet.", "Notice how your whole body feels different at the end."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_4, N'short_response', N'🎭 Conflict Rewrite

Objective: Practice rewriting how a disagreement plays out to reach a better ending.

Materials: None

Follow the steps below to play!', NULL, N'You can always choose to ''rewrite'' how a hard moment goes.', 13, N'sequence_steps', N'{"steps": ["Act out a common conflict scenario the way it usually goes wrong, like yelling or walking away angry.", "Pause and discuss what could have gone better.", "Act out the same scenario again, using better choices this time.", "Compare how the two versions felt different."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_4, N'short_response', N'🌉 Bridge the Difference

Objective: Practice finding common ground between people with different opinions or interests.

Materials: None

Follow the steps below to play!', NULL, N'Even very different interests usually share something in common if you look closely.', 14, N'sequence_steps', N'{"steps": ["Split into pairs with different favorite hobbies or interests.", "Each partner shares what they love about their interest.", "Together, find one surprising thing your two interests have in common.", "Share your bridge discovery with the group."]}');

    DECLARE @cat_sel_5 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (5, 'sel', N'SEL Skill-Building Games', 'space_heavy', 7, N'Play a game that helps you understand feelings and get along with others!', 0);
    SET @cat_sel_5 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_5, N'short_response', N'🎭 Micro-Expression Match

Objective: Practice reading quick, subtle facial expressions to identify feelings.

Materials: None

Follow the steps below to play!', NULL, N'Feelings often flash across a face quickly -- paying close attention helps you catch them.', 1, N'sequence_steps', N'{"steps": ["One player flashes a quick facial expression for just 2 seconds, then returns to neutral.", "Others try to name the feeling they caught.", "Discuss what specific facial clues gave it away, like eyebrows, mouth, or eyes.", "Take turns flashing different expressions."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_5, N'short_response', N'🔋 Feelings Battery Check

Objective: Practice checking in on your own emotional energy level throughout the day.

Materials: Paper and pencil

Follow the steps below to play!', NULL, N'Just like a phone, it''s okay to notice when your emotional battery needs a recharge.', 2, N'sequence_steps', N'{"steps": ["Draw a battery icon and rate your current emotional energy from empty to full.", "Write one reason for your current level.", "List one small action that could help recharge if you''re running low.", "Check your battery again later and notice if it changed."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_5, N'short_response', N'🏛️ Classroom Constitution

Objective: Practice negotiating group rules that everyone agrees to follow.

Materials: Paper and pencil

Follow the steps below to play!', NULL, N'Rules everyone helped write are rules everyone is more likely to follow.', 3, N'sequence_steps', N'{"steps": ["As a group, brainstorm 3-5 rules for how you''ll work together on a project.", "Discuss and adjust any rule someone disagrees with until the group finds wording everyone accepts.", "Write the final agreed rules down.", "Sign or initial the list to show your commitment."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_5, N'short_response', N'🎧 Three-Question Interview

Objective: Practice asking thoughtful follow-up questions instead of just waiting for your turn to talk.

Materials: None (paper optional for notes)

Follow the steps below to play!', NULL, N'Great follow-up questions prove you were really listening, not just waiting.', 4, N'sequence_steps', N'{"steps": ["Partner A shares something about their week for one minute.", "Partner B asks three follow-up questions based on what they actually heard.", "Switch roles and repeat.", "Talk about which follow-up question felt the most thoughtful."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_5, N'short_response', N'⚔️ Debate and Bridge

Objective: Practice arguing a position respectfully, then finding common ground with the opposing side.

Materials: A simple debate topic

Follow the steps below to play!', NULL, N'You can disagree strongly with an idea and still respect the person holding it.', 5, N'sequence_steps', N'{"steps": ["Split into two small groups, each defending a different side of a light topic.", "Each side presents their strongest point calmly.", "After both sides speak, work together to find one point you actually agree on.", "Reflect on how it felt to disagree respectfully."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_5, N'short_response', N'🪞 Empathy Mirror Interview

Objective: Practice imagining and voicing another person''s likely feelings in a real situation.

Materials: A scenario prompt

Follow the steps below to play!', NULL, N'Speaking as if you were someone else helps you understand feelings you haven''t had yourself.', 6, N'sequence_steps', N'{"steps": ["Read a scenario about someone facing a challenge, like missing a big goal or being new.", "Take turns ''becoming'' that person and answering questions in first person as if you were them.", "Your partner asks questions, like ''How did that make you feel?''", "Switch and reflect on what was easy or hard to imagine."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_5, N'short_response', N'🧠 Team Strategy Puzzle

Objective: Practice dividing tasks and combining strengths to solve a puzzle faster as a team.

Materials: A jigsaw puzzle, riddle set, or logic puzzle

Follow the steps below to play!', NULL, N'Good teams don''t just work hard -- they work smart by using everyone''s strengths.', 7, N'sequence_steps', N'{"steps": ["Look over the challenge together and decide how to split up the work.", "Assign roles based on what each person feels good at.", "Work your section, then combine results as a team.", "Discuss what strategy worked well and what you''d change next time."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_5, N'short_response', N'🌡️ Escalation Ladder

Objective: Practice recognizing the early warning signs before a feeling becomes too big to manage.

Materials: Paper and pencil

Follow the steps below to play!', NULL, N'Catching a feeling on a low rung makes it much easier to manage.', 8, N'sequence_steps', N'{"steps": ["Draw a ladder with 5 rungs from ''totally calm'' to ''completely overwhelmed.''", "Write what your body and mind feel like at each rung, like clenched fists at rung 4.", "Circle which rung you usually notice and step in to use a calming strategy.", "Share your ladder with a partner and compare warning signs."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_5, N'short_response', N'🕊️ Peace Treaty Draft

Objective: Practice writing out a fair agreement to resolve a repeated disagreement.

Materials: Paper and pencil

Follow the steps below to play!', NULL, N'Putting an agreement in writing helps everyone remember and stick to it.', 9, N'sequence_steps', N'{"steps": ["Think of a disagreement that keeps happening, like whose turn it is or sharing space.", "Each person writes down what they need to feel it''s fair.", "Together, draft a simple written agreement both people can accept.", "Both sign the treaty and agree to try it for a week."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_5, N'short_response', N'🔍 Assumption Check

Objective: Practice noticing when you''ve assumed a reason for someone''s behavior, and checking if it''s true.

Materials: A few short scenario prompts

Follow the steps below to play!', NULL, N'Our first guess about someone''s behavior isn''t always the true story.', 10, N'sequence_steps', N'{"steps": ["Read a scenario, like ''A classmate didn''t say hi to you this morning.''", "Write down your first assumption about why.", "Brainstorm at least two other possible reasons that have nothing to do with you.", "Discuss how checking assumptions changes how you might react."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_5, N'short_response', N'🎤 Panel Discussion Practice

Objective: Practice listening to multiple viewpoints in a group discussion without dominating.

Materials: A discussion topic

Follow the steps below to play!', NULL, N'A great discussion leaves room for every voice, not just the loudest one.', 11, N'sequence_steps', N'{"steps": ["Sit as a panel with one topic to discuss.", "Each person gets an equal turn to share their view uninterrupted.", "After everyone has spoken once, open it up for respectful back-and-forth.", "Reflect on whether everyone got roughly equal airtime."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_5, N'short_response', N'🧘 Reset and Refocus Routine

Objective: Practice a quick physical routine to refocus attention after a frustrating moment.

Materials: None

Follow the steps below to play!', NULL, N'A short physical reset can clear space for clearer thinking.', 12, N'sequence_steps', N'{"steps": ["Stand and shake out your hands and arms for 10 seconds.", "Take 3 slow, deep breaths while rolling your shoulders back.", "Name one thing you can see, hear, and feel right now.", "Set one small, doable next step to refocus on."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_5, N'short_response', N'🎭 Scenario Swap Court

Objective: Practice arguing both sides of a disagreement to better understand each perspective.

Materials: A scenario prompt

Follow the steps below to play!', NULL, N'Understanding the other side''s argument doesn''t mean you have to agree with it.', 13, N'sequence_steps', N'{"steps": ["Pick a common disagreement scenario as a group.", "Assign each pair to argue for the side they don''t actually agree with.", "Present your assigned side''s best argument to the group.", "Discuss how arguing the other side changed your understanding."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_5, N'short_response', N'🌱 Growth Mindset Circle

Objective: Practice supporting a teammate through a setback with encouraging, specific feedback.

Materials: None

Follow the steps below to play!', NULL, N'Real support sounds specific, not just reassuring.', 14, N'sequence_steps', N'{"steps": ["Each person shares a recent challenge or setback, big or small.", "The group responds with specific encouragement, not just ''good job'' or ''don''t worry.''", "The person shares one thing they''ll try differently next time.", "Close by each person naming one strength they see in the sharer."]}');

    DECLARE @cat_sel_6 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (6, 'sel', N'SEL Skill-Building Games', 'space_heavy', 7, N'Play a game that helps you understand feelings and get along with others!', 0);
    SET @cat_sel_6 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_6, N'short_response', N'🎭 Emotional Layers Debrief

Objective: Practice unpacking a complex situation involving mixed or conflicting feelings.

Materials: A written scenario, like ''excited to move but sad to leave friends''

Follow the steps below to play!', NULL, N'Complicated situations often come with complicated, mixed feelings -- and that''s normal.', 1, N'sequence_steps', N'{"steps": ["Read a scenario with mixed feelings out loud.", "Discuss all the different feelings someone in that situation might have.", "Debate which feeling might be strongest and why, without needing to fully agree.", "Reflect together: has anyone felt something similarly mixed before?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_6, N'short_response', N'🔧 Personal Toolkit Build

Objective: Practice building and evaluating a personalized set of strategies for handling stress.

Materials: Paper and pencil

Follow the steps below to play!', NULL, N'Having more than one tool matters, because different situations call for different strategies.', 2, N'sequence_steps', N'{"steps": ["List every calming or refocusing strategy you can think of, even ones you haven''t tried.", "Sort them into categories: physical, mental, and social strategies.", "Circle your top 3 go-to tools and explain why each works for you.", "Share your toolkit with a partner and trade one new idea."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_6, N'short_response', N'🏙️ City Council Simulation

Objective: Practice negotiating a group decision where different roles have different priorities.

Materials: Simple role cards, like ''wants more parks'' or ''wants a new library''

Follow the steps below to play!', NULL, N'Real negotiation means understanding what actually matters to each side, not just their opening position.', 3, N'sequence_steps', N'{"steps": ["Each person plays a role with a specific priority for a made-up town decision.", "Present your role''s case to the group, then listen to the others.", "Negotiate a compromise plan that addresses as many priorities as possible.", "Debrief: what made the negotiation easier or harder?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_6, N'short_response', N'🎧 Active Listening Audit

Objective: Practice noticing and correcting your own listening habits during a real conversation.

Materials: None

Follow the steps below to play!', NULL, N'Even good listeners can always find one habit worth sharpening.', 4, N'sequence_steps', N'{"steps": ["Have a 3-minute conversation with a partner about a topic you both care about.", "Partner rates you afterward on eye contact, follow-up questions, and not interrupting.", "Switch roles and repeat.", "Discuss one specific listening habit each of you wants to improve."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_6, N'short_response', N'⚖️ Both Sides Now

Objective: Practice fully understanding an opposing viewpoint before forming your own conclusion.

Materials: A debatable, age-appropriate topic

Follow the steps below to play!', NULL, N'You haven''t really heard an argument until you can explain it back accurately.', 5, N'sequence_steps', N'{"steps": ["Split into two groups defending opposite sides of a topic.", "Each side brainstorms their strongest 2-3 points.", "After presenting, each side must summarize the other side''s argument accurately.", "Discuss as a whole group whether anyone''s opinion shifted, even slightly."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_6, N'short_response', N'🪟 Window and Mirror

Objective: Practice recognizing when a story is a window into someone else''s experience versus a mirror of your own.

Materials: A few short scenario cards or stories

Follow the steps below to play!', NULL, N'Learning from someone else''s story is a powerful form of empathy.', 6, N'sequence_steps', N'{"steps": ["Read a short story or scenario about someone different from you.", "Decide if it feels like a window, learning about a new experience, or a mirror, reflecting your own experience.", "Discuss what you can learn from a window story even if it''s not your own experience.", "Share a personal example of a time a story helped you understand someone else."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_6, N'short_response', N'🧠 Divide and Conquer Challenge

Objective: Practice organizing a team by strengths under real time pressure.

Materials: A multi-step group challenge or puzzle with a timer

Follow the steps below to play!', NULL, N'Fast teamwork depends on clear roles agreed on up front, not figuring it out as you go.', 7, N'sequence_steps', N'{"steps": ["Look at the full challenge together and identify the different types of tasks involved.", "Quickly assign roles based on each person''s strengths and interests.", "Work in parallel, checking in briefly at set intervals.", "Debrief on what organizing strategy worked best under time pressure."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_6, N'short_response', N'📊 Feeling Trends Journal

Objective: Practice noticing patterns in what triggers strong feelings over time.

Materials: Paper and pencil

Follow the steps below to play!', NULL, N'Noticing your own patterns is one of the most useful emotional skills you can build.', 8, N'sequence_steps', N'{"steps": ["Think back over the last week and jot down 2-3 moments with strong feelings.", "Look for a pattern: same time of day, same type of situation, same people?", "Write one insight about a trigger you noticed.", "Write one strategy to try the next time that trigger comes up."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_6, N'short_response', N'🤝 Repair the Friendship

Objective: Practice the steps of a genuine apology and repair after a real conflict.

Materials: None

Follow the steps below to play!', NULL, N'A real apology names the specific hurt -- a vague ''sorry'' often doesn''t land the same way.', 9, N'sequence_steps', N'{"steps": ["Act out a realistic falling-out between friends, like feeling excluded or a broken promise.", "The player who caused hurt practices a genuine apology: naming what happened, how it affected the other person, and what they''ll do differently.", "The other player practices accepting the apology honestly, including saying if they need more time.", "Discuss what makes an apology feel real versus empty."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_6, N'short_response', N'🔦 Perspective Panel

Objective: Practice considering a situation from three or more different people''s perspectives at once.

Materials: A scenario involving multiple people, like a group project conflict

Follow the steps below to play!', NULL, N'The fairest solutions usually come from considering more than two points of view.', 10, N'sequence_steps', N'{"steps": ["Read a scenario involving at least 3 people with different roles.", "Assign each person in your group a character to represent.", "Each character explains the situation from their own point of view.", "Discuss together what a fair resolution would look like, considering everyone''s perspective."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_6, N'short_response', N'🎙️ Steelman Challenge

Objective: Practice restating an opposing opinion in its strongest, most fair form before responding.

Materials: A light debate topic

Follow the steps below to play!', NULL, N'Arguing against the strongest version of an idea, not a weak one, leads to better conversations.', 11, N'sequence_steps', N'{"steps": ["Pick a topic where people in the group have different opinions.", "Before disagreeing, each person must restate the other''s opinion in its strongest possible form.", "The original speaker confirms if the restatement was fair and accurate.", "Only then does the listener share their own view."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_6, N'short_response', N'🧘 Focus Reset Protocol

Objective: Practice a multi-step routine to reset focus and emotional state after a disruption.

Materials: None

Follow the steps below to play!', NULL, N'A reset routine works best when it''s the same steps every time, so your body learns to recognize it.', 12, N'sequence_steps', N'{"steps": ["Pause and name the feeling you''re currently experiencing, out loud or in your head.", "Take 4 slow breaths, counting each one.", "Physically change your position or location slightly, like standing up or turning around.", "Set one clear, small intention for what you''ll focus on next."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_6, N'short_response', N'🏛️ Mock Mediation Session

Objective: Practice running a structured mediation between two people in conflict.

Materials: None

Follow the steps below to play!', NULL, N'A structured process helps take the heat out of a hard conversation.', 13, N'sequence_steps', N'{"steps": ["Two players act out a realistic conflict, like broken trust or an unfair group work split.", "A third player mediates: each side speaks uninterrupted, the mediator summarizes both views, then the group brainstorms solutions together.", "The two sides pick a solution they can both accept.", "Debrief on what made the mediation process fair."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_6, N'short_response', N'🌍 Global Empathy Exchange

Objective: Practice imagining life circumstances very different from your own with curiosity instead of judgment.

Materials: A few short scenario descriptions of different life circumstances

Follow the steps below to play!', NULL, N'Curiosity about someone different from you is the doorway to real empathy.', 14, N'sequence_steps', N'{"steps": ["Read a short description of someone living in very different circumstances than you.", "Discuss what might be the same about their feelings and needs, despite different circumstances.", "Discuss what questions you''d want to ask them if you could.", "Reflect on one assumption you had to set aside to really imagine their perspective."]}');

    DECLARE @cat_sel_7 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (7, 'sel', N'SEL Skill-Building Games', 'space_heavy', 7, N'Play a game that helps you understand feelings and get along with others!', 0);
    SET @cat_sel_7 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_7, N'short_response', N'🎭 Emotional Contradiction Circle

Objective: Practice sitting with and discussing feelings that seem to contradict each other.

Materials: None

Follow the steps below to play!', NULL, N'Contradictory feelings aren''t a sign something''s wrong -- they''re a sign a situation is complex.', 1, N'sequence_steps', N'{"steps": ["Each person shares a time they felt two contradictory things at once, like relieved but guilty, or proud but embarrassed.", "The group discusses why both feelings can be true at the same time.", "Talk about whether one feeling needs to ''win,'' or if they can both just exist.", "Close by sharing one insight from the discussion."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_7, N'short_response', N'🧭 Values Compass Mapping

Objective: Practice connecting emotional reactions to underlying personal values.

Materials: Paper and pencil

Follow the steps below to play!', NULL, N'Strong feelings are often values speaking up -- figuring out which one helps you respond wisely.', 2, N'sequence_steps', N'{"steps": ["Think of a recent moment you felt strongly about something, like frustrated, proud, or hurt.", "Ask yourself what value was involved, like fairness, honesty, or loyalty.", "Write down the connection between the feeling and the value.", "Discuss with a partner how knowing your values helps you understand your reactions."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_7, N'short_response', N'🏛️ Stakeholder Roundtable

Objective: Practice negotiating a decision where multiple stakeholders have competing legitimate interests.

Materials: Role cards describing different stakeholder priorities

Follow the steps below to play!', NULL, N'Most real decisions involve balancing several valid interests, not picking one right answer.', 3, N'sequence_steps', N'{"steps": ["Assign each person a stakeholder role with a legitimate but different priority, like planning a class event with budget, fun, and inclusivity concerns.", "Each stakeholder presents their priority and why it matters.", "Negotiate together toward a plan that reasonably addresses multiple priorities.", "Debrief on which priorities were hardest to balance and why."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_7, N'short_response', N'🎧 Listening for What''s Not Said

Objective: Practice noticing unspoken feelings or needs behind what someone says out loud.

Materials: A few scenario prompts with subtext

Follow the steps below to play!', NULL, N'Sometimes the most important thing in a conversation is what wasn''t directly said.', 4, N'sequence_steps', N'{"steps": ["Read a short scripted line that hints at an unspoken feeling, like ''It''s fine, I guess I just won''t go.''", "Discuss what feeling or need might be behind the words.", "Practice responding to the unspoken feeling, not just the literal words.", "Switch roles and try a new line."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_7, N'short_response', N'⚖️ Ethics Roundtable

Objective: Practice discussing a values-based disagreement respectfully without needing full agreement.

Materials: An age-appropriate ethical dilemma prompt

Follow the steps below to play!', NULL, N'Respecting a different opinion doesn''t mean you have to adopt it -- it means hearing it fully.', 5, N'sequence_steps', N'{"steps": ["Present a values-based dilemma, like ''Should you tell an adult that a friend is struggling and hiding it?''", "Each person shares their view and reasoning.", "Practice responding to a differing view with ''I see it differently because...'' instead of dismissing it.", "Reflect on whether the group needs to agree, or can respectfully hold different views."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_7, N'short_response', N'🪞 Reverse Interview

Objective: Practice deeply understanding someone''s perspective by interviewing them as if writing their life story.

Materials: None

Follow the steps below to play!', NULL, N'Deep empathy starts with curiosity, not with trying to fix or relate everything back to yourself.', 6, N'sequence_steps', N'{"steps": ["Interview a partner about a challenge they''ve faced and how they felt through it.", "Ask open, curious follow-up questions rather than jumping to advice.", "Summarize their story back to them in your own words.", "Partner confirms if you captured their experience accurately."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_7, N'short_response', N'🧠 Cross-Functional Team Challenge

Objective: Practice coordinating a team where members have different skills and must combine them under a deadline.

Materials: A multi-part team challenge, like building, puzzle, or planning, with a timer

Follow the steps below to play!', NULL, N'The strongest teams adjust their plan when something isn''t working, instead of sticking to it out of habit.', 7, N'sequence_steps', N'{"steps": ["Review the challenge and identify what types of thinking or skills it requires.", "Assign roles that play to strengths, and agree on check-in points.", "Complete the challenge, adjusting roles if something isn''t working.", "Debrief on what communication strategies kept the team coordinated."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_7, N'short_response', N'📈 Trigger Pattern Analysis

Objective: Practice analyzing personal emotional patterns to identify proactive strategies.

Materials: Paper and pencil

Follow the steps below to play!', NULL, N'You can''t change a pattern you haven''t noticed yet -- awareness is the first real step.', 8, N'sequence_steps', N'{"steps": ["Reflect on the last month and identify a recurring emotional trigger.", "Analyze what typically happens right before, during, and after that trigger.", "Identify one point in that pattern where a different choice could change the outcome.", "Write a specific, realistic plan to try that different choice next time."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_7, N'short_response', N'🤝 Full-Circle Apology Practice

Objective: Practice giving and receiving a complete apology that addresses impact, not just intent.

Materials: None

Follow the steps below to play!', NULL, N'A strong apology owns the impact of an action, not just the good intentions behind it.', 9, N'sequence_steps', N'{"steps": ["Act out a realistic conflict where intent and impact were different, like a joke that unintentionally hurt someone.", "Practice apologizing for the impact even when the intent wasn''t to hurt.", "The other person practices explaining the impact honestly, without exaggerating or minimizing.", "Discuss the difference between ''I''m sorry you felt that way'' and ''I''m sorry I did that.''"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_7, N'short_response', N'🔦 Systems of Perspective

Objective: Practice recognizing how someone''s circumstances shape their perspective on a shared situation.

Materials: A scenario involving people from different circumstances

Follow the steps below to play!', NULL, N'The same event can land very differently on different people -- fairness means noticing that.', 10, N'sequence_steps', N'{"steps": ["Read a scenario involving people affected differently by the same event.", "Discuss how each person''s different circumstances might shape how they experience it.", "Identify one assumption that might be unfair to make about any of them.", "Discuss what a genuinely fair response would look like for everyone involved."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_7, N'short_response', N'🎙️ Devil''s Advocate Rotation

Objective: Practice genuinely considering a viewpoint you disagree with by being assigned to argue it.

Materials: A debatable, age-appropriate topic

Follow the steps below to play!', NULL, N'Arguing a view you disagree with is one of the fastest ways to actually understand it.', 11, N'sequence_steps', N'{"steps": ["Pick a topic and have each person state their honest opinion first.", "Rotate: everyone must now argue the opposite of their own stated opinion for two minutes.", "The group discusses which ''opposite'' arguments were more convincing than expected.", "Reflect on whether anyone''s original opinion shifted even slightly."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_7, N'short_response', N'🧘 Self-Directed Reset Design

Objective: Practice designing and committing to a personal, repeatable strategy for handling a specific stressful pattern.

Materials: Paper and pencil

Follow the steps below to play!', NULL, N'A plan you designed yourself is more likely to work than one someone else handed you.', 12, N'sequence_steps', N'{"steps": ["Identify one recurring stressful situation, like a hard subject or competition nerves.", "Design a specific, step-by-step personal plan for handling it better next time.", "Share your plan with a partner and get one piece of honest feedback.", "Commit to trying your plan the next time that situation comes up."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_7, N'short_response', N'🏛️ Community Impact Council

Objective: Practice weighing competing community interests to reach a decision that considers the common good.

Materials: Role cards representing different community perspectives

Follow the steps below to play!', NULL, N'Real fairness often means naming trade-offs honestly, not pretending everyone gets everything they want.', 13, N'sequence_steps', N'{"steps": ["Assign roles representing different community members affected by a shared decision, like a new school policy.", "Each role presents their concerns and what they need from the outcome.", "As a council, negotiate a decision, explicitly naming any trade-offs made.", "Debrief on what ''fair to everyone'' actually looked like in practice."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_sel_7, N'short_response', N'🌍 Empathy Beyond Agreement

Objective: Practice extending genuine empathy to someone whose choices or opinions you don''t agree with.

Materials: A scenario involving a character making an understandable but debatable choice

Follow the steps below to play!', NULL, N'You can understand someone''s feelings without agreeing with their actions -- both can be true.', 14, N'sequence_steps', N'{"steps": ["Read a scenario where a character makes a choice the group might not agree with, but can understand.", "Discuss what pressures or feelings might have led to that choice.", "Separate ''I understand why'' from ''I agree with what they did.''", "Reflect on why it''s possible, and useful, to empathize with someone without approving of their choice."]}');

END
GO

DELETE FROM dbo.WeeklyPacketPlan;
GO