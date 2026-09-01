-- 83_outdoor_games_retro70s_batch1.sql
-- Extends the existing 'Outdoor Games' category (see 68/69/70/71/82) with
-- 7 more games per grade (42 -> 49), introducing a 1970s-retro theme:
-- pogo sticks, kite flying, water balloon tosses, banana-bike rodeos,
-- 'Spud' (classic ball-calling game), early skateboarding, and Big Wheel
-- trike races. No branded/copyrighted characters -- traditional
-- public-domain activities and toy TYPES only, scaled by grade.
--
-- Appends to the SAME per-grade PacketCategories row with sort_order
-- continuing from 43. See gen_83_outdoor_games_retro70s_batch1.py.

IF NOT EXISTS (
    SELECT 1 FROM dbo.PacketQuestions q
    JOIN dbo.PacketCategories c ON c.category_id = q.category_id
    WHERE c.category_name = 'Outdoor Games' AND c.grade_id = 0 AND q.sort_order = 43
)
BEGIN
    DECLARE @cat_70s_0 INT;
    SELECT @cat_70s_0 = category_id FROM dbo.PacketCategories WHERE grade_id = 0 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_0, N'short_response', N'🦘 Pretend Pogo Hop

70s Inspiration: A safe, stick-free warm-up for the pogo stick craze that bounced across 1970s backyards.

Objective: Practice two-footed bouncing in place, like a pretend pogo stick, to build balance and rhythm.

Materials: None -- just open space!

Follow the steps below to play!', NULL, N'Bounce on soft ground like grass, and keep bounces small and controlled.', 43, N'sequence_steps', N'{"steps": ["Stand with feet together and hands out to the sides for balance.", "Bounce gently in place on both feet, like you''re on a pretend pogo stick.", "Count how many bounces in a row you can do without stopping.", "Try bouncing forward a little bit at a time!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_0, N'short_response', N'🪁 My First Kite Walk

70s Inspiration: A gentle introduction to kite flying, a favorite breezy-day activity of the 1970s.

Objective: Practice walking steadily while holding a kite string, to get a feel for how kites catch the wind.

Materials: 1 simple kite (or a kite-shaped paper cutout on a string)

Follow the steps below to play!', NULL, N'Fly kites away from roads, trees, and power lines, with a grown-up nearby.', 44, N'sequence_steps', N'{"steps": ["Hold the kite string with both hands and stand somewhere open and breezy.", "Walk forward slowly while a grown-up helps hold the kite up behind you.", "Feel the tug of the wind on the string as you walk.", "Wave to your kite as it starts to lift a little into the air!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_0, N'short_response', N'🎈 Water Balloon Gentle Pass

70s Inspiration: A slowed-down, no-throwing version of the classic summer water balloon toss.

Objective: Practice careful, gentle hand-offs while passing a water balloon between friends.

Materials: A few small water balloons | Towels for drying off

Follow the steps below to play!', NULL, N'Pass gently with both hands cupped underneath -- never squeeze or toss.', 45, N'sequence_steps', N'{"steps": ["Stand close together in a small circle with a grown-up.", "Gently pass a water balloon from one pair of hands to the next.", "Try to pass it all the way around the circle without it popping.", "If it pops, laugh it off and grab a towel -- then try again with a new one!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_0, N'short_response', N'🚲 Tricycle Path Ride

70s Inspiration: A gentle warm-up for the banana-bike and trike rodeos that filled 1970s driveways.

Objective: Practice steady steering and pedaling along a simple marked path.

Materials: A tricycle or ride-on toy | Chalk or cones to mark a simple path

Follow the steps below to play!', NULL, N'Ride only on a flat surface away from cars, with a grown-up watching nearby.', 46, N'sequence_steps', N'{"steps": ["Draw or mark a simple curved path with chalk or cones on a flat, safe surface.", "Sit on the tricycle and pedal slowly along the path.", "Try to keep your wheels inside the marked path the whole way.", "Ride it again a little faster once you feel steady!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_0, N'short_response', N'🏐 Spud Gentle Toss

70s Inspiration: A slowed-down, no-throwing version of the classic 1970s playground game Spud.

Objective: Practice listening for your name and freezing quickly in a gentle group ball game.

Materials: 1 soft, lightweight ball

Follow the steps below to play!', NULL, N'Always tap gently with the ball in hand -- never throw it at a friend.', 47, N'sequence_steps', N'{"steps": ["Everyone stands in a loose circle while one player gently tosses the ball straight up and calls a friend''s name.", "Everyone else scatters a few steps away and then freezes in place.", "The named friend catches or picks up the ball and calls out ''Spud!''", "That friend walks over and gently taps a frozen player with the ball -- then it''s that player''s turn to toss!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_0, N'short_response', N'🛹 Wheeled Wobble Walk

70s Inspiration: A gentle first step toward the skateboarding craze that took off in the 1970s.

Objective: Practice balance and slow, steady steps while holding onto a scooter or riding a trike.

Materials: A scooter, balance bike, or tricycle | A flat, open surface

Follow the steps below to play!', NULL, N'Always practice on a flat, open surface away from stairs, slopes, and traffic.', 48, N'sequence_steps', N'{"steps": ["Stand next to your scooter or trike, holding on with both hands.", "Take small, careful steps forward while keeping the wheels rolling slowly beside you.", "Practice stopping gently by holding still.", "Once you feel steady, try a few steps a little faster!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_0, N'short_response', N'🚗 Big Wheel Ride-Along

70s Inspiration: The iconic low-riding Big Wheel trike that was everywhere on 1970s driveways.

Objective: Practice pedaling and steering a low ride-on trike along a short, simple course.

Materials: A Big Wheel or similar low ride-on trike | Cones or chalk to mark a short path

Follow the steps below to play!', NULL, N'Ride only on a flat driveway or sidewalk away from cars, with a grown-up nearby.', 49, N'sequence_steps', N'{"steps": ["Sit low in the seat and place both feet on the pedals.", "Pedal slowly forward along a short, simple marked path.", "Practice turning the wide front wheel gently to follow the path.", "Ride it again, trying to keep a nice steady pace!"]}');

    DECLARE @cat_70s_1 INT;
    SELECT @cat_70s_1 = category_id FROM dbo.PacketCategories WHERE grade_id = 1 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_1, N'short_response', N'🦘 Pogo Stick First Bounces

70s Inspiration: The pogo stick craze that bounced across countless 1970s backyards.

Objective: Practice a few real pogo stick bounces with a grown-up holding on for support.

Materials: A pogo stick (child-sized) | A grown-up spotter

Follow the steps below to play!', NULL, N'Always practice pogo sticking with a grown-up spotting you on a soft, flat surface.', 43, N'sequence_steps', N'{"steps": ["Stand next to the pogo stick with a grown-up holding it steady.", "Step onto the footrests and hold the handles firmly.", "With the grown-up supporting you, try a few small bounces in place.", "Count how many bounces you can do before needing a break!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_1, N'short_response', N'🪁 Kite Flying Basics

70s Inspiration: The classic breezy-day activity that filled 1970s parks and open fields.

Objective: Practice launching a kite into the wind and keeping it flying steady.

Materials: 1 kite with string

Follow the steps below to play!', NULL, N'Fly kites in open fields, away from roads, trees, and power lines.', 44, N'sequence_steps', N'{"steps": ["Stand with your back to the wind and hold the kite up with a friend''s help.", "Let out a little string while walking backward slowly as the wind catches the kite.", "Once it lifts, let out a bit more string to help it climb.", "Keep gentle tension on the string to keep it flying steady!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_1, N'short_response', N'🎈 Water Balloon Toss Basics

70s Inspiration: The classic summer water balloon toss, a 1970s backyard party staple.

Objective: Practice underhand tossing and catching a water balloon with a partner.

Materials: Small water balloons | Towels for drying off

Follow the steps below to play!', NULL, N'Toss gently and underhand only -- never throw hard or aim at faces.', 45, N'sequence_steps', N'{"steps": ["Stand facing a partner just a few steps apart.", "Gently underhand toss the water balloon back and forth.", "After each successful catch, take one step farther apart.", "See how far apart you can get before it pops!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_1, N'short_response', N'🚲 Bike Rodeo Basics

70s Inspiration: The banana-seat bike rodeos that were a rite of passage on 1970s driveways.

Objective: Practice steady pedaling and simple steering skills on a bike with training wheels.

Materials: A bike with training wheels | Cones or chalk to mark a simple course

Follow the steps below to play!', NULL, N'Always wear a helmet and ride on a flat surface away from traffic.', 46, N'sequence_steps', N'{"steps": ["Set up a simple straight or gently curving path with cones or chalk.", "Pedal along the path, keeping your eyes up and looking ahead.", "Practice a smooth, controlled stop at the end.", "Ride it again, trying to stay right on the path!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_1, N'short_response', N'🏐 Spud Basics

70s Inspiration: The classic 1970s playground game where a called name means it''s your turn.

Objective: Practice quick listening, scattering, and freezing in the classic ball-calling game.

Materials: 1 soft, lightweight ball

Follow the steps below to play!', NULL, N'Always tap gently with the ball in hand -- this game never involves throwing at people.', 47, N'sequence_steps', N'{"steps": ["Everyone stands in a loose group while one player tosses the ball up and calls a friend''s name.", "Everyone scatters and freezes once the named player catches (or picks up) the ball.", "The player with the ball calls ''Spud!'' and takes up to 3 giant steps toward the nearest frozen player.", "They gently tap that player with the ball -- then that player tosses next!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_1, N'short_response', N'🛹 Skateboard First Balance

70s Inspiration: The very first steps toward the skateboarding craze that exploded in the mid-1970s.

Objective: Practice standing steady on a skateboard while it stays still, with a grown-up holding a hand.

Materials: A skateboard | A helmet | A grown-up spotter

Follow the steps below to play!', NULL, N'Always wear a helmet, and never practice without a grown-up spotting you.', 48, N'sequence_steps', N'{"steps": ["Place the skateboard on grass or carpet first so it won''t roll.", "Step on with both feet, holding a grown-up''s hand for balance.", "Practice bending your knees slightly and standing tall.", "Once you feel steady, try it on a flat, smooth surface with the grown-up holding on!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_1, N'short_response', N'🚗 Big Wheel Race Basics

70s Inspiration: The iconic Big Wheel trike races that filled 1970s neighborhood driveways.

Objective: Practice pedaling a Big Wheel at a steady pace over a short measured distance.

Materials: A Big Wheel or similar low ride-on trike | Cones to mark a start and finish

Follow the steps below to play!', NULL, N'Race only on a flat, open surface away from cars and steep slopes.', 49, N'sequence_steps', N'{"steps": ["Set up a start line and a finish line a short distance apart.", "Sit low in the seat and get your feet ready on the pedals.", "On ''go,'' pedal steadily from start to finish.", "Try it again and see if you can pedal even smoother!"]}');

    DECLARE @cat_70s_2 INT;
    SELECT @cat_70s_2 = category_id FROM dbo.PacketCategories WHERE grade_id = 2 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_2, N'short_response', N'🦘 Pogo Stick Warm-Up

70s Inspiration: The classic pogo stick, one of the defining backyard toys of the 1970s.

Objective: Practice a short series of steady pogo stick bounces with light support.

Materials: A pogo stick (child-sized) | A grown-up nearby

Follow the steps below to play!', NULL, N'Practice on a soft, flat surface, and always have a grown-up nearby.', 43, N'sequence_steps', N'{"steps": ["Step onto the pogo stick and hold the handles firmly.", "Start with a grown-up lightly supporting your shoulder for the first few bounces.", "Try bouncing on your own for 3-5 bounces in a row.", "Rest, then try again and see if you can add one more bounce!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_2, N'short_response', N'🪁 Kite Launch Warm-Up

70s Inspiration: The classic backyard and park kite-flying that peaked in popularity in the 1970s.

Objective: Practice launching a kite solo and adjusting string tension to keep it flying.

Materials: 1 kite with string

Follow the steps below to play!', NULL, N'Fly kites in wide open spaces, away from roads, trees, and power lines.', 44, N'sequence_steps', N'{"steps": ["Hold the kite up with the wind at your back and let it catch a gust.", "Run a few light steps if needed to help it lift, then stop and let out string.", "Adjust how much string is out to keep the kite steady in the wind.", "See how long you can keep it flying without it dipping to the ground!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_2, N'short_response', N'🎈 Water Balloon Toss Warm-Up

70s Inspiration: The classic backyard water balloon toss, a summertime staple of the 1970s.

Objective: Practice tossing and catching a water balloon at increasing distances with a partner.

Materials: Small water balloons | Towels for drying off

Follow the steps below to play!', NULL, N'Toss underhand and gently -- distance is about catching skill, not throwing hard.', 45, N'sequence_steps', N'{"steps": ["Start close to your partner and toss the balloon gently underhand.", "After each successful catch, both partners take one step backward.", "Keep going until the balloon pops, then start over with a new one.", "Try to beat your best distance from last time!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_2, N'short_response', N'🚲 Bike Obstacle Warm-Up

70s Inspiration: The bike-handling skills every kid needed for a proper 1970s neighborhood bike rodeo.

Objective: Practice steering carefully around a few simple obstacles on a bike.

Materials: A bike | 3-4 cones to mark obstacles

Follow the steps below to play!', NULL, N'Always wear a helmet and ride slowly enough to stay in full control.', 46, N'sequence_steps', N'{"steps": ["Set up 3-4 cones spaced out in a simple line.", "Ride slowly, steering around each cone one at a time.", "Focus on smooth, controlled turns rather than speed.", "Ride the course again and try to knock over zero cones!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_2, N'short_response', N'🏐 Spud Warm-Up

70s Inspiration: The classic 1970s playground name-calling ball game, played at a slightly faster pace.

Objective: Practice quicker reactions and short sprints in the classic ball-calling game.

Materials: 1 soft, lightweight ball

Follow the steps below to play!', NULL, N'Scatter safely, watching where you''re running, and always tap gently.', 47, N'sequence_steps', N'{"steps": ["Everyone stands in a loose group; one player tosses the ball up and calls a name.", "Everyone scatters quickly and freezes as soon as the named player has the ball.", "The player with the ball calls ''Spud!'' and takes up to 3 steps toward the nearest frozen player.", "A gentle tap with the ball ends that round -- the tapped player tosses next!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_2, N'short_response', N'🛹 Skateboard Push Warm-Up

70s Inspiration: The classic first real skateboarding skill from the 1970s skateboarding boom.

Objective: Practice a gentle push-and-glide with one foot while staying balanced.

Materials: A skateboard | A helmet | A flat, smooth surface

Follow the steps below to play!', NULL, N'Always wear a helmet and practice on a flat surface away from slopes and traffic.', 48, N'sequence_steps', N'{"steps": ["Stand with one foot on the skateboard and one foot on the ground.", "Push off gently with your ground foot and place it back on the board once moving.", "Glide slowly in a straight line, keeping your knees slightly bent.", "Practice stepping off calmly to stop whenever you feel wobbly."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_2, N'short_response', N'🚗 Big Wheel Relay Warm-Up

70s Inspiration: The friendly Big Wheel races that turned into full relays on 1970s driveways.

Objective: Practice a short relay hand-off between two Big Wheel riders.

Materials: 1-2 Big Wheels or similar ride-on trikes | Cones to mark a short lane

Follow the steps below to play!', NULL, N'Ride on a flat, open surface away from cars, and hop off carefully at the hand-off.', 49, N'sequence_steps', N'{"steps": ["Set up a short lane with a cone marking the turnaround point.", "The first rider pedals to the cone, turns around, and rides back.", "Hop off and tag the next rider to take a turn.", "See how smoothly your pair can complete two full turns!"]}');

    DECLARE @cat_70s_3 INT;
    SELECT @cat_70s_3 = category_id FROM dbo.PacketCategories WHERE grade_id = 3 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_3, N'short_response', N'🦘 Pogo Stick Challenge

70s Inspiration: The pogo stick bouncing contests that popped up on 1970s playgrounds and backyards.

Objective: Practice sustained pogo stick bouncing without support, aiming for a personal best.

Materials: A pogo stick (child-sized)

Follow the steps below to play!', NULL, N'Bounce on a soft, flat surface, and stop right away if you feel off-balance.', 43, N'sequence_steps', N'{"steps": ["Step onto the pogo stick and find your balance before starting.", "Bounce steadily, counting each bounce out loud.", "Try to beat your own best bounce count from last time.", "Take a short rest between attempts to stay steady."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_3, N'short_response', N'🪁 Kite Flying Challenge

70s Inspiration: The classic kite-flying pastime, popular at parks and beaches throughout the 1970s.

Objective: Practice keeping a kite airborne for as long as possible while managing string and wind changes.

Materials: 1 kite with string

Follow the steps below to play!', NULL, N'Keep flying in a wide open space, away from roads, trees, and power lines.', 44, N'sequence_steps', N'{"steps": ["Launch your kite and get it flying steadily in the wind.", "Practice letting out and reeling in string to react to gusts.", "Time how many minutes you can keep it airborne without it touching the ground.", "Try again and see if you can beat your own time!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_3, N'short_response', N'🎈 Water Balloon Toss Challenge

70s Inspiration: The classic water balloon toss, a favorite 1970s summer party game.

Objective: Practice precise underhand tossing and soft-handed catching over increasing distances.

Materials: Small water balloons | Towels for drying off

Follow the steps below to play!', NULL, N'Underhand tosses only, and always catch with soft, cupped hands.', 45, N'sequence_steps', N'{"steps": ["Start a few steps from your partner and toss gently underhand.", "After each catch, both partners step back one more step.", "Focus on ''soft hands'' -- catching by giving with the balloon, not grabbing hard.", "See how far apart your pair can get before the balloon finally pops!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_3, N'short_response', N'🚲 Bike Rodeo Challenge

70s Inspiration: The full bike rodeo events that were a highlight of many 1970s neighborhood summers.

Objective: Practice a full obstacle course combining steering, stopping, and balance skills.

Materials: A bike | 5-6 cones to mark a full course

Follow the steps below to play!', NULL, N'Always wear a helmet, and prioritize control over speed through every section.', 46, N'sequence_steps', N'{"steps": ["Set up a course with a slalom section, a straight sprint, and a controlled-stop zone.", "Ride the full course, focusing on control through each section.", "Time your run, or just focus on completing it without touching a cone.", "Try the course again and see where you can improve!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_3, N'short_response', N'🏐 Spud Challenge

70s Inspiration: The classic 1970s playground ball-calling game, played with a bigger group for more challenge.

Objective: Practice quicker decision-making about how far to scatter based on who''s holding the ball.

Materials: 1 soft, lightweight ball

Follow the steps below to play!', NULL, N'With more players scattering, keep your head up and watch where you''re running.', 47, N'sequence_steps', N'{"steps": ["Play with a bigger group standing in a loose scatter to start.", "One player tosses the ball up and calls a name; everyone else runs and freezes once the ball is caught.", "The ball holder calls ''Spud!'' and takes up to 3 steps toward the nearest frozen player.", "A gentle tap ends the round, and that player becomes the next tosser!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_3, N'short_response', N'🛹 Skateboard Slalom Challenge

70s Inspiration: The slalom skateboarding style that became a 1970s skateboarding favorite.

Objective: Practice weaving smoothly through a row of cones while gliding on a skateboard.

Materials: A skateboard | A helmet | 4-5 cones | A flat, smooth surface

Follow the steps below to play!', NULL, N'Always wear a helmet, and slow down rather than rush through the weave.', 48, N'sequence_steps', N'{"steps": ["Set up 4-5 cones spaced evenly in a line.", "Push off gently and glide, steering side to side around each cone.", "Keep your knees bent and weight centered as you weave.", "Try the course again, aiming for smoother turns each time!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_3, N'short_response', N'🚗 Big Wheel Relay Challenge

70s Inspiration: The full-team Big Wheel relay races that filled 1970s cul-de-sacs.

Objective: Practice a full team relay with multiple Big Wheel riders taking turns.

Materials: 1-2 Big Wheels or similar ride-on trikes | Cones to mark a lane

Follow the steps below to play!', NULL, N'Ride on a flat, open surface, and hop off carefully so the next rider has a clear start.', 49, N'sequence_steps', N'{"steps": ["Split into small teams lined up behind the start line.", "The first rider pedals to a cone, turns around, and rides back.", "Hop off and tag the next teammate to take their turn.", "First team to get every rider through the relay wins!"]}');

    DECLARE @cat_70s_4 INT;
    SELECT @cat_70s_4 = category_id FROM dbo.PacketCategories WHERE grade_id = 4 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_4, N'short_response', N'🦘 Pogo Stick Count Challenge

70s Inspiration: The pogo stick bounce-counting contests popular on 1970s playgrounds.

Objective: Practice sustained balance and rhythm to reach a target number of consecutive bounces.

Materials: A pogo stick (child-sized)

Follow the steps below to play!', NULL, N'Stop and rest if your legs feel tired -- fatigue is when falls happen.', 43, N'sequence_steps', N'{"steps": ["Set a target number of bounces to aim for (start with 10).", "Bounce steadily, keeping your core tight and eyes forward.", "If you reach your target, set a new, slightly higher goal.", "Take breaks between attempts so your legs stay fresh."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_4, N'short_response', N'🪁 Kite Height Contest

70s Inspiration: The friendly ''whose kite flies highest'' contests common at 1970s park gatherings.

Objective: Practice letting out string efficiently to get a kite as high as possible.

Materials: 1 kite with string per player

Follow the steps below to play!', NULL, N'Never let out so much string that you lose sight of or control over your kite.', 44, N'sequence_steps', N'{"steps": ["Launch your kite and get it flying steadily.", "Let out string gradually, watching how the kite responds to the wind.", "See how high you can get your kite while keeping it under control.", "Compare with a friend''s kite -- whose got the highest today?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_4, N'short_response', N'🎈 Water Balloon Toss Distance Challenge

70s Inspiration: The classic water balloon toss, taken to its farthest-distance extreme.

Objective: Practice controlled, gentle tossing technique to maximize catching distance with a partner.

Materials: Small water balloons | Towels for drying off | Something to mark distance (chalk or a tape measure)

Follow the steps below to play!', NULL, N'A gentle, arcing toss is safer and more accurate than throwing hard -- distance comes from technique, not force.', 45, N'sequence_steps', N'{"steps": ["Start close together and toss gently, stepping back after every successful catch.", "Mark your distance with chalk each time you both step back.", "Focus on a smooth, arcing underhand toss rather than a flat throw.", "See how far your pair''s mark gets before the balloon pops!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_4, N'short_response', N'🚲 Bike Slalom Course

70s Inspiration: The bike slalom events that tested steering skill at 1970s neighborhood bike rodeos.

Objective: Practice tight, controlled turns weaving through a closely spaced cone course.

Materials: A bike | 6-8 closely spaced cones

Follow the steps below to play!', NULL, N'Always wear a helmet, and go slowly enough to stay in control through tight turns.', 46, N'sequence_steps', N'{"steps": ["Set up 6-8 cones spaced closer together than a normal obstacle course.", "Ride slowly through the course, weaving tightly around each cone.", "Focus on smooth handlebar turns rather than leaning your whole body.", "Time yourself, then try again for a smoother, faster run!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_4, N'short_response', N'🏐 Spud Strategy

70s Inspiration: The classic 1970s ball-calling game, played with an eye toward smart positioning.

Objective: Practice reading the group to decide the smartest direction to scatter and freeze.

Materials: 1 soft, lightweight ball

Follow the steps below to play!', NULL, N'Even with strategy in mind, always watch where you''re running before you freeze.', 47, N'sequence_steps', N'{"steps": ["As the ball is tossed, think fast about which direction has the most open space.", "Scatter toward that space and freeze the instant the ball is caught.", "If you''re the ball holder, think about which frozen player is closest before calling ''Spud!''", "Play several rounds, tracking who avoids being tapped the longest!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_4, N'short_response', N'🛹 Skateboard Cone Course

70s Inspiration: The backyard skateboard courses kids built with whatever cones and chalk they had in the 1970s.

Objective: Practice combining pushing, gliding, and steering through a longer mixed course.

Materials: A skateboard | A helmet | 6-8 cones | A flat, smooth surface

Follow the steps below to play!', NULL, N'Always wear a helmet, and choose control over speed on every section.', 48, N'sequence_steps', N'{"steps": ["Set up a course mixing a straight glide section and a weaving section.", "Push off and glide the straight section, then carefully weave through the cones.", "Step off calmly at the end rather than jumping.", "Run the course again, aiming for one continuous smooth ride!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_4, N'short_response', N'🚗 Big Wheel Speed Course

70s Inspiration: The friendly Big Wheel speed trials that were a summer tradition on 1970s driveways.

Objective: Practice pedaling at maximum steady speed through a straight timed course.

Materials: A Big Wheel or similar low ride-on trike | Cones marking start and finish | A stopwatch or phone timer

Follow the steps below to play!', NULL, N'Race only on a flat, open surface away from cars, and keep both hands on the handlebars.', 49, N'sequence_steps', N'{"steps": ["Set up a straight course with a clear start and finish line.", "Get in position with feet ready on the pedals.", "On ''go,'' pedal as steadily and quickly as you can to the finish.", "Check your time, then try again to beat it!"]}');

    DECLARE @cat_70s_5 INT;
    SELECT @cat_70s_5 = category_id FROM dbo.PacketCategories WHERE grade_id = 5 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_5, N'short_response', N'🦘 Pogo Stick Trick Practice

70s Inspiration: The trick-bouncing that advanced pogo enthusiasts showed off in the 1970s.

Objective: Practice adding a simple trick, like a quarter-turn, to steady pogo stick bouncing.

Materials: A pogo stick (child-sized)

Follow the steps below to play!', NULL, N'Only attempt turns once your straight bouncing is steady, and always on soft ground.', 43, N'sequence_steps', N'{"steps": ["Warm up with 10-15 steady bounces in place first.", "Once steady, try a very small quarter-turn while bouncing.", "Land facing slightly to the side, then bounce back to facing forward.", "Practice slowly -- accuracy matters more than height!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_5, N'short_response', N'🪁 Kite Trick Flying

70s Inspiration: The playful trick-flying that advanced kite fans experimented with in the 1970s.

Objective: Practice steering a kite through simple loops and figure-eight patterns.

Materials: 1 kite with string

Follow the steps below to play!', NULL, N'Trick flying still means staying in a wide open space, away from people, trees, and wires.', 44, N'sequence_steps', N'{"steps": ["Get your kite flying steady and high in open wind first.", "Gently pull and release the string to make the kite dip and climb.", "Try guiding it through a slow, wide figure-eight pattern in the sky.", "Practice a few times -- smooth, gentle movements work best!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_5, N'short_response', N'🚲 Bike Rodeo Skills Test

70s Inspiration: The full skills-test bike rodeos that many 1970s schools and neighborhoods ran each summer.

Objective: Practice a full skills circuit combining slow riding, sharp turns, and precise stopping.

Materials: A bike | Cones for multiple stations | Chalk for a stopping line

Follow the steps below to play!', NULL, N'Always wear a helmet, and prioritize precision over speed at every station.', 45, N'sequence_steps', N'{"steps": ["Set up stations: a slow-ride zone, a figure-eight turn, and a precision-stop chalk line.", "Complete the slow-ride zone without putting a foot down.", "Ride the figure-eight smoothly around two cones.", "Finish by stopping with your front wheel exactly on the chalk line!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_5, N'short_response', N'🏐 Spud Championship

70s Inspiration: A championship-format version of the classic 1970s playground game Spud.

Objective: Practice competitive strategy and quick freezing across a full multi-round tournament.

Materials: 1 soft, lightweight ball

Follow the steps below to play!', NULL, N'Competitive rounds still mean gentle taps only -- speed of scattering, not contact force.', 46, N'sequence_steps', N'{"steps": ["Play multiple rounds, keeping a running tally of how many times each player is tapped.", "Whoever has the fewest taps after 10 rounds is doing the best at scattering smart.", "Rotate who starts with the ball each round to keep it fair.", "Celebrate the player with the fewest taps as the round''s champion!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_5, N'short_response', N'🛹 Skateboard Slalom Championship

70s Inspiration: A championship-format version of the classic 1970s skateboard slalom.

Objective: Practice consistent slalom weaving across a full timed head-to-head tournament.

Materials: A skateboard | A helmet | Cones | A flat, smooth surface | A stopwatch or phone timer

Follow the steps below to play!', NULL, N'Always wear a helmet, and a slower clean run beats a fast one that clips a cone.', 47, N'sequence_steps', N'{"steps": ["Set up a standard slalom cone course and time each rider''s run.", "Run several heats, keeping track of everyone''s best time.", "The rider with the fastest clean run (no missed cones) wins the round.", "Try again to see if you can beat your own best time!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_5, N'short_response', N'🚗 Big Wheel Relay Strategy

70s Inspiration: The strategic team Big Wheel relays that got competitive on longer 1970s summer days.

Objective: Practice smart hand-off timing and pacing across a multi-lap team relay.

Materials: 1-2 Big Wheels or similar ride-on trikes | Cones to mark a lane

Follow the steps below to play!', NULL, N'Ride on a flat, open surface, and always wait for a full stop before the next rider starts.', 48, N'sequence_steps', N'{"steps": ["Split into teams and decide the riding order strategically (fastest rider last, for example).", "Each rider completes one lap to the cone and back before tagging the next.", "Encourage the current rider loudly to help them pace well.", "First team through all laps in their planned order wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_5, N'short_response', N'🎈 Water Balloon Toss Championship

70s Inspiration: A championship-format version of the classic 1970s water balloon toss.

Objective: Practice peak tossing precision across a full multi-pair elimination tournament.

Materials: Small water balloons | Towels for drying off

Follow the steps below to play!', NULL, N'Championship excitement still means gentle, underhand tosses only.', 49, N'sequence_steps', N'{"steps": ["Set up several pairs tossing at once, each starting close together.", "Every successful catch means both partners step back one step.", "A pair is eliminated when their balloon pops -- last pair still tossing wins!", "Celebrate every pair''s best distance, win or not."]}');

    DECLARE @cat_70s_6 INT;
    SELECT @cat_70s_6 = category_id FROM dbo.PacketCategories WHERE grade_id = 6 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_6, N'short_response', N'🦘 Pogo Stick Championship

70s Inspiration: A championship-format version of the classic 1970s pogo stick bouncing contest.

Objective: Practice peak bounce-count endurance across a full head-to-head contest.

Materials: Pogo sticks (child-sized), one per competitor

Follow the steps below to play!', NULL, N'Always compete on a soft, flat surface, and stop immediately if legs feel shaky.', 43, N'sequence_steps', N'{"steps": ["Line up competitors and have each attempt their longest bounce streak, one at a time.", "Count bounces out loud together for whoever is competing.", "Track everyone''s best streak on a simple scoreboard.", "The longest streak at the end wins the championship!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_6, N'short_response', N'🪁 Kite Flying Championship

70s Inspiration: A championship-format version of the classic 1970s park kite-flying contest.

Objective: Practice sustained flying skill and height management across a timed group competition.

Materials: 1 kite with string per player

Follow the steps below to play!', NULL, N'Give each flier plenty of space, and stay well clear of roads, trees, and power lines.', 44, N'sequence_steps', N'{"steps": ["Everyone launches their kite at the same time in a wide open field.", "Time how long each kite stays airborne without touching the ground.", "Track everyone''s longest continuous flight time.", "Whoever keeps their kite up the longest is the Kite Flying Champion!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_6, N'short_response', N'🎈 Water Balloon Toss Grand Finals

70s Inspiration: The grand finals of the classic 1970s water balloon toss tournament.

Objective: Practice peak precision tossing in a single deciding final round.

Materials: Small water balloons | Towels for drying off

Follow the steps below to play!', NULL, N'Even in the finals, a gentle underhand toss beats a hard, risky throw.', 45, N'sequence_steps', N'{"steps": ["Bring the two most successful pairs from earlier rounds to face off.", "Both pairs start at the same distance and step back together after each catch.", "The pair that reaches the farthest distance without popping wins the finals.", "Give both finalist pairs a big round of applause either way!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_6, N'short_response', N'🚲 Bike Rodeo Championship

70s Inspiration: A championship-format version of the full 1970s neighborhood bike rodeo.

Objective: Practice peak precision across a full multi-station bike rodeo competition.

Materials: Bikes | Cones for multiple stations | A stopwatch or phone timer

Follow the steps below to play!', NULL, N'Always wear a helmet, and remember precision beats raw speed in every rodeo event.', 46, N'sequence_steps', N'{"steps": ["Set up all the classic stations: slalom, figure-eight, and precision stop.", "Each rider completes the full circuit while being timed.", "Deduct points for any missed cone or stop-line miss, added to the total time.", "The rider with the best combined time and accuracy wins the championship!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_6, N'short_response', N'🏐 Spud Grand Tournament

70s Inspiration: A grand-tournament version of the classic 1970s playground game Spud.

Objective: Practice advanced strategy and consistency across a full bracket-style Spud tournament.

Materials: 1 soft, lightweight ball

Follow the steps below to play!', NULL, N'A big tournament is still a gentle-tap-only game -- keep contact soft the whole way through.', 47, N'sequence_steps', N'{"steps": ["Play a full tournament of many rounds, with a running tally kept for everyone.", "Rotate who starts each round so every player gets equal chances.", "After a set number of rounds, total up who was tapped the fewest times.", "That player is crowned the Spud Grand Tournament winner!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_6, N'short_response', N'🛹 Skateboard Slalom Masters

70s Inspiration: The most advanced slalom format of the classic 1970s skateboarding boom.

Objective: Practice mastery-level slalom control across the toughest, most tightly spaced cone course.

Materials: A skateboard | A helmet | 8-10 closely spaced cones | A stopwatch or phone timer

Follow the steps below to play!', NULL, N'Always wear a helmet, and a slower clean run always beats a fast, sloppy one.', 48, N'sequence_steps', N'{"steps": ["Set up 8-10 cones spaced tighter than any earlier course.", "Ride the course focusing on tight, controlled weaving.", "Time your run and note if you cleanly avoided every cone.", "The fastest CLEAN run (no missed cones) is the Slalom Master!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_6, N'short_response', N'🚗 Big Wheel Grand Prix

70s Inspiration: The friendly ''Grand Prix'' Big Wheel races that capped off many 1970s summer block parties.

Objective: Practice peak steady-speed pedaling across a full multi-lap Grand-Prix-style race.

Materials: Big Wheels or similar ride-on trikes, one per racer | Cones marking a full lap course

Follow the steps below to play!', NULL, N'Race only on a flat, open surface away from cars, and keep a safe distance between racers.', 49, N'sequence_steps', N'{"steps": ["Set up a full lap course with a clear start/finish line.", "Line up all racers together at the start.", "On ''go,'' everyone pedals a set number of laps around the course.", "First to complete all laps and cross the finish line wins the Grand Prix!"]}');

    DECLARE @cat_70s_7 INT;
    SELECT @cat_70s_7 = category_id FROM dbo.PacketCategories WHERE grade_id = 7 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_7, N'short_response', N'🦘 Pogo Stick Masters

70s Inspiration: The most advanced pogo stick bouncing contest format from the 1970s craze.

Objective: Practice mastery-level bouncing endurance and control at the highest difficulty.

Materials: Pogo sticks (child-sized), one per competitor

Follow the steps below to play!', NULL, N'Only attempt tricks once your straight bouncing is fully steady, always on soft ground.', 43, N'sequence_steps', N'{"steps": ["Each competitor attempts their longest streak while also adding a small quarter-turn trick partway through.", "Judges (friends or grown-ups) note both streak length and trick success.", "Combine streak length and trick success for a final score.", "The highest combined score is the Pogo Stick Master!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_7, N'short_response', N'🪁 Kite Flying Masters

70s Inspiration: The most advanced kite-flying format enjoyed by dedicated 1970s kite hobbyists.

Objective: Practice mastery-level kite control, combining height, duration, and simple tricks.

Materials: 1 kite with string per player

Follow the steps below to play!', NULL, N'Master-level flying still means staying in wide open space, well clear of hazards.', 44, N'sequence_steps', N'{"steps": ["Launch your kite and get it flying high and steady.", "Attempt a slow figure-eight trick while maintaining height.", "Time how long you can keep the kite up while also completing the trick.", "The flier with the best combined height, time, and trick success is the Kite Master!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_7, N'short_response', N'🎈 Water Balloon Toss Masters

70s Inspiration: The ultimate mastery-level version of the classic 1970s water balloon toss.

Objective: Practice the most advanced tossing precision across the longest distances yet.

Materials: Small water balloons | Towels for drying off

Follow the steps below to play!', NULL, N'Mastery is about technique, not force -- a soft, high arc is still the safest and most accurate toss.', 45, N'sequence_steps', N'{"steps": ["Pair up with a partner known for great catching hands.", "Start farther apart than any earlier round and toss gently.", "Step back after every catch, aiming for a new personal-best distance.", "Whichever pair reaches the greatest distance overall are the Toss Masters!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_7, N'short_response', N'🚲 Bike Rodeo Masters

70s Inspiration: The master-class bike rodeo format that capped off the best 1970s neighborhood bike skills events.

Objective: Practice the highest level of bike control across the most demanding rodeo course.

Materials: Bikes | Cones for a demanding multi-station course | A stopwatch or phone timer

Follow the steps below to play!', NULL, N'Always wear a helmet -- mastery means control at every speed, not just going fast.', 46, N'sequence_steps', N'{"steps": ["Set up a demanding course: a tight slalom, a slow-ride balance zone, and a precise figure-eight.", "Complete the full course with as few mistakes as possible, timed from start to finish.", "Deduct time bonuses are earned for a perfectly clean run.", "The best time with a clean run earns the Bike Rodeo Master title!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_7, N'short_response', N'🏐 Spud Masters League

70s Inspiration: A league-format version of the classic 1970s playground game Spud, for a big group.

Objective: Practice the most advanced group strategy and awareness across an ongoing league format.

Materials: 1 soft, lightweight ball

Follow the steps below to play!', NULL, N'League play is still about smart scattering, not rough contact -- gentle taps always.', 47, N'sequence_steps', N'{"steps": ["Play Spud across several ''seasons'' (sets of 10 rounds), tracking each player''s tap count per season.", "Compare results across seasons to see who consistently avoids taps.", "Rotate ball-tossers fairly across every season.", "Crown the player with the best overall record the Spud League Champion!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_7, N'short_response', N'🛹 Skateboard Trick Masters

70s Inspiration: The trick-combo showcases that top 1970s skateboarders were known for.

Objective: Practice combining slalom control with a simple, safe trick for the ultimate skateboarding showcase.

Materials: A skateboard | A helmet | Cones | A flat, smooth surface

Follow the steps below to play!', NULL, N'Always wear a helmet, and only attempt a trick you''ve already practiced safely many times.', 48, N'sequence_steps', N'{"steps": ["Ride a slalom cone course smoothly from start to finish.", "At the end, attempt one simple trick you''ve mastered, like a controlled kick-turn.", "Combine your slalom time and trick success for an overall score.", "The best combined score earns the Skateboard Trick Master title!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s_7, N'short_response', N'🚗 Big Wheel Grand Prix Masters

70s Inspiration: The legendary multi-lap Big Wheel Grand Prix races that ended many epic 1970s summers.

Objective: Practice the ultimate combination of speed, cornering, and endurance across the longest Big Wheel race yet.

Materials: Big Wheels or similar ride-on trikes, one per racer | Cones marking a full multi-turn lap course

Follow the steps below to play!', NULL, N'Longer races mean more focus, not more speed -- steady and controlled wins multi-lap races.', 49, N'sequence_steps', N'{"steps": ["Set up the longest lap course yet, with at least two turns per lap.", "Line up all racers and agree on the number of laps (start with 3).", "Race steadily, focusing on smooth cornering to avoid losing speed.", "First racer to complete all laps and cross the finish line is the Grand Prix Masters Champion!"]}');

END
GO

DELETE FROM dbo.WeeklyPacketPlan;
GO