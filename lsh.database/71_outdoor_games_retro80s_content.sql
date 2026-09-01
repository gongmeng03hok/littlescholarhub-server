-- 71_outdoor_games_retro80s_content.sql
-- Extends the existing 'Outdoor Games' category (see 68/69/70) with 7 more
-- games per grade (28 -> 35), each inspired by a classic, traditional 1980s
-- playground game mechanic (hopscotch, kick the can, four square, jump rope/
-- double dutch, wall ball, jacks, chalk pavement games) — no branded or
-- copyrighted games/songs, just the traditional public-domain mechanics.
--
-- New vs. 68/69/70: each game's prompt now also includes an '80s
-- Inspiration' line (parsed by the admin API the same way as Objective/
-- Materials — see routes/content.py's outdoor_games_library()).
--
-- Appends to the SAME per-grade PacketCategories row with sort_order
-- continuing from 29. target_count stays at 7.
-- See gen_71_outdoor_games_retro80s_content.py.

IF NOT EXISTS (
    SELECT 1 FROM dbo.PacketQuestions q
    JOIN dbo.PacketCategories c ON c.category_id = q.category_id
    WHERE c.category_name = 'Outdoor Games' AND c.grade_id = 0 AND q.sort_order = 29
)
BEGIN
    DECLARE @cat_80s_0 INT;
    SELECT @cat_80s_0 = category_id FROM dbo.PacketCategories WHERE grade_id = 0 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_0, N'short_response', N'🦶 Toe-Tap Hopscotch

80s Inspiration: A simplified version of the classic hopscotch grid kids have chalked onto sidewalks for generations.

Objective: Practice hopping and balance on a simple 4-square chalk hopscotch course.

Materials: Playground chalk

Follow the steps below to play!', NULL, N'Hop carefully to keep your balance — it''s not a race.', 29, N'sequence_steps', N'{"steps": ["Draw 4 big squares in a row with chalk, numbered 1 to 4.", "Hop into square 1 on one foot, then square 2, and so on.", "Hop all the way to 4, then turn around and hop back.", "Try again, hopping a little faster each time!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_0, N'short_response', N'🥊 Freeze Tag Throwback

80s Inspiration: A classic schoolyard tag variant that''s been played on playgrounds for decades.

Objective: Practice quick running and freezing completely still when tagged, just like retro playground tag.

Materials: None — just open space!

Follow the steps below to play!', NULL, N'Tag gently with an open hand, and freeze safely wherever you are.', 30, N'sequence_steps', N'{"steps": ["One player is ''It'' and gently tags others.", "Tagged players freeze in place like a statue.", "Un-frozen players can tag a frozen friend to set them free.", "Play until everyone is frozen, then pick a new ''It''!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_0, N'short_response', N'🪢 Big Rope Jump-In

80s Inspiration: A gentle version of the long jump-rope games where two turners swing a rope for others to jump in.

Objective: Practice timing and jumping by hopping into a gently-swinging long rope.

Materials: 1 long jump rope

Follow the steps below to play!', NULL, N'Turners should swing slowly and low to the ground for little jumpers.', 31, N'sequence_steps', N'{"steps": ["Two grown-ups or big kids hold each end of a long rope and swing it low and slow along the ground.", "Watch the rope swing back and forth.", "Time your jump to hop over the rope as it swings near your feet.", "Take turns jumping in!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_0, N'short_response', N'🧮 Bean Bag Toss Classic

80s Inspiration: A simple version of the beanbag toss games common on 1980s playgrounds and school fairs.

Objective: Practice tossing and aiming beanbags at a chalk-drawn target.

Materials: 3-4 beanbags | Playground chalk

Follow the steps below to play!', NULL, N'Only toss beanbags toward the target, never at people.', 32, N'sequence_steps', N'{"steps": ["Draw a big circle target on the ground with chalk.", "Stand a few steps back behind a chalk line.", "Take turns tossing beanbags, trying to land them inside the circle.", "Count how many you get in!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_0, N'short_response', N'🖍️ Chalk Path Walk

80s Inspiration: Inspired by the winding chalk paths and hopscotch trails kids used to draw across playgrounds.

Objective: Practice balance and following a path by walking along a winding chalk line.

Materials: Playground chalk

Follow the steps below to play!', NULL, N'Walk slowly and carefully to keep your balance.', 33, N'sequence_steps', N'{"steps": ["Draw a long, winding line on the pavement with chalk.", "Walk along the line, trying to stay on it the whole way.", "Try walking backward once you reach the end!", "Draw a new, curvier path and try again."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_0, N'short_response', N'🪑 Musical Chairs Throwback

80s Inspiration: The classic musical chairs game that''s been a party and playground favorite since long before the 1980s.

Objective: Practice quick reactions by finding a chair before the music stops.

Materials: Chairs (one fewer than the number of players) | Music (clapping or humming works too!)

Follow the steps below to play!', NULL, N'Sit down carefully — no pushing to grab a chair.', 34, N'sequence_steps', N'{"steps": ["Set up chairs in a circle, facing outward, one fewer chair than players.", "Walk around the chairs while music plays (or while everyone claps a beat).", "When the music stops, sit in the nearest chair!", "Remove one chair each round — whoever doesn''t get a seat cheers on the rest."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_0, N'short_response', N'🤫 Statue Freeze Retro

80s Inspiration: A simple version of retro ''statues'' games where kids freeze in silly poses and try not to move.

Objective: Practice freezing in a funny pose and holding perfectly still.

Materials: None — just kids and open space!

Follow the steps below to play!', NULL, N'Choose a pose you can hold safely without losing your balance.', 35, N'sequence_steps', N'{"steps": ["Everyone spins around once, then freezes in a silly pose.", "Hold your pose as still as you can.", "A grown-up gently checks — anyone who wiggles or giggles too much starts over.", "See who can hold the silliest pose the longest!"]}');

    DECLARE @cat_80s_1 INT;
    SELECT @cat_80s_1 = category_id FROM dbo.PacketCategories WHERE grade_id = 1 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_1, N'short_response', N'🦶 Classic Hopscotch Ladder

80s Inspiration: The full classic hopscotch grid — single squares hopped on one foot, side-by-side squares landed on with both feet.

Objective: Practice hopping in a pattern of single and double squares along a chalk hopscotch ladder.

Materials: Playground chalk | A small stone or beanbag marker

Follow the steps below to play!', NULL, N'Hop carefully to keep your balance on each square.', 29, N'sequence_steps', N'{"steps": ["Draw a hopscotch ladder with chalk: squares 1-8, with 2-3 and 6-7 drawn side by side.", "Toss your marker onto square 1.", "Hop through the ladder on one foot for single squares, both feet for side-by-side squares, skipping the marker''s square.", "Pick up your marker on the way back, then toss it to the next number!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_1, N'short_response', N'🥤 Kick the Can Lite

80s Inspiration: A simplified version of Kick the Can, a beloved dusk-till-dark neighborhood game for generations of kids.

Objective: Practice hiding, sneaking, and quick running in a gentle version of the classic can-kicking game.

Materials: 1 empty plastic bottle or bucket (standing in for the ''can'')

Follow the steps below to play!', NULL, N'Hide only in spots a grown-up allows, and tip the can gently — no kicking it hard.', 30, N'sequence_steps', N'{"steps": ["Set the ''can'' (bottle) in the middle of the play area.", "One player is ''It'' and guards the can while everyone else hides nearby.", "Hiding players try to sneak up and gently tip the can over before being tagged.", "If someone kicks the can, everyone who was caught gets a fresh chance to hide!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_1, N'short_response', N'🪢 Long Rope Jump-In

80s Inspiration: The classic long jump-rope game where two turners swing a rope for others to run in and jump.

Objective: Practice timing your jump into a swinging long rope and jumping a few times before hopping out.

Materials: 1 long jump rope

Follow the steps below to play!', NULL, N'Turn the rope at a steady, gentle pace for beginners.', 31, N'sequence_steps', N'{"steps": ["Two players turn a long rope in a steady, even swing.", "Watch the rope and time your run-in as it swings up and away from you.", "Jump 3-5 times, then run back out.", "Take turns jumping in and turning the rope!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_1, N'short_response', N'🎯 Beanbag Board Toss

80s Inspiration: A pavement version of the classic beanbag toss boards found at school carnivals and playgrounds.

Objective: Practice aiming beanbags at numbered chalk zones to score points.

Materials: 3-4 beanbags | Playground chalk

Follow the steps below to play!', NULL, N'Only toss toward the target, never at people.', 32, N'sequence_steps', N'{"steps": ["Draw 3 chalk circles, one inside the other, labeled 1, 2, and 3 points from outside in.", "Stand behind a chalk line a few steps back.", "Toss beanbags, adding up your points based on where they land.", "Play 3 rounds and total your score!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_1, N'short_response', N'🏃 TV Tag Retro

80s Inspiration: A playground twist on tag where calling out a word (like a TV show name) makes you safe for a few seconds.

Objective: Practice quick thinking and running by naming something to become briefly safe from tag.

Materials: None — just open space!

Follow the steps below to play!', NULL, N'Tag gently, and give a crouching player a moment to think of their word.', 33, N'sequence_steps', N'{"steps": ["One player is ''It'' and chases the others.", "If about to be tagged, a player can crouch down and shout out any word (an animal, a color, a food) to be briefly safe.", "You can''t use the same word twice in a row — think fast!", "Once safe, count to 3 before standing back up to keep playing."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_1, N'short_response', N'🖍️ Four-Square Warm-Up

80s Inspiration: An easier version of Four Square, the classic ball-bouncing playground game played in a chalk-divided court.

Objective: Practice the basic bounce-and-hit rules of four square in a simplified starter version.

Materials: 1 bouncy ball | Playground chalk

Follow the steps below to play!', NULL, N'Hit the ball gently with an open hand, not a hard punch.', 34, N'sequence_steps', N'{"steps": ["Draw a big square divided into 4 smaller squares, numbered 1-4.", "One player stands in each square.", "The player in square 1 bounces the ball into another square.", "Keep bouncing the ball between squares — if it bounces twice in your square, you''re out and a new player rotates in!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_1, N'short_response', N'🪑 Musical Spots Throwback

80s Inspiration: A no-chairs playground version of musical chairs, using chalk circles instead.

Objective: Practice quick reactions by finding an empty chalk spot before the music stops.

Materials: Playground chalk | Music (clapping or humming works too!)

Follow the steps below to play!', NULL, N'Step (don''t dive) into circles to avoid bumping heads with a friend.', 35, N'sequence_steps', N'{"steps": ["Draw chalk circles on the ground, one fewer than the number of players.", "Walk around the circles while music plays (or everyone claps a beat).", "When the music stops, jump into the nearest empty circle!", "Erase one circle each round — last player standing wins!"]}');

    DECLARE @cat_80s_2 INT;
    SELECT @cat_80s_2 = category_id FROM dbo.PacketCategories WHERE grade_id = 2 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_2, N'short_response', N'🦶 Hopscotch Challenge

80s Inspiration: The classic full-length hopscotch course, a sidewalk-chalk staple for generations.

Objective: Practice hopping through a full 1-10 hopscotch course with speed and balance.

Materials: Playground chalk | A small stone or beanbag marker

Follow the steps below to play!', NULL, N'Hop carefully — balance matters more than speed.', 29, N'sequence_steps', N'{"steps": ["Draw a hopscotch course numbered 1 to 10, with paired squares for two-footed landings.", "Toss your marker onto square 1 and hop through the course, skipping that square.", "Turn around at 10, hop back, and pick up your marker on the way.", "Toss to the next number and keep going — see who finishes the whole course first!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_2, N'short_response', N'🥤 Kick the Can Classic

80s Inspiration: Kick the Can, a beloved neighborhood evening game that mixes hide-and-seek with a race to free everyone caught.

Objective: Combine hiding, sneaking, and running strategy in the classic can-guarding game.

Materials: 1 empty plastic bottle or bucket (the ''can'')

Follow the steps below to play!', NULL, N'Hide only in approved spots, and kick the can gently — a light tap is enough.', 30, N'sequence_steps', N'{"steps": ["Place the can in the center; one player guards it while everyone else hides.", "The guard tags hiders they spot, sending them to a ''jail'' near the can.", "Other hiders can sneak up and kick the can to free everyone in jail.", "If the guard tags everyone before the can is kicked, they win — otherwise, pick a new guard and play again!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_2, N'short_response', N'🔲 Four Square Basics

80s Inspiration: Four Square, one of the most iconic 1980s blacktop games, played in a chalk-divided court with a bouncy ball.

Objective: Learn and apply the basic rules of Four Square: serving, bouncing, and elimination.

Materials: 1 bouncy ball | Playground chalk

Follow the steps below to play!', NULL, N'Hit the ball with an open hand only — no punching or kicking.', 31, N'sequence_steps', N'{"steps": ["Draw a court divided into 4 squares, numbered 1-4, with square 4 as the ''server.''", "The server bounces the ball into another player''s square.", "That player must hit it into someone else''s square before it bounces twice.", "Miss, or hit out of bounds, and you''re out — the next waiting player rotates in!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_2, N'short_response', N'🪢 Jump Rope Rhyme Time

80s Inspiration: Classic jump-rope games where turners chant a rhyme while a jumper keeps time with their feet.

Objective: Practice steady jump-rope rhythm while chanting an original counting rhyme.

Materials: 1 jump rope

Follow the steps below to play!', NULL, N'Turn the rope at a steady pace the jumper can keep up with.', 32, N'sequence_steps', N'{"steps": ["Two players turn the rope while everyone chants together: ''Jump so high, touch the sky, count along as the seconds fly — 1, 2, 3...''", "The jumper keeps jumping and counting along with the chant.", "See how high you can count before missing a jump!", "Take turns being the jumper and the turners."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_2, N'short_response', N'⚾ Wall Ball Retro

80s Inspiration: Wall Ball, a simple throw-and-catch game that''s been a recess favorite against any handy wall for decades.

Objective: Practice throwing and catching a ball off a wall using simple rules.

Materials: 1 rubber ball | A flat outdoor wall

Follow the steps below to play!', NULL, N'Throw at a wall with no windows nearby, and watch for others waiting their turn.', 33, N'sequence_steps', N'{"steps": ["Stand a few steps back from a flat wall.", "Throw the ball against the wall and catch it after one bounce.", "Take turns, trying different throws — underhand, overhand, bounce first.", "If you drop it, it''s the next player''s turn!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_2, N'short_response', N'🐌 Sidewalk Snail Spiral

80s Inspiration: A spiral variation of hopscotch, sometimes called a ''snail,'' popular on playgrounds as an alternative to the standard ladder shape.

Objective: Practice hopping through a spiral-shaped hopscotch course from the outside in.

Materials: Playground chalk

Follow the steps below to play!', NULL, N'Hop carefully — the spiral gets tighter near the center, so slow down.', 34, N'sequence_steps', N'{"steps": ["Draw a spiral of connected squares, starting big on the outside and curling into the center.", "Number the squares in order from the outside in.", "Hop from square 1 all the way to the center, then hop back out.", "Try hopping on one foot the whole way for an extra challenge!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_2, N'short_response', N'🏃 Freeze Tag Tournament Retro

80s Inspiration: A tournament twist on the classic playground freeze tag game.

Objective: Compete to be the last player still moving in a bracket-style freeze tag showdown.

Materials: None — just open space!

Follow the steps below to play!', NULL, N'Tag gently, and freeze safely wherever you are when tagged.', 35, N'sequence_steps', N'{"steps": ["Pick 2 players to be ''It'' for this round.", "Everyone else runs to avoid being tagged; tagged players freeze in place.", "Frozen players stay frozen — no unfreezing this round!", "Last player still moving becomes an ''It'' for the next round!"]}');

    DECLARE @cat_80s_3 INT;
    SELECT @cat_80s_3 = category_id FROM dbo.PacketCategories WHERE grade_id = 3 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_3, N'short_response', N'🦶 Hopscotch Relay Retro

80s Inspiration: Turns the traditional solo hopscotch course into a team relay race.

Objective: Combine team relay racing with the classic hopscotch hopping pattern.

Materials: Playground chalk | 2 beanbag markers

Follow the steps below to play!', NULL, N'Hop carefully — a fall slows your team down more than a careful hop.', 29, N'sequence_steps', N'{"steps": ["Draw two identical hopscotch courses (1-10) side by side, one per team.", "Split into 2 teams, lined up at each course.", "First player hops the full course and back, then tags the next teammate.", "First team to have everyone finish wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_3, N'short_response', N'🥤 Kick the Can Teams

80s Inspiration: A team-based version of the classic Kick the Can game, adding cooperative strategy.

Objective: Apply team strategy to guarding the can and freeing teammates from jail.

Materials: 1 empty plastic bottle or bucket (the ''can'')

Follow the steps below to play!', NULL, N'Hide only in approved spots, and kick the can gently.', 30, N'sequence_steps', N'{"steps": ["Split into 2 teams; one team guards the can while the other hides and tries to kick it.", "Guards tag hiders and send them to a jail zone near the can.", "Hiders sneak up to kick the can and free everyone in jail.", "Switch team roles after a set time and see who freed more teammates!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_3, N'short_response', N'🔲 Four Square Rally

80s Inspiration: A rally-focused twist on the classic 1980s blacktop favorite, Four Square.

Objective: Practice sustained rallies in four square, keeping the ball in play as long as possible.

Materials: 1 bouncy ball | Playground chalk

Follow the steps below to play!', NULL, N'Hit with an open hand only, keeping hits controlled.', 31, N'sequence_steps', N'{"steps": ["Draw a court divided into 4 squares, numbered 1-4.", "Play normal four square rules, but count out loud how many hits happen in a row without a miss.", "Try to beat your group''s best rally count!", "If someone''s out, a new player rotates in and the rally count keeps going."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_3, N'short_response', N'🪢 Double Dutch Intro

80s Inspiration: Double Dutch, the iconic two-rope jump style that became hugely popular on playgrounds through the 1980s.

Objective: Learn the basics of jumping between two ropes turning in opposite directions.

Materials: 2 jump ropes

Follow the steps below to play!', NULL, N'Start with slow, gentle turns until the jumper gets the timing down.', 32, N'sequence_steps', N'{"steps": ["Two turners hold two ropes, turning them in opposite, alternating directions.", "Watch the rhythm of the ropes before jumping in.", "Time your jump to enter between the ropes and jump a few times.", "Practice slowly at first — speed comes with practice!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_3, N'short_response', N'⚾ Wall Ball Challenge

80s Inspiration: A leveled-up version of the classic recess wall-ball game, adding challenge moves.

Objective: Practice more advanced wall-ball throws and catches with added challenge rules.

Materials: 1 rubber ball | A flat outdoor wall | Playground chalk (optional, for a throwing line)

Follow the steps below to play!', NULL, N'Only attempt challenges you feel confident and safe doing.', 33, N'sequence_steps', N'{"steps": ["Draw a throwing line a few steps from the wall.", "Take turns throwing and catching, adding a challenge each round (clap once before catching, spin around, catch behind your back).", "If you miss a challenge catch, you''re out for that round.", "Last player still completing challenges wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_3, N'short_response', N'🖍️ Chalk Spot Shuffle

80s Inspiration: A pavement chalk game inspired by classic hand-and-foot placement party games from the 80s.

Objective: Practice following called-out directions to move hands and feet onto different colored chalk spots.

Materials: Playground chalk (multiple colors)

Follow the steps below to play!', NULL, N'Play on a soft or flat surface in case someone tips over.', 34, N'sequence_steps', N'{"steps": ["Draw a grid of colored chalk spots in front of each player.", "A caller shouts directions like ''left hand on blue!'' or ''right foot on red!''", "Move your hands and feet to match, without falling over.", "Keep adding directions until someone loses their balance!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_3, N'short_response', N'❌ Sidewalk Tic-Tac-Toe Toss

80s Inspiration: Merges a chalk-drawn tic-tac-toe grid with the classic beanbag-toss accuracy games of the era.

Objective: Combine beanbag-tossing accuracy with the classic 3-in-a-row strategy game.

Materials: Playground chalk | 2 sets of different-colored beanbags (or rocks)

Follow the steps below to play!', NULL, N'Toss beanbags gently, never at people.', 35, N'sequence_steps', N'{"steps": ["Draw a large tic-tac-toe grid on the ground with chalk.", "Two players take turns tossing their colored beanbag into a grid square from a throwing line.", "The beanbag stays wherever it lands, claiming that square.", "First player to get 3 in a row wins!"]}');

    DECLARE @cat_80s_4 INT;
    SELECT @cat_80s_4 = category_id FROM dbo.PacketCategories WHERE grade_id = 4 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_4, N'short_response', N'🦶 Hopscotch Speed Round

80s Inspiration: Adds a speed-challenge twist to the traditional hopscotch course.

Objective: Race against the clock to complete a hopscotch course as fast as possible without mistakes.

Materials: Playground chalk | A beanbag marker | A stopwatch or phone timer

Follow the steps below to play!', NULL, N'Go fast, but not so fast you lose your balance and fall.', 29, N'sequence_steps', N'{"steps": ["Draw a 1-10 hopscotch course with chalk.", "Time yourself hopping the full course and back, tossing the marker as usual.", "If you step on a line or miss a square, add 2 seconds as a penalty.", "Try to beat your own best time across several rounds!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_4, N'short_response', N'🥤 Kick the Can Strategy

80s Inspiration: A more strategic version of the classic Kick the Can game, emphasizing planning over just running.

Objective: Apply advanced hiding and timing strategy to outsmart the can''s guard.

Materials: 1 empty plastic bottle or bucket (the ''can'')

Follow the steps below to play!', NULL, N'Hide only in approved spots, and kick the can gently.', 30, N'sequence_steps', N'{"steps": ["One player guards the can; everyone else plans hiding spots that allow a fast sneak-up.", "Guards must balance watching for hiders and watching the can itself.", "Hiders coordinate — one might distract the guard while another sneaks in to kick the can.", "Discuss strategy afterward: what worked, what didn''t?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_4, N'short_response', N'🔲 Four Square Tournament Retro

80s Inspiration: A full-fledged tournament format built around the classic 1980s blacktop favorite, Four Square.

Objective: Compete in a bracket-style four square tournament applying full classic rules.

Materials: 1 bouncy ball | Playground chalk | A simple bracket sheet

Follow the steps below to play!', NULL, N'Hit the ball with an open hand only, keeping hits controlled.', 31, N'sequence_steps', N'{"steps": ["Draw a four square court and set up a rotation line for waiting challengers.", "Play standard rules — miss or hit out, go to the back of the line, next player rotates in.", "Track how many rounds each player survives as ''king/queen'' of square 4.", "Crown the player with the most total rounds won as tournament champion!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_4, N'short_response', N'🪢 Double Dutch Jump Challenge

80s Inspiration: Builds on the classic Double Dutch two-rope jumping tradition with an endurance challenge.

Objective: Practice sustained double dutch jumping and counting consecutive jumps.

Materials: 2 jump ropes

Follow the steps below to play!', NULL, N'Turn the ropes at a pace the jumper can safely keep up with.', 32, N'sequence_steps', N'{"steps": ["Two turners swing two ropes in opposite alternating arcs at a steady pace.", "The jumper enters and jumps continuously, counting out loud.", "See how many jumps in a row you can do before missing.", "Switch roles and try to beat the group''s best count!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_4, N'short_response', N'⚾ Wall Ball Ace

80s Inspiration: A precision-focused version of the classic recess wall-ball game.

Objective: Practice precision throwing to hit specific chalk-marked zones on a wall.

Materials: 1 rubber ball | A flat outdoor wall | Playground chalk

Follow the steps below to play!', NULL, N'Choose a wall with no windows nearby, and throw at a safe height.', 33, N'sequence_steps', N'{"steps": ["Draw 3 target zones on the wall (low, middle, high) with chalk, worth different points.", "Stand behind a throwing line and call out which zone you''re aiming for.", "Score points if you hit your called zone and catch the rebound.", "Play 5 rounds and total your score!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_4, N'short_response', N'⚪ Marbles Ring Toss

80s Inspiration: A gentle version of the classic marbles ring game, one of the most popular pocket games of the era.

Objective: Practice aiming and flicking marbles to knock others out of a chalk-drawn ring.

Materials: A handful of marbles (large, supervised — or use small rocks/bottle caps) | Playground chalk

Follow the steps below to play!', NULL, N'Use marbles only with grown-up supervision, and keep them out of your mouth.', 34, N'sequence_steps', N'{"steps": ["Draw a circle on the ground and place several marbles inside it.", "Take turns flicking your own marble from outside the circle, trying to knock others out.", "Any marble knocked out of the circle is collected by whoever knocked it out.", "Keep playing until all marbles are out — whoever collected the most wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_4, N'short_response', N'🪢 Elastics Jump Challenge

80s Inspiration: Elastics (also called Chinese jump rope), where a big loop of elastic is stretched between two players'' legs while a third jumps a set pattern of footwork.

Objective: Practice jumping footwork patterns using a big loop of elastic held between two players'' ankles.

Materials: 1 long loop of elastic (or a few rubber bands tied together, or a soft rope loop)

Follow the steps below to play!', NULL, N'Keep the elastic loose enough that it won''t trip anyone, and stop if it gets too tight.', 35, N'sequence_steps', N'{"steps": ["Two players stand facing each other with the elastic loop stretched around both their ankles.", "A third player jumps a pattern: in, out, on top of both strands, side to side.", "If you complete the pattern without a mistake, the elastic moves up to knee height for a harder round!", "Take turns being a ''post'' and the jumper."]}');

    DECLARE @cat_80s_5 INT;
    SELECT @cat_80s_5 = category_id FROM dbo.PacketCategories WHERE grade_id = 5 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_5, N'short_response', N'🦶 Hopscotch Master Challenge

80s Inspiration: Takes the classic hopscotch ladder and lets players design their own advanced layout.

Objective: Design and complete a custom advanced hopscotch course with mixed hopping patterns.

Materials: Playground chalk | A beanbag marker

Follow the steps below to play!', NULL, N'Test your own course before challenging a friend, checking for safe spacing.', 29, N'sequence_steps', N'{"steps": ["Design your own hopscotch course — mix single squares, side-by-side squares, and a few extra-large ''jump'' squares.", "Test your own course first.", "Challenge a friend to complete your course, then try theirs.", "Compare which course was trickiest and why!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_5, N'short_response', N'🥤 Kick the Can Championship

80s Inspiration: A championship format built around the enduring neighborhood classic, Kick the Can.

Objective: Apply full team strategy across multiple rounds of the classic can-guarding game.

Materials: 1 empty plastic bottle or bucket (the ''can'')

Follow the steps below to play!', NULL, N'Hide only in approved spots, and kick the can gently.', 30, N'sequence_steps', N'{"steps": ["Play several rounds, rotating who guards the can.", "Track how many times each guard successfully catches everyone versus how many times the can gets kicked.", "Discuss strategy adjustments between rounds.", "Crown the champion guard (fewest cans kicked) and champion sneaker (most cans kicked)!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_5, N'short_response', N'🔲 Four Square King/Queen League

80s Inspiration: Builds a league format around the blacktop classic Four Square, tracking long-term standings.

Objective: Compete in an ongoing four square league, tracking who holds the top square the longest.

Materials: 1 bouncy ball | Playground chalk | A league standings sheet

Follow the steps below to play!', NULL, N'Hit with an open hand only, and keep the game friendly and fair.', 31, N'sequence_steps', N'{"steps": ["Draw a four square court and establish a rotation line for challengers.", "Play using standard rules, with a special ''king/queen'' rule for the square 4 player.", "Track each player''s total time spent as king/queen across multiple play sessions.", "Keep a running league standings sheet — top scorer at the end of the week wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_5, N'short_response', N'🪢 Double Dutch Relay

80s Inspiration: Turns the classic Double Dutch jump style into a team relay event.

Objective: Combine team relay racing with double dutch jump-rope skills.

Materials: 2 jump ropes per team

Follow the steps below to play!', NULL, N'Keep turning steady, and give each jumper a clear signal to jump in.', 32, N'sequence_steps', N'{"steps": ["Split into teams; two turners per team swing double dutch ropes.", "Each teammate takes a turn jumping in, completing 5 jumps, then jumping out.", "The next teammate jumps in immediately after.", "First team to have everyone complete their jumps wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_5, N'short_response', N'⚾ Wall Ball World Cup

80s Inspiration: A tournament format built around the classic recess wall-ball game.

Objective: Compete in a bracket-style wall ball tournament applying skill challenges.

Materials: 1 rubber ball | A flat outdoor wall | A bracket sheet

Follow the steps below to play!', NULL, N'Only attempt challenge catches you feel confident doing safely.', 33, N'sequence_steps', N'{"steps": ["Set up a bracket tournament; players face off in head-to-head wall ball matches.", "Each match, players alternate throws, adding challenge moves (spin, clap, catch behind back).", "Whoever completes the most successful catches in a set number of rounds advances.", "Play through the bracket to crown a World Cup champion!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_5, N'short_response', N'🎯 Jacks Retro Challenge

80s Inspiration: Jacks, a tiny-but-mighty pavement game played with a small ball and metal or plastic pieces, hugely popular through the 1980s.

Objective: Practice hand-eye coordination and quick reflexes with the classic game of jacks.

Materials: A set of jacks (or small stones/bottle caps) | 1 small bouncy ball

Follow the steps below to play!', NULL, N'Play on a flat, clean surface, and keep small pieces away from younger siblings who might put them in their mouths.', 34, N'sequence_steps', N'{"steps": ["Scatter the jacks on a flat surface.", "Toss the ball up, and before it bounces twice, pick up 1 jack and catch the ball.", "Repeat, picking up 2 jacks at a time, then 3, and so on, each round.", "If you miss the ball or knock other jacks out of place, it''s the next player''s turn!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_5, N'short_response', N'👏 Hand-Clap Rhythm Challenge

80s Inspiration: Inspired by the hand-clapping games that were a playground staple, where partners clap out a rhythm together.

Objective: Practice memory and rhythm by learning and repeating an original hand-clapping pattern with a partner.

Materials: None — just hands and a partner!

Follow the steps below to play!', NULL, N'Clap palms gently — this is about rhythm, not force.', 35, N'sequence_steps', N'{"steps": ["Face a partner and learn a simple clap pattern: clap your own hands, then clap both of your partner''s hands, then clap your own again.", "Practice the pattern slowly until it feels smooth.", "Add a chant to keep the beat: ''Clap, clap, together, clap!''", "Once you''ve mastered it, try speeding up together!"]}');

    DECLARE @cat_80s_6 INT;
    SELECT @cat_80s_6 = category_id FROM dbo.PacketCategories WHERE grade_id = 6 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_6, N'short_response', N'🦶 Hopscotch Trick Course

80s Inspiration: Adds trick-hopping challenges (spins, backward hops) onto the traditional hopscotch course.

Objective: Master advanced hopping tricks layered onto a standard hopscotch course.

Materials: Playground chalk | A beanbag marker

Follow the steps below to play!', NULL, N'Only attempt tricks you can do safely without losing balance.', 29, N'sequence_steps', N'{"steps": ["Draw a standard 1-10 hopscotch course.", "Add a ''trick'' to specific squares (spin 180° in square 4, hop backward from 7 to 6).", "Complete the course including all tricks without falling.", "Add your own new trick and challenge a friend to try it!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_6, N'short_response', N'🥤 Kick the Can Advanced Strategy

80s Inspiration: A more advanced strategic layer added onto the classic Kick the Can game.

Objective: Apply layered team strategy, including decoys and timed sneaks, to outsmart the guard.

Materials: 1 empty plastic bottle or bucket (the ''can'')

Follow the steps below to play!', NULL, N'Hide only in approved spots, and kick the can gently.', 30, N'sequence_steps', N'{"steps": ["As a team, plan roles before starting: a decoy, a scout, and a sneaker.", "The decoy draws the guard''s attention on one side of the play area.", "The scout signals when the guard is distracted.", "The sneaker uses that window to dash in and kick the can — discuss what worked afterward!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_6, N'short_response', N'🔲 Four Square Pro Rules

80s Inspiration: Adds advanced ''pro'' rule variations to the classic Four Square blacktop game.

Objective: Apply advanced four square rules, including special serves and challenge moves.

Materials: 1 bouncy ball | Playground chalk

Follow the steps below to play!', NULL, N'Hit with an open hand only, and keep advanced moves controlled and safe.', 31, N'sequence_steps', N'{"steps": ["Draw a four square court; agree on advanced rules beforehand (allow lobs, spins, or ''around the world'' where the ball must bounce in every square in a row).", "Play using these pro rules, tracking who holds square 4 the longest.", "Rotate in new challengers as players are eliminated.", "Discuss which pro rule made the game most exciting!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_6, N'short_response', N'🪢 Double Dutch Freestyle

80s Inspiration: Freestyle Double Dutch routines were a showcase skill on playgrounds throughout the 1980s.

Objective: Create and perform an original freestyle double dutch routine with tricks.

Materials: 2 jump ropes

Follow the steps below to play!', NULL, N'Only attempt tricks you''re confident you can land safely.', 32, N'sequence_steps', N'{"steps": ["Two turners swing double dutch ropes at a steady pace.", "The jumper enters and adds tricks: a spin, a high knee, jumping on one foot.", "Perform your freestyle routine for the group.", "Take turns and vote on the most creative routine!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_6, N'short_response', N'⚾ Wall Ball Tournament

80s Inspiration: A full tournament structure built around the enduring recess classic, wall ball.

Objective: Compete in a full bracket tournament applying advanced wall ball rules and scoring.

Materials: 1 rubber ball | A flat outdoor wall | A bracket sheet

Follow the steps below to play!', NULL, N'Choose a wall with no windows nearby, and play at a controlled pace.', 33, N'sequence_steps', N'{"steps": ["Set up a bracket; players face off in timed wall ball matches.", "Score points for successful catches, lose points for drops.", "Winners advance through the bracket.", "Crown the tournament champion after the final match!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_6, N'short_response', N'🎯 Jacks Championship

80s Inspiration: The classic game of jacks, played through its traditional leveled progression of picking up increasing numbers of pieces per toss.

Objective: Compete through the full progression of jacks levels, from onesies to tensies.

Materials: A set of jacks (or small stones/bottle caps) | 1 small bouncy ball

Follow the steps below to play!', NULL, N'Play on a flat, clean surface, and keep pieces away from anyone who might put them in their mouth.', 34, N'sequence_steps', N'{"steps": ["Scatter the jacks and start at ''onesies'' — pick up 1 jack per bounce.", "If successful, move up to ''twosies'' — pick up 2 at a time, then ''threesies,'' and so on.", "Whoever reaches the highest level without missing wins that round.", "Play multiple rounds and track your personal best level!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_6, N'short_response', N'🖍️ Chalk Relay Obstacle

80s Inspiration: Blends several classic 1980s chalk pavement games into a single relay challenge.

Objective: Combine hopscotch hopping and tic-tac-toe tossing into one multi-station chalk relay.

Materials: Playground chalk | Beanbags

Follow the steps below to play!', NULL, N'Complete each station fully and carefully before moving to the next.', 35, N'sequence_steps', N'{"steps": ["Set up 2 chalk stations: a hopscotch course and a tic-tac-toe toss grid.", "Split into teams; each runner hops the hopscotch course, then tosses a beanbag to claim a tic-tac-toe square.", "Tag the next teammate to go.", "First team to complete both stations for everyone (or get 3 in a row on the tic-tac-toe grid) wins!"]}');

    DECLARE @cat_80s_7 INT;
    SELECT @cat_80s_7 = category_id FROM dbo.PacketCategories WHERE grade_id = 7 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_7, N'short_response', N'🦶 Hopscotch Innovator Challenge

80s Inspiration: Takes creative ownership of the traditional hopscotch format, inviting players to reinvent it.

Objective: Design a completely original hopscotch course layout, then teach others to play it.

Materials: Playground chalk | A beanbag marker

Follow the steps below to play!', NULL, N'Test your own course design first to check it''s safe to hop.', 29, N'sequence_steps', N'{"steps": ["Design your own hopscotch course with a unique shape (a zigzag, a star, a double-track).", "Write simple rules for your version.", "Teach your course to a partner and watch them try it.", "Trade courses with another pair and see whose design is the most fun!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_7, N'short_response', N'🥤 Kick the Can Strategy League

80s Inspiration: A league format that treats the classic Kick the Can game as an ongoing strategic competition.

Objective: Compete across multiple structured rounds, refining team strategy each time.

Materials: 1 empty plastic bottle or bucket (the ''can'')

Follow the steps below to play!', NULL, N'Hide only in approved spots, and kick the can gently.', 30, N'sequence_steps', N'{"steps": ["Play several rounds across a session, rotating guard duty.", "After each round, huddle briefly to adjust your team''s strategy.", "Track results across rounds — which strategies worked best?", "Present your team''s winning strategy to the group at the end!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_7, N'short_response', N'🔲 Four Square Masters Retro League

80s Inspiration: A full league season built around the enduring blacktop classic, Four Square.

Objective: Compete in a season-long four square league, tracking standings across multiple matches.

Materials: 1 bouncy ball | Playground chalk | A league standings sheet

Follow the steps below to play!', NULL, N'Hit with an open hand only, and keep matches friendly and fair.', 31, N'sequence_steps', N'{"steps": ["Draw a four square court and set up a challenger rotation line.", "Play using agreed-upon advanced rules across multiple sessions.", "Track total wins and time spent as king/queen on a running standings sheet.", "Crown a season champion at the end of the week!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_7, N'short_response', N'🪢 Double Dutch Performance Challenge

80s Inspiration: Reflects the competitive Double Dutch performance teams that became a genuine sport through the 1980s.

Objective: Choreograph and perform a synchronized double dutch routine with multiple jumpers.

Materials: 2 jump ropes

Follow the steps below to play!', NULL, N'Practice each part slowly before performing at full speed.', 32, N'sequence_steps', N'{"steps": ["In a small group, choreograph a routine with 2 jumpers taking turns or jumping together.", "Practice the timing until the routine feels smooth.", "Perform your routine for the rest of the group.", "Watch other groups'' routines and discuss what made each one impressive!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_7, N'short_response', N'⚾ Wall Ball Grand Championship

80s Inspiration: The ultimate tournament format for the classic recess wall-ball game.

Objective: Compete in a full tournament with escalating skill challenges to determine an overall champion.

Materials: 1 rubber ball | A flat outdoor wall | A bracket sheet

Follow the steps below to play!', NULL, N'Only attempt challenge catches you feel confident doing safely.', 33, N'sequence_steps', N'{"steps": ["Run a full bracket tournament with increasingly harder challenge rounds (basic catch, one-clap catch, spin catch).", "Players are eliminated after a set number of misses per round.", "Track results through each round of the bracket.", "Crown the Grand Champion after the final round!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_7, N'short_response', N'🎯 Jacks Speed Championship

80s Inspiration: Adds a speed-run challenge to the traditional leveled game of jacks.

Objective: Race through the full jacks progression as fast as possible while maintaining accuracy.

Materials: A set of jacks (or small stones/bottle caps) | 1 small bouncy ball | A stopwatch or phone timer

Follow the steps below to play!', NULL, N'Play on a flat, clean surface, and keep pieces away from anyone who might put them in their mouth.', 34, N'sequence_steps', N'{"steps": ["Time yourself going through onesies, twosies, threesies, up through as high as you can.", "If you miss a catch or bump other jacks, restart that level.", "Compare your total time to a friend''s.", "Try again and see if you can beat your own record!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s_7, N'short_response', N'🏆 Retro Playground Pentathlon

80s Inspiration: Combines five different 1980s playground classics into one multi-event competition, like a track-and-field pentathlon.

Objective: Compete across five classic playground events to determine an all-around champion.

Materials: Playground chalk | A jump rope | A bouncy ball | Beanbags | A set of jacks

Follow the steps below to play!', NULL, N'Complete each event fully and safely before moving to the next station.', 35, N'sequence_steps', N'{"steps": ["Set up 5 stations: hopscotch speed run, jump rope count, wall ball catches, beanbag toss accuracy, and jacks level reached.", "Rotate through all 5 stations, recording your result at each.", "Combine your results into an overall pentathlon score.", "Compare scores as a group — who''s the Retro Playground Champion?"]}');

END
GO

DELETE FROM dbo.WeeklyPacketPlan;
GO