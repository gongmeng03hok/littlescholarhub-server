-- 84_outdoor_games_retro90s_batch1.sql
-- Extends the existing 'Outdoor Games' category (see 68/69/70/71/82/83)
-- with 7 more games per grade (49 -> 56), introducing a 1990s-retro theme:
-- inline skating (rollerblades), Super Soaker water gun duels, Grounders,
-- Manhunt/Flashlight Tag, kick scooters, homemade chalk 'Twister,' and
-- yo-yo tricks. No branded/copyrighted characters -- traditional
-- public-domain activities and toy TYPES only, scaled by grade.
--
-- Appends to the SAME per-grade PacketCategories row with sort_order
-- continuing from 50. See gen_84_outdoor_games_retro90s_batch1.py.

IF NOT EXISTS (
    SELECT 1 FROM dbo.PacketQuestions q
    JOIN dbo.PacketCategories c ON c.category_id = q.category_id
    WHERE c.category_name = 'Outdoor Games' AND c.grade_id = 0 AND q.sort_order = 50
)
BEGIN
    DECLARE @cat_90s_0 INT;
    SELECT @cat_90s_0 = category_id FROM dbo.PacketCategories WHERE grade_id = 0 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_0, N'short_response', N'🛼 Rollerblade Wobble Walk

90s Inspiration: A gentle first step toward the inline-skating craze that rolled through the 1990s.

Objective: Practice standing and taking small careful steps while wearing inline skates.

Materials: Inline skates (rollerblades) | Knee and elbow pads if you have them | A grown-up spotter

Follow the steps below to play!', NULL, N'Always skate with a grown-up nearby, and wear a helmet and pads if you have them.', 50, N'sequence_steps', N'{"steps": ["Put on the skates and stand still first, getting used to the feel.", "Hold a grown-up''s hand or a railing for the first few steps.", "Take small, careful rolling steps forward, one foot at a time.", "Once you feel steady, try letting go for just a few seconds!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_0, N'short_response', N'💦 Water Gun Gentle Squirt

90s Inspiration: A calm introduction to the water-gun water fights that soaked 1990s summer backyards.

Objective: Practice aiming a small water gun at a target with control.

Materials: 1 small water gun per child | A bucket or target (a chalk circle on a fence works too)

Follow the steps below to play!', NULL, N'Only aim at targets, never at faces, and always squirt gently.', 51, N'sequence_steps', N'{"steps": ["Fill the water gun with a grown-up''s help.", "Stand a few steps back from the target.", "Squeeze gently and aim for the target, not at friends.", "Refill and try again -- see if you can hit the target three times in a row!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_0, N'short_response', N'🛝 Grounders Gentle Version

90s Inspiration: A slowed-down version of the classic 1990s recess game Grounders.

Objective: Practice climbing onto and staying on playground equipment quickly and safely.

Materials: A low platform, step, or playground structure | A grown-up to call out

Follow the steps below to play!', NULL, N'Walk, don''t run, to the platform, and only climb equipment made for climbing.', 52, N'sequence_steps', N'{"steps": ["Everyone starts standing on the ground near a low platform or step.", "A grown-up calls ''Grounders!'' as a signal.", "Everyone walks (not runs) to climb onto the platform so their feet are off the ground.", "Once everyone is safely up, celebrate together and try again from a different spot!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_0, N'short_response', N'🔦 Flashlight Freeze

90s Inspiration: A gentle, early-evening version of the flashlight tag games that lit up 1990s neighborhoods.

Objective: Practice freezing in place the instant a flashlight beam touches you.

Materials: 1 flashlight | A small, safe yard at dusk

Follow the steps below to play!', NULL, N'Play only in a small, safe, well-known yard with a grown-up watching nearby.', 53, N'sequence_steps', N'{"steps": ["One player holds the flashlight and stands in the middle.", "Everyone else walks slowly around a small safe area.", "When the flashlight beam touches you, freeze in place like a statue.", "Once everyone is frozen, pick a new flashlight holder and start again!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_0, N'short_response', N'🛴 Scooter Wobble Walk

90s Inspiration: A gentle first step toward the kick-scooter craze that took off in the late 1990s.

Objective: Practice standing on a kick scooter and taking small pushes while holding the handlebars.

Materials: A kick scooter (2-wheeled push scooter) | A helmet | A flat, open surface

Follow the steps below to play!', NULL, N'Always wear a helmet, and practice on a flat surface away from traffic.', 54, N'sequence_steps', N'{"steps": ["Stand with one foot on the scooter deck and hold the handlebars.", "Push off gently with your other foot, just a little bit.", "Practice standing steady as the scooter rolls a short distance.", "Try it again, pushing off a little more each time!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_0, N'short_response', N'🎯 Chalk Dot Hop

90s Inspiration: A simple warm-up for the homemade chalk ''Twister'' games inspired by the classic board game''s 1990s popularity.

Objective: Practice hopping carefully from one colored chalk dot to another.

Materials: Playground chalk

Follow the steps below to play!', NULL, N'Hop carefully and land with both feet steady before hopping again.', 55, N'sequence_steps', N'{"steps": ["Draw 4-5 big colored dots spread out on the pavement.", "Stand on one dot to start.", "Hop carefully to a different colored dot when a grown-up calls a color.", "Keep hopping to new dots each time a color is called!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_0, N'short_response', N'🪀 Yo-Yo Gentle Swing

90s Inspiration: A gentle introduction to the yo-yo tricks that were a huge 1990s playground obsession.

Objective: Practice a simple up-and-down yo-yo motion to build hand coordination.

Materials: 1 yo-yo (a beginner, non-string-lock style works best)

Follow the steps below to play!', NULL, N'Swing gently and keep the yo-yo away from your face and from other people.', 56, N'sequence_steps', N'{"steps": ["Loop the yo-yo string securely around one finger with a grown-up''s help.", "Let the yo-yo drop gently downward.", "Give a small upward tug to bring it back to your hand.", "Practice a few times, catching it gently each time!"]}');

    DECLARE @cat_90s_1 INT;
    SELECT @cat_90s_1 = category_id FROM dbo.PacketCategories WHERE grade_id = 1 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_1, N'short_response', N'🛼 Rollerblade First Glide

90s Inspiration: The inline-skating boom that rolled onto nearly every 1990s sidewalk.

Objective: Practice a short, steady glide on inline skates with light support.

Materials: Inline skates (rollerblades) | A helmet and pads | A grown-up spotter

Follow the steps below to play!', NULL, N'Always wear a helmet and pads, and skate only with a grown-up nearby.', 50, N'sequence_steps', N'{"steps": ["Put on skates, helmet, and pads, then stand on a flat, smooth surface.", "Hold a grown-up''s hand for the first push forward.", "Glide a short distance, keeping your knees slightly bent.", "Practice stopping by dragging the heel brake or holding a grown-up''s hand."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_1, N'short_response', N'💦 Water Gun Target Practice

90s Inspiration: The Super Soaker water-gun craze that defined 1990s summer play.

Objective: Practice aiming accurately at multiple targets from a set distance.

Materials: 1 water gun per child | 2-3 targets (chalk circles or plastic cups on a fence)

Follow the steps below to play!', NULL, N'Only aim at targets, never at people''s faces, and stay behind the marked line.', 51, N'sequence_steps', N'{"steps": ["Set up 2-3 targets at different heights on a fence or wall.", "Stand at a marked line a few steps back.", "Take turns aiming and squirting at each target.", "See how many targets you can hit in a row!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_1, N'short_response', N'🛝 Grounders Basics

90s Inspiration: The classic 1990s recess game where touching the ground means you''re caught.

Objective: Practice quick reactions to climb onto safe equipment when a signal is called.

Materials: Playground equipment (platforms, steps, a low wall) | A grown-up to be ''It''

Follow the steps below to play!', NULL, N'Only climb on equipment made for climbing, and move carefully, not recklessly.', 52, N'sequence_steps', N'{"steps": ["One player is ''It'' and closes their eyes, counting to 10.", "Everyone else spreads out near different pieces of safe equipment.", "When ''It'' calls ''Grounders!'', everyone must get off the ground onto equipment.", "''It'' opens their eyes and looks for anyone still touching the ground -- that player helps count next time!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_1, N'short_response', N'🔦 Flashlight Tag Basics

90s Inspiration: The classic evening flashlight tag that lit up 1990s cul-de-sacs after dinner.

Objective: Practice quiet movement and quick tagging using a flashlight beam as the ''tag.''

Materials: 1-2 flashlights | A safe, agreed-upon yard at dusk | A grown-up to supervise

Follow the steps below to play!', NULL, N'Stay within a clear, well-lit boundary and always play with a grown-up nearby.', 53, N'sequence_steps', N'{"steps": ["One player holds a flashlight and is ''It.''", "Everyone else moves around the yard, staying within the agreed boundary.", "If the flashlight beam touches you, you''re tagged and become the next ''It.''", "Play until everyone has had a turn holding the flashlight!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_1, N'short_response', N'🛴 Scooter First Glide

90s Inspiration: The kick-scooter craze that rolled through neighborhoods in the late 1990s.

Objective: Practice a longer, steady glide on a kick scooter while staying balanced.

Materials: A kick scooter | A helmet | A flat, smooth surface

Follow the steps below to play!', NULL, N'Always wear a helmet, and scoot only on flat ground away from traffic.', 54, N'sequence_steps', N'{"steps": ["Stand on the scooter with both hands on the handlebars.", "Push off with one foot a few times to build a steady glide.", "Keep your eyes up and knees slightly bent while gliding.", "Practice stopping smoothly by stepping your foot down gently."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_1, N'short_response', N'🎯 Chalk Twister Basics

90s Inspiration: A homemade, chalk-drawn version of the classic Twister board game, popular at 1990s block parties.

Objective: Practice placing hands and feet on different colored chalk dots without falling over.

Materials: Playground chalk

Follow the steps below to play!', NULL, N'Play on a soft or grassy area if possible, and it''s okay to laugh and fall down safely.', 55, N'sequence_steps', N'{"steps": ["Draw a grid of colored dots (red, blue, yellow, green) on the pavement.", "A caller shouts out a body part and color, like ''left hand, blue!''", "Move that hand or foot to a dot of that color without moving your other limbs.", "Keep going until someone gently loses their balance -- then start a new round!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_1, N'short_response', N'🪀 Yo-Yo Basics

90s Inspiration: The classic first real yo-yo skill that every 1990s yo-yo fan learned.

Objective: Practice the basic ''sleeper'' motion where the yo-yo spins at the bottom of the string before returning.

Materials: 1 yo-yo

Follow the steps below to play!', NULL, N'Practice with space around you so the yo-yo doesn''t bump into anyone.', 56, N'sequence_steps', N'{"steps": ["Throw the yo-yo down gently with a slight snap of the wrist.", "Let it spin (''sleep'') at the bottom of the string for a second.", "Give a small upward tug to make it climb back to your hand.", "Practice a few times to get the timing just right!"]}');

    DECLARE @cat_90s_2 INT;
    SELECT @cat_90s_2 = category_id FROM dbo.PacketCategories WHERE grade_id = 2 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_2, N'short_response', N'🛼 Rollerblade Warm-Up

90s Inspiration: The inline-skating craze that had 1990s kids gliding down every smooth sidewalk.

Objective: Practice gliding, turning gently, and stopping with more confidence on inline skates.

Materials: Inline skates | A helmet and pads

Follow the steps below to play!', NULL, N'Always wear a helmet and pads, and skate on smooth ground away from traffic.', 50, N'sequence_steps', N'{"steps": ["Skate in a straight line for a short distance, building speed slowly.", "Practice a gentle wide turn by leaning slightly to one side.", "Use your heel brake or a controlled glide-to-stop to slow down.", "Repeat, trying to make your stops smoother each time!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_2, N'short_response', N'💦 Water Gun Duel Warm-Up

90s Inspiration: The classic backyard Super Soaker duels that were a rite of summer in the 1990s.

Objective: Practice a friendly one-on-one water gun duel with clear, fair rules.

Materials: 2 water guns | A dry-off towel for each player

Follow the steps below to play!', NULL, N'Aim only at shirts and shoulders, never at faces, and agree on rules before starting.', 51, N'sequence_steps', N'{"steps": ["Two players stand a set distance apart, water guns ready.", "On ''go,'' both try to squirt the other player''s shirt first.", "First to get squirted on the shirt loses that round.", "Refill and switch who calls ''go'' for the next round!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_2, N'short_response', N'🛝 Grounders Challenge

90s Inspiration: The classic 1990s recess game, played with a slightly bigger play area for more challenge.

Objective: Practice quick decision-making about which equipment is safest and fastest to reach.

Materials: Multiple playground equipment pieces spread out | A player to be ''It''

Follow the steps below to play!', NULL, N'Choose a nearby, safe piece of equipment rather than a far, risky sprint.', 52, N'sequence_steps', N'{"steps": ["Spread out across a bigger area with several pieces of safe equipment to choose from.", "''It'' counts down loudly while everyone picks their target equipment.", "When ''It'' calls ''Grounders!'', race safely to get off the ground.", "Anyone still on the ground when ''It'' opens their eyes helps call next round!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_2, N'short_response', N'🔦 Flashlight Tag Challenge

90s Inspiration: The classic evening flashlight tag game, played across a bigger, more exciting boundary.

Objective: Practice strategic movement to avoid the flashlight beam across a slightly bigger play area.

Materials: 1-2 flashlights | A larger safe, agreed-upon yard at dusk | A grown-up to supervise

Follow the steps below to play!', NULL, N'Stick to the marked boundary, move at a walking pace in the dark, and always have a grown-up supervising.', 53, N'sequence_steps', N'{"steps": ["Mark out clear boundaries for the play area before starting.", "One player holds the flashlight and calls out when the game begins.", "Everyone else moves carefully, trying to avoid being lit up by the beam.", "Whoever is tagged by the beam becomes the next flashlight holder!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_2, N'short_response', N'🛴 Scooter Slalom Challenge

90s Inspiration: The kick-scooter tricks and courses that neighborhood kids invented in the late 1990s.

Objective: Practice steering a kick scooter smoothly around a simple row of cones.

Materials: A kick scooter | A helmet | 4-5 cones

Follow the steps below to play!', NULL, N'Always wear a helmet, and slow down through turns rather than rushing.', 54, N'sequence_steps', N'{"steps": ["Set up 4-5 cones spaced evenly in a line.", "Scoot and steer gently around each cone one at a time.", "Keep your speed slow and controlled through the weave.", "Try the course again, aiming for smoother turns!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_2, N'short_response', N'🎯 Chalk Twister Challenge

90s Inspiration: A leveled-up version of the homemade chalk Twister game, popular at 1990s summer parties.

Objective: Practice balancing across more limb positions as the calls get trickier.

Materials: Playground chalk

Follow the steps below to play!', NULL, N'Play on soft or grassy ground, and always fall safely rather than fight to stay up.', 55, N'sequence_steps', N'{"steps": ["Draw a bigger grid of colored dots than the basic version.", "A caller shouts out combinations like ''right foot green, left hand yellow.''", "Try to keep all four limbs on different dots without falling.", "Keep going until someone gently loses balance -- then reset for a new round!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_2, N'short_response', N'🪀 Yo-Yo Trick Challenge

90s Inspiration: The trick-yo-yo skills that turned 1990s recess into a playground competition.

Objective: Practice a simple named trick, like ''Walk the Dog,'' building on the basic sleeper motion.

Materials: 1 yo-yo

Follow the steps below to play!', NULL, N'Practice this trick low to the ground and with space around your feet.', 56, N'sequence_steps', N'{"steps": ["Throw a strong sleeper so the yo-yo spins steadily at the bottom.", "Gently lower the spinning yo-yo to the ground so it ''walks'' along.", "Give it a small tug to bring it back up into your hand.", "Practice a few times until you can do it smoothly!"]}');

    DECLARE @cat_90s_3 INT;
    SELECT @cat_90s_3 = category_id FROM dbo.PacketCategories WHERE grade_id = 3 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_3, N'short_response', N'🛼 Rollerblade Challenge

90s Inspiration: The inline-skating obstacle courses that neighborhood kids set up throughout the 1990s.

Objective: Practice combining speed, turning, and stopping in a short skating course.

Materials: Inline skates | A helmet and pads | 2-3 cones

Follow the steps below to play!', NULL, N'Always wear a helmet and pads, and keep speed low enough to stay in control.', 50, N'sequence_steps', N'{"steps": ["Set up 2-3 cones spaced out along a smooth path.", "Skate the path, weaving gently around each cone.", "Finish with a smooth, controlled stop.", "Try the course again, aiming for better control!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_3, N'short_response', N'💦 Water Gun Duel Challenge

90s Inspiration: The escalating Super Soaker duels that were a summer highlight for 1990s kids.

Objective: Practice quick reflexes and evasive movement in a best-of-3 water gun duel.

Materials: 2 water guns | Towels for drying off

Follow the steps below to play!', NULL, N'Aim only at shirts and shoulders, never faces, and agree on the play area boundaries first.', 51, N'sequence_steps', N'{"steps": ["Two players face off a short distance apart, guns ready.", "On ''go,'' both try to squirt the other''s shirt while dodging.", "Whoever gets squirted first loses that round -- play best of 3!", "Refill water guns between rounds and switch starting positions."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_3, N'short_response', N'🛝 Grounders Teams

90s Inspiration: A team-based twist on the classic 1990s recess game Grounders.

Objective: Practice teamwork by helping teammates find safe equipment quickly.

Materials: Multiple playground equipment pieces | A player or two to be ''It''

Follow the steps below to play!', NULL, N'Helping a teammate means guiding them safely, not pulling or pushing.', 52, N'sequence_steps', N'{"steps": ["Split into small teams, each responsible for reaching a different piece of equipment.", "One or two players are ''It'' and count down loudly.", "When ''Grounders!'' is called, teams help each other get safely off the ground.", "Any team with all members safely up scores a point for that round!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_3, N'short_response', N'🔦 Manhunt Teams

90s Inspiration: Manhunt, the large-scale hide-and-seek/tag game that took over 1990s neighborhood evenings.

Objective: Practice team-based hiding and searching strategy in a larger evening game.

Materials: 1-2 flashlights | A larger safe, agreed-upon area at dusk | A grown-up to supervise

Follow the steps below to play!', NULL, N'Stay within the clearly marked boundary, walk (don''t run) in the dark, and always have a grown-up nearby.', 53, N'sequence_steps', N'{"steps": ["Split into a ''hunter'' team with flashlights and a ''hider'' team.", "Hiders spread out and hide within the agreed boundary while hunters count.", "Hunters search together, using flashlights to spot hiders.", "A hider is caught when the flashlight beam finds them and calls their name -- switch team roles next round!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_3, N'short_response', N'🛴 Scooter Cone Course

90s Inspiration: The backyard scooter courses that late-1990s kids built with whatever cones they had.

Objective: Practice a full scooter course combining straight pushes and careful weaving.

Materials: A kick scooter | A helmet | 5-6 cones

Follow the steps below to play!', NULL, N'Always wear a helmet, and choose control over speed through the weave.', 54, N'sequence_steps', N'{"steps": ["Set up a course with a straight stretch and a weaving section.", "Push and glide the straight section, then carefully weave through the cones.", "Finish with a smooth, controlled stop.", "Run the course again, aiming for one continuous smooth ride!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_3, N'short_response', N'🎯 Chalk Twister Teams

90s Inspiration: A team-based twist on the homemade chalk Twister game popular at 1990s summer parties.

Objective: Practice teamwork by taking turns calling moves for a partner''s chalk Twister round.

Materials: Playground chalk

Follow the steps below to play!', NULL, N'Play on soft or grassy ground, and it''s okay to fall safely and laugh it off.', 55, N'sequence_steps', N'{"steps": ["Pair up, with one partner playing and one partner calling out moves.", "The caller announces a hand or foot and a color for their partner to reach.", "Switch roles after each round so everyone gets a turn playing.", "See which pair can keep their player balanced the longest!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_3, N'short_response', N'🪀 Yo-Yo Around the World

90s Inspiration: One of the most iconic yo-yo tricks that every serious 1990s yo-yo kid learned to show off.

Objective: Practice the classic ''Around the World'' trick, swinging the yo-yo in a full circle.

Materials: 1 yo-yo

Follow the steps below to play!', NULL, N'Practice this trick with LOTS of open space around you, away from other people.', 56, N'sequence_steps', N'{"steps": ["Throw a strong sleeper so the yo-yo spins steadily.", "Swing your arm out to the side, letting the spinning yo-yo circle around.", "Guide it in a full circle back to where it started.", "Catch it by giving a small tug to bring it back to your hand!"]}');

    DECLARE @cat_90s_4 INT;
    SELECT @cat_90s_4 = category_id FROM dbo.PacketCategories WHERE grade_id = 4 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_4, N'short_response', N'🛼 Rollerblade Slalom Course

90s Inspiration: The slalom skating that advanced 1990s inline skaters showed off on smooth pavement.

Objective: Practice weaving smoothly through a tighter row of cones while inline skating.

Materials: Inline skates | A helmet and pads | 5-6 closely spaced cones

Follow the steps below to play!', NULL, N'Always wear a helmet and pads, and slow down rather than rush through tight turns.', 50, N'sequence_steps', N'{"steps": ["Set up 5-6 cones spaced closer together than a basic course.", "Skate through the course, weaving side to side with small, controlled turns.", "Keep your knees bent and weight centered as you weave.", "Try the course again, aiming for smoother, quicker turns!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_4, N'short_response', N'💦 Water Gun Team Duel

90s Inspiration: The team water fights that turned 1990s backyard parties into all-out Super Soaker battles.

Objective: Practice team coordination and strategy in a small-group water gun battle.

Materials: Water guns, one per player | A marked play area | Towels for drying off

Follow the steps below to play!', NULL, N'Aim only at shirts and shoulders, never faces, and stay within the marked area.', 51, N'sequence_steps', N'{"steps": ["Split into two small teams within a marked play area.", "On ''go,'' teams try to squirt every member of the other team''s shirt.", "Once squirted, a player sits out until the round ends.", "The last team with a dry player standing wins the round!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_4, N'short_response', N'🛝 Grounders Strategy

90s Inspiration: A strategy-focused twist on the classic 1990s recess game Grounders.

Objective: Practice scanning the whole play area quickly to pick the smartest safe spot.

Materials: Multiple playground equipment pieces spread widely | A player to be ''It''

Follow the steps below to play!', NULL, N'A smart, nearby choice beats a risky sprint to a far piece of equipment.', 52, N'sequence_steps', N'{"steps": ["Before the round starts, take a moment to plan which equipment is closest to you.", "''It'' counts down while everyone gets into position nearby (but not touching) their target.", "When ''Grounders!'' is called, move quickly and safely to your planned spot.", "Compare strategies afterward -- who picked the smartest spot?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_4, N'short_response', N'🔦 Manhunt Strategy

90s Inspiration: The strategic side of Manhunt that made 1990s evening games last for hours.

Objective: Practice advanced hiding strategy and quiet communication as a hider team.

Materials: 1-2 flashlights | A larger safe, agreed-upon area at dusk | A grown-up to supervise

Follow the steps below to play!', NULL, N'Stay within the clearly marked, well-known boundary, and always have a grown-up supervising.', 53, N'sequence_steps', N'{"steps": ["As a hider team, plan hiding spots that are close together for quiet communication.", "Hide quietly while hunters search with flashlights.", "Use quiet signals (like a soft whistle) to warn teammates if hunters are close.", "See how long your hider team can avoid being fully caught!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_4, N'short_response', N'🛴 Scooter Trick Practice

90s Inspiration: The scooter tricks that adventurous kids started experimenting with as the craze grew in the late 1990s.

Objective: Practice a simple, safe scooter trick, like a controlled hop over a low line.

Materials: A kick scooter | A helmet | A piece of chalk or a low, soft obstacle

Follow the steps below to play!', NULL, N'Always wear a helmet, and only attempt tricks on flat, obstacle-free ground.', 54, N'sequence_steps', N'{"steps": ["Draw a chalk line or place a very low, soft obstacle on flat ground.", "Build a little speed in a straight line toward it.", "Give a small hop with both feet as you cross the line.", "Land steady and keep rolling -- practice a few times to smooth it out!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_4, N'short_response', N'🎯 Chalk Twister Speed Round

90s Inspiration: A faster-paced version of the homemade chalk Twister game popular at 1990s summer parties.

Objective: Practice quick, accurate moves as the calls come faster in a timed round.

Materials: Playground chalk | A stopwatch or phone timer

Follow the steps below to play!', NULL, N'Speed is fun, but balance comes first -- it''s okay to slow down if needed.', 55, N'sequence_steps', N'{"steps": ["Draw the color-dot grid and set a timer for 60 seconds.", "The caller shouts moves as quickly as they can think of them.", "The player tries to follow every call without losing balance before time runs out.", "See how many calls you can complete in the time limit!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_4, N'short_response', N'🪀 Yo-Yo Walk the Dog Challenge

90s Inspiration: The showcase yo-yo tricks that turned 1990s playgrounds into friendly competitions.

Objective: Practice combining the ''Walk the Dog'' trick with a longer walking distance for extra challenge.

Materials: 1 yo-yo

Follow the steps below to play!', NULL, N'Practice on smooth, flat ground with plenty of space and no tripping hazards.', 56, N'sequence_steps', N'{"steps": ["Throw a strong, steady sleeper.", "Lower the spinning yo-yo to the ground so it rolls along like a little dog.", "Walk forward slowly, guiding the yo-yo along the ground beside you.", "See how far you can ''walk the dog'' before bringing it back up!"]}');

    DECLARE @cat_90s_5 INT;
    SELECT @cat_90s_5 = category_id FROM dbo.PacketCategories WHERE grade_id = 5 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_5, N'short_response', N'🛼 Rollerblade Trick Practice

90s Inspiration: The trick skating that advanced 1990s inline skaters practiced at the skate park or driveway.

Objective: Practice a simple, safe skating trick, like a one-foot glide, building on solid slalom skills.

Materials: Inline skates | A helmet and pads | A flat, smooth surface

Follow the steps below to play!', NULL, N'Always wear a helmet and pads, and only try one-foot glides once your two-foot skating is solid.', 50, N'sequence_steps', N'{"steps": ["Build up a steady, comfortable speed in a straight line.", "Lift one skate slightly off the ground, balancing on the other.", "Glide on one foot for a few seconds before setting the lifted foot back down.", "Practice on both feet to build balance evenly!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_5, N'short_response', N'💦 Water Gun Strategy Battle

90s Inspiration: The elaborate backyard water-gun battles with hiding spots and strategy that defined 1990s summers.

Objective: Practice using cover and timing strategically in a bigger team water gun battle.

Materials: Water guns, one per player | A marked play area with some hiding spots (bushes, chairs) | Towels for drying off

Follow the steps below to play!', NULL, N'Aim only at shirts and shoulders, never faces, and keep hiding spots safe (no climbing).', 51, N'sequence_steps', N'{"steps": ["Split into two teams within a marked area that includes a few safe hiding spots.", "Teams plan a quick strategy: who advances, who guards a spot.", "On ''go,'' battle to squirt every player on the other team.", "The last team with a dry player wins -- then swap strategies and play again!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_5, N'short_response', N'🛝 Grounders Championship

90s Inspiration: A championship-format version of the classic 1990s recess game Grounders.

Objective: Practice consistent quick reactions across a full multi-round Grounders tournament.

Materials: Multiple playground equipment pieces | Players rotating as ''It''

Follow the steps below to play!', NULL, N'Championship excitement is still no excuse for reckless climbing -- safety first, every round.', 52, N'sequence_steps', N'{"steps": ["Play several rounds, rotating who is ''It'' each time.", "Keep a simple tally of how many times each player is caught on the ground.", "After all rounds, add up who was caught the fewest times.", "That player is the Grounders Champion!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_5, N'short_response', N'🔦 Manhunt Championship

90s Inspiration: A championship-format version of Manhunt, the epic evening game of 1990s neighborhoods.

Objective: Practice peak strategic hiding and searching skill across a multi-round Manhunt tournament.

Materials: 1-2 flashlights | A larger safe, agreed-upon area at dusk | A grown-up to supervise

Follow the steps below to play!', NULL, N'Stay within the clearly marked boundary at all times, and always play with a grown-up supervising.', 53, N'sequence_steps', N'{"steps": ["Play several rounds, swapping hunter and hider teams each time.", "Time how long each hider team can avoid being fully caught.", "Track the longest survival time across all rounds.", "The team with the longest survival time is the Manhunt Champion!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_5, N'short_response', N'🛴 Scooter Slalom Championship

90s Inspiration: A championship-format version of the kick-scooter slalom courses popular in the late 1990s.

Objective: Practice consistent slalom weaving across a full timed head-to-head tournament.

Materials: A kick scooter | A helmet | Cones | A stopwatch or phone timer

Follow the steps below to play!', NULL, N'Always wear a helmet, and a slower clean run beats a fast one that clips a cone.', 54, N'sequence_steps', N'{"steps": ["Set up a standard slalom cone course and time each rider''s run.", "Run several heats, keeping track of everyone''s best time.", "The rider with the fastest clean run (no missed cones) wins the round.", "Try again to see if you can beat your own best time!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_5, N'short_response', N'🎯 Chalk Twister Championship

90s Inspiration: A championship-format version of the homemade chalk Twister game.

Objective: Practice peak balance and flexibility across a multi-round elimination Twister tournament.

Materials: Playground chalk

Follow the steps below to play!', NULL, N'Play on soft or grassy ground, and always fall safely rather than fight to stay up.', 55, N'sequence_steps', N'{"steps": ["Draw a color-dot grid big enough for 2-3 players at once.", "Play rounds where whoever falls or loses balance first is out.", "Continue until one player remains standing after a full round of calls.", "That player is the Chalk Twister Champion!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_5, N'short_response', N'🪀 Yo-Yo Championship

90s Inspiration: The playground yo-yo competitions that were the ultimate showcase of 1990s trick skills.

Objective: Practice performing a sequence of tricks smoothly for a friendly judged competition.

Materials: 1 yo-yo per competitor

Follow the steps below to play!', NULL, N'Always leave plenty of space around each performer, especially during Around the World.', 56, N'sequence_steps', N'{"steps": ["Each competitor performs 3 tricks in a row: sleeper, walk the dog, and around the world.", "Friends or a grown-up judge smoothness and control, not just difficulty.", "Give each competitor a score out of 10 for their sequence.", "The highest combined score wins the Yo-Yo Championship!"]}');

    DECLARE @cat_90s_6 INT;
    SELECT @cat_90s_6 = category_id FROM dbo.PacketCategories WHERE grade_id = 6 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_6, N'short_response', N'🛼 Rollerblade Championship

90s Inspiration: A championship-format version of the inline-skating slalom courses from the 1990s.

Objective: Practice peak slalom speed and control across a full timed skating competition.

Materials: Inline skates | A helmet and pads | Cones | A stopwatch or phone timer

Follow the steps below to play!', NULL, N'Always wear a helmet and pads -- championship speed still needs championship control.', 50, N'sequence_steps', N'{"steps": ["Set up a full slalom course and time each skater''s run.", "Run several heats, tracking everyone''s best clean time.", "A missed cone adds a time penalty to that run.", "The fastest clean time overall is crowned the Rollerblade Champion!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_6, N'short_response', N'💦 Water Gun Grand Battle

90s Inspiration: The all-out neighborhood water wars that were the ultimate 1990s summer showdown.

Objective: Practice large-group strategy and teamwork in a full multi-team water gun tournament.

Materials: Water guns, one per player | A large marked play area | Towels for drying off

Follow the steps below to play!', NULL, N'Aim only at shirts and shoulders, never faces, and keep the whole battle within the marked area.', 51, N'sequence_steps', N'{"steps": ["Split into 2-3 teams across a large marked play area with a few safe hiding spots.", "Each team plans a strategy before the battle begins.", "On ''go,'' battle to squirt every player on the opposing teams.", "The last team with a dry player standing wins the Grand Battle!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_6, N'short_response', N'🛝 Grounders Masters

90s Inspiration: The most advanced format of the classic 1990s recess game Grounders.

Objective: Practice mastery-level quick reactions across the most demanding Grounders format.

Materials: Multiple playground equipment pieces spread widely | Players rotating as ''It''

Follow the steps below to play!', NULL, N'A shorter countdown means moving quickly but always safely -- no risky jumps.', 52, N'sequence_steps', N'{"steps": ["Play with a wider spread of equipment and a shorter countdown from ''It.''", "Rotate who is ''It'' every round to keep it fair.", "Track who is never caught across an entire extended session.", "Whoever survives every round without being caught is the Grounders Master!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_6, N'short_response', N'🔦 Manhunt Masters

90s Inspiration: The master-level Manhunt games that became legendary in some 1990s neighborhoods.

Objective: Practice the most advanced hiding, searching, and communication strategy across a full Manhunt season.

Materials: 1-2 flashlights | A large, safe, agreed-upon area at dusk | A grown-up to supervise

Follow the steps below to play!', NULL, N'A full evening of play means extra care with boundaries, lighting, and grown-up supervision throughout.', 53, N'sequence_steps', N'{"steps": ["Play a full ''season'' of several Manhunt rounds across one evening, swapping teams each round.", "Track each team''s survival time for every round.", "Add up total survival time across the whole season.", "The team with the best total survival time are the Manhunt Masters!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_6, N'short_response', N'🛴 Scooter Slalom Masters

90s Inspiration: The most advanced scooter slalom format from the height of the late-1990s scooter craze.

Objective: Practice mastery-level scooter control across the toughest, most tightly spaced cone course.

Materials: A kick scooter | A helmet | 8-10 closely spaced cones | A stopwatch or phone timer

Follow the steps below to play!', NULL, N'Always wear a helmet, and a slower clean run always beats a fast, sloppy one.', 54, N'sequence_steps', N'{"steps": ["Set up 8-10 cones spaced tighter than any earlier course.", "Ride the course focusing on tight, controlled weaving.", "Time your run and note if you cleanly avoided every cone.", "The fastest CLEAN run (no missed cones) is the Scooter Slalom Master!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_6, N'short_response', N'🎯 Chalk Twister Masters

90s Inspiration: The ultimate mastery-level format of the homemade chalk Twister craze.

Objective: Practice the most demanding balance combinations in a mastery-level chalk Twister showdown.

Materials: Playground chalk | A stopwatch or phone timer

Follow the steps below to play!', NULL, N'Play on soft or grassy ground, and always prioritize a safe fall over holding a pose too long.', 55, N'sequence_steps', N'{"steps": ["Draw a large, dense grid of colored dots for maximum challenge.", "The caller gives rapid-fire combinations for a full 90 seconds.", "The player tries to follow every call without losing balance.", "Whoever lasts the longest without falling is the Chalk Twister Master!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_6, N'short_response', N'🪀 Yo-Yo Masters

90s Inspiration: The showcase yo-yo routines that crowned the true yo-yo masters of the 1990s playground scene.

Objective: Practice combining multiple tricks into one smooth, judged routine at the highest skill level.

Materials: 1 yo-yo per competitor

Follow the steps below to play!', NULL, N'Always leave plenty of open space, especially for tricks that swing the yo-yo out wide.', 56, N'sequence_steps', N'{"steps": ["Each competitor designs a routine combining at least 4 tricks in a row.", "Practice the transitions between tricks so the routine flows smoothly.", "Perform the routine for friends or a grown-up judge.", "The smoothest, most confident routine is crowned the Yo-Yo Master!"]}');

    DECLARE @cat_90s_7 INT;
    SELECT @cat_90s_7 = category_id FROM dbo.PacketCategories WHERE grade_id = 7 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_7, N'short_response', N'🛼 Rollerblade Slalom Masters

90s Inspiration: The most advanced inline-skating showcase from the peak of the 1990s craze.

Objective: Practice the highest level of skating control combining slalom, one-foot glides, and stopping.

Materials: Inline skates | A helmet and pads | Cones | A stopwatch or phone timer

Follow the steps below to play!', NULL, N'Always wear a helmet and pads -- mastery means control at every speed, not just going fast.', 50, N'sequence_steps', N'{"steps": ["Ride a slalom course, then add a one-foot glide section, then finish with a precision stop.", "Time the full combined course.", "Deduct points for any missed cone or wobble during the one-foot section.", "The best combined time and control score wins the Slalom Masters title!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_7, N'short_response', N'💦 Water Gun World Championship

90s Inspiration: The legendary all-day water gun tournaments that capped off epic 1990s summers.

Objective: Practice the ultimate combination of strategy, teamwork, and accuracy in a grand water gun finale.

Materials: Water guns, one per player | A large marked play area with hiding spots | Towels for drying off

Follow the steps below to play!', NULL, N'Bigger tournament, same rules: aim only at shirts and shoulders, never faces.', 51, N'sequence_steps', N'{"steps": ["Run a full bracket tournament: several teams compete in elimination rounds.", "Each round follows standard team-battle rules until one team remains dry.", "Winning teams advance to the next round; losing teams cheer on the rest.", "The final remaining team is crowned the Water Gun World Champions!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_7, N'short_response', N'🛝 Grounders Grand Champion

90s Inspiration: The grand-champion format of the classic 1990s recess game Grounders.

Objective: Practice the ultimate combination of speed, awareness, and safe climbing across an extended tournament.

Materials: Multiple playground equipment pieces spread widely | Players rotating as ''It''

Follow the steps below to play!', NULL, N'An extended tournament means pacing yourself -- safety and stamina both matter.', 52, N'sequence_steps', N'{"steps": ["Play an extended tournament of many rounds, tracking every player''s catch count.", "Rotate ''It'' fairly so everyone gets equal turns.", "After the full tournament, total up who was caught the fewest times overall.", "That player earns the title of Grounders Grand Champion!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_7, N'short_response', N'🔦 Manhunt Grand Finale

90s Inspiration: The legendary season-ending Manhunt finales that neighborhood kids talked about for years.

Objective: Practice the ultimate combination of stealth, strategy, and teamwork in a climactic final round.

Materials: 1-2 flashlights | The largest safe, agreed-upon area available at dusk | Multiple grown-ups to supervise

Follow the steps below to play!', NULL, N'The biggest game of the season needs the most supervision -- make sure grown-ups can see the whole boundary.', 53, N'sequence_steps', N'{"steps": ["Bring together the two best-performing teams from earlier rounds for one final showdown.", "Play one long, decisive round with the biggest boundary used all season.", "Hunters and hiders both use everything they''ve learned all season.", "Whichever team wins this final round is crowned the Manhunt Grand Champions!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_7, N'short_response', N'🛴 Scooter Grand Prix

90s Inspiration: The legendary end-of-summer scooter showcases that capped off the late-1990s scooter craze.

Objective: Practice combining slalom skill, speed, and a simple trick in one ultimate scooter showcase.

Materials: A kick scooter | A helmet | Cones | A stopwatch or phone timer

Follow the steps below to play!', NULL, N'Always wear a helmet, and only attempt the trick if it''s one you''ve already mastered safely.', 54, N'sequence_steps', N'{"steps": ["Ride a full slalom course, then a straight speed section, then finish with one simple safe trick.", "Time the whole combined course.", "Judge the trick separately for style and control.", "Combine time and trick score for the final Scooter Grand Prix ranking!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_7, N'short_response', N'🎯 Chalk Twister Grand Champion

90s Inspiration: The grand-champion format of the homemade chalk Twister craze at its most competitive.

Objective: Practice the ultimate balance and flexibility test across a multi-round elimination showdown.

Materials: Playground chalk | A stopwatch or phone timer

Follow the steps below to play!', NULL, N'Play on soft or grassy ground, and always choose a safe fall over pushing through discomfort.', 55, N'sequence_steps', N'{"steps": ["Run a full elimination bracket: whoever falls first in each head-to-head match is out.", "Continue through the bracket until two finalists remain.", "Play one final head-to-head round between the finalists.", "The finalist who lasts longest is the Chalk Twister Grand Champion!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s_7, N'short_response', N'🪀 Yo-Yo Grand Masters

90s Inspiration: The grand finale yo-yo showcases that crowned the true legends of the 1990s playground yo-yo scene.

Objective: Practice the ultimate trick routine, combining every skill learned into one polished final performance.

Materials: 1 yo-yo per competitor

Follow the steps below to play!', NULL, N'A bigger routine still needs plenty of open space, especially for wide swinging tricks.', 56, N'sequence_steps', N'{"steps": ["Each finalist designs a routine using every trick they''ve learned: sleeper, walk the dog, around the world, and one original move.", "Practice the full routine several times for smoothness.", "Perform for a small audience of friends and family.", "The routine that gets the biggest cheer is crowned the Yo-Yo Grand Masters champion!"]}');

END
GO

DELETE FROM dbo.WeeklyPacketPlan;
GO