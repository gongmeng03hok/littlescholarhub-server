-- 68_outdoor_games_content.sql
-- Adds an 'Outdoor Games' category to the existing always-on 'health'
-- subject_area for every grade (TK-6th) — no schema or proc changes needed,
-- reuses dbo.PacketSubjectAreas/usp_GetOrCreateWeeklyPacket exactly as-is.
--
-- Each grade gets a pool of 14 games; target_count=7 (fixed, not the usual
-- ~65% auto-rebalance ratio) means the existing NEWID()-sampling rotation
-- serves a different 7-of-14 combination most weeks a grade's health
-- category is selected, satisfying "7 outdoor games, different set each
-- week" without any manual per-week authoring.
--
-- Each game is ONE PacketQuestions row: prompt carries the Name/Objective/
-- Materials, diagram_type='sequence_steps' carries the Step-by-Step
-- Instructions (already-shipped diagram type, renders as a numbered list in
-- both the app and print — see 63_whole_child_rotation.sql). The requested
-- 'Image Instruction' (a prompt for an illustrator/AI image generator) has
-- no home in the schema — nothing in Weekly Packets renders raster images
-- today, only code-drawn diagrams — so those prompts are NOT stored here;
-- see games_image_prompts.md (generated alongside this file) instead.
-- See gen_68_outdoor_games_content.py.

IF NOT EXISTS (SELECT 1 FROM dbo.PacketCategories WHERE subject_area = 'health' AND category_name = 'Outdoor Games')
BEGIN
    DECLARE @cat_outdoor_0 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (0, 'health', N'Outdoor Games', 'space_heavy', 7, N'Pick a game below and play it outside with friends or family this week!', 0);
    SET @cat_outdoor_0 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_0, N'short_response', N'🐸 Animal Walk Relay

Objective: Practice moving like different animals while taking turns with friends.

Materials: 2 cones or chairs (start/finish markers) | Open grass area

Follow the steps below to play!', NULL, N'Walk (don''t run) on grass, and take breaks whenever you feel tired.', 1, N'sequence_steps', N'{"steps": ["Grown-up sets 2 markers about 10 big steps apart.", "First player hops like a frog to the far marker.", "Next player waddles like a duck back to start.", "Take turns picking a new animal each round (bear crawl, bunny hop, crab walk)."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_0, N'short_response', N'🫧 Bubble Pop Dash

Objective: Chase and pop bubbles to practice running, reaching, and having fun outside.

Materials: Bubble solution and wand (or bubble machine)

Follow the steps below to play!', NULL, N'Watch where you''re running so you don''t bump into a friend.', 2, N'sequence_steps', N'{"steps": ["A grown-up blows a big batch of bubbles into the air.", "Children run and pop as many bubbles as they can before they land.", "Count out loud together how many bubbles got popped.", "Repeat with a new batch of bubbles!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_0, N'short_response', N'🌈 Color Hunt Hop

Objective: Find and hop to matching colors while exploring outside.

Materials: 5-6 sheets of colored paper or chalk-drawn color circles | Sidewalk chalk (optional)

Follow the steps below to play!', NULL, N'Look before you hop so you land safely.', 3, N'sequence_steps', N'{"steps": ["Grown-up places colored papers (or draws chalk circles) around the yard.", "Call out a color, like ''yellow!''", "Everyone hops to the matching colored spot.", "Take turns calling out the next color."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_0, N'short_response', N'🐾 Follow the Leader Trail

Objective: Copy a leader''s fun movements while walking along an outdoor path.

Materials: None — just open outdoor space

Follow the steps below to play!', NULL, N'Leaders should pick movements that are safe to copy, like walking, not running fast.', 4, N'sequence_steps', N'{"steps": ["One child (or grown-up) is picked as the Leader.", "The Leader walks a path and does a silly movement (tiptoe, big steps, spin, wave arms).", "Everyone else follows behind, copying exactly what the Leader does.", "After a few minutes, pick a new Leader."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_0, N'short_response', N'👥 Shadow Tag

Objective: Practice moving quickly and carefully while playing a gentle version of tag.

Materials: Sunny outdoor space (needs visible shadows)

Follow the steps below to play!', NULL, N'Play in an open, flat area with no obstacles to trip on.', 5, N'sequence_steps', N'{"steps": ["One player is ''It.''", "''It'' tries to step on another player''s shadow.", "If your shadow is stepped on, you become the new ''It.''", "Keep playing and taking turns being ''It.''"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_0, N'short_response', N'💃 Freeze Dance Outside

Objective: Dance freely to music, then freeze completely still when the music stops.

Materials: Music player or phone with speaker

Follow the steps below to play!', NULL, N'Dance in a space with room to move without bumping into anyone.', 6, N'sequence_steps', N'{"steps": ["Turn on fun music and dance around the yard.", "A grown-up pauses the music without warning.", "Everyone freezes in their silliest pose the moment the music stops.", "Turn the music back on and keep dancing!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_0, N'short_response', N'🎈 Parachute Popcorn

Objective: Work together to bounce a ball high using a shared parachute or blanket.

Materials: Play parachute or large lightweight blanket | Soft foam ball or beanbag

Follow the steps below to play!', NULL, N'Use a soft ball only, and keep a good grip on the parachute.', 7, N'sequence_steps', N'{"steps": ["Everyone holds the edge of the parachute (or blanket) in a circle.", "Place a soft ball in the middle.", "Everyone shakes the parachute up and down together to bounce the ''popcorn'' ball high.", "See how high you can bounce it without it falling off!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_0, N'short_response', N'🦆 Duck Duck Goose

Objective: Practice quick reactions and taking turns in a classic circle game.

Materials: None — just a group and open grass

Follow the steps below to play!', NULL, N'Run around the OUTSIDE of the circle only, watching for friends sitting down.', 8, N'sequence_steps', N'{"steps": ["Everyone sits in a circle facing inward.", "One player walks around the outside, tapping heads and saying ''duck'' each time.", "On one head, they say ''goose!'' instead.", "The ''goose'' jumps up and chases the tapper around the circle back to the empty spot."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_0, N'short_response', N'🎯 Rainbow Ring Toss

Objective: Practice aiming and throwing rings onto colorful targets.

Materials: 3-4 plastic rings or hula hoops | 1-2 traffic cones or bottles as targets

Follow the steps below to play!', NULL, N'Only toss rings — never throw them at people.', 9, N'sequence_steps', N'{"steps": ["Stand a cone or bottle upright as the target.", "Stand a few steps back (grown-up marks a line).", "Take turns tossing rings, trying to land them around the target.", "Count how many rings each person lands!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_0, N'short_response', N'🦁 Sleeping Lions

Objective: Practice lying still and calm, like a resting lion, for as long as possible.

Materials: Soft grass or blanket to lie on

Follow the steps below to play!', NULL, N'Choose a soft, shaded, clean spot to lie down.', 10, N'sequence_steps', N'{"steps": ["Everyone lies down on the grass and pretends to be a sleeping lion.", "Stay as still and quiet as possible.", "A grown-up gently checks around — if you giggle or move too much, you''re ''awake!''", "Whoever stays ''asleep'' the longest wins a cheer from the group."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_0, N'short_response', N'🎈 Balloon Bounce Walk

Objective: Practice balance and gentle movement while keeping a balloon in the air.

Materials: 1 balloon per child

Follow the steps below to play!', NULL, N'Walk carefully and watch for friends around you.', 11, N'sequence_steps', N'{"steps": ["Give each child a balloon.", "Walk around the yard while gently bouncing the balloon in the air.", "Try not to let your balloon touch the ground!", "See how far you can walk without dropping it."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_0, N'short_response', N'🔍 Nature Scavenger Stroll

Objective: Explore outside and find simple items from nature.

Materials: Simple picture list (leaf, rock, flower, stick, feather)

Follow the steps below to play!', NULL, N'Only touch plants and items a grown-up says are safe.', 12, N'sequence_steps', N'{"steps": ["Look at the picture list together with a grown-up.", "Walk around the yard or park looking for each item.", "Point to (or gently pick up) each item you find.", "Celebrate together when you find them all!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_0, N'short_response', N'👂 Simon Says Outside

Objective: Practice listening carefully and following movement directions.

Materials: None — just open outdoor space

Follow the steps below to play!', NULL, N'Choose safe movements like jumping, spinning slowly, or waving arms.', 13, N'sequence_steps', N'{"steps": ["One person is ''Simon'' and gives movement directions.", "If Simon says ''Simon says jump!'' — everyone jumps.", "If Simon just says ''jump!'' (no ''Simon says'') — don''t move!", "Take turns being Simon."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_0, N'short_response', N'⚽ Roll the Big Ball

Objective: Practice rolling and catching a large, soft ball with a partner.

Materials: 1 large soft ball (beach ball or exercise ball)

Follow the steps below to play!', NULL, N'Roll gently — don''t throw the ball hard.', 14, N'sequence_steps', N'{"steps": ["Two players sit or stand facing each other, a few steps apart.", "One player rolls the ball to the other.", "Catch or stop the ball, then roll it back.", "Take a step back after every few rolls to make it a bit harder!"]}');

    DECLARE @cat_outdoor_1 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (1, 'health', N'Outdoor Games', 'space_heavy', 7, N'Pick a game below and play it outside with friends or family this week!', 0);
    SET @cat_outdoor_1 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_1, N'short_response', N'🚦 Red Light, Green Light

Objective: Practice starting, stopping, and listening carefully to directions.

Materials: None — just open grass space

Follow the steps below to play!', NULL, N'Walk, don''t run, so you can freeze safely on ''red light.''', 1, N'sequence_steps', N'{"steps": ["One player is the ''Stoplight'' and stands at the finish line.", "Everyone else lines up at the starting line.", "When the Stoplight says ''Green light!'' everyone walks forward.", "When the Stoplight says ''Red light!'' everyone freezes instantly.", "First player to reach the Stoplight becomes the new Stoplight."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_1, N'short_response', N'🎯 Beanbag Toss Target

Objective: Practice aiming and tossing beanbags into target zones.

Materials: 3-4 beanbags | Hula hoop or chalk-drawn target circles | Sidewalk chalk (optional)

Follow the steps below to play!', NULL, N'Only toss beanbags at the target — never at people.', 2, N'sequence_steps', N'{"steps": ["Lay a hula hoop on the ground (or draw circles with chalk) a few steps away.", "Take turns tossing beanbags, trying to land them inside the circle.", "Count how many beanbags land inside.", "Try stepping back farther for a harder challenge!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_1, N'short_response', N'🦒 Animal Charades Tag

Objective: Act out animals while playing a gentle chasing game.

Materials: Index cards with animal pictures (optional)

Follow the steps below to play!', NULL, N'Play in a wide open space with no obstacles to trip over.', 3, N'sequence_steps', N'{"steps": ["One player is ''It'' and picks an animal to act like while chasing (e.g., a bear).", "Everyone else runs away, also moving like a different animal.", "When tagged, that player becomes ''It'' and picks a new animal.", "Keep switching animals each round!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_1, N'short_response', N'🎡 Hula Hoop Hop

Objective: Practice jumping and balance by hopping through a row of hoops.

Materials: 5-6 hula hoops

Follow the steps below to play!', NULL, N'Take your time — it''s not a race, balance matters more than speed.', 4, N'sequence_steps', N'{"steps": ["Lay hula hoops in a row on the ground, slightly apart.", "Hop from hoop to hoop, landing with both feet inside each one.", "Try to reach the end without stepping outside a hoop.", "Take turns and cheer each other on!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_1, N'short_response', N'🛍️ Sack Hop Race

Objective: Practice jumping with both feet together in a fun hopping race.

Materials: 1 pillowcase or sack per player | 2 cones (start/finish)

Follow the steps below to play!', NULL, N'Hop on grass or soft ground, and go at a pace you can control.', 5, N'sequence_steps', N'{"steps": ["Each player steps into a sack, holding the top edges with both hands.", "Line up at the start marker.", "On ''go,'' hop forward toward the finish line inside your sack.", "First one to the finish wins — then race again!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_1, N'short_response', N'🫧 Bubble Wand Chase

Objective: Chase, catch, and pop bubbles while running and jumping outside.

Materials: Bubble wand and solution

Follow the steps below to play!', NULL, N'Watch where you run so you don''t bump into friends or furniture.', 6, N'sequence_steps', N'{"steps": ["A grown-up blows a big stream of bubbles.", "Children chase after the bubbles and try to catch or pop them.", "Try catching one gently on your finger without popping it!", "Blow a new batch and keep playing."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_1, N'short_response', N'🎵 Musical Hoops

Objective: Practice quick movement and listening for when music stops.

Materials: Hula hoops (one fewer than the number of players) | Music player

Follow the steps below to play!', NULL, N'Step (don''t dive) into hoops to avoid bumping heads with a friend.', 7, N'sequence_steps', N'{"steps": ["Lay hula hoops in a circle on the ground.", "Play music while everyone walks around the hoops.", "When the music stops, jump into the nearest hoop!", "Remove one hoop each round — whoever can''t find a hoop cheers on the rest."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_1, N'short_response', N'🍂 Nature Color Match

Objective: Find outdoor items that match a set of color cards.

Materials: 5-6 colored paper swatches or cards

Follow the steps below to play!', NULL, N'Only touch plants or items a grown-up says are okay to touch.', 8, N'sequence_steps', N'{"steps": ["Grown-up hands each child a colored card.", "Search the yard or park for something outside that matches that color.", "Bring back your item (or point to it) to show the group.", "Trade cards and search for a new color!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_1, N'short_response', N'🕳️ Obstacle Crawl Course

Objective: Move through a simple obstacle course using different movements.

Materials: Hula hoops, cones, a jump rope or pool noodle (for crawling under)

Follow the steps below to play!', NULL, N'Go one at a time so no one bumps into each other.', 9, N'sequence_steps', N'{"steps": ["Set up 3-4 simple stations: hop through hoops, crawl under a rope, walk around cones, jump over a line.", "Line up and go through the course one at a time.", "Cheer for whoever is going through the course!", "Take turns going again and try to go faster (but still carefully)."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_1, N'short_response', N'⭕ Ring Around Relay

Objective: Practice running in a loop and tagging a teammate to keep the relay going.

Materials: 2 cones to mark a loop

Follow the steps below to play!', NULL, N'Run at a pace you can control, and tag hands gently.', 10, N'sequence_steps', N'{"steps": ["Set up two cones a short distance apart to mark a loop.", "Split into 2 small teams, lined up at one cone.", "First player runs around the loop and tags the next teammate''s hand.", "Keep going until every player has had a turn!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_1, N'short_response', N'☁️ Cloud Watching Circle

Objective: Practice lying still, looking up, and imagining shapes in the clouds together.

Materials: A blanket to lie on (optional)

Follow the steps below to play!', NULL, N'Choose a shaded or sunscreen-protected spot to lie comfortably.', 11, N'sequence_steps', N'{"steps": ["Everyone lies down on a blanket or the grass, looking up at the sky.", "Take turns pointing out a cloud and saying what shape it looks like.", "Listen to what shapes your friends see too.", "Relax and enjoy the sky for a few quiet minutes."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_1, N'short_response', N'🗺️ Follow the Path Maze

Objective: Follow a chalk-drawn path from start to finish without stepping off.

Materials: Sidewalk chalk

Follow the steps below to play!', NULL, N'Walk slowly on the chalk path to avoid slipping.', 12, N'sequence_steps', N'{"steps": ["Draw a winding path on the driveway or sidewalk with chalk.", "Walk along the path, staying on the chalk lines.", "Try walking backward or hopping along the path for a challenge!", "Draw a new, trickier path and try again."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_1, N'short_response', N'🥅 Kick and Catch

Objective: Practice kicking a ball to a partner and catching it back.

Materials: 1 soft playground ball

Follow the steps below to play!', NULL, N'Kick gently along the ground — no high kicks.', 13, N'sequence_steps', N'{"steps": ["Two players stand a few steps apart, facing each other.", "One player gently kicks the ball to the other.", "The other player stops the ball with their foot or catches it with their hands.", "Take turns kicking back and forth."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_1, N'short_response', N'🦘 Giant Steps

Objective: Practice asking politely and taking different-sized steps toward a goal.

Materials: None — just open space

Follow the steps below to play!', NULL, N'Take steps carefully so you don''t lose your balance and fall.', 14, N'sequence_steps', N'{"steps": ["One player is the ''Leader'' and stands at the finish line.", "Everyone else lines up at the start and asks, ''Mother, may I take [2 giant steps]?''", "The Leader says ''Yes, you may!'' (or suggests a different step type).", "First to reach the Leader wins and becomes the new Leader."]}');

    DECLARE @cat_outdoor_2 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (2, 'health', N'Outdoor Games', 'space_heavy', 7, N'Pick a game below and play it outside with friends or family this week!', 0);
    SET @cat_outdoor_2 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_2, N'short_response', N'🏁 Simple Relay Race

Objective: Work as a team to run and pass a baton as fast as possible.

Materials: 1 baton (or stick/ball) | 2 cones

Follow the steps below to play!', NULL, N'Hand off the baton carefully — don''t throw it.', 1, N'sequence_steps', N'{"steps": ["Split into 2 teams, lined up behind a starting cone.", "First runner races to the far cone, around it, and back.", "Hand the baton to the next teammate.", "First team to have everyone finish wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_2, N'short_response', N'🧭 Four Corners

Objective: Practice quick decision-making and quiet movement between four spots.

Materials: 4 cones or markers to label corners of a square area

Follow the steps below to play!', NULL, N'Walk quietly to your corner — no running or pushing.', 2, N'sequence_steps', N'{"steps": ["Mark 4 corners of a square play area with cones.", "One player is ''It'' and closes their eyes and counts to 10 in the middle.", "Everyone else quietly picks a corner to stand in.", "''It'' points to a corner with eyes still closed — everyone there is out!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_2, N'short_response', N'🦈 Gentle Sharks and Minnows

Objective: Practice running and dodging while trying to cross safely to the other side.

Materials: 2 lines marked with chalk or cones (opposite ends of the play area)

Follow the steps below to play!', NULL, N'Tag gently with an open hand — no grabbing or shoving.', 3, N'sequence_steps', N'{"steps": ["One or two players are ''Sharks'' and stand in the middle.", "Everyone else (''Minnows'') lines up on one side.", "On ''go,'' Minnows try to run to the other side without being gently tagged.", "Tagged Minnows become Sharks for the next round!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_2, N'short_response', N'🏐 Balloon Volleyball

Objective: Work with a partner to keep a balloon from touching the ground using a ''net.''

Materials: 1 balloon | A jump rope or string tied between two chairs as a net

Follow the steps below to play!', NULL, N'Use gentle taps, not hard hits, since it''s a balloon.', 4, N'sequence_steps', N'{"steps": ["Tie a rope between two chairs at chest height to make a net.", "Two players stand on opposite sides.", "Hit the balloon back and forth over the ''net'' using your hands.", "Count how many times you can hit it back and forth without it touching the ground!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_2, N'short_response', N'🎯 Beanbag Bullseye

Objective: Practice aiming beanbags at a target to score points.

Materials: 4-5 beanbags | Chalk-drawn target circles or a hula hoop with a bucket in the middle

Follow the steps below to play!', NULL, N'Only toss toward the target, never at another player.', 5, N'sequence_steps', N'{"steps": ["Draw 3 rings on the ground with chalk (or set a bucket inside a hoop) — outer ring worth 1 point, middle worth 2, center worth 3.", "Stand behind a throwing line a few steps back.", "Take turns tossing beanbags, adding up your points.", "Play 3 rounds and see who scores the most!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_2, N'short_response', N'🏗️ Obstacle Course Challenge

Objective: Complete a multi-station obstacle course as quickly and safely as possible.

Materials: Cones, hula hoops, a jump rope, a small ramp or step (optional)

Follow the steps below to play!', NULL, N'Go one at a time through the course, and walk (don''t sprint) between stations.', 6, N'sequence_steps', N'{"steps": ["Set up 4-5 stations: zigzag around cones, hop through hoops, crawl under a rope, balance-walk a line, jump over a small object.", "Time each player (or team) going through the whole course.", "Cheer each other on as you go through the stations.", "Try again and see if you can beat your own time!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_2, N'short_response', N'🧊 Freeze Tag

Objective: Practice running, dodging, and helping teammates get unfrozen.

Materials: Open play space

Follow the steps below to play!', NULL, N'Tag gently with an open hand, and crawl carefully under arms.', 7, N'sequence_steps', N'{"steps": ["One or two players are ''It.''", "When tagged, a player freezes in place with arms out.", "Frozen players can be unfrozen if a teammate crawls under their arms.", "See if ''It'' can freeze everyone, or if the team can stay unfrozen!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_2, N'short_response', N'🎡 Hula Hoop Toss

Objective: Practice tossing hula hoops onto a target for points.

Materials: 3-4 hula hoops | 1 cone or bottle as a target post

Follow the steps below to play!', NULL, N'Toss hoops low and gently — never toward another person.', 8, N'sequence_steps', N'{"steps": ["Stand a cone or bottle upright as the target.", "Stand a few steps back behind a line.", "Take turns tossing hula hoops like rings, trying to land them around the target.", "Count how many hoops each player lands!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_2, N'short_response', N'🔍 Nature Scavenger Hunt

Objective: Find a list of outdoor items by searching and observing carefully.

Materials: A written or picture scavenger hunt list (leaf, pinecone, feather, rock, flower, bug)

Follow the steps below to play!', NULL, N'Only pick up items a grown-up says are safe to touch.', 9, N'sequence_steps', N'{"steps": ["Look over the scavenger hunt list together.", "Search the yard or park for each item on the list.", "Check off (or collect) each item as you find it.", "See who can find every item first, or work together as a team!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_2, N'short_response', N'🏃 Simon Says Sprint

Objective: Practice listening carefully and reacting quickly with movement commands.

Materials: Open outdoor space

Follow the steps below to play!', NULL, N'Pick safe movements — no fast running near obstacles.', 10, N'sequence_steps', N'{"steps": ["One player is ''Simon'' and calls out movement commands.", "If Simon says ''Simon says run in place!'' — everyone does it.", "If Simon just says ''run in place!'' (no ''Simon says'') — don''t move!", "Anyone who moves at the wrong time sits out one round, then rejoins."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_2, N'short_response', N'🚧 Line Tag

Objective: Practice quick footwork by only being allowed to run along drawn lines.

Materials: Sidewalk chalk to draw a grid of lines

Follow the steps below to play!', NULL, N'Watch your footing on the lines so you don''t trip.', 11, N'sequence_steps', N'{"steps": ["Draw a large chalk grid (like a tic-tac-toe pattern, but bigger) on pavement.", "One player is ''It'' and can only move along the chalk lines.", "Everyone else also must stay on the lines while avoiding being tagged.", "Tagged players become ''It'' for the next round."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_2, N'short_response', N'🪣 Bucket Ball Toss

Objective: Practice underhand throwing accuracy by tossing balls into buckets.

Materials: 3 buckets of different sizes | Several small soft balls

Follow the steps below to play!', NULL, N'Use an underhand toss, and only aim at the buckets.', 12, N'sequence_steps', N'{"steps": ["Line up 3 buckets at different distances (close, medium, far).", "Stand behind a throwing line.", "Take turns tossing balls, trying to land them in a bucket.", "Farther buckets are worth more points — add up your score!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_2, N'short_response', N'🧭 Follow the Compass

Objective: Practice following simple directions (left, right, forward, back) to reach a spot.

Materials: Sidewalk chalk or cones to mark a start and hidden ''treasure'' spot

Follow the steps below to play!', NULL, N'Walk carefully while counting steps so you don''t bump into anything.', 13, N'sequence_steps', N'{"steps": ["A grown-up hides a small prize or marker somewhere in the yard.", "Give simple directions: ''5 steps forward, turn right, 3 steps forward.''", "Follow the directions exactly to find the hidden spot.", "Take turns giving directions to a friend!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_2, N'short_response', N'🗿 Statue Game

Objective: Practice balance and self-control by freezing in place after being spun or tossed gently.

Materials: Open grass space

Follow the steps below to play!', NULL, N'Spin gently and slowly — this is about balance, not speed.', 14, N'sequence_steps', N'{"steps": ["One player gently spins or swings each player''s hand once, then lets go.", "That player must freeze immediately in whatever position they land in, like a statue.", "Everyone tries to hold their statue pose without wobbling.", "After a few seconds, take turns being the ''spinner.''"]}');

    DECLARE @cat_outdoor_3 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (3, 'health', N'Outdoor Games', 'space_heavy', 7, N'Pick a game below and play it outside with friends or family this week!', 0);
    SET @cat_outdoor_3 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_3, N'short_response', N'🚩 Capture the Flag Lite

Objective: Work with a team to sneak across enemy territory and grab the other team''s flag.

Materials: 2 flags (or bandanas) | Cones to mark a center dividing line

Follow the steps below to play!', NULL, N'Tag gently with an open hand — no grabbing clothes or pulling.', 1, N'sequence_steps', N'{"steps": ["Split into 2 teams, each with its own half of the field and a flag hidden near the back.", "On ''go,'' try to sneak into the other team''s territory to grab their flag.", "If tagged in enemy territory, walk back to your own side and try again.", "First team to bring the flag back to their side wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_3, N'short_response', N'⚽ Kickball Basics

Objective: Practice kicking, running bases, and basic teamwork rules of kickball.

Materials: 1 kickball | 4 bases (or cones)

Follow the steps below to play!', NULL, N'Run bases carefully and watch for the ball and other players.', 2, N'sequence_steps', N'{"steps": ["Set up 4 bases in a diamond shape, like baseball.", "One team kicks, the other fields the ball.", "The pitcher rolls the ball to the kicker, who kicks it and runs the bases.", "The fielding team tries to get the kicker ''out'' by catching the ball or tagging a base."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_3, N'short_response', N'🎯 Frisbee Toss Target

Objective: Practice throwing a frisbee accurately toward a target.

Materials: 1 flying disc (frisbee) | A hula hoop or bucket as a target

Follow the steps below to play!', NULL, N'Only throw toward the target and check that no one is in the flight path.', 3, N'sequence_steps', N'{"steps": ["Set a hula hoop or bucket on the ground as the target.", "Stand a few steps back behind a throwing line.", "Take turns throwing the frisbee, aiming for the target.", "Move the line back for a bigger challenge as you improve!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_3, N'short_response', N'🏃 Obstacle Relay Teams

Objective: Work as a team to complete an obstacle course relay as fast as possible.

Materials: Cones, hula hoops, a jump rope, a baton

Follow the steps below to play!', NULL, N'Only one runner goes through the course at a time per team.', 4, N'sequence_steps', N'{"steps": ["Set up an obstacle course (zigzag cones, hop through hoops, crawl under a rope).", "Split into 2 teams, lined up at the start.", "First player runs the course and hands the baton to the next teammate.", "First team to have everyone finish the course wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_3, N'short_response', N'🌀 Blob Tag

Objective: Work together as a growing group to tag remaining players.

Materials: Open play space

Follow the steps below to play!', NULL, N'The Blob must stay holding hands — no letting go to grab someone.', 5, N'sequence_steps', N'{"steps": ["One player is ''It'' and tags another player.", "The two tagged players hold hands and become ''the Blob,'' chasing together.", "Every new player tagged joins the Blob, holding hands in a line.", "Last player not tagged wins the round!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_3, N'short_response', N'⚖️ Ball Balance Race

Objective: Practice balance and steady movement while carrying a ball on a spoon or racket.

Materials: 1 spoon or small racket per player | 1 small ball per player | 2 cones

Follow the steps below to play!', NULL, N'Walk carefully — this is about balance, not speed.', 6, N'sequence_steps', N'{"steps": ["Each player balances a small ball on a spoon or racket.", "Line up at the start cone.", "Walk to the far cone and back without dropping the ball.", "If you drop it, pick it back up and keep going from where you dropped it!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_3, N'short_response', N'🔎 Scavenger Hunt Clues

Objective: Follow written clues to find hidden items around the outdoor area.

Materials: 4-5 written clue cards | Small hidden prizes or markers

Follow the steps below to play!', NULL, N'Only search in areas a grown-up has approved ahead of time.', 7, N'sequence_steps', N'{"steps": ["Grown-up hides clue cards and a final prize around the yard beforehand.", "Read the first clue together and figure out where it points.", "Find that spot to get the next clue.", "Follow all the clues until you find the final prize!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_3, N'short_response', N'🔲 Four Square

Objective: Practice bouncing and hitting a ball within a 4-square court using simple rules.

Materials: 1 bouncy ball | Chalk to draw a 4-square court

Follow the steps below to play!', NULL, N'Hit the ball gently with an open hand, not a hard punch.', 8, N'sequence_steps', N'{"steps": ["Draw a large square divided into 4 smaller squares, numbered 1-4.", "One player stands in each square.", "The player in square 4 serves by bouncing the ball into another square.", "Keep hitting the ball into different squares — miss or hit out of bounds, and you''re out (new player rotates in)!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_3, N'short_response', N'🎒 Bean Bag Relay

Objective: Practice balance and teamwork by racing while carrying a beanbag on your head.

Materials: 1 beanbag per team | 2 cones

Follow the steps below to play!', NULL, N'If your beanbag falls, stop, pick it up, and continue from where you are.', 9, N'sequence_steps', N'{"steps": ["Split into teams, lined up at the start cone.", "First player balances a beanbag on their head and walks to the far cone and back.", "Hand the beanbag to the next teammate (no throwing!).", "First team to finish wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_3, N'short_response', N'🪢 Jump Rope Challenge

Objective: Practice jump-roping and count how many consecutive jumps you can do.

Materials: 1 jump rope per player

Follow the steps below to play!', NULL, N'Give yourself space so your rope doesn''t hit a friend.', 10, N'sequence_steps', N'{"steps": ["Each player gets their own jump rope.", "Practice swinging the rope and jumping over it.", "Count out loud how many jumps in a row you can do without stopping.", "Try to beat your own best score!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_3, N'short_response', N'💪 Team Tug of War (Light)

Objective: Work together as a team to pull a rope across a middle line.

Materials: 1 sturdy rope | Chalk or a marker for the center line

Follow the steps below to play!', NULL, N'Wear closed-toe shoes and let go of the rope right away if you fall or slip.', 11, N'sequence_steps', N'{"steps": ["Draw a line on the ground for the middle.", "Split into 2 even teams, each holding one end of the rope.", "On ''go,'' pull together to try to bring the middle of the rope past your side of the line.", "First team to pull the rope''s middle marker across their line wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_3, N'short_response', N'🦶 Hopscotch Trail

Objective: Practice hopping on one and two feet along a numbered hopscotch grid.

Materials: Sidewalk chalk | A small stone or beanbag marker

Follow the steps below to play!', NULL, N'Hop carefully to keep your balance on each square.', 12, N'sequence_steps', N'{"steps": ["Draw a hopscotch grid (numbered 1-8) with chalk.", "Toss your marker onto square 1.", "Hop through the grid on one foot for single squares, two feet for side-by-side squares, skipping the square with your marker.", "Pick up your marker on the way back, then toss it to the next number!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_3, N'short_response', N'🦆 Duck Duck Goose Sprint

Objective: Practice quick reactions and full-speed running in a faster version of a classic circle game.

Materials: Open grass space

Follow the steps below to play!', NULL, N'Only run around the outside of the circle, watching for seated players.', 13, N'sequence_steps', N'{"steps": ["Everyone sits in a circle facing inward.", "One player walks (or jogs) around the circle tapping heads, saying ''duck'' each time.", "On one head, they say ''goose!'' — that player jumps up and sprints to chase them.", "The tapper must run all the way around the circle back to the empty spot before being tagged."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_3, N'short_response', N'💦 Water Balloon Toss

Objective: Work with a partner to toss and catch a water balloon without popping it.

Materials: Water balloons (filled)

Follow the steps below to play!', NULL, N'Toss gently and catch with both hands — expect a splash if it pops!', 14, N'sequence_steps', N'{"steps": ["Pair up and stand a few steps apart, facing your partner.", "Gently toss the water balloon back and forth.", "After each successful catch, both partners take one step back.", "See how far apart you can get before the balloon pops!"]}');

    DECLARE @cat_outdoor_4 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (4, 'health', N'Outdoor Games', 'space_heavy', 7, N'Pick a game below and play it outside with friends or family this week!', 0);
    SET @cat_outdoor_4 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_4, N'short_response', N'🚩 Capture the Flag

Objective: Use teamwork and strategy to capture the opposing team''s flag and bring it home.

Materials: 2 flags | Cones to mark boundaries and a jail zone for each team

Follow the steps below to play!', NULL, N'Tag gently with an open hand, and know your team''s boundary lines.', 1, N'sequence_steps', N'{"steps": ["Split the field in half between 2 teams, each with a flag and a jail zone.", "Sneak into enemy territory to grab their flag without being tagged.", "If tagged on enemy territory, go to their jail until a teammate frees you.", "First team to bring the flag back to their own side wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_4, N'short_response', N'⚽ Kickball Tournament

Objective: Apply kickball rules and teamwork across a full mini-tournament of innings.

Materials: 1 kickball | 4 bases | Scorecard (optional)

Follow the steps below to play!', NULL, N'Slide-free base running — just run through the base safely.', 2, N'sequence_steps', N'{"steps": ["Set up bases in a diamond; split into 2 teams.", "Play 3 innings, switching between kicking and fielding each inning.", "Track runs scored by each team on a simple scorecard.", "Team with the most runs after 3 innings wins the tournament!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_4, N'short_response', N'🥏 Ultimate Frisbee Intro

Objective: Practice throwing, catching, and moving a frisbee downfield as a team without running while holding it.

Materials: 1 flying disc | 4 cones to mark end zones

Follow the steps below to play!', NULL, N'No grabbing the disc out of someone''s hands — only intercept passes in the air.', 3, N'sequence_steps', N'{"steps": ["Mark two end zones with cones at opposite ends of the field.", "Split into 2 teams; the goal is to catch the disc inside the other team''s end zone.", "You can''t run while holding the disc — only pivot and pass to a teammate.", "If the disc touches the ground or is caught by the other team, they take possession."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_4, N'short_response', N'🏃 Team Relay Obstacle

Objective: Coordinate as a team to complete a multi-station relay obstacle course fastest.

Materials: Cones, hula hoops, a jump rope, a balance beam or line, a baton

Follow the steps below to play!', NULL, N'Complete each station fully and safely before moving to the next.', 4, N'sequence_steps', N'{"steps": ["Set up 5 stations: cone zigzag, hoop hop, rope crawl, balance line, jump rope 5 times.", "Split into 2 teams lined up at the start.", "Each runner completes all 5 stations, then tags the next teammate.", "First team with everyone finished wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_4, N'short_response', N'🔲 Four Square Challenge

Objective: Apply advanced four-square rules including special serves and challenges.

Materials: 1 bouncy ball | Chalk to draw the 4-square court

Follow the steps below to play!', NULL, N'Hit with an open hand only — no punching or kicking the ball.', 5, N'sequence_steps', N'{"steps": ["Draw a 4-square court with squares numbered 1 (lowest) to 4 (king/queen square).", "The player in square 4 serves the ball into another square.", "Players hit the ball back and forth; missing or hitting out sends you to square 1, others move up.", "Try to reach and stay in square 4 the longest!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_4, N'short_response', N'🗺️ Scavenger Hunt Teams

Objective: Work in small teams to solve clues and find hidden items across a wider area.

Materials: 5-6 written clue cards per team | Small prizes at the final spot

Follow the steps below to play!', NULL, N'Stay within the boundaries a grown-up sets for the hunt area.', 6, N'sequence_steps', N'{"steps": ["Split into small teams of 2-3.", "Give each team their first clue card.", "Follow the clue trail, solving each clue to find the next location.", "First team to reach the final hidden prize wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_4, N'short_response', N'💪 Tug of War

Objective: Use coordinated team strength and strategy to pull the rope across the line.

Materials: 1 thick sturdy rope | Chalk or marker for the center line

Follow the steps below to play!', NULL, N'Wear closed-toe shoes, and let go immediately if you slip or fall.', 7, N'sequence_steps', N'{"steps": ["Mark a center line and tie a ribbon at the rope''s middle.", "Split into 2 even teams, gripping the rope on opposite sides.", "On ''go,'' pull together, leaning back and digging in your heels.", "First team to pull the ribbon marker past their line wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_4, N'short_response', N'🦈 Sharks and Minnows

Objective: Practice sprinting and dodging strategy while trying to safely cross the field.

Materials: 2 boundary lines marked with chalk or cones

Follow the steps below to play!', NULL, N'Tag with an open hand only, and watch for other runners nearby.', 8, N'sequence_steps', N'{"steps": ["Mark two lines at opposite ends of the field.", "2-3 players are ''Sharks'' and stand in the middle; everyone else (''Minnows'') lines up on one side.", "On ''go,'' Minnows sprint to the other line without being tagged.", "Tagged Minnows become Sharks — play continues until only a few Minnows remain!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_4, N'short_response', N'🥏 Kan Jam Basics

Objective: Practice throwing a disc toward a partner''s goal to score points as a team.

Materials: 2 goal targets (buckets or a Kan Jam set) | 1 flying disc

Follow the steps below to play!', NULL, N'Only throw when it''s your turn, and stand clear of the goal area otherwise.', 9, N'sequence_steps', N'{"steps": ["Set up 2 goal targets facing each other, about 15 steps apart.", "Pair up — one thrower per team stands at each goal, one deflector partner stands near their own goal.", "Throwers alternate tossing the disc toward their partner''s goal.", "The deflector can tap the disc to redirect it into the goal for bonus points!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_4, N'short_response', N'🏷️ Team Tag Strategy

Objective: Use team communication and strategy to tag opposing players while protecting your own.

Materials: Pinnies or colored bands to mark 2 teams | Boundary cones

Follow the steps below to play!', NULL, N'Tag gently on the shoulder or back — no shoving.', 10, N'sequence_steps', N'{"steps": ["Split into 2 teams marked by different colors.", "Each team tries to tag members of the other team while avoiding being tagged themselves.", "Tagged players do 5 jumping jacks before rejoining the game.", "Play for a set time — team with the fewest tags wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_4, N'short_response', N'🪣 Bucket Brigade Relay

Objective: Work as a team to transport water from one bucket to another as efficiently as possible.

Materials: 2 large buckets per team (one filled with water) | 1 cup per player

Follow the steps below to play!', NULL, N'Watch for slippery wet ground and walk carefully near buckets.', 11, N'sequence_steps', N'{"steps": ["Line up team members between a full bucket and an empty bucket.", "Each player scoops water with their cup and passes it down the line.", "Pour into the next person''s cup without spilling too much!", "The team that moves the most water to the empty bucket in 2 minutes wins."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_4, N'short_response', N'🎡 Hula Hoop Pass

Objective: Work as a team in a circle to pass a hula hoop around without letting go of hands.

Materials: 1 hula hoop

Follow the steps below to play!', NULL, N'Move slowly and carefully so no one''s hands get pulled too hard.', 12, N'sequence_steps', N'{"steps": ["Everyone forms a circle, holding hands.", "Loop a hula hoop over one player''s arm before they join hands.", "Without letting go of hands, everyone works together to pass the hoop all the way around the circle.", "Time yourselves and try to beat your own record!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_4, N'short_response', N'🪢 Jump Rope Relay

Objective: Combine running and jump-roping skills in a team relay format.

Materials: 1 jump rope per team | 2 cones

Follow the steps below to play!', NULL, N'Make sure you have space to swing the rope without hitting anyone.', 13, N'sequence_steps', N'{"steps": ["Split into teams lined up at the start cone.", "First player runs to the far cone, does 10 jump-rope jumps, then runs back.", "Hand the rope to the next teammate.", "First team to have everyone finish wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_4, N'short_response', N'🌳 Nature Trail Race

Objective: Navigate a marked outdoor trail while identifying nature checkpoints along the way.

Materials: Trail markers (flags or chalk arrows) | A checklist of things to spot along the trail

Follow the steps below to play!', NULL, N'Stay on the marked trail and walk carefully over uneven ground.', 14, N'sequence_steps', N'{"steps": ["Set up a looping trail marked with flags or chalk arrows.", "Give each player or team a checklist of things to spot (a certain tree, a rock, a bench).", "Follow the trail, checking off items as you go.", "First to complete the full loop with all items checked wins!"]}');

    DECLARE @cat_outdoor_5 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (5, 'health', N'Outdoor Games', 'space_heavy', 7, N'Pick a game below and play it outside with friends or family this week!', 0);
    SET @cat_outdoor_5 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_5, N'short_response', N'🚩 Capture the Flag: Strategy Edition

Objective: Plan and execute a team strategy involving offense, defense, and guards to capture the flag.

Materials: 2 flags | Cones for boundaries and jail zones

Follow the steps below to play!', NULL, N'Tag with an open hand only, and respect boundary lines at all times.', 1, N'sequence_steps', N'{"steps": ["Split into 2 teams; before starting, each team huddles to assign roles (attackers, guards, jail-breakers).", "Attackers try to sneak in and grab the flag; guards defend it; jail-breakers free tagged teammates.", "Tagged players wait in jail until freed by a teammate''s touch.", "First team to bring the flag home safely wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_5, N'short_response', N'🥏 Ultimate Frisbee Match

Objective: Apply full ultimate frisbee rules including stall counts and turnovers in a real match.

Materials: 1 flying disc | Cones for end zones and sidelines

Follow the steps below to play!', NULL, N'No physical contact when guarding — stay an arm''s length away from the thrower.', 2, N'sequence_steps', N'{"steps": ["Mark the field with sidelines and end zones on each end.", "Teams move the disc by passing only — no running with it, and the thrower has 10 seconds (''stall count'') to release each pass.", "A dropped, intercepted, or out-of-bounds disc turns possession over to the other team.", "Score by catching the disc inside the opposing end zone!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_5, N'short_response', N'⚽ Kickball League

Objective: Play a structured multi-inning kickball game applying fielding positions and scoring strategy.

Materials: 1 kickball | 4 bases | Scorecard

Follow the steps below to play!', NULL, N'Run through bases without sliding to avoid injury.', 3, N'sequence_steps', N'{"steps": ["Assign fielding positions (pitcher, baseman, outfield) for the fielding team.", "Play 4 innings, switching kicking and fielding each inning.", "Track outs (3 outs ends a team''s turn kicking) and runs scored.", "Team with the most runs after 4 innings wins the league match!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_5, N'short_response', N'🏗️ Team Obstacle Design

Objective: Design and then complete a custom obstacle course as a team, combining creativity with athletics.

Materials: Cones, hula hoops, jump ropes, chalk, and other yard items

Follow the steps below to play!', NULL, N'Check each team''s course for safety before anyone runs it.', 4, N'sequence_steps', N'{"steps": ["Split into small teams and give each team 10 minutes to design an obstacle course using available materials.", "Each team explains their course''s stations to the group.", "Teams rotate through and complete each other''s courses.", "Vote together on the most creative and fun course design!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_5, N'short_response', N'🧭 Scavenger Hunt Navigator

Objective: Use simple map-reading and coordinate skills to locate hidden checkpoints.

Materials: A hand-drawn simple map of the play area | 5-6 checkpoint markers

Follow the steps below to play!', NULL, N'Stay within the mapped play area boundaries at all times.', 5, N'sequence_steps', N'{"steps": ["Give each team a simple hand-drawn map marking checkpoint locations.", "Navigate using the map to find each checkpoint in order.", "Collect a puzzle piece or letter at each checkpoint.", "First team to find all checkpoints and solve the final puzzle/word wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_5, N'short_response', N'🏈 Flag Football Basics

Objective: Learn basic flag football rules: passing, receiving, and pulling flags instead of tackling.

Materials: 1 football | Flag belts (or bandanas tucked into waistbands) | Cones for end zones

Follow the steps below to play!', NULL, N'Only pull flags — never grab, push, or tackle another player.', 6, N'sequence_steps', N'{"steps": ["Split into 2 teams; each player wears a flag belt.", "The offense tries to move the ball toward the end zone by running or passing.", "The defense stops the play by pulling a flag off the ball carrier (no tackling!).", "Score a touchdown by reaching the end zone with the ball!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_5, N'short_response', N'🔲 Four Square Tournament

Objective: Compete in a bracket-style four-square tournament applying advanced rules.

Materials: 1 bouncy ball | Chalk for the court | Simple bracket sheet

Follow the steps below to play!', NULL, N'Hit the ball with an open hand only, keeping hits low and controlled.', 7, N'sequence_steps', N'{"steps": ["Draw a 4-square court and set up a rotation line for waiting players.", "Play standard four-square rules — miss or hit out, you''re out and go to the back of the line.", "Track how many rounds each player survives as ''king/queen'' of square 4.", "Crown the player with the most total rounds won as tournament champion!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_5, N'short_response', N'🏃 Relay Baton Pass

Objective: Practice smooth, fast baton exchanges in a competitive team relay.

Materials: 1 baton per team | 4 cones marking a relay loop

Follow the steps below to play!', NULL, N'Practice the baton handoff slowly first before going full speed.', 8, N'sequence_steps', N'{"steps": ["Split into teams of 4, each player positioned at a different point around the loop.", "First runner sprints to the next teammate and passes the baton without stopping.", "Continue until all 4 legs of the relay are complete.", "Fastest team to complete the full loop wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_5, N'short_response', N'💪 Team Tug of War

Objective: Coordinate team strategy and timing to win a full tug-of-war match.

Materials: 1 thick rope | Chalk or marker for center line

Follow the steps below to play!', NULL, N'Wear closed-toe shoes and let go immediately if you lose your footing.', 9, N'sequence_steps', N'{"steps": ["Tie a ribbon at the rope''s center and mark a line on the ground.", "Teams line up in order of strength/height for balance, gripping the rope.", "On ''go,'' pull together in a coordinated rhythm — try calling out ''pull!'' together.", "First team to pull the ribbon past their line wins the match!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_5, N'short_response', N'🥏 Disc Golf Intro

Objective: Practice throwing a disc toward a target in as few throws as possible, like mini golf.

Materials: 1 flying disc | 5-6 target markers (buckets, trees, or cones)

Follow the steps below to play!', NULL, N'Make sure the throwing path is clear of people before each throw.', 10, N'sequence_steps', N'{"steps": ["Set up 5-6 ''holes'' around the yard, each a target like a bucket or tree.", "Throw the disc from a starting spot toward the first target.", "Pick up the disc where it lands and throw again toward the same target until you hit it.", "Count your throws for each hole — lowest total throws across all holes wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_5, N'short_response', N'💧 Water Relay Challenge

Objective: Work as a team to transport water using sponges in a fast-paced relay.

Materials: 2 buckets per team (one full, one empty) | 1 sponge per team

Follow the steps below to play!', NULL, N'Watch for wet, slippery ground while running.', 11, N'sequence_steps', N'{"steps": ["Line up teams between a full bucket and an empty bucket, a short distance apart.", "Each player soaks the sponge in the full bucket, then runs to squeeze it into the empty bucket.", "Run back and pass the sponge to the next teammate.", "Team with the most water transferred in the time limit wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_5, N'short_response', N'🏷️ Team Strategy Tag

Objective: Use planned team roles (chasers and blockers) to tag opponents strategically.

Materials: Colored pinnies for 2 teams | Boundary cones

Follow the steps below to play!', NULL, N'Blocking means standing in the way, not pushing or grabbing.', 12, N'sequence_steps', N'{"steps": ["Split into 2 teams; each team assigns some players as ''chasers'' and some as ''blockers.''", "Chasers try to tag the other team; blockers protect their own teammates by standing between them and chasers.", "Tagged players sit out for 30 seconds before rejoining.", "Team with fewer tags after the time limit wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_5, N'short_response', N'🪵 Balance Beam Relay

Objective: Practice balance and coordination by walking a low balance beam as part of a relay.

Materials: A low balance beam (or a wide board/line of chalk) | 2 cones

Follow the steps below to play!', NULL, N'Walk slowly with arms out for balance — this isn''t a running race.', 13, N'sequence_steps', N'{"steps": ["Set up a low balance beam (or chalk line) between two cones.", "Split into teams; first player walks across the beam without stepping off.", "If you step off, go back to where you started on the beam and continue.", "Tag the next teammate after crossing — fastest team to finish wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_5, N'short_response', N'🧭 Orienteering Basics

Objective: Use a simple compass and clues to navigate to specific points in order.

Materials: A simple compass (or compass app) | 5 numbered checkpoint cards with directions

Follow the steps below to play!', NULL, N'Stay within the marked area, and walk (don''t run) while checking the compass.', 14, N'sequence_steps', N'{"steps": ["Give each team a compass and a set of directions (e.g., ''walk north 10 steps to checkpoint 1'').", "Follow the compass directions to find each checkpoint in order.", "Collect a letter or stamp at each checkpoint.", "First team to visit all checkpoints in order and spell the secret word wins!"]}');

    DECLARE @cat_outdoor_6 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (6, 'health', N'Outdoor Games', 'space_heavy', 7, N'Pick a game below and play it outside with friends or family this week!', 0);
    SET @cat_outdoor_6 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_6, N'short_response', N'🚩 Capture the Flag: Advanced

Objective: Design and execute a multi-role team strategy involving scouts, guards, and runners.

Materials: 2 flags | Cones for boundaries and jail zones | Colored pinnies for teams

Follow the steps below to play!', NULL, N'Tag with an open hand only, and call out ''tag!'' clearly so there''s no confusion.', 1, N'sequence_steps', N'{"steps": ["Split into 2 teams; each team plans roles (scouts to find the flag, guards to defend, runners to grab and sprint it home).", "Play a full round, allowing teams to adjust strategy between rounds.", "Track jail rescues and successful flag captures.", "Best 2 out of 3 rounds wins the match!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_6, N'short_response', N'🥏 Ultimate Frisbee League

Objective: Play a full-length ultimate frisbee game applying complete rules and defensive strategy.

Materials: 1 flying disc | Cones for field boundaries and end zones | Pinnies for 2 teams

Follow the steps below to play!', NULL, N'No physical contact — maintain a safe guarding distance at all times.', 2, N'sequence_steps', N'{"steps": ["Set up a full field with end zones; split into 2 teams of equal size.", "Play to a set score (e.g., first to 7 points) or a time limit.", "Apply full rules: stall counts, turnovers on drops/interceptions/out-of-bounds.", "Rotate positions between offense and defense strategically as a team."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_6, N'short_response', N'🏈 Flag Football Scrimmage

Objective: Run a structured flag football scrimmage applying downs, positions, and play strategy.

Materials: 1 football | Flag belts | Cones for field markers and end zones

Follow the steps below to play!', NULL, N'Only pull flags to stop a play — no tackling, blocking with force, or grabbing jerseys.', 3, N'sequence_steps', N'{"steps": ["Set up a field with yard markers and end zones; split into 2 teams.", "Offense gets 4 downs to advance the ball and score; huddle to call a play each down.", "Defense tries to pull flags to stop the play before the end zone.", "Switch offense/defense after a touchdown or turnover on downs."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_6, N'short_response', N'🏗️ Team Obstacle Course Design

Objective: Design, build, and test a challenging obstacle course while considering safety and fairness.

Materials: Cones, hula hoops, jump ropes, chalk, and other available yard equipment

Follow the steps below to play!', NULL, N'Test every station yourself before letting others use it.', 4, N'sequence_steps', N'{"steps": ["In small teams, brainstorm and sketch an obstacle course with at least 6 stations.", "Build the course using available materials, checking for safety hazards.", "Have another team test-run your course and give feedback.", "Revise your course based on feedback, then host a final course-run event!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_6, N'short_response', N'🔐 Scavenger Hunt Cipher

Objective: Decode simple ciphers and clues to locate a sequence of hidden checkpoints.

Materials: Cipher clue cards (simple letter-shift codes) | Hidden checkpoint markers

Follow the steps below to play!', NULL, N'Stay within the boundaries a grown-up sets for the hunt.', 5, N'sequence_steps', N'{"steps": ["Give each team a starting cipher clue that decodes into a location hint.", "Solve the cipher, go to that location, and find the next coded clue.", "Continue decoding and following clues through the whole trail.", "First team to decode the final clue and find the hidden prize wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_6, N'short_response', N'⚽ Kickball Strategy League

Objective: Apply advanced kickball strategy including defensive positioning and kicking placement.

Materials: 1 kickball | 4 bases | Scorecard

Follow the steps below to play!', NULL, N'Run bases under control and avoid colliding with fielders.', 6, N'sequence_steps', N'{"steps": ["Assign strategic fielding positions based on where kickers tend to send the ball.", "Kicking team discusses strategy for placing kicks to open field areas.", "Play a full multi-inning game, tracking outs, runs, and strategy adjustments between innings.", "Team with the most runs after all innings wins the league match!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_6, N'short_response', N'🥏 Disc Golf Challenge

Objective: Complete a full disc golf course using strategic throws to minimize total throw count.

Materials: 1-2 flying discs | 8-9 target markers around the play area

Follow the steps below to play!', NULL, N'Always check that your throwing lane is clear of people before throwing.', 7, N'sequence_steps', N'{"steps": ["Set up an 8-9 hole disc golf course using buckets, trees, or cones as targets.", "Throw from the tee toward each target, then throw again from where the disc lands.", "Track your throw count for each hole on a scorecard.", "Lowest total throws across the whole course wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_6, N'short_response', N'🏃 Team Relay Championship

Objective: Coordinate a multi-leg relay combining running, jumping, and balance stations across a full team.

Materials: Cones, a jump rope, a balance beam or line, a baton

Follow the steps below to play!', NULL, N'Complete your leg''s task fully before handing off — no skipping steps.', 8, N'sequence_steps', N'{"steps": ["Set up a relay with 4 different legs: sprint, jump-rope station, balance beam, and zigzag cones.", "Split into teams of 4, each assigned to one leg.", "Each runner completes their leg and hands off the baton to the next.", "Fastest team through all 4 legs wins the championship!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_6, N'short_response', N'🧭 Orienteering Challenge

Objective: Use a compass and paced distances to navigate a multi-point course as accurately and quickly as possible.

Materials: Compass (or compass app) | Course map with 6-8 numbered checkpoints and bearings

Follow the steps below to play!', NULL, N'Stay within the marked course boundaries and check in with a grown-up at each checkpoint.', 9, N'sequence_steps', N'{"steps": ["Study the course map showing compass bearings and distances between checkpoints.", "Navigate from checkpoint to checkpoint using your compass and paced steps.", "Punch or mark your card at each checkpoint to prove you found it.", "Fastest accurate completion of the full course wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_6, N'short_response', N'💪 Tug of War Tournament

Objective: Compete in a bracket-style tug of war tournament, adjusting team strategy between matches.

Materials: 1 thick rope | Chalk for center lines | Tournament bracket sheet

Follow the steps below to play!', NULL, N'Wear closed-toe shoes, and let go immediately if you feel unsteady.', 10, N'sequence_steps', N'{"steps": ["Split into several small teams for a bracket tournament.", "Each match, teams pull against each other; winner advances in the bracket.", "Between matches, teams can discuss strategy (foot placement, timing, grip).", "The team that wins all their matches becomes tournament champion!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_6, N'short_response', N'🔲 Four Square Masters

Objective: Apply advanced four-square techniques and special rules in competitive play.

Materials: 1 bouncy ball | Chalk for the court | List of ''special rule'' cards (optional advanced moves)

Follow the steps below to play!', NULL, N'Hit with an open hand only, and call out clearly if the ball is out.', 11, N'sequence_steps', N'{"steps": ["Draw a 4-square court with squares numbered 1 to 4.", "Play standard rules, but allow special moves like ''around the world'' (ball must bounce in every square before returning).", "Track how many rounds each player holds square 4 (''king/queen'').", "Player with the longest total reign as king/queen is the Four Square Master!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_6, N'short_response', N'🤝 Team Building Trust Walk

Objective: Build communication and trust by guiding a blindfolded partner safely through a simple course.

Materials: Blindfolds (bandanas) | Cones or soft obstacles to navigate around

Follow the steps below to play!', NULL, N'Guides must speak clearly and walk close by in case their partner needs help.', 12, N'sequence_steps', N'{"steps": ["Pair up; one partner wears a blindfold, the other gives verbal directions only.", "Set up a simple path with a few soft obstacles (cones) to walk around.", "The guiding partner uses clear words (not touch) to direct their partner safely through.", "Switch roles and try again — discuss what communication worked best!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_6, N'short_response', N'🏐 Speedball Basics

Objective: Combine soccer, basketball, and football movements in a fast-paced hybrid game.

Materials: 1 soccer-style ball | Cones for boundaries and goals

Follow the steps below to play!', NULL, N'No pushing or grabbing — steal the ball with your feet or hands only, never a player.', 13, N'sequence_steps', N'{"steps": ["Set up a field with a goal at each end.", "Players can kick the ball on the ground OR pick it up and pass it by hand once it''s in the air (popped up).", "Score by kicking the ball into the goal, or by a caught pass inside the goal area.", "Play with 2 teams, switching between ground and air play as the ball moves."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_6, N'short_response', N'💧 Water Relay Olympics

Objective: Compete in a multi-station water-themed relay combining speed, balance, and teamwork.

Materials: Buckets, sponges, cups, water balloons | Cones marking 3-4 stations

Follow the steps below to play!', NULL, N'Watch for slippery wet ground and walk carefully between stations.', 14, N'sequence_steps', N'{"steps": ["Set up 3-4 water-themed stations: sponge squeeze relay, cup-carry balance walk, water balloon toss.", "Split into teams; each runner completes all stations before tagging the next teammate.", "Track team times or points across each station.", "Team with the best overall performance wins the Water Relay Olympics!"]}');

    DECLARE @cat_outdoor_7 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (7, 'health', N'Outdoor Games', 'space_heavy', 7, N'Pick a game below and play it outside with friends or family this week!', 0);
    SET @cat_outdoor_7 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_7, N'short_response', N'🚩 Capture the Flag: Championship

Objective: Lead a full team through a multi-round championship applying complex strategy and sportsmanship.

Materials: 2 flags | Cones for boundaries and jail zones | Pinnies for teams

Follow the steps below to play!', NULL, N'Tag with an open hand only, and settle any disputes calmly using good sportsmanship.', 1, N'sequence_steps', N'{"steps": ["Split into 2 teams; elect a team captain to help coordinate strategy.", "Play 3 timed rounds, allowing teams to adjust roles and strategy between rounds based on what worked.", "Track captures, tags, and jailbreaks across all 3 rounds.", "Team with the most successful captures across all rounds is champion!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_7, N'short_response', N'🥏 Ultimate Frisbee Tournament

Objective: Compete in a bracket-style ultimate frisbee tournament applying full rules and sportsmanship (the ''Spirit of the Game'').

Materials: 1 flying disc per field | Cones for boundaries and end zones | Bracket sheet

Follow the steps below to play!', NULL, N'Ultimate is self-officiated — call your own fouls honestly and resolve disagreements respectfully.', 2, N'sequence_steps', N'{"steps": ["Split into several teams for a round-robin or bracket tournament.", "Play each match to a set point total or time limit, self-officiating calls fairly (Spirit of the Game).", "Track wins/losses or points across all matches.", "Team with the best overall record becomes tournament champion!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_7, N'short_response', N'🏈 Flag Football League

Objective: Play a full flag football league match applying offensive plays, defensive coverage, and scoring strategy.

Materials: 1 football | Flag belts | Cones for yard markers and end zones | Scorecard

Follow the steps below to play!', NULL, N'Only pull flags to end a play — no tackling or excessive contact.', 3, N'sequence_steps', N'{"steps": ["Set up a full field with yard markers; split into 2 teams with assigned positions.", "Offense huddles to call plays each down; defense calls coverage assignments.", "Play a full game to a point total or time limit, tracking downs and score.", "Team with the most points at the end wins the league match!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_7, N'short_response', N'🧗 Leadership Obstacle Course

Objective: Take turns leading a team through an obstacle course using only verbal instructions.

Materials: Cones, hula hoops, jump ropes for an obstacle course | Blindfolds (optional challenge mode)

Follow the steps below to play!', NULL, N'Leaders must give clear, safe directions and watch closely in case help is needed.', 4, N'sequence_steps', N'{"steps": ["Set up a multi-station obstacle course as a team.", "One student is the ''Leader'' and must verbally guide a teammate (who can''t see the course layout) through it.", "The teammate follows only the Leader''s spoken directions to complete each station.", "Rotate Leaders so everyone gets a turn practicing clear communication!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_7, N'short_response', N'🧭 Orienteering Expedition

Objective: Navigate an extended multi-checkpoint course using compass bearings, pacing, and map reading as a team.

Materials: Compass (or compass app) | Detailed course map with 8-10 checkpoints and bearings/distances

Follow the steps below to play!', NULL, N'Stay together as a team and within marked boundaries throughout the expedition.', 5, N'sequence_steps', N'{"steps": ["Study the full course map showing all checkpoints, bearings, and distances.", "As a team, plan the most efficient order to visit checkpoints.", "Navigate the full expedition, recording your time and route at each checkpoint.", "Team with the fastest accurate completion of the full expedition wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_7, N'short_response', N'🥏 Disc Golf Tournament

Objective: Compete across a full disc golf course, applying strategic throw selection to achieve the lowest score.

Materials: 1-2 flying discs per player | 9-hole course with target markers | Scorecards

Follow the steps below to play!', NULL, N'Always confirm the throwing lane is clear before every throw.', 6, N'sequence_steps', N'{"steps": ["Play a full 9-hole disc golf course, recording throw counts per hole on a scorecard.", "Discuss throw strategy with your group between holes (distance vs. accuracy).", "Total your scores after all 9 holes.", "Lowest total score across the whole course wins the tournament!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_7, N'short_response', N'🗝️ Team Strategy Scavenger Hunt

Objective: Plan and execute a team strategy to efficiently solve multi-step clues and puzzles across a wide area.

Materials: 6-8 multi-step clue cards (riddles, simple ciphers, math clues) | Hidden final prize

Follow the steps below to play!', NULL, N'Stay within the boundaries a grown-up sets and check in regularly.', 7, N'sequence_steps', N'{"steps": ["As a team, review all starting clues together and divide tasks if clues can be solved in parallel.", "Solve each clue to reveal the next checkpoint location.", "Regroup to combine information if some clues depend on others.", "First team to solve the full trail and find the final prize wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_7, N'short_response', N'🏐 Speedball Match

Objective: Apply combined soccer/basketball/football rules in a full competitive speedball match.

Materials: 1 soccer-style ball | Cones for boundaries and goals | Pinnies for 2 teams

Follow the steps below to play!', NULL, N'No pushing, grabbing, or aggressive contact — steal the ball fairly.', 8, N'sequence_steps', N'{"steps": ["Set up a field with a goal at each end; split into 2 teams.", "Play with combined rules: ground play uses feet only, air play (ball popped up) can be caught and passed by hand.", "Score by kicking into the goal or completing a caught pass inside the goal area.", "Play a full timed match, tracking the score for each team!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_7, N'short_response', N'💪 Tug of War Finals

Objective: Compete in a high-stakes tug of war final applying refined team strategy and timing.

Materials: 1 thick rope | Chalk for center line | Tournament bracket sheet showing finalists

Follow the steps below to play!', NULL, N'Wear closed-toe shoes, and let go immediately if you feel unsteady or start to fall.', 9, N'sequence_steps', N'{"steps": ["The two remaining tournament teams face off for the championship.", "Before pulling, each team huddles to finalize foot placement, grip order, and pulling rhythm.", "On ''go,'' pull together with coordinated timing and calls.", "The team that pulls the rope''s center marker past their line wins the championship!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_7, N'short_response', N'🔁 Relay Olympics

Objective: Compete across a full multi-event relay Olympics combining speed, skill, and teamwork events.

Materials: Cones, jump ropes, batons, balance beams, and other relay equipment

Follow the steps below to play!', NULL, N'Complete every event fully and fairly before moving to the next.', 10, N'sequence_steps', N'{"steps": ["Set up 4-5 different relay events (sprint relay, jump-rope relay, balance-beam relay, obstacle relay).", "Split into teams; each team competes in every event, earning points based on placement.", "Track total points across all events on a scoreboard.", "Team with the most total points after all events wins the Relay Olympics!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_7, N'short_response', N'🤝 Team Building Challenge Course

Objective: Solve a series of cooperative physical challenges that require full-team communication and trust.

Materials: Jump ropes, hula hoops, a tarp or blanket, cones

Follow the steps below to play!', NULL, N'Move carefully during challenges — the goal is cooperation, not speed.', 11, N'sequence_steps', N'{"steps": ["Set up 3-4 cooperative challenges (e.g., whole team must cross a ''lava zone'' using only 2 hula hoops as stepping stones).", "As a team, discuss and plan your strategy before attempting each challenge.", "Complete each challenge together — if a rule is broken, the team restarts that challenge.", "Reflect as a group afterward: what teamwork strategies worked best?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_7, N'short_response', N'⚽ Kickball Championship

Objective: Apply full strategic kickball play across a championship-level multi-inning match.

Materials: 1 kickball | 4 bases | Scorecard

Follow the steps below to play!', NULL, N'Run bases under control, and communicate clearly to avoid collisions with fielders.', 12, N'sequence_steps', N'{"steps": ["Set defensive positions strategically based on scouting the other team''s kicking tendencies.", "Play a full championship match (5+ innings), tracking outs, runs, and strategy adjustments.", "Discuss strategy adjustments as a team between innings.", "Team with the most runs at the end of the match is champion!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_7, N'short_response', N'🔲 Four Square Pro League

Objective: Compete in an ongoing four-square league applying advanced strategy and special move rules.

Materials: 1 bouncy ball | Chalk for the court | League standings sheet

Follow the steps below to play!', NULL, N'Hit with an open hand only, and keep special moves controlled and safe.', 13, N'sequence_steps', N'{"steps": ["Draw a 4-square court; establish a rotation line for waiting challengers.", "Play using advanced rules (allow special moves like spins or lobs, agreed on beforehand).", "Track each player''s total time spent as ''king/queen'' of square 4 across multiple sessions.", "Keep a running league standings sheet — top scorer at the end of the week is Pro League Champion!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_outdoor_7, N'short_response', N'🏃 Fitness Circuit Relay

Objective: Complete a fast-paced circuit combining strength, cardio, and agility stations as a team.

Materials: Cones for 6 stations | A jump rope | A stopwatch (or phone timer)

Follow the steps below to play!', NULL, N'Use good form at each station — speed matters less than doing each exercise correctly and safely.', 14, N'sequence_steps', N'{"steps": ["Set up 6 stations in a loop: jumping jacks, jump rope, high knees, lunges, sprint, plank hold.", "Split into teams; each runner does a set amount at each station (e.g., 10 jumping jacks) before moving to the next.", "Time each team''s total circuit completion.", "Team with the fastest full circuit (done correctly at every station) wins!"]}');

END
GO

DELETE FROM dbo.WeeklyPacketPlan;
GO