-- 91_outdoor_games_paper_craft.sql
-- Adds a new paper-craft-themed Outdoor Games batch: 7 concepts x 8
-- grades = 56 games (jumping paper frog, paper fortune teller, paper
-- pinwheel, paper cup speed stacking, paper mask parade, paper chain
-- challenge, paper snowflake toss). Each combines a simple paper craft
-- with a real outdoor/physical game or challenge using what was made.
-- Distinct from the existing 26 paper/cardboard games already in the
-- bank (paper airplanes, paper/cardboard boats, paper bridge/tower/
-- catapult engineering, newspaper games, paper plate toss/frisbee golf,
-- the pre-made-kite walk, etc.) -- no repeated concepts.
--
-- Includes Players: and Prerequisites: from the start (unlike the
-- original 448 + first two retro batches, which needed a follow-up
-- migration to add those fields). Appends to the SAME per-grade
-- PacketCategories row with sort_order continuing from 71.

IF NOT EXISTS (
    SELECT 1 FROM dbo.PacketQuestions q
    JOIN dbo.PacketCategories c ON c.category_id = q.category_id
    WHERE c.category_name = 'Outdoor Games' AND c.grade_id = 0 AND q.sort_order = 71
)
BEGIN
    DECLARE @cat_paper_0 INT;
    SELECT @cat_paper_0 = category_id FROM dbo.PacketCategories WHERE grade_id = 0 AND category_name = 'Outdoor Games';

    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_0, N'short_response', N'🐸 Pretend Paper Frog Hop

Objective: Watch a grown-up''s paper frog hop and practice copying the hopping motion with your finger.

Players: 1+ (solo or group)

Prerequisites: None — a great first-timer activity

Materials: 1 square piece of paper per player | A flat surface to hop on (table or floor) | A ruler or tape measure (for the distance grades)

Follow the steps below to play!', NULL, N'Flick gently — no rough tugging on the paper frog.', 71, N'sequence_steps', N'{"steps": ["A grown-up folds a simple paper frog and shows you how it hops.", "Watch closely as they press its back to make it jump.", "Try pressing it yourself with a soft finger tap.", "Cheer every time it hops, even a tiny bit!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_0, N'short_response', N'🔮 Pretend Fortune Teller Peek

Objective: Pick a color and a number and let a grown-up reveal a silly, friendly fortune.

Players: 2-4 players

Prerequisites: None — a great first-timer activity

Materials: 1 square piece of paper per player | Markers or crayons | A pencil (for writing fortunes and numbers)

Follow the steps below to play!', NULL, N'Let a grown-up do the folding — this is a watching-and-choosing game for you.', 72, N'sequence_steps', N'{"steps": ["A grown-up folds and decorates a paper fortune teller.", "Pick your favorite color on the outside.", "Pick a number and count the flaps opening and closing.", "Read your silly fortune together, like ''You get a hug!''"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_0, N'short_response', N'🎐 Pretend Pinwheel Blow

Objective: Blow on a pinwheel a grown-up made and watch it spin.

Players: 1+ (solo or group)

Prerequisites: None — a great first-timer activity

Materials: 1 square piece of paper per player | 1 pin or brad fastener | 1 pencil with an eraser (to mount the pinwheel)

Follow the steps below to play!', NULL, N'A grown-up should push the pin through the paper — that part is a grown-up job.', 73, N'sequence_steps', N'{"steps": ["A grown-up folds and assembles a simple paper pinwheel.", "Hold it out in front of you.", "Take a deep breath and blow gently on the blades.", "Watch it spin and try blowing again!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_0, N'short_response', N'🥤 Pretend Cup Tower

Objective: Stack a few cups into a small tower with help and knock it down for fun.

Players: 1+ (solo or group)

Prerequisites: None — a great first-timer activity

Materials: 9-12 paper or plastic cups per player | A stopwatch or phone timer (for the speed grades)

Follow the steps below to play!', NULL, N'Stack on the floor or a low table so a toppling tower can''t fall far.', 74, N'sequence_steps', N'{"steps": ["A grown-up helps you set three cups in a row.", "Carefully place one cup on top to make a small tower.", "Look at your tower and clap for yourself!", "Gently knock it down and try again."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_0, N'short_response', N'🎭 Pretend Animal Face

Objective: Decorate a paper plate like an animal and make its sound and movement.

Players: 1+ (solo or group)

Prerequisites: None — a great first-timer activity

Materials: 1 paper plate or piece of cardstock per player | Crayons, markers, or paint | A craft stick or elastic string (to hold or wear the mask)

Follow the steps below to play!', NULL, N'A grown-up should cut any eye holes before decorating begins.', 75, N'sequence_steps', N'{"steps": ["Pick an animal you love and a paper plate.", "Color and decorate the plate to look like that animal.", "Hold it up to your face like a mask.", "Make the animal''s sound and move like it walks!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_0, N'short_response', N'🔗 Pretend Chain Links

Objective: Link a few pre-cut paper strips together with help and count the links.

Players: 1+ (solo or group)

Prerequisites: None — a great first-timer activity

Materials: Several strips of colored paper per player or team | Tape or a glue stick | A stopwatch or phone timer (for the timed grades)

Follow the steps below to play!', NULL, N'A grown-up should have the strips already cut and ready.', 76, N'sequence_steps', N'{"steps": ["A grown-up hands you a paper strip already looped and taped.", "Loop a new strip through it and ask for help taping the ends.", "Add one more link the same way.", "Count your links out loud together!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_0, N'short_response', N'❄️ Pretend Snowflake Flutter

Objective: Release a paper snowflake a grown-up cut and watch it flutter down, then try to catch it.

Players: 1+ (solo or group)

Prerequisites: None — a great first-timer activity

Materials: 1 square piece of paper per player | Scissors (adult-assisted) | A hula hoop or basket (for the target-toss grades)

Follow the steps below to play!', NULL, N'A grown-up should do all the cutting for this activity.', 77, N'sequence_steps', N'{"steps": ["A grown-up folds and cuts a simple paper snowflake for you.", "Hold it up high and let it go.", "Watch it flutter gently down.", "Try to catch it before it lands!"]}');

    DECLARE @cat_paper_1 INT;
    SELECT @cat_paper_1 = category_id FROM dbo.PacketCategories WHERE grade_id = 1 AND category_name = 'Outdoor Games';

    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_1, N'short_response', N'🐸 First Frog Fold and Hop

Objective: Help fold a simple paper frog and try making it hop for the first time.

Players: 1+ (solo or group)

Prerequisites: Comfortable following simple folding steps with help

Materials: 1 square piece of paper per player | A flat surface to hop on (table or floor) | A ruler or tape measure (for the distance grades)

Follow the steps below to play!', NULL, N'Fold gently and flick with a light touch, not a hard push.', 71, N'sequence_steps', N'{"steps": ["With a grown-up''s help, fold your paper into a simple frog shape.", "Set it on a flat table or floor.", "Press down on its back and let go to make it hop.", "Try it three times and see which hop was the best!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_1, N'short_response', N'🔮 First Fortune Fold

Objective: Help fold a paper fortune teller and play one simple round.

Players: 2-4 players

Prerequisites: Comfortable following folding steps with help

Materials: 1 square piece of paper per player | Markers or crayons | A pencil (for writing fortunes and numbers)

Follow the steps below to play!', NULL, N'Fold on a flat surface and take your time with each crease.', 72, N'sequence_steps', N'{"steps": ["With help, fold the paper into a square and then into a fortune teller shape.", "Color each flap a different color.", "Pick a color, then a number, then open the flap.", "Read the fortune underneath together!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_1, N'short_response', N'🎐 First Pinwheel Spin

Objective: Help assemble a paper pinwheel and count how many times it spins from one blow.

Players: 1+ (solo or group)

Prerequisites: Comfortable holding and blowing on a pinwheel

Materials: 1 square piece of paper per player | 1 pin or brad fastener | 1 pencil with an eraser (to mount the pinwheel)

Follow the steps below to play!', NULL, N'Let a grown-up handle the pin — hold the pencil steady while they attach it.', 73, N'sequence_steps', N'{"steps": ["Help fold the paper corners in to make the pinwheel shape.", "Watch a grown-up attach it to the pencil with the pin.", "Blow on it one time and count the spins out loud.", "Try blowing harder and see if it spins longer!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_1, N'short_response', N'🥤 First Cup Stack

Objective: Stack a small pyramid of cups at your own pace.

Players: 1+ (solo or group)

Prerequisites: Comfortable stacking a simple small tower

Materials: 9-12 paper or plastic cups per player | A stopwatch or phone timer (for the speed grades)

Follow the steps below to play!', NULL, N'Stack slowly on a flat, stable surface.', 74, N'sequence_steps', N'{"steps": ["Set three cups in a row on a flat surface.", "Place two cups on top of the gaps between them.", "Place one final cup on top to finish the pyramid.", "Carefully take it apart and try building it again!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_1, N'short_response', N'🎭 First Mask Craft

Objective: Decorate a mask and, once a grown-up cuts the eye holes, wear it and walk around.

Players: 1+ (solo or group)

Prerequisites: Comfortable decorating a plate independently

Materials: 1 paper plate or piece of cardstock per player | Crayons, markers, or paint | A craft stick or elastic string (to hold or wear the mask)

Follow the steps below to play!', NULL, N'An adult must cut the eye holes — that step is not for kids.', 75, N'sequence_steps', N'{"steps": ["Decorate your paper plate with your favorite colors and shapes.", "A grown-up carefully cuts two eye holes.", "Attach a craft stick or string so you can hold or wear it.", "Put it on and walk around showing everyone your design!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_1, N'short_response', N'🔗 First Paper Chain

Objective: Link five paper strips together on your own to make a short chain.

Players: 1+ (solo or group)

Prerequisites: Comfortable looping and holding a paper strip still

Materials: Several strips of colored paper per player or team | Tape or a glue stick | A stopwatch or phone timer (for the timed grades)

Follow the steps below to play!', NULL, N'Ask for help with the tape if it''s tricky to handle.', 76, N'sequence_steps', N'{"steps": ["Take a paper strip and loop it into a circle.", "Tape or glue the ends together.", "Loop a new strip through the last link and seal it.", "Keep going until you have five links, then count them!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_1, N'short_response', N'❄️ First Snowflake Catch

Objective: Help fold and cut a snowflake, then toss it gently and catch it yourself.

Players: 1+ (solo or group)

Prerequisites: Comfortable releasing and watching a fluttering paper

Materials: 1 square piece of paper per player | Scissors (adult-assisted) | A hula hoop or basket (for the target-toss grades)

Follow the steps below to play!', NULL, N'Only a grown-up should handle the scissors during cutting.', 77, N'sequence_steps', N'{"steps": ["Fold your paper into a small triangle with help.", "Watch a grown-up snip a few simple shapes into the edges.", "Unfold your snowflake and toss it up gently.", "Try to catch it as it flutters back down!"]}');

    DECLARE @cat_paper_2 INT;
    SELECT @cat_paper_2 = category_id FROM dbo.PacketCategories WHERE grade_id = 2 AND category_name = 'Outdoor Games';

    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_2, N'short_response', N'🐸 Frog Hop Practice

Objective: Fold your own paper frog with guidance and practice making it hop forward several times in a row.

Players: 1+ (solo or group)

Prerequisites: Comfortable with the First Frog Fold and Hop basics

Materials: 1 square piece of paper per player | A flat surface to hop on (table or floor) | A ruler or tape measure (for the distance grades)

Follow the steps below to play!', NULL, N'Fold gently and flick with a light touch on a flat surface.', 71, N'sequence_steps', N'{"steps": ["Fold your paper frog, asking for help on any tricky folds.", "Set it at a starting line on a table or floor.", "Flick its back to make it hop forward.", "Practice five hops in a row and count how many go straight!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_2, N'short_response', N'🔮 Fortune Teller Practice

Objective: Fold a fortune teller with less help and play a full round with a friend.

Players: 2 players

Prerequisites: Comfortable with the First Fortune Fold basics

Materials: 1 square piece of paper per player | Markers or crayons | A pencil (for writing fortunes and numbers)

Follow the steps below to play!', NULL, N'Fold gently along the creases so the paper doesn''t tear.', 72, N'sequence_steps', N'{"steps": ["Fold your fortune teller, only asking for help on the trickiest step.", "Write a number under each flap and a short fortune inside.", "Let a friend pick a color, a number, and a flap.", "Take turns being the fortune teller!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_2, N'short_response', N'🎐 Pinwheel Wind Walk

Objective: Carry your pinwheel on a walk and notice how the breeze makes it spin.

Players: 1+ (solo or group)

Prerequisites: Can hold a pinwheel steady while walking

Materials: 1 square piece of paper per player | 1 pin or brad fastener | 1 pencil with an eraser (to mount the pinwheel)

Follow the steps below to play!', NULL, N'Walk in an open, flat area away from stairs or traffic.', 73, N'sequence_steps', N'{"steps": ["Hold your pinwheel out in front of you.", "Walk slowly and watch what happens to the blades.", "Walk a little faster and see if it spins more.", "Find a breezy spot outside and hold it still to compare!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_2, N'short_response', N'🥤 Cup Stack Practice

Objective: Build and take apart a six-cup pyramid using both hands.

Players: 1+ (solo or group)

Prerequisites: Comfortable building a simple 3-cup pyramid

Materials: 9-12 paper or plastic cups per player | A stopwatch or phone timer (for the speed grades)

Follow the steps below to play!', NULL, N'Keep the stack on a flat surface away from table edges.', 74, N'sequence_steps', N'{"steps": ["Set up a six-cup pyramid: three, then two, then one.", "Practice stacking it up smoothly with both hands.", "Practice un-stacking it back into a row.", "Try three times and see if you get faster!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_2, N'short_response', N'🎭 Mask Parade Practice

Objective: Wear your finished mask and walk a simple marked path, showing off your design.

Players: 1+ (solo or group)

Prerequisites: Has a finished, wearable mask ready to go

Materials: 1 paper plate or piece of cardstock per player | Crayons, markers, or paint | A craft stick or elastic string (to hold or wear the mask)

Follow the steps below to play!', NULL, N'Walk slowly since the mask can block some side vision.', 75, N'sequence_steps', N'{"steps": ["Put on your mask and check that you can see clearly ahead.", "Walk along a marked path (a chalk line or row of cones).", "Wave to anyone watching as you pass by.", "Take a bow at the end of your parade walk!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_2, N'short_response', N'🔗 Chain Length Practice

Objective: Build a paper chain for two minutes and count or measure how long it grew.

Players: 1+ (solo or group)

Prerequisites: Can link paper strips together smoothly on their own

Materials: Several strips of colored paper per player or team | Tape or a glue stick | A stopwatch or phone timer (for the timed grades)

Follow the steps below to play!', NULL, N'Keep scissors, if used, only in grown-up hands.', 76, N'sequence_steps', N'{"steps": ["Set a timer for two minutes.", "Link as many paper strips together as you can.", "Stop when the timer goes off.", "Count the links or measure the total length!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_2, N'short_response', N'❄️ Snowflake Toss Practice

Objective: Toss and catch your snowflake solo, counting how many catches you can get in a row.

Players: 1+ (solo or group)

Prerequisites: Comfortable tossing and catching a fluttering object

Materials: 1 square piece of paper per player | Scissors (adult-assisted) | A hula hoop or basket (for the target-toss grades)

Follow the steps below to play!', NULL, N'Toss gently upward, not toward your face.', 77, N'sequence_steps', N'{"steps": ["Toss your snowflake a short distance up into the air.", "Catch it before it touches the ground.", "Toss it again right away.", "Count how many catches in a row you can make!"]}');

    DECLARE @cat_paper_3 INT;
    SELECT @cat_paper_3 = category_id FROM dbo.PacketCategories WHERE grade_id = 3 AND category_name = 'Outdoor Games';

    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_3, N'short_response', N'🐸 Frog Hop Distance Challenge

Objective: Fold a paper frog and measure how far it can hop in three flicks.

Players: 1+ (solo or group)

Prerequisites: Can fold a simple paper frog with only a little help

Materials: 1 square piece of paper per player | A flat surface to hop on (table or floor) | A ruler or tape measure (for the distance grades)

Follow the steps below to play!', NULL, N'Measure with a soft ruler edge, and keep fingers away from the flicking motion.', 71, N'sequence_steps', N'{"steps": ["Fold your paper frog and set it behind a starting line.", "Flick it forward one time and mark where it lands.", "Flick it two more times from that new spot.", "Measure the total distance from start to finish with a ruler!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_3, N'short_response', N'🔮 Fortune Teller Challenge

Objective: Write your own creative fortunes and play a full game with two friends.

Players: 3+ players

Prerequisites: Can fold a fortune teller independently

Materials: 1 square piece of paper per player | Markers or crayons | A pencil (for writing fortunes and numbers)

Follow the steps below to play!', NULL, N'Keep fortunes kind and silly — nothing that could hurt someone''s feelings.', 72, N'sequence_steps', N'{"steps": ["Fold your fortune teller and write eight fun, original fortunes inside.", "Gather two friends in a small circle.", "Take turns picking colors and numbers for each other.", "See whose fortunes get the biggest laughs!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_3, N'short_response', N'🎐 Pinwheel Spin Challenge

Objective: Time how long a single blow keeps your pinwheel spinning.

Players: 1+ (solo or group)

Prerequisites: Can assemble a pinwheel with only light help

Materials: 1 square piece of paper per player | 1 pin or brad fastener | 1 pencil with an eraser (to mount the pinwheel)

Follow the steps below to play!', NULL, N'Keep the pin-mounted pencil pointed away from faces while spinning.', 73, N'sequence_steps', N'{"steps": ["Assemble your pinwheel on its pencil.", "Have a friend start a timer the moment you blow.", "Watch until the blades stop turning completely.", "Record your time and try to beat it on a second try!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_3, N'short_response', N'🥤 Cup Stack Speed Challenge

Objective: Time how fast you can build a ten-cup pyramid.

Players: 1+ (solo or group)

Prerequisites: Confident building a six-cup pyramid without help

Materials: 9-12 paper or plastic cups per player | A stopwatch or phone timer (for the speed grades)

Follow the steps below to play!', NULL, N'Keep your stacking space clear of other players'' hands.', 74, N'sequence_steps', N'{"steps": ["Set out ten cups in a row.", "Have a friend start the timer when you begin stacking.", "Build the full pyramid as fast as you safely can.", "Record your time and try to beat it!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_3, N'short_response', N'🎭 Mask Character Challenge

Objective: Act out your mask''s character with movements and sounds while walking the parade route.

Players: 1+ (solo or group)

Prerequisites: Comfortable walking confidently while wearing a mask

Materials: 1 paper plate or piece of cardstock per player | Crayons, markers, or paint | A craft stick or elastic string (to hold or wear the mask)

Follow the steps below to play!', NULL, N'Keep movements safe and avoid anything that could make you trip.', 75, N'sequence_steps', N'{"steps": ["Decide who or what your mask''s character is.", "Practice a special walk, sound, or gesture for that character.", "Perform your character while walking the parade route.", "Ask a friend to guess who your character is!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_3, N'short_response', N'🔗 Chain Challenge

Objective: Build a paper chain in three minutes and compare its length with a friend''s.

Players: 2 players

Prerequisites: Comfortable building a chain quickly and neatly

Materials: Several strips of colored paper per player or team | Tape or a glue stick | A stopwatch or phone timer (for the timed grades)

Follow the steps below to play!', NULL, N'Work in your own space so strips and tape don''t get mixed up.', 76, N'sequence_steps', N'{"steps": ["Each player gets their own pile of paper strips.", "Set a three-minute timer and start building at the same time.", "Stop when the timer ends.", "Lay both chains side by side to compare their length!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_3, N'short_response', N'❄️ Snowflake Target Toss

Objective: Toss your snowflake so it lands inside a hoop or basket target.

Players: 1+ (solo or group)

Prerequisites: Comfortable controlling a gentle upward toss

Materials: 1 square piece of paper per player | Scissors (adult-assisted) | A hula hoop or basket (for the target-toss grades)

Follow the steps below to play!', NULL, N'Aim toward the target and keep the landing area clear of other players.', 77, N'sequence_steps', N'{"steps": ["Set a hula hoop or basket a few steps away as your target.", "Toss your snowflake gently toward the target.", "See if it lands inside or nearby.", "Try five tosses and count how many land inside!"]}');

    DECLARE @cat_paper_4 INT;
    SELECT @cat_paper_4 = category_id FROM dbo.PacketCategories WHERE grade_id = 4 AND category_name = 'Outdoor Games';

    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_4, N'short_response', N'🐸 Frog Hop Relay

Objective: Work with a team to hop paper frogs one after another down a marked path.

Players: Teams of 2+ (2 or more teams)

Prerequisites: Can reliably make a paper frog hop forward

Materials: 1 square piece of paper per player | A flat surface to hop on (table or floor) | A ruler or tape measure (for the distance grades)

Follow the steps below to play!', NULL, N'Keep the hopping lane clear and only flick your own frog.', 71, N'sequence_steps', N'{"steps": ["Each team member folds their own paper frog.", "Mark a start and finish line on the floor or table.", "The first player hops their frog to the finish, then the next player starts.", "The team that gets every frog across first wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_4, N'short_response', N'🔮 Fortune Teller Party

Objective: Run a small-group fortune teller circle where everyone gets a turn being the teller.

Players: 4+ players

Prerequisites: Comfortable running a full fortune-teller round for others

Materials: 1 square piece of paper per player | Markers or crayons | A pencil (for writing fortunes and numbers)

Follow the steps below to play!', NULL, N'Make sure every player gets an equal turn and a kind fortune.', 72, N'sequence_steps', N'{"steps": ["Everyone folds and decorates their own fortune teller.", "Sit in a circle and pass fortune tellers to your right.", "Give the fortune of the one you''re holding to its neighbor.", "Keep passing until everyone has heard a fortune!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_4, N'short_response', N'🎐 Pinwheel Run Race

Objective: Run holding your pinwheel and race to see whose spins fastest or longest.

Players: 2-4 players

Prerequisites: Comfortable running while holding an object steady

Materials: 1 square piece of paper per player | 1 pin or brad fastener | 1 pencil with an eraser (to mount the pinwheel)

Follow the steps below to play!', NULL, N'Race in a clear, open space with plenty of room between runners.', 73, N'sequence_steps', N'{"steps": ["Line up at a starting line, each with your own pinwheel.", "On ''go,'' run to the finish line holding your pinwheel out front.", "Watch whose pinwheel is spinning fastest as you cross.", "Race again and see if the same person wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_4, N'short_response', N'🥤 Cup Stack Race

Objective: Race a friend side-by-side to build and take apart a cup pyramid.

Players: 2 players

Prerequisites: Comfortable timing your own cup-stacking speed

Materials: 9-12 paper or plastic cups per player | A stopwatch or phone timer (for the speed grades)

Follow the steps below to play!', NULL, N'Give each racer their own space so hands don''t bump.', 74, N'sequence_steps', N'{"steps": ["Set up matching cup pyramids for both racers.", "On ''go,'' both racers stack their pyramid up.", "Then both racers take their pyramid back apart.", "Whoever finishes stacking AND unstacking first wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_4, N'short_response', N'🎭 Mask Parade Obstacle Walk

Objective: Wear your mask through a simple obstacle course, stepping over and around objects.

Players: 1+ (solo or group)

Prerequisites: Comfortable walking a parade route in character

Materials: 1 paper plate or piece of cardstock per player | Crayons, markers, or paint | A craft stick or elastic string (to hold or wear the mask)

Follow the steps below to play!', NULL, N'Set up low, soft obstacles and go slowly through the course.', 75, N'sequence_steps', N'{"steps": ["Set up a simple obstacle course with cones or soft objects to step around.", "Put on your mask and start at the beginning.", "Carefully step over and around each obstacle in character.", "Celebrate at the finish line with your best character pose!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_4, N'short_response', N'🔗 Chain Relay

Objective: Work with a team, taking turns adding links to build one long chain together.

Players: Teams of 2+ (2 or more teams)

Prerequisites: Comfortable linking strips quickly under a little pressure

Materials: Several strips of colored paper per player or team | Tape or a glue stick | A stopwatch or phone timer (for the timed grades)

Follow the steps below to play!', NULL, N'Only the player whose turn it is should be adding a link.', 76, N'sequence_steps', N'{"steps": ["Line your team up in a row.", "The first player adds one link, then passes the chain to the next player.", "Keep passing and adding links down the line.", "The team with the longest chain when time is up wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_4, N'short_response', N'❄️ Snowflake Toss Challenge

Objective: Toss and catch a snowflake back and forth with a partner, keeping a rally going.

Players: 2 players

Prerequisites: Comfortable tossing a snowflake with accuracy

Materials: 1 square piece of paper per player | Scissors (adult-assisted) | A hula hoop or basket (for the target-toss grades)

Follow the steps below to play!', NULL, N'Stand a comfortable distance apart so tosses stay gentle.', 77, N'sequence_steps', N'{"steps": ["Stand a few steps away from your partner.", "Gently toss the snowflake to them.", "Have them catch it and toss it right back.", "Count how many times you can pass it back and forth without dropping it!"]}');

    DECLARE @cat_paper_5 INT;
    SELECT @cat_paper_5 = category_id FROM dbo.PacketCategories WHERE grade_id = 5 AND category_name = 'Outdoor Games';

    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_5, N'short_response', N'🐸 Frog Hop Trick Practice

Objective: Practice flicking your paper frog to land it inside a small target and even make it spin.

Players: 1+ (solo or group)

Prerequisites: Comfortable hopping a frog a consistent distance forward

Materials: 1 square piece of paper per player | A flat surface to hop on (table or floor) | A ruler or tape measure (for the distance grades)

Follow the steps below to play!', NULL, N'Aim flicks carefully and keep the landing zone clear of other players.', 71, N'sequence_steps', N'{"steps": ["Set a small paper circle or box lid as a landing target a short hop away.", "Fold your frog and take aim at the target.", "Flick with different amounts of force to see what lands it inside.", "Try adding a light side-flick to make it spin as it lands!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_5, N'short_response', N'🔮 Fortune Teller Trick Practice

Objective: Practice folding a fortune teller as fast and neatly as possible.

Players: 1+ (solo or group)

Prerequisites: Very comfortable with the full folding sequence

Materials: 1 square piece of paper per player | Markers or crayons | A pencil (for writing fortunes and numbers)

Follow the steps below to play!', NULL, N'Fold quickly but carefully so creases stay sharp and even.', 72, N'sequence_steps', N'{"steps": ["Start a timer and fold a fortune teller as fast as you can.", "Check that all eight flaps open and close smoothly.", "Try again and see if your time improves.", "Compare your best time with a friend''s!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_5, N'short_response', N'🎐 Pinwheel Design Trick Practice

Objective: Decorate and adjust your pinwheel''s blade angle to test which design spins best.

Players: 1+ (solo or group)

Prerequisites: Comfortable assembling and testing a basic pinwheel

Materials: 1 square piece of paper per player | 1 pin or brad fastener | 1 pencil with an eraser (to mount the pinwheel)

Follow the steps below to play!', NULL, N'Test different folds carefully so the paper doesn''t tear at the center.', 73, N'sequence_steps', N'{"steps": ["Fold a second pinwheel with slightly different blade angles.", "Decorate both pinwheels so you can tell them apart.", "Blow on each one the same way and compare their spins.", "Decide which design spins better and why!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_5, N'short_response', N'🥤 Cup Stack Trick Practice

Objective: Practice the real sport-stacking 3-6-3 pattern for speed and accuracy.

Players: 1+ (solo or group)

Prerequisites: Solid experience building larger cup pyramids quickly

Materials: 9-12 paper or plastic cups per player | A stopwatch or phone timer (for the speed grades)

Follow the steps below to play!', NULL, N'Practice slowly first before trying for speed.', 74, N'sequence_steps', N'{"steps": ["Learn the 3-6-3 pattern: a 3-cup stack, a 6-cup stack, then another 3-cup stack.", "Practice building all three stacks in a row, slowly at first.", "Practice taking them all back down into a line.", "Repeat until the pattern starts to feel smooth!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_5, N'short_response', N'🎭 Mask Design Trick Practice

Objective: Add 3D details like paper strips or folds to make your mask more dramatic.

Players: 1+ (solo or group)

Prerequisites: Has already completed one full mask design

Materials: 1 paper plate or piece of cardstock per player | Crayons, markers, or paint | A craft stick or elastic string (to hold or wear the mask)

Follow the steps below to play!', NULL, N'An adult should help attach any small extra pieces securely.', 75, N'sequence_steps', N'{"steps": ["Look at your finished mask and think of one part to make 3D.", "Cut and fold paper strips to add texture, like fur, feathers, or spikes.", "Attach them carefully to your mask.", "Try it on and see how the new details move as you walk!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_5, N'short_response', N'🔗 Chain Speed Trick Practice

Objective: Practice a fast looping-and-taping technique to build your chain more efficiently.

Players: 1+ (solo or group)

Prerequisites: Solid experience building chains under a timer

Materials: Several strips of colored paper per player or team | Tape or a glue stick | A stopwatch or phone timer (for the timed grades)

Follow the steps below to play!', NULL, N'Move quickly but keep your fingers clear of the tape''s sticky edges carefully.', 76, N'sequence_steps', N'{"steps": ["Pre-fold or pre-loop several strips before you start the timer.", "Practice taping with one quick motion instead of many small ones.", "Time yourself building ten links using your new technique.", "Compare that time to your old method!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_5, N'short_response', N'❄️ Snowflake Design Trick Practice

Objective: Cut a more intricate snowflake pattern and test how differently it flutters.

Players: 1+ (solo or group)

Prerequisites: Comfortable with basic snowflake folding and design

Materials: 1 square piece of paper per player | Scissors (adult-assisted) | A hula hoop or basket (for the target-toss grades)

Follow the steps below to play!', NULL, N'An adult should do the more detailed cutting for intricate patterns.', 77, N'sequence_steps', N'{"steps": ["Fold your paper into a tighter triangle for a more detailed pattern.", "Have a grown-up help snip extra small shapes into the edges.", "Unfold it and compare how it looks to a simple snowflake.", "Toss both and see which one flutters more slowly!"]}');

    DECLARE @cat_paper_6 INT;
    SELECT @cat_paper_6 = category_id FROM dbo.PacketCategories WHERE grade_id = 6 AND category_name = 'Outdoor Games';

    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_6, N'short_response', N'🐸 Frog Hop Championship

Objective: Compete to see whose single paper-frog hop travels the farthest.

Players: Teams of 2+ (2 or more teams)

Prerequisites: Solid control over hop direction and distance

Materials: 1 square piece of paper per player | A flat surface to hop on (table or floor) | A ruler or tape measure (for the distance grades)

Follow the steps below to play!', NULL, N'Take turns one at a time so measuring stays accurate and safe.', 71, N'sequence_steps', N'{"steps": ["Everyone folds their own paper frog at the same starting line.", "Take turns flicking one single best hop each.", "Measure and record each player''s distance.", "The longest single hop is the champion!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_6, N'short_response', N'🔮 Fortune Teller Championship

Objective: Compete on both folding speed and the creativity of your written fortunes.

Players: Teams of 2+ (2 or more teams)

Prerequisites: Fast, confident folding plus creative writing

Materials: 1 square piece of paper per player | Markers or crayons | A pencil (for writing fortunes and numbers)

Follow the steps below to play!', NULL, N'Keep the writing contest friendly and encouraging.', 72, N'sequence_steps', N'{"steps": ["Race to fold a neat fortune teller against the clock.", "Write eight fortunes that are funny, kind, or clever.", "Trade with another player and rate the fortunes together.", "Crown a folding-speed winner and a most-creative-fortunes winner!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_6, N'short_response', N'🎐 Pinwheel Championship

Objective: Compete head-to-head to see whose pinwheel spins the longest from one blow.

Players: Teams of 2+ (2 or more teams)

Prerequisites: Confident pinwheel assembly and a tested design

Materials: 1 square piece of paper per player | 1 pin or brad fastener | 1 pencil with an eraser (to mount the pinwheel)

Follow the steps below to play!', NULL, N'Blow one at a time so the timer stays accurate.', 73, N'sequence_steps', N'{"steps": ["Each player brings their best pinwheel design.", "Take turns blowing once while a timer counts the spin.", "Record every player''s best time.", "The longest spin time wins the championship!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_6, N'short_response', N'🥤 Cup Stack Championship

Objective: Compete on time to complete a full 3-6-3 stack-and-unstack cycle.

Players: Teams of 2+ (2 or more teams)

Prerequisites: Comfortable performing the 3-6-3 pattern

Materials: 9-12 paper or plastic cups per player | A stopwatch or phone timer (for the speed grades)

Follow the steps below to play!', NULL, N'Take turns one at a time so times are measured fairly.', 74, N'sequence_steps', N'{"steps": ["Each player sets up their 3-6-3 starting cups.", "On ''go,'' stack all three formations as fast as possible.", "Then unstack them all back into a line.", "The fastest full cycle wins the championship!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_6, N'short_response', N'🎭 Mask Parade Championship

Objective: Take part in a group parade with friendly votes for best design and best character acting.

Players: Whole group (6+)

Prerequisites: Has a finished mask and a practiced character walk

Materials: 1 paper plate or piece of cardstock per player | Crayons, markers, or paint | A craft stick or elastic string (to hold or wear the mask)

Follow the steps below to play!', NULL, N'Keep the voting kind and encouraging for everyone.', 75, N'sequence_steps', N'{"steps": ["Everyone lines up wearing their finished masks.", "Take turns parading past the group in character.", "The group votes on a favorite design and a favorite performance.", "Celebrate every mask with a round of applause!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_6, N'short_response', N'🔗 Chain Championship

Objective: Compete in a team timed build-off to see which team makes the longest chain in five minutes.

Players: Teams of 2+ (2 or more teams)

Prerequisites: Comfortable with fast chain-building technique

Materials: Several strips of colored paper per player or team | Tape or a glue stick | A stopwatch or phone timer (for the timed grades)

Follow the steps below to play!', NULL, N'Keep each team''s paper and tape supply clearly separated.', 76, N'sequence_steps', N'{"steps": ["Give each team an equal pile of paper strips and tape.", "Start a five-minute timer for all teams at once.", "Everyone builds as fast and as long as they can.", "Measure every team''s chain — the longest wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_6, N'short_response', N'❄️ Snowflake Championship

Objective: Compete in a target-toss contest to see who lands the most snowflakes in a basket out of five tries.

Players: Teams of 2+ (2 or more teams)

Prerequisites: Confident, accurate target tossing

Materials: 1 square piece of paper per player | Scissors (adult-assisted) | A hula hoop or basket (for the target-toss grades)

Follow the steps below to play!', NULL, N'Take turns one at a time to keep scoring fair and clear.', 77, N'sequence_steps', N'{"steps": ["Set up one basket or hoop target for the group.", "Each player takes five tosses at the target.", "Count how many of each player''s five tosses land inside.", "The player with the most successful tosses wins the championship!"]}');

    DECLARE @cat_paper_7 INT;
    SELECT @cat_paper_7 = category_id FROM dbo.PacketCategories WHERE grade_id = 7 AND category_name = 'Outdoor Games';

    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_7, N'short_response', N'🐸 Frog Hop Masters

Objective: Design and hop your paper frog through a mini obstacle course made of paper hoops and lines.

Players: 1+ (solo or group)

Prerequisites: Championship-level control over hop distance and direction

Materials: 1 square piece of paper per player | A flat surface to hop on (table or floor) | A ruler or tape measure (for the distance grades)

Follow the steps below to play!', NULL, N'Build the obstacle course on a flat, clutter-free surface.', 71, N'sequence_steps', N'{"steps": ["Set up a mini course with paper-loop ''hoops'' and taped lines to hop between.", "Fold your frog and plan a path through the course.", "Flick your way through, trying to complete it in the fewest hops.", "Race a friend to see who clears the whole course first!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_7, N'short_response', N'🔮 Fortune Teller Masters

Objective: Design an elaborate themed fortune teller and run a mini fortune-telling booth for friends or family.

Players: 1+ (solo or group)

Prerequisites: Championship-level folding and fortune-writing skill

Materials: 1 square piece of paper per player | Markers or crayons | A pencil (for writing fortunes and numbers)

Follow the steps below to play!', NULL, N'Set up your booth somewhere it won''t block walkways.', 72, N'sequence_steps', N'{"steps": ["Pick a fun theme (space, animals, sports) for your fortune teller.", "Design and write themed fortunes to match.", "Set up a little ''booth'' and invite friends or family to play.", "Keep a tally of everyone''s fortunes for extra fun!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_7, N'short_response', N'🎐 Pinwheel Masters

Objective: Engineer and test three different pinwheel blade designs, recording which spins longest.

Players: 1+ (solo or group)

Prerequisites: Championship-level testing and comparison skills

Materials: 1 square piece of paper per player | 1 pin or brad fastener | 1 pencil with an eraser (to mount the pinwheel)

Follow the steps below to play!', NULL, N'Keep pins and pencils pointed safely away from others while testing.', 73, N'sequence_steps', N'{"steps": ["Build three pinwheels with different blade shapes or angles.", "Test each one the same way and time its spin.", "Write down the results for all three designs.", "Share which design worked best and why you think so!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_7, N'short_response', N'🥤 Cup Stack Masters

Objective: Complete the full advanced cycle: 3-6-3 up and down, then a 6-6 stack up and down, for best overall time.

Players: 1+ (solo or group)

Prerequisites: Championship-level speed with the 3-6-3 pattern

Materials: 9-12 paper or plastic cups per player | A stopwatch or phone timer (for the speed grades)

Follow the steps below to play!', NULL, N'Warm up your hands first and stack on a stable table.', 74, N'sequence_steps', N'{"steps": ["Perform the 3-6-3 stack up, then take it back down.", "Immediately build a 6-6 stack (two six-cup towers), then take it down.", "Time your entire combined routine.", "Practice again to smooth out your best time!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_7, N'short_response', N'🎭 Mask Parade Masters

Objective: Design a mask and perform a short in-character skit while wearing it.

Players: 1+ (solo or group)

Prerequisites: Championship-level mask design and character acting

Materials: 1 paper plate or piece of cardstock per player | Crayons, markers, or paint | A craft stick or elastic string (to hold or wear the mask)

Follow the steps below to play!', NULL, N'Keep the skit space clear and practice movements safely beforehand.', 75, N'sequence_steps', N'{"steps": ["Design your most detailed mask yet, with a clear character in mind.", "Write or plan three short lines or actions for your character.", "Put on the mask and perform your mini skit for an audience.", "Take a bow and ask for feedback on your performance!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_7, N'short_response', N'🔗 Chain Masters

Objective: Plan and run a team strategy where players specialize as cutter, looper, and taper for maximum speed.

Players: Teams of 2+ (2 or more teams)

Prerequisites: Championship-level chain-building experience

Materials: Several strips of colored paper per player or team | Tape or a glue stick | A stopwatch or phone timer (for the timed grades)

Follow the steps below to play!', NULL, N'Only the designated cutter handles scissors, with adult supervision.', 76, N'sequence_steps', N'{"steps": ["Assign team roles: one cutter, one looper, one taper (add more roles for bigger teams).", "Practice your assembly line for one minute before the real round.", "Run your full assembly line for five minutes.", "Measure your chain and talk about what worked best!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_paper_7, N'short_response', N'❄️ Snowflake Masters

Objective: Design and test three different snowflake shapes to see which flutters farthest or most accurately.

Players: 1+ (solo or group)

Prerequisites: Championship-level snowflake design and toss testing

Materials: 1 square piece of paper per player | Scissors (adult-assisted) | A hula hoop or basket (for the target-toss grades)

Follow the steps below to play!', NULL, N'Keep the testing area clear and toss away from anyone''s face.', 77, N'sequence_steps', N'{"steps": ["Design and cut three snowflakes with different shapes or sizes.", "Toss each one the same way toward a target.", "Record which one landed closest or most often.", "Explain to a friend which design worked best and why!"]}');

END
GO

DELETE FROM dbo.WeeklyPacketPlan;
GO
