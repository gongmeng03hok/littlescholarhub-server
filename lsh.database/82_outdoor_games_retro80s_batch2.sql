-- 82_outdoor_games_retro80s_batch2.sql
-- Extends the existing 'Outdoor Games' category (see 68/69/70/71) with 7
-- more games per grade (35 -> 42), continuing the 1980s-retro theme from
-- batch 71 with a fresh set of classic playground/field-day mechanics not
-- already covered: Red Rover, Mother May I, Steal the Bacon, Sack Race, Egg
-- and Spoon Race, Three-Legged/Wheelbarrow Race, plus one special per grade
-- (London Bridge, Tetherball, Roller Skating Relay, Ghost in the Graveyard).
--
-- Appends to the SAME per-grade PacketCategories row with sort_order
-- continuing from 36. target_count stays at 7 per batch (14 retro-80s
-- games total per grade after this migration).
-- See gen_82_outdoor_games_retro80s_batch2.py.

IF NOT EXISTS (
    SELECT 1 FROM dbo.PacketQuestions q
    JOIN dbo.PacketCategories c ON c.category_id = q.category_id
    WHERE c.category_name = 'Outdoor Games' AND c.grade_id = 0 AND q.sort_order = 36
)
BEGIN
    DECLARE @cat_80s2_0 INT;
    SELECT @cat_80s2_0 = category_id FROM dbo.PacketCategories WHERE grade_id = 0 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_0, N'short_response', N'🙌 Red Rover Wave Hello

80s Inspiration: A gentle, safety-first take on the classic Red Rover call-and-cross game.

Objective: Practice walking confidently across an open space while friends cheer you on.

Materials: None -- just open space!

Follow the steps below to play!', NULL, N'Walk, don''t run, and hold hands gently -- this is a friendly walk-over, not a crash.', 36, N'sequence_steps', N'{"steps": ["Two lines of kids stand facing each other, holding hands loosely with a grown-up nearby.", "One line calls a friend''s name from the other side: ''Red Rover, Red Rover, send [name] right over!''", "That friend walks (not runs) across to the other line.", "They join hands at the end of the new line, then it''s someone else''s turn."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_0, N'short_response', N'👑 Mother May I Baby Steps

80s Inspiration: A simplified version of the classic permission-asking playground game.

Objective: Practice listening carefully and following simple step directions.

Materials: None -- just open space!

Follow the steps below to play!', NULL, N'Only move after Mother says yes -- and always take small, careful steps.', 37, N'sequence_steps', N'{"steps": ["One grown-up or child is ''Mother'' and stands at the finish line.", "Everyone else lines up far away and takes turns asking, ''Mother, may I take 2 baby steps?''", "Mother says ''Yes, you may!'' before that player moves.", "First player to reach Mother wins, then picks the next Mother!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_0, N'short_response', N'🥓 Steal the Bacon Gentle Start

80s Inspiration: A slowed-down, walk-only version of the classic team retrieval game.

Objective: Practice quick walking and grabbing a soft object placed in the middle.

Materials: 1 soft object (a rolled sock or beanbag)

Follow the steps below to play!', NULL, N'Walk quickly instead of running, and tag gently with an open hand.', 38, N'sequence_steps', N'{"steps": ["Two small teams line up facing each other, with the object placed exactly in the middle.", "A grown-up calls one player''s number from each team.", "Both players walk quickly to the middle and try to grab the object first.", "Whoever grabs it walks it back to their team without being gently tagged."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_0, N'short_response', N'🛍️ Sack Hop Starter

80s Inspiration: A short, simple version of the classic field-day potato sack race.

Objective: Practice hopping while holding onto a soft sack or pillowcase.

Materials: 1 soft pillowcase or cloth sack per child

Follow the steps below to play!', NULL, N'Hop slowly and stay balanced -- it''s okay to take tiny hops.', 39, N'sequence_steps', N'{"steps": ["Step into the sack and hold the top edge with both hands.", "Line up at a starting line a few big steps from the finish.", "Hop forward slowly, one small hop at a time.", "Reach the finish line, then try again a little faster!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_0, N'short_response', N'🥄 Egg and Spoon Wobble Walk

80s Inspiration: A gentle version of the classic field-day egg-and-spoon race, using a soft ball instead of a real egg.

Objective: Practice balancing a soft ball on a spoon while walking carefully.

Materials: 1 large spoon per child | 1 small soft ball or pom-pom per child

Follow the steps below to play!', NULL, N'Walk slowly and watch your feet -- this game is about balance, not speed.', 40, N'sequence_steps', N'{"steps": ["Place the soft ball on the spoon and hold the spoon handle flat.", "Walk slowly from the start line to the finish line.", "If the ball falls off, stop and put it back on before continuing.", "See how many times you can cross without dropping it!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_0, N'short_response', N'🤝 Buddy Steps Partner Walk

80s Inspiration: A safe warm-up version of the classic three-legged race, using linked arms instead of tied legs.

Objective: Practice walking in sync with a partner, side by side.

Materials: None -- just open space!

Follow the steps below to play!', NULL, N'Walk slowly and stay close together so neither friend trips.', 41, N'sequence_steps', N'{"steps": ["Stand side by side with a partner and link arms or hold hands.", "Practice saying ''left, right, left, right'' together before moving.", "Walk forward slowly, stepping with the same foot at the same time.", "Try to reach a nearby marker together without letting go!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_0, N'short_response', N'🌉 London Bridge Sing-Along

80s Inspiration: A classic traditional singing-and-movement circle game passed down for generations.

Objective: Practice moving through a bridge shape made by two friends'' raised arms, in time with a song.

Materials: None -- just open space!

Follow the steps below to play!', NULL, N'Lower your arms gently -- this is a soft, playful catch, not a grab.', 42, N'sequence_steps', N'{"steps": ["Two children face each other and raise joined hands to make a ''bridge.''", "Everyone else walks in a line underneath the bridge, one at a time.", "The two bridge-makers gently lower their arms to ''catch'' whoever is underneath at the end of the song.", "The caught friend picks the next song verse or becomes part of the bridge!"]}');

    DECLARE @cat_80s2_1 INT;
    SELECT @cat_80s2_1 = category_id FROM dbo.PacketCategories WHERE grade_id = 1 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_1, N'short_response', N'🙌 Red Rover Gentle Version

80s Inspiration: A safety-first take on the classic Red Rover call-and-cross game.

Objective: Practice jogging lightly across an open space and gently letting go of hands.

Materials: None -- just open space!

Follow the steps below to play!', NULL, N'Jog lightly, never crash into arms -- gently touch and let go, no rough contact.', 36, N'sequence_steps', N'{"steps": ["Two lines of kids stand facing each other, holding hands with a grown-up supervising.", "One line calls a friend''s name: ''Red Rover, Red Rover, send [name] right over!''", "That friend jogs lightly across and gently tries to pass through a pair of joined hands.", "If hands separate, that friend joins the new line; if not, they go back to their own team."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_1, N'short_response', N'👑 Mother May I Basics

80s Inspiration: The classic permission-asking playground game, with a few different step types.

Objective: Practice asking politely and following different types of movement steps.

Materials: None -- just open space!

Follow the steps below to play!', NULL, N'Only move after hearing ''yes,'' and keep steps under control.', 37, N'sequence_steps', N'{"steps": ["One player is ''Mother'' and stands at the finish line; everyone else lines up far away.", "Take turns asking, ''Mother, may I take 3 giant steps?'' or ''2 bunny hops?''", "Mother says ''Yes, you may!'' before you move -- if you forget to ask, you go back to start.", "First player to reach Mother wins and becomes the next Mother!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_1, N'short_response', N'🥓 Steal the Bacon Basics

80s Inspiration: The classic team game where a called player races to grab an object first.

Objective: Practice quick reactions, running, and gentle tagging in a team retrieval game.

Materials: 1 soft object (a rolled sock or beanbag)

Follow the steps below to play!', NULL, N'Tag gently with an open hand, and always run with your eyes up.', 38, N'sequence_steps', N'{"steps": ["Two teams line up facing each other with the object placed in the middle.", "A grown-up calls a matching number from each team to run to the middle.", "Whoever grabs the object first tries to run it back to their own line.", "The other player tries to gently tag them before they get back -- a tag before home means a point for the tagger''s team!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_1, N'short_response', N'🛍️ Sack Race Basics

80s Inspiration: The classic field-day potato sack race.

Objective: Practice hopping steadily in a sack over a short race distance.

Materials: 1 soft pillowcase or cloth sack per child

Follow the steps below to play!', NULL, N'If you feel wobbly, take smaller hops -- staying upright matters more than speed.', 39, N'sequence_steps', N'{"steps": ["Step into the sack and hold the top edge firmly with both hands.", "Line up at the start line, a short distance from the finish.", "On ''go,'' hop forward toward the finish line as steadily as you can.", "First to cross the finish line without falling wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_1, N'short_response', N'🥄 Egg and Spoon Basics

80s Inspiration: The classic field-day egg-and-spoon race, using a soft ball for safety.

Objective: Practice balancing a soft ball on a spoon while walking briskly.

Materials: 1 large spoon per child | 1 small soft ball or pom-pom per child

Follow the steps below to play!', NULL, N'Walking beats running here -- go at a pace where you can still balance.', 40, N'sequence_steps', N'{"steps": ["Balance the soft ball on the spoon and hold the handle steady.", "Line up at the start, a short distance from the finish.", "Walk briskly to the finish line without letting the ball fall.", "If it falls, pick it back up and keep going -- first to finish wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_1, N'short_response', N'🦵 Three-Legged Race Basics

80s Inspiration: The classic field-day three-legged race.

Objective: Practice walking in sync with a partner whose ankle is gently tied to yours.

Materials: 1 soft scarf or strip of cloth per pair

Follow the steps below to play!', NULL, N'Tie the cloth loosely (never tight), and always start slow before speeding up.', 41, N'sequence_steps', N'{"steps": ["Stand side by side with a partner and loosely tie your inside ankles together with the soft cloth.", "Put your arms around each other''s shoulders or hold hands for balance.", "Practice saying ''left, right, left, right'' together, then walk slowly toward a nearby marker.", "Once you''re steady, try picking up the pace a little!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_1, N'short_response', N'🛼 Roller Skate Wobble Walk

80s Inspiration: A gentle introduction to the roller-skating relays that were everywhere on 1980s playgrounds.

Objective: Practice basic balance and small steps while wearing roller skates.

Materials: Roller skates (with a grown-up spotting) | A smooth, flat surface

Follow the steps below to play!', NULL, N'Always skate with a grown-up nearby, and wear a helmet if you have one.', 42, N'sequence_steps', N'{"steps": ["Put on roller skates and stand still first, getting used to the feel.", "Hold a grown-up''s hand or a railing for the first few steps.", "Take small, careful rolling steps forward, one foot at a time.", "Once you feel steady, try letting go for just a few seconds!"]}');

    DECLARE @cat_80s2_2 INT;
    SELECT @cat_80s2_2 = category_id FROM dbo.PacketCategories WHERE grade_id = 2 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_2, N'short_response', N'🙌 Red Rover Warm-Up

80s Inspiration: The classic call-and-cross team game, played with a safety-first mindset.

Objective: Practice jogging with control and breaking through joined hands safely.

Materials: None -- just open space!

Follow the steps below to play!', NULL, N'Jog under control -- no full sprinting or slamming into arms.', 36, N'sequence_steps', N'{"steps": ["Two teams form lines facing each other, holding hands.", "One team calls a player from the other side by name.", "That player jogs across and tries to gently break through a pair of joined hands.", "If they break through, they pick a player to bring back to their team; if not, they join the new line."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_2, N'short_response', N'👑 Mother May I Challenge

80s Inspiration: The classic permission-asking game, with a wider variety of step types.

Objective: Practice strategic step choices while following clear directions.

Materials: None -- just open space!

Follow the steps below to play!', NULL, N'Keep steps controlled, especially spins -- stay aware of your neighbors.', 37, N'sequence_steps', N'{"steps": ["One player is Mother; everyone else lines up at the start.", "Ask for different step types: giant steps, baby steps, scissor steps, or spins.", "Mother approves or denies the request -- if denied, try a different step.", "First to tag Mother wins and takes over as the next Mother!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_2, N'short_response', N'🥓 Steal the Bacon Relay

80s Inspiration: The classic team game, adapted so every player gets a turn in order.

Objective: Practice quick decision-making and teamwork in a relay-style retrieval game.

Materials: 1 soft object (a rolled sock or beanbag)

Follow the steps below to play!', NULL, N'Tag with an open hand only, and keep your head up while running.', 38, N'sequence_steps', N'{"steps": ["Two teams line up in order, facing each other, with the object in the middle.", "The first player from each team runs to grab the object when a grown-up says ''go.''", "Whoever grabs it races it back to their team''s line before being tagged.", "Next pair of players goes, continuing until every player has had a turn."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_2, N'short_response', N'🛍️ Sack Race Challenge

80s Inspiration: The classic field-day potato sack race, with an added turn for more challenge.

Objective: Practice steady hopping over a longer race distance with a turnaround.

Materials: 1 soft pillowcase or cloth sack per child | 1 cone or marker

Follow the steps below to play!', NULL, N'Slow down around the turn so you don''t tip over.', 39, N'sequence_steps', N'{"steps": ["Step into the sack and line up at the start, with a cone placed partway to the finish.", "Hop to the cone, go around it, then hop back to the start.", "Stay balanced the whole way -- falling means starting that lap again.", "First one back to the start line wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_2, N'short_response', N'🥄 Egg and Spoon Challenge

80s Inspiration: The classic field-day egg-and-spoon race, with an added turn for more challenge.

Objective: Practice balancing while walking around an obstacle.

Materials: 1 large spoon per child | 1 small soft ball or pom-pom per child | 1 cone or marker

Follow the steps below to play!', NULL, N'Slow way down for the turn -- that''s when most balls fall.', 40, N'sequence_steps', N'{"steps": ["Balance the ball on the spoon and walk toward a cone placed partway to the finish.", "Carefully go around the cone without dropping the ball.", "Walk back to the start line, keeping your balance the whole way.", "If the ball falls, stop, pick it up, and keep going!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_2, N'short_response', N'🦵 Three-Legged Race Challenge

80s Inspiration: The classic field-day three-legged race, stepped up with a full race course.

Objective: Practice coordinated walking with a partner over a longer race distance.

Materials: 1 soft scarf or strip of cloth per pair

Follow the steps below to play!', NULL, N'If you start to stumble, slow down together rather than one person speeding up.', 41, N'sequence_steps', N'{"steps": ["Loosely tie inside ankles together with your partner and get into a starting stance.", "Count ''1, 2, 1, 2'' out loud together as you take your first few steps.", "Race toward the finish line, staying in sync with your partner.", "First pair to cross the finish line together wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_2, N'short_response', N'🏓 Tetherball Intro

80s Inspiration: The classic playground tetherball game, found on nearly every 1980s schoolyard.

Objective: Practice hitting a ball on a rope around a pole with a partner.

Materials: A tetherball pole and ball (or improvised rope-and-ball setup)

Follow the steps below to play!', NULL, N'Hit the ball, not your partner''s hands -- keep a safe distance apart.', 42, N'sequence_steps', N'{"steps": ["Stand on opposite sides of the pole from your partner.", "Take turns hitting the ball with an open hand or fist to wind the rope around the pole in your direction.", "Your partner tries to hit it back the other way to unwind it.", "The first player to fully wind the rope around the pole (in their direction) wins the round!"]}');

    DECLARE @cat_80s2_3 INT;
    SELECT @cat_80s2_3 = category_id FROM dbo.PacketCategories WHERE grade_id = 3 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_3, N'short_response', N'🙌 Red Rover Championship

80s Inspiration: The classic call-and-cross team game, played with strategic team calling.

Objective: Practice teamwork strategy in choosing which player to call across.

Materials: None -- just open space!

Follow the steps below to play!', NULL, N'Jog with control, and always break through with an open, gentle push -- never a shoulder charge.', 36, N'sequence_steps', N'{"steps": ["Two teams form lines facing each other, holding hands firmly but gently.", "Teams huddle briefly to decide strategically which opposing player to call.", "The called player jogs across and tries to break through a pair of joined hands.", "Winners of each round bring a player back to their team; play multiple rounds to see which team grows biggest!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_3, N'short_response', N'👑 Mother May I Teams

80s Inspiration: A team relay twist on the classic Mother May I game.

Objective: Practice teamwork by taking turns asking permission as a relay team.

Materials: None -- just open space!

Follow the steps below to play!', NULL, N'Wait your turn patiently, and keep steps under control near your teammates.', 37, N'sequence_steps', N'{"steps": ["Split into small teams lined up behind a starting line, with one team''s turn at a time.", "One player per team asks Mother for a type of step and, if approved, moves.", "Then it''s the next player''s turn on that team, and so on.", "First team to get every player to Mother wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_3, N'short_response', N'🥓 Steal the Bacon Teams

80s Inspiration: A team-based expansion of the classic Steal the Bacon game.

Objective: Practice quick teamwork calls and multi-player retrieval strategy.

Materials: 1-2 soft objects (rolled socks or beanbags)

Follow the steps below to play!', NULL, N'Tag gently with an open hand, and never grab a teammate''s clothing to pull them.', 38, N'sequence_steps', N'{"steps": ["Two teams line up facing each other with one or two objects placed in the middle.", "A grown-up calls TWO numbers from each team at once, so pairs race together.", "Partners can work together to grab an object and protect each other from being tagged.", "Whichever team scores the most successful retrievals after several rounds wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_3, N'short_response', N'🛍️ Sack Race Relay

80s Inspiration: A relay-team version of the classic potato sack race.

Objective: Practice teamwork by passing the sack to the next teammate in a relay.

Materials: 1-2 soft pillowcases or cloth sacks | 1 cone or marker per lane

Follow the steps below to play!', NULL, N'Hand off the sack carefully -- don''t throw it -- and wait for a clear tag before starting.', 39, N'sequence_steps', N'{"steps": ["Split into teams lined up behind a starting line, with a cone placed down the lane.", "The first player hops in the sack to the cone, back, then hands the sack to the next teammate.", "Continue until every player on the team has had a turn.", "First team to finish wins the relay!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_3, N'short_response', N'🥄 Egg and Spoon Relay

80s Inspiration: A relay-team version of the classic egg-and-spoon race.

Objective: Practice teamwork by handing off a balanced spoon to the next teammate.

Materials: 1-2 large spoons | 1-2 small soft balls or pom-poms | 1 cone or marker per lane

Follow the steps below to play!', NULL, N'Hand off slowly and carefully so the ball doesn''t fall during the pass.', 40, N'sequence_steps', N'{"steps": ["Split into teams; the first player balances the ball on the spoon and walks to a cone and back.", "Carefully hand the spoon (with the ball still balanced) to the next teammate.", "If the ball falls during a hand-off, pick it back up and try again.", "First team to get every player through the relay wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_3, N'short_response', N'🦵 Three-Legged Race Relay

80s Inspiration: A relay-team version of the classic three-legged race.

Objective: Practice coordinated team racing with multiple tied pairs taking turns.

Materials: Soft scarves or strips of cloth, one per pair | 1 cone or marker per lane

Follow the steps below to play!', NULL, N'Untie ankles fully before the next pair starts, so nobody trips over loose cloth.', 41, N'sequence_steps', N'{"steps": ["Split into teams of paired-up partners, tied loosely at the ankle.", "The first pair races to a cone and back, then unties and tags the next pair.", "Continue until every pair on the team has raced.", "First team to finish wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_3, N'short_response', N'🛼 Roller Skating Relay

80s Inspiration: The classic roller-skating relays that were a staple of 1980s neighborhood playgrounds.

Objective: Practice balanced skating over a short distance as part of a team relay.

Materials: Roller skates | A smooth, flat surface | 1 cone or marker per lane

Follow the steps below to play!', NULL, N'Skate on a flat, open surface away from traffic, and wear a helmet and pads if you have them.', 42, N'sequence_steps', N'{"steps": ["Split into teams; the first skater rolls carefully to a cone and back.", "Tag the next teammate''s hand to pass the turn.", "Continue until every teammate has skated their turn.", "First team to finish wins -- balance matters more than speed!"]}');

    DECLARE @cat_80s2_4 INT;
    SELECT @cat_80s2_4 = category_id FROM dbo.PacketCategories WHERE grade_id = 4 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_4, N'short_response', N'🙌 Red Rover Advanced Strategy

80s Inspiration: The classic call-and-cross team game, with real strategic thinking.

Objective: Practice reading the other team''s line to choose the weakest link to call.

Materials: None -- just open space!

Follow the steps below to play!', NULL, N'Strategy is about WHERE you break through, not how hard -- always stay in control.', 36, N'sequence_steps', N'{"steps": ["Two teams form lines facing each other, holding hands.", "Before calling, scan the other line for a spot where two smaller hands might be easier to break through.", "Call that player''s name; they jog across and try to break through.", "Track how many players each team gains over several rounds to see who wins overall."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_4, N'short_response', N'👑 Mother May I Strategy

80s Inspiration: A strategy-focused twist on the classic Mother May I game.

Objective: Practice choosing the most efficient step type to reach the finish fastest.

Materials: None -- just open space!

Follow the steps below to play!', NULL, N'Even ''giant steps'' should stay controlled -- no leaping into a neighbor''s space.', 37, N'sequence_steps', N'{"steps": ["Estimate the distance to Mother and think about which step type covers it fastest.", "Ask for that step type -- but Mother might approve a smaller step instead as a twist!", "Adjust your strategy each turn based on what''s approved.", "First to reach Mother wins and becomes the next Mother!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_4, N'short_response', N'🥓 Steal the Bacon Strategy

80s Inspiration: A strategy-focused twist on the classic Steal the Bacon game.

Objective: Practice reading an opponent''s movement to decide when to grab and when to fake.

Materials: 1 soft object (a rolled sock or beanbag)

Follow the steps below to play!', NULL, N'Fakes are for footwork, not physical contact -- keep hands to yourself until it''s a real grab.', 38, N'sequence_steps', N'{"steps": ["Two teams line up with the object in the middle; a number is called from each side.", "Try faking a grab to see how your opponent reacts before actually going for it.", "Whoever actually grabs it runs it home while the other tries to tag them.", "Keep score over several rounds -- whoever reads their opponent best usually wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_4, N'short_response', N'🛍️ Sack Race Obstacle Course

80s Inspiration: A leveled-up version of the classic potato sack race with an obstacle course twist.

Objective: Practice hopping steadily through a short course with multiple obstacles.

Materials: Soft pillowcases or cloth sacks | 3-4 cones or markers

Follow the steps below to play!', NULL, N'Slow down at each turn -- a wide course beats a fast fall.', 39, N'sequence_steps', N'{"steps": ["Set up 3-4 cones in a winding path from start to finish.", "Step into the sack and hop the winding path around each cone.", "Stay balanced through each turn -- falling means going back to the last cone you passed.", "First to complete the whole course wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_4, N'short_response', N'🥄 Egg and Spoon Obstacle Dash

80s Inspiration: A leveled-up version of the classic egg-and-spoon race with obstacles added.

Objective: Practice balancing through a short obstacle course without dropping the ball.

Materials: Large spoons | Small soft balls or pom-poms | 3-4 cones or markers

Follow the steps below to play!', NULL, N'Go slowly on turns -- most drops happen when you turn too fast.', 40, N'sequence_steps', N'{"steps": ["Set up 3-4 cones in a winding path from start to finish.", "Balance the ball on the spoon and walk the winding path around each cone.", "If the ball falls, stop, pick it up right where it fell, and continue.", "First to complete the course without too many drops wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_4, N'short_response', N'🦵 Wheelbarrow Race Basics

80s Inspiration: The classic field-day wheelbarrow race, a favorite of 1980s school field days.

Objective: Practice teamwork balance with one partner walking on hands while the other holds their legs.

Materials: A soft grassy or padded surface

Follow the steps below to play!', NULL, N'Only attempt this on soft ground, and hold ankles gently -- stop right away if arms get tired.', 41, N'sequence_steps', N'{"steps": ["One partner gets on hands and knees, then lifts into a plank position on their hands.", "The other partner gently holds their ankles, just above the ground, like wheelbarrow handles.", "The ''wheelbarrow'' partner walks forward on their hands while the other walks behind holding on.", "Race to a marker and back, then switch roles!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_4, N'short_response', N'👻 Ghost in the Graveyard

80s Inspiration: A beloved neighborhood evening game from countless 1980s summer nights.

Objective: Practice quiet movement and quick reactions in a classic dusk hide-and-seek game.

Materials: None -- just open space with hiding spots | A grown-up to supervise

Follow the steps below to play!', NULL, N'Play in a well-lit, agreed-upon area with a grown-up nearby, and always know the boundary lines.', 42, N'sequence_steps', N'{"steps": ["One player is the ''Ghost'' and hides while everyone else counts to 20 at a home base with eyes closed.", "Everyone spreads out to search for the Ghost, staying within the agreed-upon play area.", "Whoever spots the Ghost shouts ''Ghost in the graveyard!'' and everyone races back to home base.", "The Ghost tries to tag someone before they reach base -- whoever is tagged becomes the next Ghost!"]}');

    DECLARE @cat_80s2_5 INT;
    SELECT @cat_80s2_5 = category_id FROM dbo.PacketCategories WHERE grade_id = 5 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_5, N'short_response', N'🙌 Red Rover Team Tactics

80s Inspiration: The classic call-and-cross team game, played with real tactical planning.

Objective: Practice full-team strategy across multiple rounds of calling and defending.

Materials: None -- just open space!

Follow the steps below to play!', NULL, N'Fast play still means controlled play -- no shoulder-first charges, ever.', 36, N'sequence_steps', N'{"steps": ["Two teams form lines, holding hands, and appoint a quick team captain.", "Before each call, the captain gathers input on who to call based on the other team''s line.", "The called player jogs across and tries to break through strategically.", "Track total players gained across many rounds to determine the winning team."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_5, N'short_response', N'🥓 Steal the Bacon Championship

80s Inspiration: A championship-format version of the classic Steal the Bacon game.

Objective: Practice competitive, multi-round retrieval strategy tracked for an overall winner.

Materials: 1-2 soft objects (rolled socks or beanbags)

Follow the steps below to play!', NULL, N'Championship energy still means gentle, open-hand tags only.', 37, N'sequence_steps', N'{"steps": ["Set up a full tournament bracket of numbered rounds between two or more teams.", "Play each round with the standard call-and-retrieve rules.", "Keep a running score across all rounds on a simple scoreboard.", "The team with the most successful retrievals at the end is the champion!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_5, N'short_response', N'🛍️ Sack Race Championship

80s Inspiration: A championship-format version of the classic potato sack race.

Objective: Practice consistent, fast hopping across a full multi-round tournament.

Materials: Soft pillowcases or cloth sacks | Cones for a marked lane

Follow the steps below to play!', NULL, N'Staying upright still beats winning fast -- pace yourself to avoid falling.', 38, N'sequence_steps', N'{"steps": ["Set up heats of 3-4 racers at a time, with winners advancing to the next round.", "Race each heat over the same marked distance.", "Continue advancing winners until a final race determines the champion.", "Celebrate every racer''s effort, not just the winner!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_5, N'short_response', N'🥄 Egg and Spoon Championship

80s Inspiration: A championship-format version of the classic egg-and-spoon race.

Objective: Practice consistent balance skill across a full multi-round tournament.

Materials: Large spoons | Small soft balls or pom-poms | Cones for a marked lane

Follow the steps below to play!', NULL, N'A slow, steady walk beats a fast run that drops the ball -- balance first.', 39, N'sequence_steps', N'{"steps": ["Set up heats of 3-4 racers at a time, each balancing a ball on a spoon.", "Race each heat over the same marked distance -- fastest without dropping advances.", "Continue advancing winners until a final race determines the champion.", "A dropped ball means a quick pause to pick it up, not disqualification!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_5, N'short_response', N'🦵 Wheelbarrow Race Championship

80s Inspiration: A championship-format version of the classic field-day wheelbarrow race.

Objective: Practice sustained partner-balance strength across a full competitive race.

Materials: A soft grassy or padded surface | Cones for a marked lane

Follow the steps below to play!', NULL, N'If the ''wheelbarrow'' partner''s arms get tired, stop immediately and switch or rest.', 40, N'sequence_steps', N'{"steps": ["Pairs line up with one partner in wheelbarrow position, hands on the ground.", "Race the full marked lane to the finish and back if the course allows.", "The back partner gently guides by the ankles the whole way -- no letting go mid-race.", "Fastest pair to complete the course without stopping wins the championship!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_5, N'short_response', N'👑 Mother May I Championship

80s Inspiration: A championship-format version of the classic Mother May I game.

Objective: Practice competitive strategic step choices across a multi-round tournament.

Materials: None -- just open space!

Follow the steps below to play!', NULL, N'Bigger steps still need control -- especially spins and leaps near other players.', 41, N'sequence_steps', N'{"steps": ["Play several rounds with a rotating ''Mother'' role, keeping score of who wins each round.", "Vary the step types allowed each round to keep strategy fresh.", "Track total round wins across the whole game.", "The player with the most round wins at the end is the Mother May I champion!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_5, N'short_response', N'🏓 Tetherball Championship

80s Inspiration: A championship-format version of the classic playground tetherball game.

Objective: Practice sustained tetherball skill across a full head-to-head tournament.

Materials: A tetherball pole and ball (or improvised rope-and-ball setup)

Follow the steps below to play!', NULL, N'Watch your hands near the pole and rope, and always hit the ball, never a person.', 42, N'sequence_steps', N'{"steps": ["Set up a bracket of head-to-head matches between players.", "Play each match to a full wind of the rope as the win condition.", "Track match winners advancing through the bracket.", "The final match winner is the Tetherball Champion!"]}');

    DECLARE @cat_80s2_6 INT;
    SELECT @cat_80s2_6 = category_id FROM dbo.PacketCategories WHERE grade_id = 6 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_6, N'short_response', N'🙌 Red Rover Grand League

80s Inspiration: A league-format version of the classic Red Rover team game.

Objective: Practice team leadership and strategy across a multi-team league format.

Materials: None -- just open space!

Follow the steps below to play!', NULL, N'Bigger league, same rule: control over speed, every single round.', 36, N'sequence_steps', N'{"steps": ["Split into 3-4 smaller teams and rotate matchups so every team plays every other team once.", "Each match follows standard Red Rover rules, tracking players gained per team.", "After all matches, total up each team''s overall performance across the league.", "The team with the best overall record is the league champion!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_6, N'short_response', N'🥓 Steal the Bacon Grand Tournament

80s Inspiration: A grand-tournament version of the classic Steal the Bacon game.

Objective: Practice advanced retrieval strategy across a full bracket tournament with multiple teams.

Materials: 1-2 soft objects (rolled socks or beanbags)

Follow the steps below to play!', NULL, N'Bigger stakes, same care -- gentle open-hand tags, every round.', 37, N'sequence_steps', N'{"steps": ["Set up a bracket with 4 or more teams competing in elimination rounds.", "Play each round with standard rules, with the losing team eliminated each round.", "Continue until two teams remain for a final round.", "The winner of the final round is the Grand Tournament Champion!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_6, N'short_response', N'🛍️ Sack Race Grand Championship

80s Inspiration: A grand-championship version of the classic field-day potato sack race.

Objective: Practice consistent racing performance across a full field-day-style championship.

Materials: Soft pillowcases or cloth sacks | Cones for marked lanes

Follow the steps below to play!', NULL, N'Championship nerves are normal -- remind everyone that staying upright wins over rushing.', 38, N'sequence_steps', N'{"steps": ["Run a full field-day format: qualifying heats, semifinals, and a final race.", "Every racer gets at least one heat to qualify for the next round.", "Track times or finishing order at each stage.", "The winner of the final heat is crowned Sack Race Grand Champion!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_6, N'short_response', N'🥄 Egg and Spoon Masters

80s Inspiration: A masters-level version of the classic egg-and-spoon race.

Objective: Practice mastering balance under pressure across a full elimination tournament.

Materials: Large spoons | Small soft balls or pom-poms | Cones for marked lanes

Follow the steps below to play!', NULL, N'Precision beats speed here -- a slow, steady finish always beats a fast fall.', 39, N'sequence_steps', N'{"steps": ["Run heats where any dropped ball eliminates that attempt for the round.", "Racers who complete the course without dropping advance to the next round.", "Continue until a final head-to-head heat determines the winner.", "The Egg and Spoon Master is whoever balances best under pressure!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_6, N'short_response', N'🦵 Wheelbarrow Race Grand Finals

80s Inspiration: A grand-finals version of the classic field-day wheelbarrow race.

Objective: Practice sustained teamwork and strength across a full elimination bracket.

Materials: A soft grassy or padded surface | Cones for marked lanes

Follow the steps below to play!', NULL, N'If any arm or wrist feels sore, sit out a round rather than push through pain.', 40, N'sequence_steps', N'{"steps": ["Run bracket-style head-to-head races between pairs, with losers eliminated.", "Each pair races the full marked lane, switching who is in wheelbarrow position between rounds if they like.", "Continue until two pairs remain for the grand final race.", "The winning pair of the grand final is the Wheelbarrow Race Champion team!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_6, N'short_response', N'👑 Mother May I Leader Rotation

80s Inspiration: An advanced version of the classic Mother May I game with rotating leadership.

Objective: Practice leadership by taking turns creating fair, creative step challenges for the group.

Materials: None -- just open space!

Follow the steps below to play!', NULL, N'Invented steps still need to be safe -- no leaping, spinning too fast, or contact.', 41, N'sequence_steps', N'{"steps": ["Everyone takes a turn being ''Mother'' for one full round, inventing a new step type each time.", "The group votes on whether each invented step is fair and fun before playing it.", "Play a full round with each invented step type.", "At the end, vote on which invented step type was the most fun overall!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_6, N'short_response', N'👻 Ghost in the Graveyard Championship

80s Inspiration: A bigger, more strategic version of the classic 1980s dusk hide-and-seek game.

Objective: Practice advanced stealth, teamwork, and quick sprinting in a large-group version of the classic game.

Materials: None -- just open space with hiding spots | A grown-up to supervise

Follow the steps below to play!', NULL, N'Stick to a clearly marked, well-lit boundary, and always play with a grown-up supervising nearby.', 42, N'sequence_steps', N'{"steps": ["With a larger group, choose 2 Ghosts who hide together while everyone else counts at home base.", "Searchers move in pairs for safety and to cover more ground spotting the Ghosts.", "Whoever spots a Ghost shouts the signal and everyone races back to base.", "Both Ghosts try to tag runners before they reach base; anyone tagged becomes a Ghost for the next round!"]}');

    DECLARE @cat_80s2_7 INT;
    SELECT @cat_80s2_7 = category_id FROM dbo.PacketCategories WHERE grade_id = 7 AND category_name = 'Outdoor Games';
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_7, N'short_response', N'🙌 Red Rover Legends Cup

80s Inspiration: The most advanced format of the classic Red Rover team game.

Objective: Practice top-level team strategy and communication across a full multi-team cup format.

Materials: None -- just open space!

Follow the steps below to play!', NULL, N'The bigger the event, the more it matters to stay controlled -- no shoulder charges, ever.', 36, N'sequence_steps', N'{"steps": ["Split into several teams and run a round-robin cup where every team faces every other team.", "Each match uses standard rules, with a scorekeeper tracking players gained per team.", "After all matches, rank teams by total players gained across the whole cup.", "The top-ranked team lifts the Red Rover Legends Cup!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_7, N'short_response', N'👑 Mother May I Grandmaster Round

80s Inspiration: The most advanced format of the classic Mother May I game.

Objective: Practice inventing and negotiating fair, creative step challenges at an advanced level.

Materials: None -- just open space!

Follow the steps below to play!', NULL, N'New step ideas still need grown-up approval if they involve running or spinning.', 37, N'sequence_steps', N'{"steps": ["Each player gets one turn as Mother, allowed to invent one brand-new step type.", "Before playing each invented step, the group briefly discusses if it''s fair and safe.", "Play a full round with each invented step type, keeping score of who wins each round.", "The player with the most round wins across the whole session is the Grandmaster!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_7, N'short_response', N'🥓 Steal the Bacon World Series

80s Inspiration: The most advanced format of the classic Steal the Bacon game.

Objective: Practice elite-level retrieval strategy across a best-of-several-rounds series between two top teams.

Materials: 1-2 soft objects (rolled socks or beanbags)

Follow the steps below to play!', NULL, N'High-stakes rounds still mean gentle, open-hand tags only -- no exceptions.', 38, N'sequence_steps', N'{"steps": ["The two strongest teams from earlier rounds face off in a best-of-5 series.", "Play each round with standard rules, tracking wins for each team.", "First team to win 3 rounds takes the series.", "Celebrate great plays from BOTH teams, not just the winners!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_7, N'short_response', N'🛍️ Sack Race Ultimate Finals

80s Inspiration: The final, ultimate round of the classic field-day potato sack race.

Objective: Practice peak hopping consistency in a single ultimate final race.

Materials: Soft pillowcases or cloth sacks | Cones for a marked lane

Follow the steps below to play!', NULL, N'Finals nerves are normal -- remind everyone that a steady finish always beats a fast fall.', 39, N'sequence_steps', N'{"steps": ["Gather the fastest racer from each earlier heat for one ultimate final race.", "Line up together at the start line for a single deciding race.", "Hop the full marked distance, staying balanced the whole way.", "The winner of the ultimate final is crowned the season''s Sack Race champion!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_7, N'short_response', N'🥄 Egg and Spoon Grand Masters Cup

80s Inspiration: The final, ultimate round of the classic field-day egg-and-spoon race.

Objective: Practice mastering precision balance under the pressure of a final head-to-head cup match.

Materials: Large spoons | Small soft balls or pom-poms | Cones for a marked lane

Follow the steps below to play!', NULL, N'A calm, steady walk beats a fast run that drops the ball -- balance always comes first.', 40, N'sequence_steps', N'{"steps": ["Gather the two most consistent balancers from earlier rounds for a final cup match.", "Both walk the full marked distance at the same time, side by side.", "A dropped ball means a quick pause to pick it up and continue -- no disqualification.", "Whoever finishes first without too many drops lifts the Grand Masters Cup!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_7, N'short_response', N'🦵 Wheelbarrow Race Legends League

80s Inspiration: The most advanced format of the classic field-day wheelbarrow race.

Objective: Practice sustained partner strength and trust across a full multi-pair league format.

Materials: A soft grassy or padded surface | Cones for marked lanes

Follow the steps below to play!', NULL, N'If any arm or wrist feels sore during the league, sit out a round rather than push through it.', 41, N'sequence_steps', N'{"steps": ["Split into several pairs and run a round-robin league where every pair races every other pair once.", "Each race follows standard wheelbarrow rules over the same marked distance.", "Track wins for each pair across the whole league.", "The pair with the most wins across the league are the Wheelbarrow Race Legends!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_80s2_7, N'short_response', N'🎪 80s Field Day Showdown

80s Inspiration: A capstone celebration combining several classic 1980s field-day games into one big showdown.

Objective: Practice a wide range of retro field-day skills across several linked mini-stations in one big event.

Materials: Soft pillowcases or cloth sacks | Large spoons and small soft balls | Soft cloth ties for partner races | Cones or markers for each station

Follow the steps below to play!', NULL, N'Complete each station fully and safely before moving to the next -- this is about finishing, not rushing.', 42, N'sequence_steps', N'{"steps": ["Set up 4 stations around the field: sack hop, egg-and-spoon walk, three-legged/wheelbarrow dash, and Mother May I steps.", "Split into small groups and rotate through every station, completing each one fully.", "Add up each group''s combined results (or just how many stations they completed) across all 4 stations.", "Celebrate every group''s effort at the end with a group cheer -- everyone who finishes all 4 stations is a Field Day Champion!"]}');

END
GO

DELETE FROM dbo.WeeklyPacketPlan;
GO