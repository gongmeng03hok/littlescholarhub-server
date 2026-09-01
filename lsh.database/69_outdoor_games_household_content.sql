-- 69_outdoor_games_household_content.sql
-- Extends the existing 'Outdoor Games' category (see
-- 68_outdoor_games_content.sql) with 7 more games per grade (14 -> 21),
-- all built from paper, household items, natural materials, or basic stuff
-- most families already have — no purchased sports equipment needed. Many
-- work indoors as well as outdoors (noted per game's objective text).
--
-- Appends to the SAME per-grade PacketCategories row (looked up, not
-- re-created) with sort_order continuing from 15. target_count stays at 7
-- (unchanged) — a bigger 21-game pool just means more weekly variety, same
-- NEWID()-sampling mechanism as every other category.
-- See gen_69_outdoor_games_household_content.py.

IF NOT EXISTS (
    SELECT 1 FROM dbo.PacketQuestions q
    JOIN dbo.PacketCategories c ON c.category_id = q.category_id
    WHERE c.category_name = 'Outdoor Games' AND c.grade_id = 0 AND q.sort_order = 15
)
BEGIN
    DECLARE @cat_ext_0 INT;
    SELECT @cat_ext_0 = category_id FROM dbo.PacketCategories WHERE grade_id = 0 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_0, N'short_response', N'🍽️ Paper Plate Toss

Objective: Practice tossing and aiming using paper plates as flying discs. Works indoors or outdoors.

Materials: 2-3 paper plates | A laundry basket or box as a target

Follow the steps below to play!', NULL, N'Toss gently — paper plates can flip in the wind, so stay clear of anyone''s face.', 15, N'sequence_steps', N'{"steps": ["Set a basket or box a few steps away.", "Hold a paper plate flat and gently toss it like a mini frisbee toward the basket.", "Try to land the plate inside!", "Take turns tossing all the plates, then collect and try again."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_0, N'short_response', N'🧦 Sock Ball Basket

Objective: Practice tossing a soft rolled-up sock into a basket target.

Materials: 2-3 pairs of socks rolled into balls | A laundry basket or bucket

Follow the steps below to play!', NULL, N'Sock balls are soft and safe for indoor play, but toss gently near others.', 16, N'sequence_steps', N'{"steps": ["Roll socks into soft little balls.", "Set a basket a few steps away.", "Take turns tossing the sock balls, trying to land them in the basket.", "Count how many you get in — then try again from a bit farther!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_0, N'short_response', N'🍂 Leaf & Stick Sorting

Objective: Collect and sort natural items by size, color, or shape.

Materials: Leaves and sticks found outside | 2-3 sorting bins or hoops (optional)

Follow the steps below to play!', NULL, N'Only pick up leaves and sticks a grown-up says are safe to touch.', 17, N'sequence_steps', N'{"steps": ["Go outside and collect a handful of leaves and sticks.", "Lay them out and sort them into groups — big vs. small, or by color.", "Talk about why you put each one in its group.", "Mix them up and try sorting a different way!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_0, N'short_response', N'🛏️ Pillow Path Walk

Objective: Practice balance and big steps by walking across a path of pillows.

Materials: 4-5 pillows or couch cushions

Follow the steps below to play!', NULL, N'Clear the area of hard furniture edges before playing indoors.', 18, N'sequence_steps', N'{"steps": ["Lay pillows in a line on the floor, like stepping stones.", "Walk across, stepping only on the pillows.", "Try not to touch the ''floor is lava'' space in between!", "Rearrange the pillows and try a new path."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_0, N'short_response', N'🥄 Spoon and Cotton Ball Walk

Objective: Practice balance and steady hands by carrying a cotton ball on a spoon.

Materials: 1 spoon per player | 1 cotton ball (or pom-pom) per player

Follow the steps below to play!', NULL, N'Walk carefully — this is about steady hands, not speed.', 19, N'sequence_steps', N'{"steps": ["Balance a cotton ball on a spoon.", "Walk from one spot to another without dropping it.", "If it falls, pick it back up and keep going from where you are.", "Try walking faster once you''ve got the hang of it!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_0, N'short_response', N'✈️ Paper Airplane Fly-Off

Objective: Make a simple paper airplane and practice throwing it.

Materials: 1 sheet of paper per player

Follow the steps below to play!', NULL, N'Only throw your airplane forward, away from other people''s faces.', 20, N'sequence_steps', N'{"steps": ["With a grown-up''s help, fold a simple paper airplane.", "Stand behind a starting line.", "Throw your airplane and see how far it flies!", "Try again and see if you can beat your own distance."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_0, N'short_response', N'🔍 Nature Texture Hunt

Objective: Explore outside and find things that feel different — smooth, rough, soft, bumpy.

Materials: None — just curious hands and open outdoor space

Follow the steps below to play!', NULL, N'Only touch things a grown-up says are safe, and wash hands afterward.', 21, N'sequence_steps', N'{"steps": ["Walk around outside with a grown-up.", "Touch different things gently — a smooth rock, rough bark, soft grass, bumpy pinecone.", "Talk about how each one feels.", "See who can find the softest thing, or the bumpiest thing!"]}');

    DECLARE @cat_ext_1 INT;
    SELECT @cat_ext_1 = category_id FROM dbo.PacketCategories WHERE grade_id = 1 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_1, N'short_response', N'📰 Newspaper Stomp Ball

Objective: Make a ball out of scrap paper and practice kicking it into a goal.

Materials: Old newspaper or scrap paper | Tape | 2 chairs or shoes as goal markers

Follow the steps below to play!', NULL, N'Kick gently along the ground — the ball is soft but keep kicks low.', 15, N'sequence_steps', N'{"steps": ["Scrunch newspaper into a ball shape and wrap it with tape.", "Set two chairs or shoes a few steps apart as a goal.", "Take turns kicking the paper ball toward the goal.", "Count how many goals you can score!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_1, N'short_response', N'🥤 Cup Stack Race

Objective: Practice fine motor skills and speed by stacking and unstacking cups.

Materials: 6-10 plastic cups per player

Follow the steps below to play!', NULL, N'Use lightweight plastic cups so nothing gets hurt if they tip over.', 16, N'sequence_steps', N'{"steps": ["Give each player a stack of cups.", "On ''go,'' build a pyramid stack as fast as you can.", "Then knock it down and stack it again in a single tower!", "See who finishes both builds first."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_1, N'short_response', N'🎨 Rock Painting Match

Objective: Paint or color rocks with matching patterns, then find their pairs.

Materials: 6-8 smooth rocks (collected outside) | Washable paint or markers

Follow the steps below to play!', NULL, N'Use washable, non-toxic paint and wear old clothes or an apron.', 17, N'sequence_steps', N'{"steps": ["Collect smooth rocks from outside.", "Paint or color pairs of rocks with matching patterns or colors.", "Let them dry, then mix them up face-down.", "Flip two at a time trying to find matching pairs, like a memory game!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_1, N'short_response', N'⛺ Blanket Fort Builder

Objective: Work together to design and build a cozy fort using blankets and furniture.

Materials: 2-3 blankets or sheets | Chairs, couch cushions, or a table

Follow the steps below to play!', NULL, N'Ask a grown-up before draping blankets over lamps or anything that gets hot.', 18, N'sequence_steps', N'{"steps": ["Gather blankets and find furniture to build around (chairs, a table, a couch).", "Drape the blankets to create a fort roof and walls.", "Add cushions inside to make it cozy.", "Enjoy your fort — read a book or tell stories inside!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_1, N'short_response', N'🧷 Clothespin Drop

Objective: Practice hand-eye coordination by dropping clothespins into a target container.

Materials: 5-6 clothespins | 1 jar or narrow container

Follow the steps below to play!', NULL, N'Only drop clothespins straight down into the jar, not toward anyone.', 19, N'sequence_steps', N'{"steps": ["Stand up and hold a clothespin at waist height, right above the jar.", "Drop the clothespin, trying to get it into the jar.", "Count how many out of 5 make it in!", "Try holding a little higher for a harder challenge."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_1, N'short_response', N'⛵ Paper Boat Race

Objective: Fold a simple paper boat and race it in water.

Materials: 1 sheet of paper per player | A tub, sink, or shallow puddle of water

Follow the steps below to play!', NULL, N'Only play near water with a grown-up watching closely.', 20, N'sequence_steps', N'{"steps": ["With a grown-up''s help, fold a simple paper boat.", "Set your boat in the water at a starting line.", "Gently blow on your boat to make it move across the water.", "First boat to reach the other side wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_1, N'short_response', N'🌿 Stick Balance Walk

Objective: Practice balance and focus by walking along a stick or rope laid on the ground.

Materials: A long stick, rope, or string laid straight on the ground

Follow the steps below to play!', NULL, N'Walk slowly with arms out for balance — take your time.', 21, N'sequence_steps', N'{"steps": ["Lay a long stick or rope in a straight (or gently curving) line on the ground.", "Walk along it heel-to-toe, one foot in front of the other.", "Try walking backward once you''ve done it forward!", "Make the line curvier for a bigger challenge."]}');

    DECLARE @cat_ext_2 INT;
    SELECT @cat_ext_2 = category_id FROM dbo.PacketCategories WHERE grade_id = 2 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_2, N'short_response', N'✈️ Paper Airplane Distance Challenge

Objective: Fold, test, and improve a paper airplane design to fly as far as possible.

Materials: 2-3 sheets of paper per player | A measuring tape or long string

Follow the steps below to play!', NULL, N'Only throw airplanes forward, away from other people.', 15, N'sequence_steps', N'{"steps": ["Fold a paper airplane.", "Throw it from a starting line and mark where it lands.", "Measure the distance, or compare landing spots.", "Try folding it a different way and see if it flies farther!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_2, N'short_response', N'🧦 Sock Ball Target Toss

Objective: Practice aiming by tossing rolled socks at numbered targets for points.

Materials: 4-5 rolled-up sock balls | Chalk or tape to mark 3 target zones with point values

Follow the steps below to play!', NULL, N'Only toss toward the targets, never at people or breakable objects.', 16, N'sequence_steps', N'{"steps": ["Mark 3 target zones on the ground or wall (with chalk or tape), worth 1, 2, and 3 points.", "Stand behind a throwing line.", "Take turns tossing sock balls at the targets, adding up your score.", "Play 3 rounds and see who scores the most!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_2, N'short_response', N'🥄 Spoon and Ball Relay

Objective: Balance a small ball on a spoon while racing to a finish line and back.

Materials: 1 spoon per team | 1 small ball (or bouncy ball) per team | 2 markers

Follow the steps below to play!', NULL, N'Walk, don''t run, to keep the ball balanced and stay safe.', 17, N'sequence_steps', N'{"steps": ["Split into teams; each player balances a ball on a spoon.", "Walk quickly to the far marker and back without dropping it.", "If it drops, stop, pick it up, and continue from there.", "Hand the spoon to the next teammate — fastest team wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_2, N'short_response', N'📦 Cardboard Box Maze

Objective: Build and navigate a simple maze using cardboard boxes.

Materials: 4-6 cardboard boxes (open on both ends, or just used as walls)

Follow the steps below to play!', NULL, N'Make sure boxes are sturdy and won''t collapse or have sharp edges.', 18, N'sequence_steps', N'{"steps": ["Arrange cardboard boxes to form maze walls and turns.", "Take turns crawling or walking through the maze from start to finish.", "Time each other, or just enjoy exploring the path!", "Rearrange the boxes to build a trickier maze."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_2, N'short_response', N'🌲 Pinecone Toss Game

Objective: Practice tossing pinecones (or rocks) into targets for points.

Materials: 4-5 pinecones (or small rocks) | A bucket or hula hoop target

Follow the steps below to play!', NULL, N'Only toss toward the target, and check the area is clear first.', 19, N'sequence_steps', N'{"steps": ["Collect a few pinecones from outside.", "Set a bucket or hoop a few steps away as the target.", "Take turns tossing pinecones, trying to land them inside.", "Move the target farther away as you improve!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_2, N'short_response', N'🕸️ String Web Walk

Objective: Navigate through a string ''spider web'' without touching the strings.

Materials: A ball of string or yarn | Two chairs or door frames to tie it between

Follow the steps below to play!', NULL, N'Move slowly and carefully — this is about control, not speed.', 20, N'sequence_steps', N'{"steps": ["Tie string back and forth between two chairs or a doorway to make a ''web.''", "Try to climb through the gaps without touching any string.", "If you touch a string, gently start that section again.", "Time yourself, or race a friend through a second web!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_2, N'short_response', N'🎳 Rolled-Sock Bowling

Objective: Set up homemade bowling pins and practice rolling a ball to knock them down.

Materials: 6 empty plastic bottles or rolled-sock ''pins'' | 1 ball (soft ball or rolled sock)

Follow the steps below to play!', NULL, N'Roll the ball along the ground — no throwing it in the air.', 21, N'sequence_steps', N'{"steps": ["Set up 6 bottles or rolled socks in a triangle shape, like bowling pins.", "Stand behind a line a few steps back.", "Roll the ball, trying to knock down as many pins as possible.", "Reset the pins and take turns — count your total knocked down after 3 rolls!"]}');

    DECLARE @cat_ext_3 INT;
    SELECT @cat_ext_3 = category_id FROM dbo.PacketCategories WHERE grade_id = 3 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_3, N'short_response', N'📰 Newspaper Ball Toss Battle

Objective: Work in teams to toss paper balls across a line, keeping your own side clear.

Materials: 10-15 balls of crumpled scrap paper | A rope or tape line to divide the area

Follow the steps below to play!', NULL, N'Toss gently — paper balls are soft, but aim below head height.', 15, N'sequence_steps', N'{"steps": ["Split into 2 teams on either side of a dividing line.", "Each team gets half the paper balls.", "On ''go,'' toss the balls to the other side as fast as you can for 30 seconds.", "When time''s up, whichever side has fewer balls on their floor wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_3, N'short_response', N'🥤 Cup Tower Relay

Objective: Race in teams to build the tallest cup tower before time runs out.

Materials: 15-20 plastic cups per team

Follow the steps below to play!', NULL, N'Build carefully — if a tower wobbles, stop adding and steady it.', 16, N'sequence_steps', N'{"steps": ["Split into teams, each with a pile of cups.", "On ''go,'' work together to build the tallest tower you can.", "You have 60 seconds — stop building when time is called.", "Measure each team''s tower — tallest standing tower wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_3, N'short_response', N'🌳 Nature Scavenger Bingo

Objective: Find and check off a bingo card of natural outdoor items.

Materials: A simple 3x3 bingo card with nature items drawn or listed (leaf, rock, flower, bird, cloud, etc.)

Follow the steps below to play!', NULL, N'Only touch or collect items a grown-up says are safe.', 17, N'sequence_steps', N'{"steps": ["Give each player a bingo card with 9 nature items.", "Search outside for each item, checking it off when found.", "Get 3 in a row (across, down, or diagonal) to call ''Bingo!''", "Keep playing to fill the whole card!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_3, N'short_response', N'🦸 Blanket Cape Obstacle Dash

Objective: Wear a blanket cape and complete a simple obstacle course as a superhero.

Materials: 1 small blanket or towel per player (as a cape) | Household items for obstacles (pillows, chairs, boxes)

Follow the steps below to play!', NULL, N'Make sure the cape is tied loosely and won''t catch on anything.', 18, N'sequence_steps', N'{"steps": ["Tie a blanket or towel around your shoulders as a cape.", "Set up a simple obstacle course using pillows, chairs, and boxes.", "Race through the course as a ''superhero,'' completing each obstacle.", "Take turns and time each other!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_3, N'short_response', N'🥏 Paper Plate Frisbee Golf

Objective: Toss a paper plate ''disc'' toward a series of household targets in as few throws as possible.

Materials: 1-2 paper plates | 3-4 household ''holes'' (a laundry basket, a chair, a doorway, a box)

Follow the steps below to play!', NULL, N'Check the throwing path is clear of people and breakable items.', 19, N'sequence_steps', N'{"steps": ["Set up 3-4 targets around the house or yard (a basket, a chair leg, a doorway).", "Throw your paper plate toward the first target, counting your throws.", "Pick it up from where it landed and throw again until you hit the target.", "Move to the next target — fewest total throws across all targets wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_3, N'short_response', N'🧷 Clothespin Clip Relay

Objective: Race to clip clothespins onto your clothing, then race to remove them.

Materials: 10-15 clothespins per team | 2 cones or markers

Follow the steps below to play!', NULL, N'Clip pins onto loose clothing only, gently, never onto skin.', 20, N'sequence_steps', N'{"steps": ["Split into teams, lined up at the start.", "First player runs to the pile of clothespins and clips as many as they can onto their clothes in 10 seconds.", "Run back and tag the next teammate, who removes the clips and adds their own.", "Team with the most clips successfully passed through wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_3, N'short_response', N'🎣 Stick and String Fishing Game

Objective: Make a simple fishing pole and practice ''catching'' paper fish with a magnet or hook.

Materials: 1 stick | String | A magnet or paperclip | Paper fish cutouts with paperclips attached

Follow the steps below to play!', NULL, N'Keep the stick pointed down and away from faces while fishing.', 21, N'sequence_steps', N'{"steps": ["Tie string to a stick, with a magnet or paperclip hook on the end.", "Cut out paper fish shapes and attach a paperclip to each.", "Spread the fish on the floor or ground.", "''Fish'' by dangling your hook near a fish until it attaches, then reel it in!"]}');

    DECLARE @cat_ext_4 INT;
    SELECT @cat_ext_4 = category_id FROM dbo.PacketCategories WHERE grade_id = 4 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_4, N'short_response', N'✈️ Paper Airplane Target Challenge

Objective: Design a paper airplane and practice landing it accurately inside target zones.

Materials: 2-3 sheets of paper per player | Chalk or tape to mark 3 target zones on the ground

Follow the steps below to play!', NULL, N'Only throw airplanes toward the targets, never at people.', 15, N'sequence_steps', N'{"steps": ["Fold a paper airplane and mark 3 target zones on the ground worth 1, 2, and 3 points.", "Throw from a starting line, aiming for the highest-value zone.", "Score points based on where it lands.", "Play 5 rounds and total your score!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_4, N'short_response', N'🎳 Household Item Bowling

Objective: Set up a bowling lane using household items and practice rolling for accuracy.

Materials: 6-10 plastic bottles or cups as pins | A ball (soft ball or rolled-up socks taped together)

Follow the steps below to play!', NULL, N'Roll along the ground only, and reset pins carefully.', 16, N'sequence_steps', N'{"steps": ["Set up bottles or cups in a triangle formation.", "Mark a rolling line a few steps back.", "Roll the ball to knock down as many pins as possible.", "Track your score across 5 rounds — most pins knocked down wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_4, N'short_response', N'🧺 Nature Weaving Craft Race

Objective: Collect natural materials and weave them into a simple pattern as fast as possible.

Materials: Long grass, thin sticks, or vines collected outside | A simple frame (a paper plate with slits cut in, or a stick frame)

Follow the steps below to play!', NULL, N'Only collect natural materials a grown-up says are safe to touch.', 17, N'sequence_steps', N'{"steps": ["Collect long grass, thin sticks, or vines outside.", "Weave them in and out of a simple frame (like a paper plate with cut slits).", "See how much of the frame you can cover in 5 minutes.", "Compare your woven patterns with a friend''s!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_4, N'short_response', N'📦 Cardboard Slide and Ramp Challenge

Objective: Build a ramp from cardboard and test which household objects roll or slide the farthest.

Materials: A large piece of cardboard | Books or a chair to prop it up | Small household objects to test (a ball, a toy car, a bottle cap)

Follow the steps below to play!', NULL, N'Make sure the ramp is stable and won''t tip over during testing.', 18, N'sequence_steps', N'{"steps": ["Prop a cardboard sheet against books or a chair to make a ramp.", "Choose several small objects to test.", "Release each one from the top and mark how far it travels after reaching the bottom.", "Compare distances — which object rolled the farthest?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_4, N'short_response', N'🧦 Sock Ball Dodge

Objective: Practice dodging and throwing accuracy in a gentle sock-ball dodgeball game.

Materials: 6-8 rolled-up sock balls | A center line (rope or tape)

Follow the steps below to play!', NULL, N'Aim below the shoulders, and remember the socks are soft — play gently.', 19, N'sequence_steps', N'{"steps": ["Split into 2 teams on either side of a center line.", "Toss sock balls across the line, trying to gently tag opposing players.", "If tagged, sit out for one round, then rejoin.", "Play until time runs out — team with the most players still in wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_4, N'short_response', N'🪨 Rock Stacking Challenge

Objective: Practice patience and balance by stacking rocks into the tallest stable tower.

Materials: 5-8 rocks of different sizes (collected outside)

Follow the steps below to play!', NULL, N'Stack rocks low to the ground so nothing falls on toes.', 20, N'sequence_steps', N'{"steps": ["Collect a handful of rocks of different sizes.", "Try stacking them into the tallest tower you can, balancing carefully.", "If it falls, that''s okay — try again!", "See how many rocks you can balance at once."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_4, N'short_response', N'📰 Newspaper Tower Build

Objective: Work in teams to build the tallest free-standing tower using only newspaper and tape.

Materials: A stack of newspaper or scrap paper per team | 1 roll of tape per team

Follow the steps below to play!', NULL, N'Build on a stable, flat surface away from foot traffic.', 21, N'sequence_steps', N'{"steps": ["Split into teams, each with paper and tape.", "In 10 minutes, build the tallest tower that can stand on its own.", "No other materials allowed — just paper and tape!", "Measure each team''s tower at the end — tallest standing tower wins!"]}');

    DECLARE @cat_ext_5 INT;
    SELECT @cat_ext_5 = category_id FROM dbo.PacketCategories WHERE grade_id = 5 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_5, N'short_response', N'🥄 Paper Catapult Challenge

Objective: Build a simple catapult from household items and test its launch distance.

Materials: 1 spoon | A rubber band | A small stack of books or a block for a pivot | Small paper balls or pom-poms to launch

Follow the steps below to play!', NULL, N'Only launch soft paper balls, never anything hard, and aim away from faces.', 15, N'sequence_steps', N'{"steps": ["Build a simple catapult: rest a spoon on a pivot block, secured with a rubber band.", "Load a small paper ball onto the spoon.", "Press down and release to launch it toward a target.", "Measure your launch distances and try adjusting your design for more power!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_5, N'short_response', N'♻️ Recycling Relay Sort

Objective: Race in teams to correctly sort recyclable household items into the right bins.

Materials: A mixed pile of clean recyclables (paper, plastic, cardboard) | 3 labeled boxes or bins

Follow the steps below to play!', NULL, N'Use only clean, safe items — no sharp edges or broken glass.', 16, N'sequence_steps', N'{"steps": ["Set up 3 bins labeled paper, plastic, and cardboard.", "Pile mixed clean recyclables at a starting point.", "Teams race to carry items one at a time to the correct bin.", "Fastest team to correctly sort everything wins — double-check for mistakes!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_5, N'short_response', N'🍁 Nature Land Art Challenge

Objective: Use only natural materials found outside to create a piece of art on the ground.

Materials: Leaves, sticks, rocks, flowers, and other natural items found outside

Follow the steps below to play!', NULL, N'Only use materials already on the ground — don''t pick living plants without permission.', 17, N'sequence_steps', N'{"steps": ["Collect natural materials from around the yard or park.", "Arrange them into a picture or pattern on the ground (a face, a shape, a design).", "Take a photo of your finished land art (or just admire it together)!", "Try a new design with different materials."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_5, N'short_response', N'🛏️ Blanket Tug and Balance

Objective: Combine balance and gentle team pulling using a folded blanket.

Materials: 1 sturdy blanket or towel

Follow the steps below to play!', NULL, N'Pull gently and stop immediately if anyone feels unsteady or unsafe.', 18, N'sequence_steps', N'{"steps": ["Two players each hold one end of a folded blanket while standing on one foot.", "Gently pull and try to make the other person lose balance and put their foot down.", "Whoever stays balanced longest wins the round!", "Switch partners and try again."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_5, N'short_response', N'🥤 Cup Stack Speed Challenge

Objective: Practice speed and precision using the competitive cup-stacking technique.

Materials: 12 plastic cups per player

Follow the steps below to play!', NULL, N'Practice on a flat, stable surface with room for cups to fall safely.', 19, N'sequence_steps', N'{"steps": ["Learn a simple stacking pattern: build a pyramid of cups, then collapse it back into a single stack.", "Time yourself doing the full pattern.", "Practice a few times to get faster.", "Challenge a friend to a head-to-head speed race!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_5, N'short_response', N'🧭 String and Stick Compass Walk

Objective: Use a simple sun-shadow method with a stick to estimate direction, then walk a course.

Materials: 1 stick | String | A sunny outdoor spot

Follow the steps below to play!', NULL, N'Never look directly at the sun — only watch the shadow on the ground.', 20, N'sequence_steps', N'{"steps": ["Push a stick upright into the ground in a sunny spot; mark where its shadow tip falls.", "Wait 10-15 minutes, then mark the new shadow tip position — the first mark is roughly west, the second roughly east.", "Use string to lay out a simple direction line based on your marks.", "Walk a short course using your estimated directions (e.g., ''10 steps toward your west mark'')!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_5, N'short_response', N'🏠 Household Obstacle Ninja Course

Objective: Design and complete an obstacle course using only furniture and household items.

Materials: Pillows, chairs, tape, boxes, and other safe household items

Follow the steps below to play!', NULL, N'Check for sharp corners or unstable furniture before anyone runs the course.', 21, N'sequence_steps', N'{"steps": ["Design a course: crawl under a table, jump over a pillow line, weave through chairs, balance-walk a taped line.", "Test your course yourself first for safety.", "Race friends or family through the course, timing each run.", "Redesign a station if it''s too easy or too hard!"]}');

    DECLARE @cat_ext_6 INT;
    SELECT @cat_ext_6 = category_id FROM dbo.PacketCategories WHERE grade_id = 6 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_6, N'short_response', N'🌉 Paper Bridge Engineering Challenge

Objective: Design and test a paper bridge that can hold as much weight as possible.

Materials: Several sheets of paper | Tape | 2 books or blocks (bridge supports) | Small weights (coins, small toys)

Follow the steps below to play!', NULL, N'Test with small, safe weights only, and keep fingers clear as it collapses.', 15, N'sequence_steps', N'{"steps": ["Build a bridge out of paper and tape, spanning the gap between two books.", "Test how much weight it can hold before collapsing (add coins or small toys one at a time).", "Record how much weight it held.", "Redesign your bridge (try folding the paper, adding supports) and test again — did it hold more?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_6, N'short_response', N'🏠 Household Item Olympics

Objective: Compete across multiple mini-events using only everyday household items.

Materials: Cups, socks, spoons, paper, string — whatever''s on hand

Follow the steps below to play!', NULL, N'Check each event''s setup for safety before competing.', 16, N'sequence_steps', N'{"steps": ["Set up 3-4 mini ''Olympic'' events: sock-ball shot put, paper airplane javelin, spoon-and-ball balance walk, cup-stack speed build.", "Compete in each event, scoring points for placement.", "Add up total points across all events.", "Crown the household Olympics champion!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_6, N'short_response', N'🏕️ Natural Materials Shelter Build

Objective: Design and build a small shelter or structure using only materials found outside.

Materials: Sticks, leaves, and other natural materials found outside | String (optional, for lashing sticks together)

Follow the steps below to play!', NULL, N'Only use materials already on the ground, and build somewhere it won''t be a tripping hazard.', 17, N'sequence_steps', N'{"steps": ["Collect sticks, leaves, and other natural materials.", "Design and build a small shelter structure (big enough for a stuffed animal or small object, not a person).", "Test if it stays standing, and if it could shed rain (pour a little water on it, if allowed).", "Improve your design based on what you learned!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_6, N'short_response', N'📦 Cardboard Box Derby

Objective: Design and race simple cardboard vehicles down a ramp, testing speed and distance.

Materials: Small cardboard boxes or cardboard scraps | Tape | Bottle caps or small wheels (optional) | A ramp (a board or cardboard sheet propped up)

Follow the steps below to play!', NULL, N'Keep the ramp stable and test area clear of people and pets.', 18, N'sequence_steps', N'{"steps": ["Build a simple cardboard ''vehicle,'' adding wheels if you have bottle caps or similar round objects.", "Set up a ramp using a board or propped cardboard.", "Release your vehicle from the top and measure how far it travels.", "Redesign and test again — what made it go farther or straighter?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_6, N'short_response', N'🎯 Sock and Spoon Trebuchet

Objective: Build a simple lever-based launcher and test its accuracy and distance.

Materials: 1 spoon | A rubber band | A pivot point (a block or stack of books) | Sock balls to launch

Follow the steps below to play!', NULL, N'Only launch soft sock balls, and keep the launch path clear of people.', 19, N'sequence_steps', N'{"steps": ["Build a simple lever launcher: a spoon balanced on a pivot, secured with a rubber band.", "Load a sock ball onto the spoon end.", "Press and release to launch toward a target.", "Adjust your pivot point or launch angle and test again — what changes the distance?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_6, N'short_response', N'⚖️ Rock Balancing Art Challenge

Objective: Use patience, precision, and an understanding of balance to stack rocks into artistic sculptures.

Materials: 8-10 rocks of varying sizes and shapes

Follow the steps below to play!', NULL, N'Stack low to the ground and away from where anyone might bump into it.', 20, N'sequence_steps', N'{"steps": ["Collect rocks of different sizes and shapes.", "Experiment with balancing them into a tall or creative sculpture, using each rock''s natural balance points.", "Once stable, step back and admire (or photograph) your creation.", "Challenge a friend to build something even more impressive!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_6, N'short_response', N'📰 Newspaper Fashion Design Race

Objective: Work in teams to design and ''construct'' a wearable outfit from newspaper as fast as possible.

Materials: A stack of newspaper per team | Tape | Scissors (with grown-up supervision)

Follow the steps below to play!', NULL, N'Use scissors carefully with a grown-up''s help, and keep the outfit loose and comfortable.', 21, N'sequence_steps', N'{"steps": ["Split into teams; one person is the ''model.''", "In 15 minutes, design and tape/fold a newspaper outfit onto your model.", "Hold a mini fashion show, walking each design across the room.", "Vote together on the most creative design!"]}');

    DECLARE @cat_ext_7 INT;
    SELECT @cat_ext_7 = category_id FROM dbo.PacketCategories WHERE grade_id = 7 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_7, N'short_response', N'🗼 Paper Tower Engineering Challenge

Objective: Design and build the tallest free-standing paper tower that can support a weight on top.

Materials: A stack of paper | Tape | A small weight (like a small book or apple) to place on top

Follow the steps below to play!', NULL, N'Build on a stable surface and keep the weight small and safe.', 15, N'sequence_steps', N'{"steps": ["Using only paper and tape, build a tower as tall as you can.", "Your tower must stand on its own and hold a small weight on top for 10 seconds.", "Measure your tower''s height once it successfully holds the weight.", "Redesign and try to beat your own height record!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_7, N'short_response', N'🏆 Household Item Triathlon

Objective: Compete across three different skill-based mini-events using everyday items.

Materials: A ball or sock ball, a spoon, cups, and other household items

Follow the steps below to play!', NULL, N'Warm up briefly before the sprint event, and check each station for safety first.', 16, N'sequence_steps', N'{"steps": ["Set up 3 events: a sock-ball accuracy toss, a spoon-and-object balance sprint, and a cup-stacking speed challenge.", "Compete in all 3 events, recording your placement or time in each.", "Combine your results into an overall triathlon score.", "Compare scores with friends or family — who''s the household triathlon champion?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_7, N'short_response', N'🧭 Nature Survival Skills Challenge

Objective: Practice basic outdoor skills like shelter-building, direction-finding, and identifying materials.

Materials: Sticks, leaves, and natural materials found outside | A simple compass (optional)

Follow the steps below to play!', NULL, N'Stay within sight of a grown-up and only use materials already on the ground.', 17, N'sequence_steps', N'{"steps": ["In small teams, build a small emergency shelter frame using sticks and leaves.", "Use the sun-shadow method (or a compass) to estimate which direction is north.", "Identify 3 natural materials that could be useful in a real outdoor situation (e.g., soft moss, sturdy sticks).", "Present your shelter and findings to the group!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_7, N'short_response', N'⛵ Cardboard Boat Regatta

Objective: Design and test a small cardboard/foil boat for how much weight it can float before sinking.

Materials: Cardboard scraps or aluminum foil | Tape | A tub or basin of water | Small weights (coins)

Follow the steps below to play!', NULL, N'Only play near water with a grown-up watching, and dry hands/surfaces afterward.', 18, N'sequence_steps', N'{"steps": ["Build a small boat from cardboard or foil, shaped to float.", "Set it in a tub of water and add coins one at a time to test how much weight it holds.", "Record how many coins it held before sinking or taking on water.", "Redesign your boat''s shape and test again — did it hold more weight?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_7, N'short_response', N'🌉 String and Stick Bridge Challenge

Objective: Design a small bridge using sticks and string, then test its strength.

Materials: Several sticks | String or yarn | Two supports (books or blocks) | Small weights to test with

Follow the steps below to play!', NULL, N'Test with small, safe weights, and keep fingers clear as the structure is tested.', 19, N'sequence_steps', N'{"steps": ["Lash sticks together with string to build a small bridge spanning two supports.", "Test how much weight it holds before bending or breaking.", "Record your results.", "Try a new design (like a triangle truss pattern) and test if it holds more!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_7, N'short_response', N'💡 Recycled Materials Invention Fair

Objective: Design and build a useful invention using only recycled household materials.

Materials: Clean recyclables (cardboard, bottles, paper, caps) | Tape or glue

Follow the steps below to play!', NULL, N'Use only clean materials, and ask before using scissors or sharp tools.', 20, N'sequence_steps', N'{"steps": ["Brainstorm a simple problem to solve (like organizing pencils, or a mini catapult).", "Build your invention using only recycled materials.", "Test whether your invention actually works.", "Present your invention to others, explaining the problem it solves!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_ext_7, N'short_response', N'🕐 Natural Compass and Shadow Clock Challenge

Objective: Build a simple shadow clock using a stick and track how shadows change over time.

Materials: 1 stick | Small stones or markers | A sunny outdoor spot | A watch or phone clock (for reference only)

Follow the steps below to play!', NULL, N'Never look directly at the sun — only observe the shadow it casts on the ground.', 21, N'sequence_steps', N'{"steps": ["Push a stick upright into the ground in a sunny spot.", "Mark the tip of its shadow with a small stone every 30 minutes, noting the time on each marker.", "After a few markers, observe the pattern the shadow makes as the sun moves.", "Explain what your ''shadow clock'' shows about the sun''s movement across the sky!"]}');

END
GO

DELETE FROM dbo.WeeklyPacketPlan;
GO