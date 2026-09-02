-- 87_outdoor_games_retro70s_batch2.sql
-- Extends the existing 'Outdoor Games' category (see 68/69/70/71/82/83) with
-- 7 MORE games per grade (56 -> 63), a SECOND 1970s-retro batch: hula hoop
-- spinning, jump rope / Double Dutch, chalk hopscotch, tetherball, flying
-- disc (Frisbee), quad roller skating, and bean-bag toss. No branded or
-- copyrighted characters/names -- traditional public-domain activities and
-- toy TYPES only, scaled by grade. Distinct from the 83_ batch (pogo stick,
-- kite, water balloon toss, tricycle/banana-bike, Spud, early skateboarding,
-- Big Wheel) -- no repeated concepts.
--
-- Appends to the SAME per-grade PacketCategories row with sort_order
-- continuing from 57. See gen_87_outdoor_games_retro70s_batch2.py.

IF NOT EXISTS (
    SELECT 1 FROM dbo.PacketQuestions q
    JOIN dbo.PacketCategories c ON c.category_id = q.category_id
    WHERE c.category_name = 'Outdoor Games' AND c.grade_id = 0 AND q.sort_order = 57
)
BEGIN
    DECLARE @cat_70s2_0 INT;
    SELECT @cat_70s2_0 = category_id FROM dbo.PacketCategories WHERE grade_id = 0 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_0, N'short_response', N'⭕ Pretend Hula Hoop Wiggle

70s Inspiration: The hula hoop, a spinning backyard toy that stayed a favorite through the 1970s.

Objective: Practice standing inside a hoop and doing a gentle wiggle to get a feel for hooping.

Players: 1+ (solo or group)

Materials: 1 hula hoop

Follow the steps below to play!', NULL, N'Practice on soft grass, and always leave space between hoopers.', 57, N'sequence_steps', N'{"steps": ["Step inside the hula hoop and hold it against your back with both hands.", "Gently wiggle your hips from side to side.", "Let go and see if the hoop can spin just once around your waist.", "Catch it or pick it up and try again!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_0, N'short_response', N'🪢 Pretend Jump Rope Hop

70s Inspiration: The jump rope rhymes and games that bounced across 1970s sidewalks and driveways.

Objective: Practice hopping with both feet together, like getting ready for real rope jumping.

Players: 1+ (solo or group)

Materials: 1 jump rope (or none -- just pretend!)

Follow the steps below to play!', NULL, N'Hop on a flat, open surface, and keep hops small and controlled.', 58, N'sequence_steps', N'{"steps": ["Lay the jump rope flat on the ground in a straight line.", "Stand at one end with feet together.", "Hop gently over the rope from one side to the other.", "Turn around and hop back across again!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_0, N'short_response', N'🔢 Pretend Hopscotch Steps

70s Inspiration: The chalk hopscotch grids that covered nearly every 1970s sidewalk and driveway.

Objective: Practice walking through a simple chalk hopscotch grid one square at a time.

Players: 1+ (solo or group)

Materials: Sidewalk chalk

Follow the steps below to play!', NULL, N'Draw the grid on a flat, smooth surface away from steps or curbs.', 59, N'sequence_steps', N'{"steps": ["A grown-up draws 3 big squares in a row with chalk.", "Stand at the first square with both feet.", "Step carefully into each square, one at a time, all the way to the end.", "Turn around and step your way back!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_0, N'short_response', N'🎾 Pretend Tetherball Pat

70s Inspiration: The tetherball courts that were a fixture of 1970s playgrounds and backyards.

Objective: Practice gently patting a ball hanging from a rope to get a feel for tetherball.

Players: 1+ (solo or group)

Materials: A soft ball tied to a rope, hung from a low branch or post

Follow the steps below to play!', NULL, N'Use a soft, lightweight ball and always pat gently -- never hit hard.', 60, N'sequence_steps', N'{"steps": ["Stand facing the hanging ball with both hands ready.", "Gently pat the ball with one open hand.", "Watch it swing away and then pat it again as it comes back.", "Try patting it a few times in a row!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_0, N'short_response', N'🥏 Pretend Disc Roll

70s Inspiration: The flying disc craze that took off across 1970s parks and beaches.

Objective: Practice rolling a soft flying disc back and forth along the ground with a partner.

Players: 2 players

Materials: 1 soft flying disc

Follow the steps below to play!', NULL, N'Roll gently along the ground -- no throwing yet at this stage.', 61, N'sequence_steps', N'{"steps": ["Sit or kneel facing your partner a few steps apart.", "Gently roll the disc along the ground toward them like a wheel.", "Watch it roll and stop it with both hands when it arrives.", "Roll it back and forth a few times!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_0, N'short_response', N'🛼 Pretend Roller Skate Shuffle

70s Inspiration: The quad roller skating craze that rolled through 1970s driveways and roller rinks (different from the inline skates that came later).

Objective: Practice standing steady and shuffling small steps while holding a grown-up''s hand.

Players: 1+ (solo or group)

Materials: Quad roller skates (or just socks on a smooth, safe floor) | A grown-up spotter

Follow the steps below to play!', NULL, N'Always practice with a grown-up holding on, and wear a helmet if using real skates.', 62, N'sequence_steps', N'{"steps": ["Stand with your feet apart for balance, holding a grown-up''s hand.", "Take small, careful shuffle steps forward.", "Practice stopping by standing still and holding steady.", "Try a few more shuffle steps once you feel balanced!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_0, N'short_response', N'🎯 Pretend Bean Bag Drop

70s Inspiration: A safe backyard toss game, a favorite low-key activity at 1970s parties and picnics.

Objective: Practice dropping a bean bag gently into a nearby target, like a hoop or basket.

Players: 1+ (solo or group)

Materials: 1-2 bean bags | A hula hoop or basket as a target

Follow the steps below to play!', NULL, N'Start very close to the target, and always drop gently rather than throwing hard.', 63, N'sequence_steps', N'{"steps": ["Stand very close to the hoop or basket on the ground.", "Hold a bean bag with both hands.", "Gently drop it so it lands inside the target.", "Pick it up and try again from the same close spot!"]}');

    DECLARE @cat_70s2_1 INT;
    SELECT @cat_70s2_1 = category_id FROM dbo.PacketCategories WHERE grade_id = 1 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_1, N'short_response', N'⭕ Hula Hoop First Spins

70s Inspiration: The hula hoop craze that had kids spinning hoops in nearly every 1970s backyard.

Objective: Practice starting a hoop spin and keeping it going for a few turns.

Players: 1+ (solo or group)

Materials: 1 hula hoop

Follow the steps below to play!', NULL, N'Give yourself plenty of open space so the hoop doesn''t bump into anyone.', 57, N'sequence_steps', N'{"steps": ["Hold the hoop against your back at waist height with both hands.", "Give it a good spin to one side and let go.", "Move your hips in a circle to keep the hoop spinning.", "Count how many spins you get before it drops!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_1, N'short_response', N'🪢 Jump Rope First Turns

70s Inspiration: The classic jump rope skills every 1970s kid practiced on the driveway.

Objective: Practice turning your own rope slowly and hopping over it one time.

Players: 1+ (solo or group)

Materials: 1 jump rope sized for you

Follow the steps below to play!', NULL, N'Use a rope that''s the right length for your height so it swings smoothly.', 58, N'sequence_steps', N'{"steps": ["Hold a rope handle in each hand and stand with the rope behind your heels.", "Swing the rope slowly over your head and down in front of you.", "Hop over the rope with both feet as it reaches the ground.", "Try it again and see if you can do two turns in a row!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_1, N'short_response', N'🔢 Hopscotch First Hops

70s Inspiration: The classic hopscotch grids that filled 1970s neighborhoods, drawn fresh after every rain.

Objective: Practice hopping on one foot through single squares and landing with both feet on double squares.

Players: 1+ (solo or group)

Materials: Sidewalk chalk

Follow the steps below to play!', NULL, N'Slow down on the single-foot squares -- balance matters more than speed.', 59, N'sequence_steps', N'{"steps": ["Draw a simple hopscotch grid with a mix of single and side-by-side squares.", "Hop on one foot into each single square.", "Land with both feet when you reach side-by-side squares.", "Hop all the way to the end, then hop back!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_1, N'short_response', N'🎾 Tetherball First Hits

70s Inspiration: The rope-and-pole tetherball games that filled 1970s school playgrounds.

Objective: Practice hitting a hanging ball with an open hand to send it around the pole.

Players: 2 players

Materials: A tetherball set, or a soft ball tied to a rope on a low pole or post

Follow the steps below to play!', NULL, N'Hit with an open, flat hand -- never a fist -- and keep hits soft.', 60, N'sequence_steps', N'{"steps": ["Stand on opposite sides of the pole from your partner.", "Take turns gently hitting the ball with an open hand.", "Watch the rope wind around the pole a little more each hit.", "See how many gentle hits it takes to wind the rope all the way up!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_1, N'short_response', N'🥏 Flying Disc First Throws

70s Inspiration: The backyard disc tossing that became a 1970s park and beach favorite.

Objective: Practice a simple two-handed underhand toss and catch with a partner.

Players: 2 players

Materials: 1 soft flying disc

Follow the steps below to play!', NULL, N'Keep tosses low, gentle, and aimed away from faces.', 61, N'sequence_steps', N'{"steps": ["Stand facing your partner just a few steps apart.", "Hold the disc flat with both hands and give it a gentle underhand push.", "Watch it glide and try to catch it with both hands.", "Toss it back and forth a few times!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_1, N'short_response', N'🛼 Roller Skate First Steps

70s Inspiration: The quad skates that rolled kids up and down 1970s driveways and sidewalks.

Objective: Practice rolling a few steps forward on quad skates with a grown-up nearby.

Players: 1+ (solo or group)

Materials: Quad roller skates | A helmet | A grown-up spotter

Follow the steps below to play!', NULL, N'Always wear a helmet, and practice on a flat, smooth surface only.', 62, N'sequence_steps', N'{"steps": ["Put on your skates and stand still first, finding your balance.", "With a grown-up nearby, take a few small, slow rolling steps forward.", "Keep your knees slightly bent and arms out for balance.", "Practice a gentle stop by dragging your toe or stepping onto grass!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_1, N'short_response', N'🎯 Bean Bag Toss First Tries

70s Inspiration: The gentle beanbag toss games families played at 1970s backyard get-togethers.

Objective: Practice a simple underhand toss aimed at a nearby target.

Players: 1+ (solo or group)

Materials: 2-3 bean bags | A hula hoop or bucket as a target

Follow the steps below to play!', NULL, N'Toss underhand and easy -- accuracy comes from a smooth, gentle motion.', 63, N'sequence_steps', N'{"steps": ["Stand a few steps back from the target.", "Hold a bean bag and toss it gently underhand toward it.", "Count how many out of 3 tosses land inside.", "Try again and see if you can improve your score!"]}');

    DECLARE @cat_70s2_2 INT;
    SELECT @cat_70s2_2 = category_id FROM dbo.PacketCategories WHERE grade_id = 2 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_2, N'short_response', N'⭕ Hula Hoop Warm-Up

70s Inspiration: The hula hoop, still one of the most popular spinning toys of the 1970s.

Objective: Practice keeping a hula hoop spinning steadily for a short streak.

Players: 1+ (solo or group)

Materials: 1 hula hoop

Follow the steps below to play!', NULL, N'Keep knees soft and bent slightly -- it makes spinning easier and safer.', 57, N'sequence_steps', N'{"steps": ["Start the hoop spinning around your waist with a good push.", "Keep your hips moving in a smooth circle, not side to side.", "Try to reach 5 spins in a row without the hoop dropping.", "Reset and try again, aiming to beat your count!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_2, N'short_response', N'🪢 Jump Rope Warm-Up

70s Inspiration: The rhythmic jump rope skipping that filled 1970s sidewalks after school.

Objective: Practice a steady rhythm of turning and hopping in a row.

Players: 1+ (solo or group)

Materials: 1 jump rope sized for you

Follow the steps below to play!', NULL, N'Keep a little bend in your knees to land softly each time.', 58, N'sequence_steps', N'{"steps": ["Get into a steady rhythm: turn the rope, hop, turn, hop.", "Keep your hops small and close to the ground.", "Try for 5 jumps in a row without stopping.", "Shake out your arms and try again!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_2, N'short_response', N'🔢 Hopscotch Warm-Up

70s Inspiration: The numbered hopscotch grids drawn on nearly every 1970s driveway and sidewalk.

Objective: Practice a full hopscotch grid with a smooth up-and-back pattern.

Players: 1+ (solo or group)

Materials: Sidewalk chalk

Follow the steps below to play!', NULL, N'Keep your arms out for balance, especially when turning around.', 59, N'sequence_steps', N'{"steps": ["Draw a numbered hopscotch grid from 1 to 6.", "Hop through the numbers in order, one foot on singles, both feet on doubles.", "At the end, turn around carefully and hop back through in reverse order.", "Try it again, aiming for smoother turns!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_2, N'short_response', N'🎾 Tetherball Warm-Up

70s Inspiration: The steady rally style of tetherball that made it a 1970s recess favorite.

Objective: Practice steady back-and-forth hitting to keep the ball moving smoothly around the pole.

Players: 2 players

Materials: A tetherball set, or a soft ball tied to a rope on a low pole or post

Follow the steps below to play!', NULL, N'Keep a little space from the pole so the rope doesn''t tangle your arm.', 60, N'sequence_steps', N'{"steps": ["Stand across from your partner with the pole between you.", "Hit the ball gently so it circles the pole toward your partner.", "Your partner hits it back the other direction.", "Keep the rally going as long as you can!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_2, N'short_response', N'🥏 Flying Disc Warm-Up

70s Inspiration: The sidearm disc-tossing style that spread through 1970s parks and campuses.

Objective: Practice a one-handed sidearm toss and catch, stepping back after each success.

Players: 2 players

Materials: 1 soft flying disc

Follow the steps below to play!', NULL, N'A gentle wrist flick works better than a hard arm throw -- and it''s safer too.', 61, N'sequence_steps', N'{"steps": ["Hold the disc with one hand, thumb on top and fingers underneath.", "Flick your wrist gently to send it sideways toward your partner.", "Catch it with two hands cupped together.", "After each catch, both partners take one small step back!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_2, N'short_response', N'🛼 Roller Skate Warm-Up

70s Inspiration: The quad roller skates that rolled up and down 1970s driveways all summer long.

Objective: Practice rolling steadily in a straight line without holding on.

Players: 1+ (solo or group)

Materials: Quad roller skates | A helmet | Knee and elbow pads

Follow the steps below to play!', NULL, N'Wear a helmet plus knee and elbow pads, and skate on a flat, open surface.', 62, N'sequence_steps', N'{"steps": ["Push off gently with one foot and glide forward on both skates.", "Keep your knees bent and eyes looking ahead, not down.", "Roll in a straight line for a short distance.", "Practice stopping gently, then try rolling again!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_2, N'short_response', N'🎯 Bean Bag Toss Warm-Up

70s Inspiration: The easygoing beanbag toss games that livened up 1970s backyard gatherings.

Objective: Practice tossing at increasing distances while keeping accuracy steady.

Players: 1+ (solo or group)

Materials: 2-3 bean bags | A hula hoop or bucket as a target

Follow the steps below to play!', NULL, N'A slow, arcing toss lands more accurately than a fast, flat one.', 63, N'sequence_steps', N'{"steps": ["Start close to the target and toss all your bean bags.", "If most land inside, take one step back.", "Keep tossing and stepping back after each successful round.", "See how far back you can go while still landing inside!"]}');

    DECLARE @cat_70s2_3 INT;
    SELECT @cat_70s2_3 = category_id FROM dbo.PacketCategories WHERE grade_id = 3 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_3, N'short_response', N'⭕ Hula Hoop Challenge

70s Inspiration: The hula hoop spinning contests that popped up at 1970s playgrounds and pool parties.

Objective: Practice sustaining a longer hoop-spinning streak and tracking your best count.

Players: 1+ (solo or group)

Materials: 1 hula hoop

Follow the steps below to play!', NULL, N'If you feel dizzy, stop and rest before spinning again.', 57, N'sequence_steps', N'{"steps": ["Start your spin with steady hip circles.", "Count each spin out loud as you go.", "See how many spins you can reach before the hoop falls.", "Try again and aim to beat your personal best!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_3, N'short_response', N'🪢 Jump Rope Challenge

70s Inspiration: The jump rope streak contests that were a lunchtime tradition on 1970s playgrounds.

Objective: Practice building a longer consecutive jump streak and tracking your progress.

Players: 1+ (solo or group)

Materials: 1 jump rope sized for you

Follow the steps below to play!', NULL, N'Jump on grass or a soft surface to cushion each landing.', 58, N'sequence_steps', N'{"steps": ["Start jumping at a steady, comfortable pace.", "Count each jump out loud as you go.", "Keep going until you miss, then note your count.", "Try again and see if you can beat your best streak!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_3, N'short_response', N'🔢 Hopscotch Challenge

70s Inspiration: The classic marker-toss hopscotch rules that 1970s kids passed down block by block.

Objective: Practice tossing a marker into a numbered square and hopping around it cleanly.

Players: 2-4 players

Materials: Sidewalk chalk | A small beanbag or soft marker

Follow the steps below to play!', NULL, N'Toss the marker gently and underhand so it lands flat, not skidding.', 59, N'sequence_steps', N'{"steps": ["Toss your marker gently onto square 1.", "Hop through the grid, skipping the square with your marker.", "Pick up your marker on the way back without losing balance.", "Take turns, and try square 2 next!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_3, N'short_response', N'🎾 Tetherball Challenge

70s Inspiration: The competitive wind-up rallies that made tetherball a top 1970s playground game.

Objective: Practice controlled hitting to try to wind the rope fully to your side.

Players: 2 players

Materials: A tetherball set, or a soft ball tied to a rope on a low pole or post

Follow the steps below to play!', NULL, N'Watch the rope length, not just the ball, so you don''t get tangled.', 60, N'sequence_steps', N'{"steps": ["Start with the rope at a medium length hanging freely.", "Take turns hitting the ball in your own direction.", "Try to wind the rope all the way to the top on your side.", "Whoever winds it fully first wins that round!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_3, N'short_response', N'🥏 Flying Disc Challenge

70s Inspiration: The accuracy-focused disc games that 1970s park-goers played for hours at a time.

Objective: Practice consistent accuracy, aiming the disc right to your partner''s hands.

Players: 2 players

Materials: 1 soft flying disc

Follow the steps below to play!', NULL, N'Slow, aimed throws are more accurate than fast, hard ones.', 61, N'sequence_steps', N'{"steps": ["Stand a comfortable distance from your partner.", "Aim each throw carefully at chest height.", "Count how many catches in a row your pair can make.", "Try again and see if you can beat your best streak!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_3, N'short_response', N'🛼 Roller Skate Challenge

70s Inspiration: The quad-skate steering skills every 1970s driveway skater eventually practiced.

Objective: Practice steering gentle curves while keeping a steady, controlled roll.

Players: 1+ (solo or group)

Materials: Quad roller skates | A helmet | Knee and elbow pads | Chalk or cones to mark a path

Follow the steps below to play!', NULL, N'Always wear full safety gear, and go slowly enough to stay in control.', 62, N'sequence_steps', N'{"steps": ["Draw or mark a gently curving path with chalk or cones.", "Roll along the path, leaning slightly to steer through the curves.", "Keep your speed slow and controlled the whole way.", "Try the path again, aiming for a smoother curve!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_3, N'short_response', N'🎯 Bean Bag Toss Challenge

70s Inspiration: The point-scoring beanbag toss games that were a 1970s backyard party staple.

Objective: Practice scoring points by tossing bean bags into targets of different sizes.

Players: 2-4 players

Materials: 3-4 bean bags per player | 2 targets of different sizes (like a small bucket and a large hoop)

Follow the steps below to play!', NULL, N'Toss gently and take your time lining up each shot.', 63, N'sequence_steps', N'{"steps": ["Set up a small target worth more points and a larger target worth fewer.", "Take turns tossing your bean bags, aiming for either target.", "Add up your points after each player''s turn.", "Play a few rounds and see who scores the most!"]}');

    DECLARE @cat_70s2_4 INT;
    SELECT @cat_70s2_4 = category_id FROM dbo.PacketCategories WHERE grade_id = 4 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_4, N'short_response', N'⭕ Hula Hoop Count Challenge

70s Inspiration: The timed hula hoop contests that measured who could out-spin the neighborhood in the 1970s.

Objective: Practice timing your hoop spins with a stopwatch to measure steady endurance.

Players: 2 players

Materials: 1 hula hoop | A stopwatch or phone timer

Follow the steps below to play!', NULL, N'Choose an open, flat spot so nobody trips while watching the clock.', 57, N'sequence_steps', N'{"steps": ["One player spins the hoop while a partner starts the timer.", "Keep the hoop spinning as long as you can without touching it.", "The partner stops the timer the moment the hoop drops.", "Switch roles and compare your times!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_4, N'short_response', N'🪢 Jump Rope Speed Challenge

70s Inspiration: The speed-jumping contests that turned simple jump rope into a 1970s playground event.

Objective: Practice jumping as many times as possible within a set time limit.

Players: 2 players

Materials: 1 jump rope sized for you | A stopwatch or phone timer

Follow the steps below to play!', NULL, N'Pace yourself -- steady jumping beats rushing and tripping.', 58, N'sequence_steps', N'{"steps": ["A partner sets a timer for 30 seconds.", "Jump as many times as you can before time runs out.", "Your partner counts your jumps out loud.", "Switch roles, then compare your jump counts!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_4, N'short_response', N'🔢 Hopscotch Toss Challenge

70s Inspiration: The full-grid hopscotch tournaments that 1970s kids ran up and down the block.

Objective: Practice increasing toss accuracy as you work your way through every numbered square.

Players: 2-4 players

Materials: Sidewalk chalk | A small beanbag or soft marker

Follow the steps below to play!', NULL, N'If your marker lands on a line, that''s a gentle miss -- just wait for your next turn.', 59, N'sequence_steps', N'{"steps": ["Start at square 1 and toss your marker onto it.", "Hop the full grid, skipping the marker''s square each time.", "If you succeed, move on and aim for the next higher number.", "Whoever reaches the highest number first wins the round!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_4, N'short_response', N'🎾 Tetherball Wrap Challenge

70s Inspiration: The wrap-counting tetherball matches that decided many a 1970s recess champion.

Objective: Practice counting rope wraps to track how close each player is to winning.

Players: 2 players

Materials: A tetherball set, or a soft ball tied to a rope on a low pole or post

Follow the steps below to play!', NULL, N'Blocking means hitting the ball, not your partner''s hand -- always give space.', 60, N'sequence_steps', N'{"steps": ["Agree on a target number of wraps needed to win (start with 5).", "Take turns hitting the ball, counting each wrap out loud.", "Try to block your partner''s direction gently with your own hits.", "First to reach the target number of wraps wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_4, N'short_response', N'🥏 Flying Disc Distance Challenge

70s Inspiration: The distance-throwing contests that flying disc fans loved at 1970s parks and beaches.

Objective: Practice throwing farther while keeping the disc catchable, tracking your pair''s best distance.

Players: 2 players

Materials: 1 soft flying disc | Chalk or cones to mark distance

Follow the steps below to play!', NULL, N'A smooth, flat release flies farther and truer than a rushed one.', 61, N'sequence_steps', N'{"steps": ["Start close together and toss gently, catching each time.", "After every successful catch, both partners step back one more step.", "Mark your distance with chalk or a cone each time you step back.", "See how far apart your pair can get before a toss is missed!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_4, N'short_response', N'🛼 Roller Skate Obstacle Challenge

70s Inspiration: The cone-weaving skate courses that quad-skate fans built in 1970s driveways.

Objective: Practice weaving carefully around a few cones while rolling steadily.

Players: 1+ (solo or group)

Materials: Quad roller skates | A helmet | Knee and elbow pads | 3-4 cones

Follow the steps below to play!', NULL, N'Slow down through every turn -- control matters more than speed here.', 62, N'sequence_steps', N'{"steps": ["Set up 3-4 cones spaced out in a simple line.", "Roll slowly, steering around each cone one at a time.", "Focus on smooth, small turns rather than speed.", "Try the course again, aiming to touch zero cones!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_4, N'short_response', N'🎯 Bean Bag Toss Distance Challenge

70s Inspiration: The long-distance beanbag toss contests that capped off many 1970s summer picnics.

Objective: Practice hitting a target from the farthest distance yet while keeping form consistent.

Players: 2-4 players

Materials: 3-4 bean bags per player | 1 target | Chalk or cones to mark distance lines

Follow the steps below to play!', NULL, N'Keep the same smooth underhand motion no matter the distance -- don''t rush the throw.', 63, N'sequence_steps', N'{"steps": ["Mark several toss lines at increasing distances from the target with chalk.", "Start at the closest line and try to land a bean bag inside.", "If you succeed, move back to the next line.", "Whoever reaches the farthest line with a successful toss wins!"]}');

    DECLARE @cat_70s2_5 INT;
    SELECT @cat_70s2_5 = category_id FROM dbo.PacketCategories WHERE grade_id = 5 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_5, N'short_response', N'⭕ Hula Hoop Trick Practice

70s Inspiration: The trick-hooping moves that advanced hula hoop fans showed off in the 1970s.

Objective: Practice a beginner hoop trick, like moving the hoop from your waist down to your knees.

Players: 1+ (solo or group)

Materials: 1 hula hoop

Follow the steps below to play!', NULL, N'Practice on a soft, flat surface in case you lose balance while bending.', 57, N'sequence_steps', N'{"steps": ["Get a steady waist spin going first.", "Slowly bend your knees to let the hoop slide down toward them.", "Try to keep it spinning at knee level for a few turns.", "Straighten back up and bring the spin back to your waist!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_5, N'short_response', N'🪢 Double Dutch Practice

70s Inspiration: The Double Dutch jump rope style that turned sidewalks into stages across the 1970s.

Objective: Practice jumping through two ropes turned by friends, the classic Double Dutch skill.

Players: 3+ players

Materials: 2 long jump ropes

Follow the steps below to play!', NULL, N'Start with slow, gentle turns until timing feels comfortable.', 58, N'sequence_steps', N'{"steps": ["Two players turn the ropes in opposite, alternating circles.", "Watch the ropes and time your entry, jumping in as they cross near the ground.", "Hop steadily in the middle, lifting your feet for each rope.", "Jump back out safely, then switch places with a turner!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_5, N'short_response', N'🔢 Hopscotch Trick Practice

70s Inspiration: The balance-trick flourishes that skilled 1970s hopscotch players added to the classic game.

Objective: Practice adding balance tricks, like a slow spin, on the turnaround square.

Players: 2-4 players

Materials: Sidewalk chalk | A small beanbag or soft marker

Follow the steps below to play!', NULL, N'Only attempt the turn once your balance on one foot feels steady.', 59, N'sequence_steps', N'{"steps": ["Hop through the grid as usual, tossing your marker each round.", "On the very last square, balance on one foot and do a slow, careful half-turn.", "Hop back through the grid the way you came.", "Try it again, aiming for a wobble-free turn!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_5, N'short_response', N'🎾 Tetherball Trick Practice

70s Inspiration: The switch-hand tricks that skilled 1970s tetherball players used to keep opponents guessing.

Objective: Practice hitting with your non-dominant hand to build more well-rounded control.

Players: 2 players

Materials: A tetherball set, or a soft ball tied to a rope on a low pole or post

Follow the steps below to play!', NULL, N'Trying your weaker hand is about control, not power -- keep every hit gentle.', 60, N'sequence_steps', N'{"steps": ["Play a normal rally using only your dominant hand for a few hits.", "Switch to hitting only with your other hand for the next few.", "Notice which hand gives you more control over direction.", "Play a full round using both hands as needed!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_5, N'short_response', N'🥏 Flying Disc Trick Catch Practice

70s Inspiration: The showy trick catches that flying disc enthusiasts perfected throughout the 1970s.

Objective: Practice a fun trick catch, like catching behind your back or between your legs, off a gentle toss.

Players: 2 players

Materials: 1 soft flying disc

Follow the steps below to play!', NULL, N'Only attempt trick catches on slow, easy tosses aimed right at you.', 61, N'sequence_steps', N'{"steps": ["Warm up with a few normal catches first.", "Ask your partner for a slow, gentle toss right to you.", "Try a trick catch, like reaching behind your back or between your legs.", "Switch roles so your partner can try a trick catch too!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_5, N'short_response', N'🛼 Roller Skate Trick Practice

70s Inspiration: The showy quad-skate moves that confident skaters practiced at 1970s roller rinks.

Objective: Practice a simple trick, like skating backward a few steps or a gentle one-foot glide.

Players: 1+ (solo or group)

Materials: Quad roller skates | A helmet | Knee and elbow pads

Follow the steps below to play!', NULL, N'Only try new tricks on a flat surface with a grown-up watching.', 62, N'sequence_steps', N'{"steps": ["Warm up by rolling forward steadily first.", "Try shifting your weight to glide on one foot for a moment.", "Or, with a grown-up nearby, try a few slow steps rolling backward.", "Practice a few times, always staying in control!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_5, N'short_response', N'🎯 Bean Bag Toss Trick Practice

70s Inspiration: The playful toss variations that kept 1970s beanbag games fresh at long family gatherings.

Objective: Practice tossing with your non-dominant hand or with your eyes briefly closed for extra challenge.

Players: 2-4 players

Materials: 3-4 bean bags per player | 1-2 targets

Follow the steps below to play!', NULL, N'Trick tosses are for fun and challenge -- keep every throw soft and gentle.', 63, N'sequence_steps', N'{"steps": ["Toss a few rounds normally to warm up.", "Try tossing a few bean bags with your other hand.", "For an extra challenge, try one toss with your eyes closed just before releasing.", "Compare which method felt more accurate for you!"]}');

    DECLARE @cat_70s2_6 INT;
    SELECT @cat_70s2_6 = category_id FROM dbo.PacketCategories WHERE grade_id = 6 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_6, N'short_response', N'⭕ Hula Hoop Championship

70s Inspiration: A championship-format version of the classic 1970s hula hoop spinning contest.

Objective: Practice peak spinning endurance in a friendly group timed competition.

Players: Whole group (6+)

Materials: A hula hoop for each player | A stopwatch or phone timer

Follow the steps below to play!', NULL, N'Space everyone out well so hoops and arms don''t collide.', 57, N'sequence_steps', N'{"steps": ["Everyone starts spinning their hoop at the same signal.", "Keep spinning as long as possible without touching the hoop.", "Sit or step out quietly the moment your hoop drops.", "Whoever keeps their hoop spinning longest is the Hula Hoop Champion!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_6, N'short_response', N'🪢 Jump Rope Championship

70s Inspiration: A championship-format version of the jump rope and Double Dutch contests popular in the 1970s.

Objective: Practice peak jumping consistency across a friendly group relay or streak contest.

Players: Whole group (6+)

Materials: Several jump ropes | 2 long ropes for Double Dutch | A stopwatch or phone timer

Follow the steps below to play!', NULL, N'Rotate turning duties often so every player''s arms get a rest.', 58, N'sequence_steps', N'{"steps": ["Split into small teams and choose either a solo streak contest or a Double Dutch relay.", "Each player takes a timed turn while teammates count or turn the ropes.", "Add up each team''s best combined jump counts.", "The team with the highest total is the Jump Rope Champion!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_6, N'short_response', N'🔢 Hopscotch Championship

70s Inspiration: A championship-format version of the classic chalk hopscotch tournaments of the 1970s.

Objective: Practice consistent accuracy across a full multi-round hopscotch tournament.

Players: 2-4 players

Materials: Sidewalk chalk | A small beanbag or soft marker

Follow the steps below to play!', NULL, N'Cheer for good tosses and steady hops -- friendly competition stays kind.', 59, N'sequence_steps', N'{"steps": ["Play a full round-robin, with everyone tossing and hopping through all numbers in order.", "Track how many rounds each player completes without a miss.", "A miss (stepping on a line or losing balance) means waiting for your next turn.", "Whoever completes the most clean rounds is the Hopscotch Champion!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_6, N'short_response', N'🎾 Tetherball Championship

70s Inspiration: A championship-format version of the classic 1970s tetherball tournament.

Objective: Practice peak accuracy and strategy across a full multi-round tournament.

Players: Whole group (6+)

Materials: A tetherball set, or a soft ball tied to a rope on a low pole or post

Follow the steps below to play!', NULL, N'Even in a championship, every hit stays open-handed and gentle.', 60, N'sequence_steps', N'{"steps": ["Set up a bracket where players take turns facing off in pairs.", "Each match is won by wrapping the rope fully to one side.", "Winners move on to face the next challenger.", "The player who wins the most matches is the Tetherball Champion!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_6, N'short_response', N'🥏 Flying Disc Championship

70s Inspiration: A championship-format version of the flying disc games that took over 1970s parks.

Objective: Practice peak accuracy and distance across a friendly group tournament.

Players: Whole group (6+)

Materials: 1 soft flying disc per pair | Chalk or cones to mark distance

Follow the steps below to play!', NULL, N'Give every pair plenty of open space so throwing lanes don''t cross.', 61, N'sequence_steps', N'{"steps": ["Split into pairs and each find their own throwing lane.", "Every pair tosses and steps back after each successful catch, just like the distance challenge.", "Track each pair''s farthest successful distance.", "The pair with the longest successful distance is the Flying Disc Champion!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_6, N'short_response', N'🛼 Roller Skate Championship

70s Inspiration: A championship-format version of the quad-skate obstacle courses popular at 1970s rinks.

Objective: Practice peak control across a full timed obstacle course competition.

Players: Whole group (6+)

Materials: Quad roller skates | Helmets | Knee and elbow pads | Cones | A stopwatch or phone timer

Follow the steps below to play!', NULL, N'Full safety gear for everyone, every time -- champions skate safe first.', 62, N'sequence_steps', N'{"steps": ["Set up a full cone course combining a curve section and a weave section.", "Each skater takes a timed turn through the whole course.", "Add a small time penalty for each cone that''s touched.", "The skater with the best combined time and control wins the championship!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_6, N'short_response', N'🎯 Bean Bag Toss Championship

70s Inspiration: A championship-format version of the classic 1970s backyard beanbag toss.

Objective: Practice peak scoring accuracy across a full multi-round tournament.

Players: 2-4 players

Materials: 3-4 bean bags per player | Multiple targets worth different points

Follow the steps below to play!', NULL, N'Even in a championship, every toss stays a gentle, controlled underhand throw.', 63, N'sequence_steps', N'{"steps": ["Set up several targets worth different point values.", "Each player gets the same number of tosses per round.", "Add up total points across 3-5 rounds.", "The player with the highest total score is the Bean Bag Toss Champion!"]}');

    DECLARE @cat_70s2_7 INT;
    SELECT @cat_70s2_7 = category_id FROM dbo.PacketCategories WHERE grade_id = 7 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_7, N'short_response', N'⭕ Hula Hoop Masters

70s Inspiration: The most advanced hula hoop showcases from the height of the 1970s hooping craze.

Objective: Practice combining a steady spin with a simple trick for the ultimate hooping showcase.

Players: Whole group (6+)

Materials: A hula hoop for each player | A stopwatch or phone timer

Follow the steps below to play!', NULL, N'Master tricks slowly and only after your basic spin feels steady and controlled.', 57, N'sequence_steps', N'{"steps": ["Start your spin and hold a steady waist streak for at least 10 spins.", "Add one trick, like sliding the hoop to your knees and back up.", "A helper times your total spin before the hoop drops.", "The longest total time including a successful trick wins Hula Hoop Masters!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_7, N'short_response', N'🪢 Jump Rope Masters

70s Inspiration: The most advanced jump rope and Double Dutch showcases from 1970s sidewalks.

Objective: Practice combining speed jumping with a Double Dutch entry for the ultimate rope-skills showcase.

Players: 3+ players

Materials: 1 jump rope | 2 long ropes for Double Dutch | A stopwatch or phone timer

Follow the steps below to play!', NULL, N'Only attempt Double Dutch once your solo jumping feels steady and confident.', 58, N'sequence_steps', N'{"steps": ["Start with a timed solo speed-jump streak.", "Then attempt a clean Double Dutch entry and a few steady jumps inside.", "Combine your speed count and Double Dutch success for a total score.", "The best combined score earns the Jump Rope Master title!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_7, N'short_response', N'🔢 Hopscotch Masters

70s Inspiration: The most advanced hopscotch showcases perfected by dedicated 1970s sidewalk players.

Objective: Practice the toughest hopscotch combination: full grid accuracy plus a balance trick, for the top score.

Players: 2-4 players

Materials: Sidewalk chalk | A small beanbag or soft marker

Follow the steps below to play!', NULL, N'Precision beats speed -- a slow, clean hop is worth more than a rushed one.', 59, N'sequence_steps', N'{"steps": ["Complete a full clean round through every numbered square.", "Add the one-foot turn trick on the final square without wobbling.", "Score one point for a clean grid and one bonus point for a clean turn.", "The player with the most points after several rounds is the Hopscotch Master!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_7, N'short_response', N'🎾 Tetherball Masters

70s Inspiration: The most advanced tetherball rallies played by the sharpest 1970s playground champions.

Objective: Practice the most advanced tetherball skills: quick direction changes and controlled blocking.

Players: 2 players

Materials: A tetherball set, or a soft ball tied to a rope on a low pole or post

Follow the steps below to play!', NULL, N'Master-level play is still about control and safety, never speed or force.', 60, N'sequence_steps', N'{"steps": ["Rally steadily, watching your partner''s hand position to predict their next hit.", "Practice changing the ball''s direction smoothly without losing control.", "Use gentle, well-timed blocks to slow your partner''s wraps.", "Whoever wins the most rounds out of five earns the Tetherball Master title!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_7, N'short_response', N'🥏 Flying Disc Masters

70s Inspiration: The most advanced flying disc showcases from dedicated 1970s disc enthusiasts.

Objective: Practice combining distance, accuracy, and a trick catch for the ultimate disc showcase.

Players: 2 players

Materials: 1 soft flying disc | Chalk or cones to mark distance

Follow the steps below to play!', NULL, N'Mastery means control at any distance -- keep every throw smooth and aimed.', 61, N'sequence_steps', N'{"steps": ["Build up distance together, stepping back after each clean catch.", "Once you reach your best distance, attempt one trick catch to finish strong.", "Score points for both your total distance and a successful trick catch.", "The pair with the highest combined score earns the Flying Disc Master title!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_7, N'short_response', N'🛼 Roller Skate Masters

70s Inspiration: The most advanced quad-skate showcases from the peak of the 1970s roller skating craze.

Objective: Practice the most advanced combination of speed, steering, and a simple trick.

Players: Whole group (6+)

Materials: Quad roller skates | Helmets | Knee and elbow pads | Cones | A stopwatch or phone timer

Follow the steps below to play!', NULL, N'Mastery is steady control at speed -- never skate faster than you can safely stop.', 62, N'sequence_steps', N'{"steps": ["Roll the full obstacle course as smoothly and quickly as safely possible.", "At the finish, add one practiced trick, like a one-foot glide.", "Combine your course time and trick success for a total score.", "The best combined score earns the Roller Skate Master title!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_70s2_7, N'short_response', N'🎯 Bean Bag Toss Masters

70s Inspiration: The most advanced beanbag toss showcases from long, competitive 1970s family gatherings.

Objective: Practice the toughest combination yet: long distance, small targets, and consistent scoring.

Players: 2-4 players

Materials: 3-4 bean bags per player | Small targets set at a long distance | Chalk or cones to mark distance

Follow the steps below to play!', NULL, N'Mastery is calm, repeatable technique -- the same gentle toss, every single time.', 63, N'sequence_steps', N'{"steps": ["Set targets at the farthest distance used yet, with smaller targets worth more points.", "Each player tosses a full round, tallying points as they go.", "Play multiple rounds, keeping a running total for each player.", "The player with the highest total after all rounds earns the Bean Bag Toss Master title!"]}');

END
GO

DELETE FROM dbo.WeeklyPacketPlan;
GO
