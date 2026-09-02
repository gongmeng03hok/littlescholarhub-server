-- 88_outdoor_games_retro90s_batch2.sql
-- Extends the existing 'Outdoor Games' category (see 68/69/70/71/82/83/84)
-- with a SECOND batch of 7 more games per grade (63 -> 70), continuing the
-- 1990s-retro theme: Slip 'N Slide backyard water sliding, backyard trampoline
-- bouncing, Chinese jump rope / elastics, wall-ball (handball), wiffle ball,
-- numbered chalk hopscotch, and hippity hop (space hopper) ball bouncing. No
-- branded/copyrighted characters -- traditional public-domain activities and
-- toy TYPES only, scaled by grade. Distinct from 84_outdoor_games_retro90s_batch1.sql
-- (rollerblades, water guns, Grounders, flashlight tag, kick scooters, chalk
-- 'Twister,' and yo-yos) and from the parallel 1970s-batch-2 migration, which
-- separately claims sort_order 57-63.
--
-- Appends to the SAME per-grade PacketCategories row with sort_order
-- continuing from 64. See gen_88_outdoor_games_retro90s_batch2.py.

IF NOT EXISTS (
    SELECT 1 FROM dbo.PacketQuestions q
    JOIN dbo.PacketCategories c ON c.category_id = q.category_id
    WHERE c.category_name = 'Outdoor Games' AND c.grade_id = 0 AND q.sort_order = 64
)
BEGIN
    DECLARE @cat_90s2_0 INT;
    SELECT @cat_90s2_0 = category_id FROM dbo.PacketCategories WHERE grade_id = 0 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_0, N'short_response', N'🌊 Slip ''N Slide Wobble Walk

90s Inspiration: A gentle first step toward the backyard water-slide fun that soaked 1990s lawns all summer.

Objective: Practice walking carefully beside a wet slide mat and sitting down slowly with help.

Players: 1+ (solo or group)

Materials: A plastic backyard water slide (Slip ''N Slide) | A hose | A grown-up spotter

Follow the steps below to play!', NULL, N'Always slide feet-first while sitting or lying down, and never dive or run onto the wet mat.', 64, N'sequence_steps', N'{"steps": ["Lay the wet slide mat flat on soft grass with a grown-up''s help.", "Sit down slowly at the top edge of the mat.", "Hold a grown-up''s hand and slide just a tiny bit forward.", "Stand up carefully at the end and try again!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_0, N'short_response', N'🤸 Trampoline Wobble Bounce

90s Inspiration: A gentle first taste of the backyard trampolines that became a 1990s backyard favorite.

Objective: Practice small, controlled bounces while sitting or standing with support.

Players: 1+ (solo or group)

Materials: A backyard trampoline with a safety net if possible | A grown-up spotter

Follow the steps below to play!', NULL, N'Only one person bounces at a time, and a grown-up should always be watching close by.', 65, N'sequence_steps', N'{"steps": ["Sit in the middle of the trampoline with a grown-up holding your hands.", "Press down gently to feel a tiny, soft bounce.", "With help, stand up slowly and try a few tiny standing bounces.", "Sit back down carefully when you feel done."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_0, N'short_response', N'🪢 Elastic Rope Wobble Step

90s Inspiration: A gentle first step toward the elastic Chinese jump rope games that filled 1990s playgrounds.

Objective: Practice stepping carefully over a low elastic loop without tripping.

Players: 2 players

Materials: A long loop of Chinese jump rope elastic | 2 players (1 to hold, 1 to step)

Follow the steps below to play!', NULL, N'Keep the elastic low to the ground and step slowly and carefully, holding a grown-up''s hand if needed.', 66, N'sequence_steps', N'{"steps": ["One player loops the elastic around their own two ankles.", "The other player stands ready to step over it.", "Step one foot, then the other, carefully over the elastic band.", "Switch roles so both players get a turn stepping!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_0, N'short_response', N'🎾 Wall Ball Wobble Toss

90s Inspiration: A gentle first step toward the wall-ball games played against any driveway wall in the 1990s.

Objective: Practice tossing a ball underhand at a wall and catching it as it comes back.

Players: 1+ (solo or group)

Materials: A soft, bouncy rubber ball | A flat outdoor wall

Follow the steps below to play!', NULL, N'Stand a few big steps back from the wall and always keep your eyes on the ball.', 67, N'sequence_steps', N'{"steps": ["Stand facing the wall, a few steps back.", "Toss the ball underhand gently at the wall.", "Watch the ball bounce back toward you.", "Catch it with both hands, then try again!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_0, N'short_response', N'⚾ Wiffle Ball Wobble Swing

90s Inspiration: A gentle first step toward the plastic wiffle ball sets that made backyard baseball safe and easy in the 1990s.

Objective: Practice a slow, controlled swing at a ball resting on a stand.

Players: 1+ (solo or group)

Materials: A wiffle ball | A plastic wiffle bat | A ball stand or tee

Follow the steps below to play!', NULL, N'Only swing the bat when the batting area around you is completely clear.', 68, N'sequence_steps', N'{"steps": ["Set the wiffle ball on the stand at a comfortable height.", "Hold the bat with both hands, feet apart, facing the ball.", "Take a slow, gentle practice swing to check your aim.", "Swing and try to tap the ball off the stand!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_0, N'short_response', N'🔢 Number Hop Wobble Walk

90s Inspiration: A gentle first step toward the numbered chalk hopscotch grids drawn on 1990s sidewalks everywhere.

Objective: Practice stepping carefully through a simple numbered chalk grid.

Players: 1+ (solo or group)

Materials: Sidewalk chalk

Follow the steps below to play!', NULL, N'Hop or step carefully and always land with both feet steady before moving again.', 69, N'sequence_steps', N'{"steps": ["Draw three big numbered squares (1, 2, 3) in a row with chalk.", "Stand at square 1 to start.", "Step carefully into square 2, then square 3.", "Turn around and step back to square 1 to finish!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_0, N'short_response', N'🦘 Hippity Hop Wobble Sit

90s Inspiration: A gentle first step toward the bouncy inflatable hippity hop balls that bounced across 1990s yards.

Objective: Practice sitting on the hippity hop ball and feeling small, controlled bounces with help.

Players: 1+ (solo or group)

Materials: A hippity hop ball (space hopper) sized for the child | A soft grassy area | A grown-up spotter

Follow the steps below to play!', NULL, N'Always bounce on soft grass, and hold the handles tightly with a grown-up close by.', 70, N'sequence_steps', N'{"steps": ["Sit on the hippity hop ball on soft grass with a grown-up steadying you.", "Hold both handles with a firm grip.", "Press down gently to feel a tiny, soft bounce.", "Stop and rest whenever you feel ready!"]}');

    DECLARE @cat_90s2_1 INT;
    SELECT @cat_90s2_1 = category_id FROM dbo.PacketCategories WHERE grade_id = 1 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_1, N'short_response', N'🌊 Slip ''N Slide First Splash

90s Inspiration: The backyard water slide that turned ordinary lawns into 1990s summer hotspots.

Objective: Practice a short, feet-first slide on your tummy or back with a grown-up watching.

Players: 1+ (solo or group)

Materials: A plastic backyard water slide | A hose | A grown-up spotter

Follow the steps below to play!', NULL, N'Slide feet-first only, one person at a time, and wait until the mat is clear before your turn.', 64, N'sequence_steps', N'{"steps": ["Wet the slide mat down with the hose.", "Lie down feet-first at the top of the mat.", "Push off gently with your hands and slide to the end.", "Get up, step off the mat, and go to the back of the line for another turn."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_1, N'short_response', N'🤸 Trampoline First Jumps

90s Inspiration: The bouncing fun that spread across 1990s backyards as trampolines became common.

Objective: Practice standing bounces while staying balanced in the center of the mat.

Players: 1+ (solo or group)

Materials: A backyard trampoline with a safety net if possible | A grown-up spotter

Follow the steps below to play!', NULL, N'Stay in the center of the trampoline and always land on both feet.', 65, N'sequence_steps', N'{"steps": ["Stand in the very center of the trampoline mat.", "Bend your knees and push off gently for a small jump.", "Land softly on both feet with bent knees.", "Repeat a few small jumps, staying centered each time."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_1, N'short_response', N'🪢 Chinese Jump Rope First Steps

90s Inspiration: The classic elastic jump rope game that was everywhere on 1990s playgrounds.

Objective: Practice the basic in-out foot pattern at ankle height.

Players: 3+ players

Materials: A long loop of Chinese jump rope elastic | 2 players to hold it (or a chair/fence for solo)

Follow the steps below to play!', NULL, N'Agree on a comfortable height before starting, and stop right away if the elastic feels too tight.', 66, N'sequence_steps', N'{"steps": ["Two players stand inside the elastic loop at ankle height, stretching it into a rectangle.", "The jumper hops both feet outside the elastic.", "Then hops both feet back inside the elastic.", "Repeat the in-out pattern a few times, then switch who jumps!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_1, N'short_response', N'🎾 Wall Ball First Bounce

90s Inspiration: The classic wall-ball games that turned any blank wall into 1990s playtime.

Objective: Practice throwing the ball so it bounces once off the wall and once on the ground before catching.

Players: 1+ (solo or group)

Materials: A soft, bouncy rubber ball | A flat outdoor wall

Follow the steps below to play!', NULL, N'Keep a steady distance from the wall so the ball has room to bounce back safely.', 67, N'sequence_steps', N'{"steps": ["Stand a comfortable distance from the wall.", "Throw the ball so it hits the wall first.", "Let it bounce once on the ground.", "Catch it with both hands and throw again!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_1, N'short_response', N'⚾ Wiffle Ball First Hit

90s Inspiration: The plastic bat-and-ball sets that made every 1990s backyard a mini baseball field.

Objective: Practice hitting a gently tossed wiffle ball with the bat.

Players: 2 players

Materials: A wiffle ball | A plastic wiffle bat

Follow the steps below to play!', NULL, N'The pitcher should toss softly and underhand, and only when the batter is ready.', 68, N'sequence_steps', N'{"steps": ["A partner tosses the wiffle ball softly and underhand toward you.", "Watch the ball closely as it comes.", "Swing the bat and try to hit it.", "Switch turns so both players get to bat and toss!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_1, N'short_response', N'🔢 Hopscotch Number Hop Basics

90s Inspiration: The classic numbered hopscotch grid that was a sidewalk staple throughout the 1990s.

Objective: Practice tossing a marker onto number 1 and hopping through the numbers 1 to 5.

Players: 1+ (solo or group)

Materials: Sidewalk chalk | A small beanbag or smooth stone (marker)

Follow the steps below to play!', NULL, N'Toss the marker gently, and always hop on one foot only where the grid shows a single square.', 69, N'sequence_steps', N'{"steps": ["Draw a hopscotch grid numbered 1 through 5 with chalk.", "Toss your marker gently so it lands on square 1.", "Hop over square 1 and continue hopping through squares 2 to 5.", "Turn around at the end and hop back to the start!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_1, N'short_response', N'🦘 Hippity Hop First Bounce

90s Inspiration: The bouncy inflatable balls (space hoppers) that had kids hopping across 1990s driveways and yards.

Objective: Practice small controlled bounces while holding the handles steady.

Players: 1+ (solo or group)

Materials: A hippity hop ball | A soft grassy area

Follow the steps below to play!', NULL, N'Keep both hands on the handles at all times and bounce only on soft ground.', 70, N'sequence_steps', N'{"steps": ["Sit on the ball on soft grass, holding both handles.", "Bounce gently up and down a few small times in one spot.", "Keep your grip steady on the handles the whole time.", "Rest and try a few more small bounces!"]}');

    DECLARE @cat_90s2_2 INT;
    SELECT @cat_90s2_2 = category_id FROM dbo.PacketCategories WHERE grade_id = 2 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_2, N'short_response', N'🌊 Slip ''N Slide Splash Warm-Up

90s Inspiration: The classic Slip ''N Slide that made every 1990s backyard feel like a water park.

Objective: Practice sliding smoothly in a straight line from start to finish.

Players: 1+ (solo or group)

Materials: A plastic backyard water slide | A hose | Swimsuits

Follow the steps below to play!', NULL, N'Keep the slide path clear of toys and people, and always slide one at a time.', 64, N'sequence_steps', N'{"steps": ["Re-wet the mat so it stays slippery.", "Take a running-free, walking start right up to the edge.", "Lie down feet-first and slide the whole way to the end.", "Try to keep your body straight so you glide smoothly!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_2, N'short_response', N'🤸 Trampoline Bounce Warm-Up

90s Inspiration: The everyday backyard trampoline bouncing that kept 1990s kids entertained for hours.

Objective: Practice counting continuous bounces while keeping good control.

Players: 1+ (solo or group)

Materials: A backyard trampoline with a safety net if possible | A grown-up spotter

Follow the steps below to play!', NULL, N'If you ever feel off balance, sit down right away instead of trying to catch yourself.', 65, N'sequence_steps', N'{"steps": ["Start with a few steady, centered bounces.", "Count each bounce out loud as you go.", "Try to reach 10 controlled bounces in a row.", "Stop and rest, then see if you can beat your count!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_2, N'short_response', N'🪢 Chinese Jump Rope Warm-Up

90s Inspiration: The ankle-height elastic jump rope patterns that 1990s kids practiced every recess.

Objective: Practice a simple sequence of ankle-height jump patterns without a mistake.

Players: 3+ players

Materials: A long loop of Chinese jump rope elastic | 2 players to hold it

Follow the steps below to play!', NULL, N'Take turns patiently, and cheer on the jumper instead of rushing them.', 66, N'sequence_steps', N'{"steps": ["Holders stretch the elastic into a rectangle at ankle height.", "The jumper hops in, out, side, side following a simple called pattern.", "Try the same pattern three times in a row without a mistake.", "Switch places so everyone gets a turn jumping and holding!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_2, N'short_response', N'🎾 Wall Ball Warm-Up

90s Inspiration: The everyday wall-ball bouncing that kept 1990s kids busy on any driveway or schoolyard wall.

Objective: Practice a steady rhythm of throwing, bouncing, and catching without stopping.

Players: 1+ (solo or group)

Materials: A soft, bouncy rubber ball | A flat outdoor wall

Follow the steps below to play!', NULL, N'If you miss a catch, just pick the ball up calmly and start your count over.', 67, N'sequence_steps', N'{"steps": ["Stand at a comfortable throwing distance from the wall.", "Throw, let it bounce off the wall and the ground once, then catch.", "Repeat the same rhythm without pausing between throws.", "Count how many catches in a row you can complete!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_2, N'short_response', N'⚾ Wiffle Ball Warm-Up

90s Inspiration: The pitch-and-hit wiffle ball practice that filled 1990s backyards on sunny afternoons.

Objective: Practice hitting several pitched balls in a row and counting successful hits.

Players: 2 players

Materials: A wiffle ball | A plastic wiffle bat

Follow the steps below to play!', NULL, N'Stand a safe distance from the pitcher so there''s plenty of room to swing.', 68, N'sequence_steps', N'{"steps": ["The pitcher tosses five soft pitches, one at a time.", "The batter tries to hit each pitch cleanly.", "Count how many of the five pitches were hit.", "Switch roles so the pitcher gets a turn batting too!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_2, N'short_response', N'🔢 Hopscotch Number Hop Warm-Up

90s Inspiration: The full numbered hopscotch course that kept 1990s kids hopping for hours.

Objective: Practice a full 1-8 numbered course, using one foot for single squares and two feet for side-by-side squares.

Players: 1+ (solo or group)

Materials: Sidewalk chalk | A small beanbag or smooth stone (marker)

Follow the steps below to play!', NULL, N'Land softly with bent knees, and step out of the grid calmly if you lose your balance.', 69, N'sequence_steps', N'{"steps": ["Draw a full hopscotch grid numbered 1 through 8.", "Hop on one foot for single squares and land on both feet for side-by-side squares.", "Hop all the way to square 8 without touching a line.", "Turn around carefully and hop all the way back!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_2, N'short_response', N'🦘 Hippity Hop Warm-Up

90s Inspiration: The everyday hippity hop bouncing that kept 1990s kids entertained across the yard.

Objective: Practice bouncing forward a short distance while staying balanced.

Players: 1+ (solo or group)

Materials: A hippity hop ball | A soft grassy area

Follow the steps below to play!', NULL, N'Bounce slowly forward and stop right away if you feel wobbly.', 70, N'sequence_steps', N'{"steps": ["Sit on the ball, holding the handles firmly.", "Bounce gently forward, moving just a little with each bounce.", "Keep bouncing forward across a short, clear stretch of grass.", "Stop, turn around carefully, and bounce back to the start!"]}');

    DECLARE @cat_90s2_3 INT;
    SELECT @cat_90s2_3 = category_id FROM dbo.PacketCategories WHERE grade_id = 3 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_3, N'short_response', N'🌊 Slip ''N Slide Splash Challenge

90s Inspiration: The backyard water-slide contests neighborhood kids invented during 1990s summers.

Objective: Practice sliding as far as possible and marking the distance with chalk.

Players: 2-4 players

Materials: A plastic backyard water slide | A hose | Sidewalk chalk to mark distance

Follow the steps below to play!', NULL, N'Wait until the slider ahead of you is fully off the mat before your turn begins.', 64, N'sequence_steps', N'{"steps": ["Wet the mat well and mark a chalk line at the very end of it.", "Each player takes one turn sliding feet-first from the top.", "Mark with chalk exactly where each player stops sliding.", "Compare marks -- whose slide went the farthest past the end line?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_3, N'short_response', N'🤸 Trampoline Bounce Challenge

90s Inspiration: The backyard trampoline games kids invented to spice up bouncing during 1990s summers.

Objective: Practice controlled bounce patterns, like tucking knees up mid-bounce.

Players: 1+ (solo or group)

Materials: A backyard trampoline with a safety net if possible | A grown-up spotter

Follow the steps below to play!', NULL, N'Only try knee-tuck bounces once your regular bouncing feels steady and controlled.', 65, N'sequence_steps', N'{"steps": ["Warm up with five steady, centered bounces.", "On the next bounce, gently tuck your knees toward your chest in the air.", "Land softly on both feet with knees slightly bent.", "Practice a few more knee-tuck bounces, resetting your balance each time."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_3, N'short_response', N'🪢 Chinese Jump Rope Challenge

90s Inspiration: The knee-height elastic jump rope challenges that separated the experts from beginners in the 1990s.

Objective: Practice the same jump patterns with the elastic raised to knee height.

Players: 3+ players

Materials: A long loop of Chinese jump rope elastic | 2 players to hold it

Follow the steps below to play!', NULL, N'Only raise the elastic once the ankle-height patterns feel easy and steady.', 66, N'sequence_steps', N'{"steps": ["Holders raise the elastic to knee height, stretched into a rectangle.", "The jumper tries the in-out-side-side pattern at this new height.", "If a jump is missed, gently reset and try the pattern again.", "See how many clean rounds you can complete at knee height!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_3, N'short_response', N'🎾 Wall Ball Challenge

90s Inspiration: The wall-ball counting contests that turned a simple wall into a 1990s playground challenge.

Objective: Practice keeping a continuous catch count going as long as possible without a drop.

Players: 1+ (solo or group)

Materials: A soft, bouncy rubber ball | A flat outdoor wall

Follow the steps below to play!', NULL, N'Keep your knees a little bent and stay light on your feet so you can move for tricky bounces.', 67, N'sequence_steps', N'{"steps": ["Start your throw-bounce-catch rhythm against the wall.", "Count each successful catch out loud.", "Keep going, moving your feet if the ball bounces off to a side.", "See if you can beat your best count from last time!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_3, N'short_response', N'⚾ Wiffle Ball Challenge

90s Inspiration: The backyard hit-and-run games that added extra excitement to 1990s wiffle ball play.

Objective: Practice hitting the ball and then running to a base before it''s picked up.

Players: 2-4 players

Materials: A wiffle ball | A plastic wiffle bat | A towel or cone for a base

Follow the steps below to play!', NULL, N'Run in a straight line to the base and slow down before you get there.', 68, N'sequence_steps', N'{"steps": ["Set one base (a towel or cone) a short distance from home.", "The batter hits a pitched ball.", "As soon as it''s hit, run to the base as fast as you safely can.", "See if you can reach the base before a fielder grabs the ball!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_3, N'short_response', N'🔢 Hopscotch Number Hop Challenge

90s Inspiration: The marker-tossing hopscotch challenges that made 1990s sidewalk games more competitive.

Objective: Practice tossing the marker at increasing numbers and hopping to pick it up along the way.

Players: 2-4 players

Materials: Sidewalk chalk | A small beanbag or smooth stone (marker)

Follow the steps below to play!', NULL, N'Bend your knees and balance carefully whenever you pause to pick up the marker.', 69, N'sequence_steps', N'{"steps": ["Toss the marker onto the next number in order, starting at 1.", "Hop through the course, skipping the square with the marker.", "Pause on one foot to pick up the marker on your way back.", "Move up to the next number and try again!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_3, N'short_response', N'🦘 Hippity Hop Challenge

90s Inspiration: The backyard hippity hop courses kids set up with whatever they had around in the 1990s.

Objective: Practice bouncing around a simple course of cones without knocking any over.

Players: 1+ (solo or group)

Materials: A hippity hop ball | A soft grassy area | 4-5 cones

Follow the steps below to play!', NULL, N'Slow down for each turn around a cone rather than bouncing too fast to control.', 70, N'sequence_steps', N'{"steps": ["Set up 4-5 cones spaced out in a gentle curved line.", "Bounce from the start toward the first cone.", "Bounce carefully around each cone, one at a time.", "Finish the course and try again for a smoother run!"]}');

    DECLARE @cat_90s2_4 INT;
    SELECT @cat_90s2_4 = category_id FROM dbo.PacketCategories WHERE grade_id = 4 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_4, N'short_response', N'🌊 Slip ''N Slide Relay Splash

90s Inspiration: The team water-slide relays that livened up 1990s backyard parties.

Objective: Practice teamwork by taking turns sliding as fast as a team can in a relay.

Players: Teams of 2+ (2 or more teams)

Materials: A plastic backyard water slide | A hose | A stopwatch or phone timer

Follow the steps below to play!', NULL, N'Only start your slide once the teammate ahead of you is completely clear of the mat.', 64, N'sequence_steps', N'{"steps": ["Split into two or more teams and line up behind the slide.", "On ''go,'' the first player on each team slides down and runs to tag the next teammate.", "Each teammate slides in turn until the whole team has gone once.", "The team that finishes all its slides first wins the relay!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_4, N'short_response', N'🤸 Trampoline Trick Practice

90s Inspiration: The simple trampoline tricks that adventurous kids practiced in 1990s backyards.

Objective: Practice a safe, simple twist jump, turning a quarter-turn in the air.

Players: 1+ (solo or group)

Materials: A backyard trampoline with a safety net if possible | A grown-up spotter

Follow the steps below to play!', NULL, N'Only attempt a small quarter-turn, never a full flip, and always land facing safely.', 65, N'sequence_steps', N'{"steps": ["Bounce a few times to build a steady, centered rhythm.", "On one bounce, gently twist your hips a quarter-turn in the air.", "Land softly, facing the new direction, with bent knees.", "Practice turning the same way a few times before trying the other direction."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_4, N'short_response', N'🪢 Chinese Jump Rope Pattern Practice

90s Inspiration: The named tricks, like ''diamonds'' and ''scissors,'' that turned Chinese jump rope into a real skill game in the 1990s.

Objective: Practice learning one named pattern, like ''diamonds,'' step by step.

Players: 3+ players

Materials: A long loop of Chinese jump rope elastic | 2 players to hold it

Follow the steps below to play!', NULL, N'Learn a new pattern slowly, one step at a time, before trying it at full speed.', 66, N'sequence_steps', N'{"steps": ["Holders stretch the elastic at knee height.", "The jumper practices the ''diamonds'' pattern one slow step at a time.", "Once each step feels comfortable, try linking them together smoothly.", "Perform the full pattern for your friends once you''ve got it down!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_4, N'short_response', N'🎾 Wall Ball Rally Practice

90s Inspiration: The two-player wall-ball rallies (a backyard version of handball) that were a 1990s recess favorite.

Objective: Practice taking turns hitting the ball against the wall with a partner, like a rally.

Players: 2 players

Materials: A soft, bouncy rubber ball | A flat outdoor wall | Chalk to mark a line (optional)

Follow the steps below to play!', NULL, N'Give your partner enough room to reach the ball, and call out if you''re about to miss.', 67, N'sequence_steps', N'{"steps": ["Two players stand side by side, a few steps back from the wall.", "The first player hits the ball against the wall.", "The second player lets it bounce once, then hits it back at the wall.", "Keep the rally going, taking turns, for as long as you can!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_4, N'short_response', N'⚾ Wiffle Ball Mini Game

90s Inspiration: The small backyard wiffle ball games with a pitcher, batter, and fielder that 1990s kids played all summer.

Objective: Practice playing a simple 3-player game with clear roles and one inning.

Players: 3+ players

Materials: A wiffle ball | A plastic wiffle bat | 1-2 bases (towels or cones)

Follow the steps below to play!', NULL, N'Fielders should call out clearly before catching so no two players collide going for the ball.', 68, N'sequence_steps', N'{"steps": ["Assign one pitcher, one batter, and one or more fielders.", "The pitcher tosses underhand pitches to the batter.", "The batter tries to hit and run the bases while fielders try to field the ball.", "After a few hits, rotate roles so everyone gets a turn batting!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_4, N'short_response', N'🔢 Hopscotch Math Hop

90s Inspiration: A math twist on the classic 1990s numbered hopscotch grid.

Objective: Practice quick mental math by hopping to the number that matches a called-out sum.

Players: 2-4 players

Materials: Sidewalk chalk | A small beanbag or smooth stone (marker)

Follow the steps below to play!', NULL, N'Take your time to think of the answer before hopping -- accuracy matters more than speed.', 69, N'sequence_steps', N'{"steps": ["Draw the numbered grid 1 through 8 as usual.", "A caller shouts out a simple math problem, like ''3 plus 2.''", "The hopper solves it and hops straight to the matching numbered square.", "Take turns calling and hopping through several rounds!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_4, N'short_response', N'🦘 Hippity Hop Race Practice

90s Inspiration: The friendly hippity hop races that turned yard bouncing into 1990s backyard competition.

Objective: Practice bouncing a short, timed distance as quickly and safely as possible.

Players: 2-4 players

Materials: A hippity hop ball per player if possible | A soft grassy area | A stopwatch or phone timer

Follow the steps below to play!', NULL, N'A faster time never matters more than staying balanced -- slow down if you feel unsteady.', 70, N'sequence_steps', N'{"steps": ["Mark a start and finish line a short distance apart on the grass.", "One player bounces from start to finish while a friend times them.", "Record the time it took to reach the finish line.", "Take turns so everyone gets a timed run!"]}');

    DECLARE @cat_90s2_5 INT;
    SELECT @cat_90s2_5 = category_id FROM dbo.PacketCategories WHERE grade_id = 5 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_5, N'short_response', N'🌊 Slip ''N Slide Distance Challenge

90s Inspiration: The measured backyard slide contests that turned simple sliding into a friendly 1990s competition.

Objective: Practice measuring and comparing slide distances using a tape measure or footsteps.

Players: 2-4 players

Materials: A plastic backyard water slide | A hose | A tape measure or measuring wheel

Follow the steps below to play!', NULL, N'Measure only after the slider has come to a complete, safe stop.', 64, N'sequence_steps', N'{"steps": ["Wet the mat thoroughly so it stays fast and slippery.", "Each player slides feet-first and stays still exactly where they stop.", "Measure the distance from the end of the mat to where each player stopped.", "Keep a tally of everyone''s best distance across a few rounds!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_5, N'short_response', N'🤸 Trampoline Rhythm Challenge

90s Inspiration: The rhythm bouncing games that made trampoline time extra fun in 1990s backyards.

Objective: Practice bouncing in time with a counted rhythm, adding small arm movements.

Players: 2-4 players

Materials: A backyard trampoline with a safety net if possible | A grown-up spotter | A stopwatch or phone timer

Follow the steps below to play!', NULL, N'Take turns bouncing one at a time so everyone stays safely spaced out.', 65, N'sequence_steps', N'{"steps": ["One player bounces while a friend calls out a steady counting rhythm.", "Try adding a simple arm movement, like a clap, on every fourth bounce.", "Keep the rhythm going for 30 seconds without losing your balance.", "Switch turns so every player gets a rhythm round!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_5, N'short_response', N'🪢 Chinese Jump Rope Waist Challenge

90s Inspiration: The waist-height elastic challenges that only the most practiced 1990s jumpers attempted.

Objective: Practice jump patterns with the elastic raised to waist height for extra challenge.

Players: 3+ players

Materials: A long loop of Chinese jump rope elastic | 2 players to hold it

Follow the steps below to play!', NULL, N'Waist height is tricky -- it''s okay to step out and reset if a jump doesn''t land right.', 66, N'sequence_steps', N'{"steps": ["Holders raise the elastic carefully to waist height.", "The jumper attempts a favorite pattern at this taller height.", "Reset calmly after any missed step and try again.", "Celebrate every clean pattern completed at waist height!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_5, N'short_response', N'🎾 Wall Ball Speed Challenge

90s Inspiration: The timed wall-ball rallies that added extra excitement to 1990s driveway games.

Objective: Practice keeping a rally going for a full timed round without missing.

Players: 2 players

Materials: A soft, bouncy rubber ball | A flat outdoor wall | A stopwatch or phone timer

Follow the steps below to play!', NULL, N'Speed is fun, but a controlled hit beats a wild one -- slow down if you''re rushing.', 67, N'sequence_steps', N'{"steps": ["Set a timer for 60 seconds.", "Two players rally the ball against the wall, taking turns hitting it back.", "Count how many total hits the pair completes before time runs out.", "Try again and see if you can beat your combined total!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_5, N'short_response', N'⚾ Wiffle Ball Team Challenge

90s Inspiration: The small-team backyard wiffle ball games that mimicked real baseball in 1990s neighborhoods.

Objective: Practice playing a short, friendly team game with a set number of innings.

Players: Teams of 2+ (2 or more teams)

Materials: A wiffle ball | A plastic wiffle bat | Bases (towels or cones)

Follow the steps below to play!', NULL, N'Agree on the rules together before starting so every play is fair for both teams.', 68, N'sequence_steps', N'{"steps": ["Split into two small teams and decide who bats first.", "Play three innings, with each team batting and fielding once per inning.", "Keep a simple tally of runs scored by each team.", "The team with the most runs after three innings wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_5, N'short_response', N'🔢 Hopscotch Number Hop Speed Challenge

90s Inspiration: The timed hopscotch races that added extra thrill to 1990s recess play.

Objective: Practice completing the full numbered course as quickly and cleanly as possible.

Players: 2-4 players

Materials: Sidewalk chalk | A small beanbag or smooth stone (marker) | A stopwatch or phone timer

Follow the steps below to play!', NULL, N'A fast time only counts if you never step on a line -- careful hopping beats rushing.', 69, N'sequence_steps', N'{"steps": ["Time each player completing the full 1-8 course and back.", "A step on a line means that run doesn''t count as clean.", "Compare everyone''s best clean time.", "Try again to see if you can beat your own record!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_5, N'short_response', N'🦘 Hippity Hop Relay Challenge

90s Inspiration: The team hippity hop relays that added extra fun to 1990s backyard get-togethers.

Objective: Practice teamwork by taking turns bouncing a relay leg as a team.

Players: Teams of 2+ (2 or more teams)

Materials: A hippity hop ball per team | A soft grassy area | A stopwatch or phone timer

Follow the steps below to play!', NULL, N'Only start bouncing once the teammate ahead has fully finished their leg and handed off.', 70, N'sequence_steps', N'{"steps": ["Split into teams and line up at the start line.", "The first player on each team bounces to the finish line and back.", "Hand the ball off to the next teammate to take their turn.", "The team that finishes all their legs first wins the relay!"]}');

    DECLARE @cat_90s2_6 INT;
    SELECT @cat_90s2_6 = category_id FROM dbo.PacketCategories WHERE grade_id = 6 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_6, N'short_response', N'🌊 Slip ''N Slide Championship

90s Inspiration: The all-out Slip ''N Slide showdowns that capped off many 1990s summer afternoons.

Objective: Practice consistent sliding technique across several timed and measured rounds.

Players: Teams of 2+ (2 or more teams)

Materials: A plastic backyard water slide | A hose | A tape measure | A stopwatch or phone timer

Follow the steps below to play!', NULL, N'A championship still means one slider at a time -- never crowd the mat.', 64, N'sequence_steps', N'{"steps": ["Run three rounds where each player gets one measured slide per round.", "Record each player''s best distance across the three rounds.", "Add a bonus round timing how fast each player gets from start to a full stop.", "Combine distance and speed to crown the Slip ''N Slide Champion!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_6, N'short_response', N'🤸 Trampoline Championship

90s Inspiration: The backyard bouncing contests that turned trampoline time into a 1990s summer event.

Objective: Practice sustained, controlled bouncing to see who can keep the best rhythm the longest.

Players: 2-4 players

Materials: A backyard trampoline with a safety net if possible | A grown-up spotter | A stopwatch or phone timer

Follow the steps below to play!', NULL, N'Championship rules still mean one bouncer at a time, watched closely by a grown-up.', 65, N'sequence_steps', N'{"steps": ["Each player gets a 60-second turn to bounce with steady control.", "A judge counts how many clean, centered bounces each player completes.", "Deduct a point any time a player has to step off-center to catch balance.", "The highest clean bounce count wins the Trampoline Championship!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_6, N'short_response', N'🪢 Chinese Jump Rope Championship

90s Inspiration: The timed elastic jump rope relays that made for exciting 1990s recess competitions.

Objective: Practice completing a full pattern sequence as quickly and cleanly as possible.

Players: 3+ players

Materials: A long loop of Chinese jump rope elastic | 2 players to hold it | A stopwatch or phone timer

Follow the steps below to play!', NULL, N'A faster time never beats a clean run -- slow down if patterns start slipping.', 66, N'sequence_steps', N'{"steps": ["Agree on one full pattern sequence at ankle, knee, and waist height.", "Time each jumper completing the full three-height sequence.", "A missed jump means restarting that height''s pattern.", "The fastest clean run through all three heights wins the Championship!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_6, N'short_response', N'🎾 Wall Ball Championship

90s Inspiration: The elimination wall-ball matches that crowned 1990s playground champions.

Objective: Practice head-to-head rally rules where a missed catch or bad hit ends the point.

Players: 2 players

Materials: A soft, bouncy rubber ball | A flat outdoor wall | Chalk to mark boundary lines

Follow the steps below to play!', NULL, N'Play fair -- a point only counts if the ball hits the wall inside the marked lines.', 67, N'sequence_steps', N'{"steps": ["Mark a boundary area on the wall and ground with chalk.", "Players take turns hitting the ball against the wall inside the lines.", "A player loses the point if they miss the catch or hit outside the lines.", "First player to reach 7 points wins the Wall Ball Championship!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_6, N'short_response', N'⚾ Wiffle Ball Championship

90s Inspiration: The backyard wiffle ball leagues that some 1990s neighborhoods played all season long.

Objective: Practice full-game skills -- batting, pitching, and fielding -- across a scored championship game.

Players: Teams of 2+ (2 or more teams)

Materials: A wiffle ball | A plastic wiffle bat | Bases (towels or cones)

Follow the steps below to play!', NULL, N'Championship energy is still no reason to rush -- play each pitch and catch carefully.', 68, N'sequence_steps', N'{"steps": ["Play a full game of five innings between two teams.", "Track runs scored by each team every inning.", "Add up the total score after all five innings.", "The team with the most total runs is the Wiffle Ball Champion!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_6, N'short_response', N'🔢 Hopscotch Championship

90s Inspiration: The neighborhood hopscotch tournaments that crowned sidewalk champions throughout the 1990s.

Objective: Practice consistent, clean hopping across several timed and scored rounds.

Players: 2-4 players

Materials: Sidewalk chalk | A small beanbag or smooth stone (marker) | A stopwatch or phone timer

Follow the steps below to play!', NULL, N'Championship rounds still mean landing softly and stepping out calmly if you wobble.', 69, N'sequence_steps', N'{"steps": ["Play three full rounds of the numbered course with marker tosses.", "Time each round and note any line touches as a small penalty.", "Add up total time plus penalties for each player.", "The lowest combined score is the Hopscotch Champion!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_6, N'short_response', N'🦘 Hippity Hop Championship

90s Inspiration: The neighborhood hippity hop competitions that were a fun 1990s summer tradition.

Objective: Practice consistent racing across several timed heats to find the fastest bouncer.

Players: Teams of 2+ (2 or more teams)

Materials: A hippity hop ball per player | A soft grassy area | A stopwatch or phone timer

Follow the steps below to play!', NULL, N'Championship excitement is still no reason to rush past safe, controlled bouncing.', 70, N'sequence_steps', N'{"steps": ["Run three timed heats of the same course for each player.", "Record each player''s best time across the three heats.", "Compare best times among all players.", "The fastest best time wins the Hippity Hop Championship!"]}');

    DECLARE @cat_90s2_7 INT;
    SELECT @cat_90s2_7 = category_id FROM dbo.PacketCategories WHERE grade_id = 7 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_7, N'short_response', N'🌊 Slip ''N Slide Grand Splash Championship

90s Inspiration: The legendary end-of-summer Slip ''N Slide tournaments that neighborhood kids still remember from the 1990s.

Objective: Practice the ultimate combination of technique, distance, and teamwork in a full tournament.

Players: Teams of 2+ (2 or more teams)

Materials: A plastic backyard water slide | A hose | A tape measure | A stopwatch or phone timer

Follow the steps below to play!', NULL, N'Bigger tournament, same rule: only one slider on the mat at any time, always feet-first.', 64, N'sequence_steps', N'{"steps": ["Split into teams and run a bracket of individual best-distance slides.", "Total each team''s combined distance across all their players'' turns.", "Add a final relay round where every team member slides once for team points.", "The team with the highest combined score is the Grand Splash Champion!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_7, N'short_response', N'🤸 Trampoline Grand Masters

90s Inspiration: The showcase trampoline routines that the most practiced 1990s backyard bouncers loved to perform.

Objective: Practice combining several safe moves -- bounces, knee tucks, and quarter-turns -- into one smooth routine.

Players: 2-4 players

Materials: A backyard trampoline with a safety net if possible | A grown-up spotter | A stopwatch or phone timer

Follow the steps below to play!', NULL, N'Bigger routines still mean one performer at a time, with a grown-up watching the whole thing.', 65, N'sequence_steps', N'{"steps": ["Design a short routine combining regular bounces, a knee tuck, and a quarter-turn.", "Practice the routine slowly, one move at a time, until it feels smooth.", "Perform the full routine for friends or a grown-up judge.", "The smoothest, most controlled routine earns the Trampoline Grand Masters title!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_7, N'short_response', N'🪢 Chinese Jump Rope Grand Masters

90s Inspiration: The showcase Chinese jump rope routines that crowned true masters on 1990s playgrounds.

Objective: Practice combining ankle, knee, and waist patterns into one smooth performance routine.

Players: 3+ players

Materials: A long loop of Chinese jump rope elastic | 2 players to hold it

Follow the steps below to play!', NULL, N'A bigger routine still means resetting calmly, never forcing a jump that isn''t landing.', 66, N'sequence_steps', N'{"steps": ["Design a routine moving from ankle height, to knee height, to waist height.", "Practice each height''s pattern separately until it feels smooth.", "Link all three heights into one continuous routine.", "Perform it for friends or family to earn the Grand Masters title!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_7, N'short_response', N'🎾 Wall Ball Grand Champion

90s Inspiration: The full wall-ball tournaments that some 1990s neighborhoods played all summer long.

Objective: Practice competing through a small bracket of head-to-head wall-ball matches.

Players: Teams of 2+ (2 or more teams)

Materials: A soft, bouncy rubber ball | A flat outdoor wall | Chalk to mark boundary lines

Follow the steps below to play!', NULL, N'A bigger tournament means more players nearby -- always check the wall area is clear before you serve.', 67, N'sequence_steps', N'{"steps": ["Set up a small bracket with several players or pairs.", "Play short matches to 5 points using the standard wall-ball rules.", "Winners advance to the next round of the bracket.", "The player or pair left standing is the Wall Ball Grand Champion!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_7, N'short_response', N'⚾ Wiffle Ball Grand Championship

90s Inspiration: The end-of-summer backyard wiffle ball tournaments that were the highlight of many 1990s neighborhoods.

Objective: Practice competing across a multi-team mini tournament with several short games.

Players: Teams of 2+ (2 or more teams)

Materials: A wiffle ball | A plastic wiffle bat | Bases (towels or cones)

Follow the steps below to play!', NULL, N'More teams means more people around the field -- always check that fielders are ready before pitching.', 68, N'sequence_steps', N'{"steps": ["Split into three or more small teams for a round-robin of short games.", "Play each matchup for three innings, tracking wins for every team.", "After all matchups, total up which team has the most wins.", "The team with the most wins is crowned the Wiffle Ball Grand Champion!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_7, N'short_response', N'🔢 Hopscotch Grand Champion

90s Inspiration: The ultimate sidewalk hopscotch showdowns that some 1990s neighborhoods played all summer.

Objective: Practice the full combination of math hops, marker tosses, and timed speed in one grand event.

Players: 2-4 players

Materials: Sidewalk chalk | A small beanbag or smooth stone (marker) | A stopwatch or phone timer

Follow the steps below to play!', NULL, N'A grand event still means one hopper on the course at a time, hopping carefully throughout.', 69, N'sequence_steps', N'{"steps": ["Round 1: complete the timed 1-8 course cleanly.", "Round 2: complete a math-hop round with called-out sums.", "Round 3: complete a full marker-toss round from 1 to 8.", "Combine scores from all three rounds to crown the Hopscotch Grand Champion!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_90s2_7, N'short_response', N'🦘 Hippity Hop Grand Championship

90s Inspiration: The full hippity hop tournaments that some 1990s neighborhoods held as a season finale.

Objective: Practice the ultimate combination of racing and relay teamwork in a full bracket tournament.

Players: Teams of 2+ (2 or more teams)

Materials: A hippity hop ball per player | A soft grassy area | A stopwatch or phone timer

Follow the steps below to play!', NULL, N'A bigger tournament still means one bouncer per lane at a time, moving carefully throughout.', 70, N'sequence_steps', N'{"steps": ["Run an individual timed bracket, eliminating the slowest time each round.", "Once a champion racer is crowned, run one final team relay.", "Combine the individual champion''s title with the winning relay team''s title.", "Celebrate both champions at the Hippity Hop Grand Championship!"]}');

END
GO

DELETE FROM dbo.WeeklyPacketPlan;
GO
