-- 77_civic_games_content.sql
-- Adds a 'Community & Civics Games' category to the existing always-on
-- 'civic' subject_area for every grade (TK-6th) — no schema or proc changes
-- needed, reuses dbo.PacketSubjectAreas/usp_GetOrCreateWeeklyPacket exactly
-- as-is. The 'civic' subject_area already ships three categories (Civics &
-- Government, Community & Global Citizenship, Public Speaking & Debate —
-- see 67_civic_humor_character_culture_content.sql); this Games category
-- spans all three of those themes through hands-on play instead of Q&A.
--
-- Each grade gets a pool of 14 games; target_count=7 (fixed, not the usual
-- ~65% auto-rebalance ratio) means the existing NEWID()-sampling rotation
-- serves a different 7-of-14 combination most weeks a grade's civic
-- category is selected, satisfying "7 civic games, different set each
-- week" without any manual per-week authoring.
--
-- Content rule: strictly nonpartisan and non-controversial. No real
-- political parties, no real politicians of any era, no real-world
-- divisive social/political issues. Voting/election mechanics are always
-- generic-process; debate topics are always lighthearted (pizza toppings,
-- cats vs dogs, best season, etc.).
--
-- Each game is ONE PacketQuestions row: prompt carries the Name/Objective/
-- Materials, diagram_type='sequence_steps' carries the Step-by-Step
-- Instructions (already-shipped diagram type, renders as a numbered list in
-- both the app and print). answer_text carries a short encouraging
-- civic-mindset tip.
-- See gen_77_civic_games_content.py.

IF NOT EXISTS (SELECT 1 FROM dbo.PacketCategories WHERE subject_area = 'civic' AND category_name = N'Community & Civics Games')
BEGIN
    DECLARE @cat_civic_0 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (0, 'civic', N'Community & Civics Games', 'space_heavy', 7, N'Learn how communities work together through a fun civics game!', 0);
    SET @cat_civic_0 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_0, N'short_response', N'🗳️ Raise Your Hand Vote

Objective: Practice voting by raising a hand to help the group choose something together.

Materials: None — just a group and raised hands

Follow the steps below to play!', NULL, N'Every raised hand helps the whole group decide together!', 1, N'sequence_steps', N'{"steps": ["Grown-up asks a fun question, like ''Story time or song time first?''", "Everyone raises a hand for their favorite choice.", "Count the hands together out loud.", "Whichever choice has more hands wins — do that one first!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_0, N'short_response', N'👩‍⚕️ Community Helper Dress-Up

Objective: Practice recognizing community helpers by dressing up and acting out their jobs.

Materials: Dress-up clothes or simple props (hat, toy stethoscope, etc.) | A few stuffed animals as ''patients'' or ''customers''

Follow the steps below to play!', NULL, N'Community helpers take care of us every single day!', 2, N'sequence_steps', N'{"steps": ["Pick a community helper to be, like a doctor, firefighter, or mail carrier.", "Put on a simple costume piece or grab a matching prop.", "Act out one thing that helper does to help people.", "Take turns being a different helper!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_0, N'short_response', N'🤝 Kindness Helper Hunt

Objective: Practice noticing simple ways to help family members around the house.

Materials: None — just your home and a grown-up

Follow the steps below to play!', NULL, N'Small kind acts make a big difference to the people we love!', 3, N'sequence_steps', N'{"steps": ["Grown-up names someone in the house who might need a small hand.", "Think of one gentle way to help them, like carrying a napkin or picking up a toy.", "Go do that one kind thing together.", "Give each other a high five when it''s done!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_0, N'short_response', N'🍕 Pizza vs Ice Cream Cheer

Objective: Practice sharing a simple opinion out loud in a fun, friendly way.

Materials: None — just a group of friends or family

Follow the steps below to play!', NULL, N'It''s fun to share what you like, even when friends pick something different!', 4, N'sequence_steps', N'{"steps": ["Grown-up asks: pizza or ice cream — which do you like best?", "Walk to one side of the room for pizza, the other side for ice cream.", "Everyone says one word about why they picked their side, like ''cheesy!'' or ''yummy!''", "Cheer for both sides — everyone''s favorite is okay!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_0, N'short_response', N'🌍 Spin the Globe Friends

Objective: Practice noticing that children all over the world live in different kinds of communities.

Materials: A globe, world map, or picture book about the world

Follow the steps below to play!', NULL, N'There are friendly kids just like you living all around the world!', 5, N'sequence_steps', N'{"steps": ["Grown-up spins the globe or opens the map.", "Stop it gently with a finger on a spot.", "Imagine a kid living there — what might their house or school look like?", "Try again and imagine a different faraway friend!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_0, N'short_response', N'📫 Mail Carrier Delivery Game

Objective: Practice the mail carrier''s job by delivering pretend letters around the house.

Materials: A few pieces of paper folded like letters | A small bag or basket

Follow the steps below to play!', NULL, N'Mail carriers help people stay connected to each other!', 6, N'sequence_steps', N'{"steps": ["Put a few paper ''letters'' in your delivery bag.", "Walk to each family member''s favorite spot in the house.", "Hand them their letter with a smile, just like a mail carrier.", "Say ''Special delivery!'' each time you deliver one."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_0, N'short_response', N'🚒 Helper Sounds Match

Objective: Practice matching sounds to the community helpers who make them.

Materials: None — just your voice and imagination

Follow the steps below to play!', NULL, N'Helpers use sounds and signals to keep everyone safe!', 7, N'sequence_steps', N'{"steps": ["Grown-up makes a sound, like a siren ''wee-oo'' or a whistle.", "Guess which helper makes that sound — firefighter, police officer, crossing guard?", "Act out that helper for a few seconds.", "Take turns making the next sound!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_0, N'short_response', N'🧺 Neighbor Basket Pass

Objective: Practice naming helpful items and how they can be used to help a neighbor.

Materials: A small basket | 3-4 simple household items (a spoon, a bandage, a toy, a blanket)

Follow the steps below to play!', NULL, N'Even everyday items can help us take care of each other!', 8, N'sequence_steps', N'{"steps": ["Sit in a circle and put the basket in the middle.", "Take turns picking one item from the basket.", "Say one way that item could help a neighbor.", "Pass the basket to the next friend."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_0, N'short_response', N'✋ Thumbs Up Town Meeting

Objective: Practice a simple group decision using thumbs up or thumbs down.

Materials: None — just a group and thumbs

Follow the steps below to play!', NULL, N'Meetings help a whole group make a choice together!', 9, N'sequence_steps', N'{"steps": ["Grown-up brings up a silly choice, like ''Should we have snack time before or after story time?''", "Everyone shows thumbs up for one choice, thumbs down for the other.", "Count the thumbs together.", "Go with whichever choice got more thumbs up!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_0, N'short_response', N'🎨 Community Helper Coloring Match

Objective: Practice matching community helpers to the tools they use.

Materials: Simple pictures or cutouts of helpers (firefighter, doctor, teacher) | Matching pictures of their tools (hose, stethoscope, book) | Crayons (optional)

Follow the steps below to play!', NULL, N'Every helper has special tools that help them do their job!', 10, N'sequence_steps', N'{"steps": ["Spread out the helper pictures and the tool pictures.", "Look at each helper and think about what tool they use.", "Match each tool picture next to the correct helper.", "Color your favorite helper when you''re done!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_0, N'short_response', N'🐶 Take Turns Circle

Objective: Practice waiting patiently and listening while each friend gets a turn to talk.

Materials: A soft toy or small object to pass around

Follow the steps below to play!', NULL, N'Listening to a friend is just as important as talking!', 11, N'sequence_steps', N'{"steps": ["Sit together in a circle.", "Whoever is holding the toy gets to talk — everyone else listens quietly.", "Share something simple, like your favorite color.", "Pass the toy gently to the next friend."]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_0, N'short_response', N'🏘️ Build-a-Block Town

Objective: Practice imagining how a community fits together by building a pretend town.

Materials: Building blocks or empty boxes | Small toy people (optional)

Follow the steps below to play!', NULL, N'A town works best when every building has a helpful job!', 12, N'sequence_steps', N'{"steps": ["Build a few simple buildings out of blocks, like a house, a school, and a store.", "Name each building and who might work there.", "Move a toy person around the town, ''visiting'' each building.", "Add a new building together!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_0, N'short_response', N'🎈 Balloon Ballot Box

Objective: Practice an early version of voting by dropping a choice into a box.

Materials: An empty box or bowl | Small paper balls or pom-poms in 2 colors

Follow the steps below to play!', NULL, N'Dropping in your choice is a fun way to be part of a group decision!', 13, N'sequence_steps', N'{"steps": ["Grown-up names two color choices, like red or blue.", "Pick your favorite color''s paper ball.", "Drop it into the ballot box.", "Count together how many of each color are inside!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_0, N'short_response', N'🚦 Helper Freeze Dance

Objective: Practice recognizing community helpers by freezing into their pose during a dance game.

Materials: Music player or phone with speaker

Follow the steps below to play!', NULL, N'Community helpers come in all shapes, sizes, and jobs!', 14, N'sequence_steps', N'{"steps": ["Turn on music and dance around freely.", "When the music stops, freeze like a community helper — a firefighter holding a hose, a doctor listening with a stethoscope.", "Grown-up guesses which helper you''re being.", "Turn the music back on and pick a new helper next time!"]}');

    DECLARE @cat_civic_1 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (1, 'civic', N'Community & Civics Games', 'space_heavy', 7, N'Learn how communities work together through a fun civics game!', 0);
    SET @cat_civic_1 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_1, N'short_response', N'🗳️ Class Snack Vote

Objective: Practice voting between two choices and counting the results together.

Materials: Paper and pencil (for tally marks)

Follow the steps below to play!', NULL, N'Counting every vote makes sure everyone''s choice is heard!', 1, N'sequence_steps', N'{"steps": ["Pick two snack choices, like crackers or fruit.", "Each person raises a hand for their favorite.", "Make a tally mark for each vote on paper.", "Count the tally marks — the snack with more marks wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_1, N'short_response', N'👷 Helper Charades

Objective: Practice acting out and recognizing different community helper jobs.

Materials: Index cards with helper names or pictures (firefighter, teacher, doctor, mail carrier)

Follow the steps below to play!', NULL, N'You can recognize a helper''s job just by watching what they do!', 2, N'sequence_steps', N'{"steps": ["Pick a card without showing anyone.", "Act out that helper''s job using only actions, no talking.", "Everyone else guesses which helper you''re acting out.", "Take turns picking a new card!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_1, N'short_response', N'🤗 Helping Hands Chain

Objective: Practice thinking of kind ways to help others and sharing ideas out loud.

Materials: Paper strips | Tape or glue | Markers

Follow the steps below to play!', NULL, N'Kindness grows bigger every time it''s shared, just like this chain!', 3, N'sequence_steps', N'{"steps": ["Think of one kind thing you could do for someone this week.", "Draw or write it on a paper strip.", "Loop the strip and tape it into a chain link.", "Connect your link to a friend''s to build a kindness chain!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_1, N'short_response', N'🐱 Cats vs Dogs Cheer-Off

Objective: Practice sharing a simple opinion and one reason for it in front of a group.

Materials: None — just a group of friends

Follow the steps below to play!', NULL, N'Sharing why you like something helps others understand you better!', 4, N'sequence_steps', N'{"steps": ["Split into two groups: Team Cats and Team Dogs.", "Each team huddles for a moment to think of one reason their pick is great.", "Each team shouts their reason together, like ''Dogs play fetch!''", "Clap for both teams — both answers are great!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_1, N'short_response', N'🗺️ Around-the-World Match Game

Objective: Practice matching homes, foods, or clothing to different communities around the world.

Materials: Picture cards of homes/foods/clothing from a few different countries

Follow the steps below to play!', NULL, N'Communities around the world can look different but share the same kindness!', 5, N'sequence_steps', N'{"steps": ["Spread out the picture cards.", "Look closely at each picture and notice what''s different or similar to your own home.", "Sort the cards into small groups by country or region.", "Share one thing you noticed with a friend!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_1, N'short_response', N'📬 Neighborhood Delivery Relay

Objective: Practice teamwork by delivering pretend mail to labeled stations.

Materials: A few labeled ''house'' stations (paper signs) | Pretend letters (folded paper) | A small basket per team

Follow the steps below to play!', NULL, N'Mail carriers help every house in the neighborhood, one at a time!', 6, N'sequence_steps', N'{"steps": ["Set up 3-4 labeled house stations around the room or yard.", "Split into small teams, each with a basket of letters.", "Take turns running one letter at a time to the matching house.", "First team to deliver all their mail wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_1, N'short_response', N'🚑 Helper Tool Sort

Objective: Practice sorting tools by which community helper uses them.

Materials: Pictures or toy versions of tools (stethoscope, hose, badge, book) | Labeled sorting spots for each helper

Follow the steps below to play!', NULL, N'Every tool has a helper who knows exactly how to use it!', 7, N'sequence_steps', N'{"steps": ["Lay out the labeled helper spots.", "Look at each tool and decide which helper would use it.", "Place the tool in the matching helper''s spot.", "Check your work together when all tools are sorted!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_1, N'short_response', N'🙋 Ballot Box Basics

Objective: Practice an early voting process by writing a choice on paper and placing it in a box.

Materials: Small paper slips | Pencils | A box or container

Follow the steps below to play!', NULL, N'A ballot box lets everyone share their choice, one at a time!', 8, N'sequence_steps', N'{"steps": ["Grown-up asks a fun question, like your favorite color.", "Write or draw your answer on a paper slip.", "Fold it and place it in the ballot box.", "Open all the slips together and count each answer!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_1, N'short_response', N'🏫 Classroom Rules Vote

Objective: Practice making a group decision about a simple rule for game time.

Materials: Paper and marker (to write the winning rule)

Follow the steps below to play!', NULL, N'Rules feel fairer when everyone gets to help choose them!', 9, N'sequence_steps', N'{"steps": ["Think of two friendly options for a game-time rule, like ''quiet music'' or ''no music.''", "Everyone votes with a raised hand for their choice.", "Count the votes and announce the winner.", "Write the new rule down and follow it during your next game!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_1, N'short_response', N'🌎 Global Friends Circle

Objective: Practice learning and sharing a simple fact about kids in another country.

Materials: A book or picture about children in another country

Follow the steps below to play!', NULL, N'Learning about other communities helps us understand our big, wide world!', 10, N'sequence_steps', N'{"steps": ["Grown-up shares one fun fact about kids somewhere else in the world.", "Sit in a circle and talk about how it''s similar or different from your day.", "Take turns sharing what surprised you most.", "Thank each other for listening!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_1, N'short_response', N'🎤 Best Season Cheer

Objective: Practice giving one clear reason to support an opinion in front of others.

Materials: None — just a group and open floor space

Follow the steps below to play!', NULL, N'Everyone can have a different favorite — and that''s what makes sharing fun!', 11, N'sequence_steps', N'{"steps": ["Pick your favorite season: spring, summer, fall, or winter.", "Think of one reason you like it, like ''summer has swimming!''", "Take turns standing up and sharing your season and reason.", "Clap for every speaker!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_1, N'short_response', N'🧹 Helping Neighbor Chore Relay

Objective: Practice teamwork by pretending to help a neighbor tidy up quickly.

Materials: A few soft toys scattered on the floor | A basket

Follow the steps below to play!', NULL, N'Helping a neighbor feels great, especially when you work together!', 12, N'sequence_steps', N'{"steps": ["Imagine a neighbor needs help tidying their yard before a friend visits.", "Set a timer and race to pick up the scattered toys into the basket.", "Work together, not against each other.", "Celebrate together when the ''yard'' is tidy!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_1, N'short_response', N'🚸 Community Helper Freeze Tag

Objective: Practice recognizing helper roles while playing an active tag game.

Materials: Open play space

Follow the steps below to play!', NULL, N'Just like helpers work together, friends can help unfreeze each other!', 13, N'sequence_steps', N'{"steps": ["One player is ''It'' and gently tags others.", "Tagged players freeze in place with arms out.", "To unfreeze a friend, name a community helper out loud.", "Keep playing until everyone has been unfrozen at least once!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_1, N'short_response', N'🖐️ Talking Stick Turns

Objective: Practice listening quietly and waiting for a turn to speak.

Materials: A stick, spoon, or small object to use as the ''talking stick''

Follow the steps below to play!', NULL, N'Good listening is one of the kindest things you can do for a friend!', 14, N'sequence_steps', N'{"steps": ["Sit in a circle together.", "Only the person holding the talking stick may speak.", "Share a short thought, then pass the stick to the next friend.", "Everyone else listens quietly until it''s their turn!"]}');

    DECLARE @cat_civic_2 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (2, 'civic', N'Community & Civics Games', 'space_heavy', 7, N'Learn how communities work together through a fun civics game!', 0);
    SET @cat_civic_2 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_2, N'short_response', N'🗳️ Two-Choice Class Vote

Objective: Practice voting on two options and recording the results with tally marks.

Materials: Paper | Pencil

Follow the steps below to play!', NULL, N'Tally marks help us count votes clearly and fairly!', 1, N'sequence_steps', N'{"steps": ["Pick two simple choices, like ''read outside'' or ''read inside.''", "Each person votes by raising a hand for their pick.", "Make a tally mark for every vote as it''s counted.", "Announce which choice won and do that activity!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_2, N'short_response', N'🏆 Best Recess Game Debate

Objective: Practice giving one reason to support an opinion about a favorite game.

Materials: None — just two players and a friendly audience

Follow the steps below to play!', NULL, N'A good reason helps others understand why you like something!', 2, N'sequence_steps', N'{"steps": ["Two players each pick a different favorite recess game.", "Each player says one reason their game is the most fun.", "The audience listens carefully to both reasons.", "Everyone claps for both games — no wrong answers here!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_2, N'short_response', N'👩‍🚒 Helper Job Interview

Objective: Practice asking and answering simple questions about a community helper''s job.

Materials: A simple prop (hat, badge, or toy tool)

Follow the steps below to play!', NULL, N'Asking questions is a great way to learn how someone helps their community!', 3, N'sequence_steps', N'{"steps": ["One player pretends to be a community helper.", "Another player asks, ''What do you do to help people?''", "The helper answers with one or two simple sentences.", "Switch roles and pick a new helper job!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_2, N'short_response', N'🤝 Kindness Coupon Swap

Objective: Practice writing and trading small acts of kindness with a partner.

Materials: Index cards | Markers

Follow the steps below to play!', NULL, N'A small kindness coupon can make someone''s whole day brighter!', 4, N'sequence_steps', N'{"steps": ["Write one simple kind act on a card, like ''I''ll share my crayons.''", "Decorate your kindness coupon.", "Trade coupons with a partner.", "Try to complete your partner''s kind act sometime this week!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_2, N'short_response', N'🍦 Ice Cream Flavor Poll

Objective: Practice collecting opinions from a group and organizing them into a simple graph.

Materials: Paper | Pencil or crayons

Follow the steps below to play!', NULL, N'A poll is a friendly way to find out what a whole group thinks!', 5, N'sequence_steps', N'{"steps": ["Ask friends or family to name their favorite ice cream flavor.", "Draw a simple bar for each flavor, adding one box per vote.", "Compare the bars to see which flavor got the most votes.", "Share your graph with the group!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_2, N'short_response', N'🗺️ Passport Stamp Game

Objective: Practice learning one fact about a different community at each pretend-travel station.

Materials: A few ''country'' stations with one fun fact each | A homemade paper ''passport'' | A stamp or sticker per station

Follow the steps below to play!', NULL, N'Every stamp in your passport is a new community you learned about!', 6, N'sequence_steps', N'{"steps": ["Visit each station and read (or listen to) one fact about that place.", "Add a sticker ''stamp'' to your passport at each stop.", "Visit all the stations to fill your passport.", "Share your favorite fact you learned!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_2, N'short_response', N'📮 Mail Carrier Route Planning

Objective: Practice planning a simple, efficient path to deliver mail to several houses.

Materials: Paper with a simple drawn map of houses | Pencil

Follow the steps below to play!', NULL, N'Planning ahead helps helpers like mail carriers do their job efficiently!', 7, N'sequence_steps', N'{"steps": ["Look at the map with 4-5 houses drawn on it.", "Draw a path connecting all the houses without crossing your own line.", "Trace your route with a finger to check it makes sense.", "Compare your route with a friend''s — is there a shorter way?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_2, N'short_response', N'🐾 Community Helper Match-Up

Objective: Practice matching community helper job titles to descriptions of what they do.

Materials: Cards with helper names | Cards with matching job descriptions

Follow the steps below to play!', NULL, N'Knowing what each helper does helps you appreciate your whole community!', 8, N'sequence_steps', N'{"steps": ["Mix up both sets of cards and spread them out.", "Read a job description card carefully.", "Find the helper name card that matches it.", "Keep going until every helper is matched!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_2, N'short_response', N'🎙️ One-Minute Pitch: Best Pet

Objective: Practice giving a short, one-reason pitch to persuade an audience.

Materials: A timer or phone stopwatch

Follow the steps below to play!', NULL, N'A short, clear reason can be very convincing!', 9, N'sequence_steps', N'{"steps": ["Pick your favorite type of pet.", "Think of one good reason it makes the best pet.", "Give your pitch to a friend or family member in under a minute.", "Ask your listener what they liked about your pitch!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_2, N'short_response', N'🧭 Map Your Neighborhood

Objective: Practice drawing a simple map and marking where community helpers work.

Materials: Paper | Crayons or markers

Follow the steps below to play!', NULL, N'Maps help us understand how our whole community fits together!', 10, N'sequence_steps', N'{"steps": ["Draw a simple map of your neighborhood or town.", "Mark where helpers work, like the school, fire station, or store.", "Add a small symbol for each helper location.", "Show your map to someone and explain what each symbol means!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_2, N'short_response', N'🙌 Group Decision Circle

Objective: Practice making a group decision by talking it through and voting.

Materials: None — just a group ready to play

Follow the steps below to play!', NULL, N'Talking it through before voting helps everyone feel heard!', 11, N'sequence_steps', N'{"steps": ["Suggest 2-3 different games the group could play next.", "Talk about each choice for a moment, sharing why it might be fun.", "Vote by raised hands for the favorite.", "Play the winning game together!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_2, N'short_response', N'🌟 Everyday Hero Spotlight

Objective: Practice recognizing and sharing about real people who help others.

Materials: None — just your own stories

Follow the steps below to play!', NULL, N'Everyday heroes are all around us, not just in stories!', 12, N'sequence_steps', N'{"steps": ["Think of someone you know who helped somebody else recently.", "Share what they did and how it helped.", "Listen to a friend''s story about their everyday hero too.", "Thank a real helper in your life this week!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_2, N'short_response', N'⚖️ For and Against: Recess Length

Objective: Practice hearing and respectfully considering two different sides of a friendly topic.

Materials: None — just two players and a listening audience

Follow the steps below to play!', NULL, N'Listening to both sides helps you understand a topic better!', 13, N'sequence_steps', N'{"steps": ["One player argues for a longer recess, the other for keeping it the same.", "Each player shares one reason for their side.", "The audience listens to both sides without interrupting.", "Talk together about which reason made the most sense to you!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_2, N'short_response', N'🏘️ Build a Fair Rule

Objective: Practice working together to agree on a fair rule for a game.

Materials: Paper | Marker

Follow the steps below to play!', NULL, N'Fair rules work best when everyone has a say in making them!', 14, N'sequence_steps', N'{"steps": ["Pick a game the group wants to play.", "Suggest one new rule that could make it more fun or fair.", "Talk about the suggestion and vote on whether to use it.", "Write down the agreed rule and play by it!"]}');

    DECLARE @cat_civic_3 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (3, 'civic', N'Community & Civics Games', 'space_heavy', 7, N'Learn how communities work together through a fun civics game!', 0);
    SET @cat_civic_3 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_3, N'short_response', N'🗳️ Team Captain Vote

Objective: Practice a simple election process by nominating and voting for a team captain.

Materials: Paper slips | A small box

Follow the steps below to play!', NULL, N'A good captain listens to the whole team, just like a good leader listens to their community!', 1, N'sequence_steps', N'{"steps": ["Ask for 2 volunteers who would like to be team captain.", "Each volunteer says one sentence about how they''d help the team.", "Everyone writes their choice on a paper slip and drops it in the box.", "Count the votes together and announce the new captain!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_3, N'short_response', N'🏅 Best Superhero Power Debate

Objective: Practice building a short argument with two reasons to support an opinion.

Materials: None — just two debaters and an audience

Follow the steps below to play!', NULL, N'Two good reasons make an argument even stronger than one!', 2, N'sequence_steps', N'{"steps": ["Each debater picks a different superhero power (like flying or invisibility).", "Each one shares two reasons their power is the most useful.", "The audience listens to both arguments.", "Vote by cheering for the argument that convinced you most!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_3, N'short_response', N'🚓 Community Helper Riddle Game

Objective: Practice recognizing community helper jobs by solving riddles.

Materials: A few written riddles about helper jobs

Follow the steps below to play!', NULL, N'Riddles are a fun way to think carefully about how helpers serve their community!', 3, N'sequence_steps', N'{"steps": ["Read a riddle out loud, like ''I put out fires and rescue cats from trees. Who am I?''", "Guess which community helper the riddle describes.", "Check the answer together.", "Take turns making up your own helper riddle!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_3, N'short_response', N'🤲 Random Acts of Kindness Bingo

Objective: Practice completing and tracking simple kind acts for family and neighbors.

Materials: A bingo-style grid with kind acts written in each square | A pencil or stickers to mark squares

Follow the steps below to play!', NULL, N'Every square you fill in makes your community a little kinder!', 4, N'sequence_steps', N'{"steps": ["Look over the bingo grid of kind acts, like ''hold the door'' or ''say thank you.''", "Complete one kind act from the grid.", "Mark that square off when it''s done.", "See how many rows you can complete this week!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_3, N'short_response', N'🍕 Pizza Topping Persuasion Speech

Objective: Practice giving a short persuasive speech in favor of an opinion.

Materials: A timer or phone stopwatch

Follow the steps below to play!', NULL, N'Speaking with confidence helps others really hear your point!', 5, N'sequence_steps', N'{"steps": ["Pick your favorite pizza topping.", "Prepare a 30-second speech explaining why it''s the best.", "Deliver your speech to a partner or small group.", "Ask your audience which point convinced them most!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_3, N'short_response', N'🌏 Where in the World Game

Objective: Practice matching landmarks or symbols to simple facts about communities around the world.

Materials: Picture cards of landmarks or flags | Matching fact cards

Follow the steps below to play!', NULL, N'Every community has its own special landmarks and stories!', 6, N'sequence_steps', N'{"steps": ["Spread out the landmark/flag cards and the fact cards.", "Read a fact card and figure out which landmark or flag it matches.", "Pair up all the matching cards.", "Share which community you''d most like to learn more about!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_3, N'short_response', N'📦 Delivery Route Challenge

Objective: Practice planning an efficient delivery route across a simple map.

Materials: A drawn map with several delivery stops | Pencil

Follow the steps below to play!', NULL, N'Good planning helps community helpers do their jobs faster and better!', 7, N'sequence_steps', N'{"steps": ["Look at the map showing several delivery stops.", "Plan a route that visits every stop without backtracking too much.", "Trace your planned route with a pencil.", "Compare routes with a friend and discuss which one is shorter!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_3, N'short_response', N'🏫 Classroom Ballot Box

Objective: Practice a majority-rules voting process using written ballots.

Materials: Small paper ballots | A box | Pencils

Follow the steps below to play!', NULL, N'Majority rules means the choice most people agree on wins!', 8, N'sequence_steps', N'{"steps": ["Present two or three choices for the group to decide on.", "Everyone writes their choice on a ballot and places it in the box.", "Count the ballots out loud together.", "Announce the choice with the majority of votes!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_3, N'short_response', N'🐕 Cats vs Dogs Formal Debate Lite

Objective: Practice a simple two-sided debate structure with reasons and an audience vote.

Materials: None — just two small teams and an audience

Follow the steps below to play!', NULL, N'A calm, clear argument is more convincing than a loud one!', 9, N'sequence_steps', N'{"steps": ["Split into Team Cats and Team Dogs.", "Each team shares two reasons their pet is the best.", "The other team listens without interrupting.", "The audience votes by clapping for the most convincing team!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_3, N'short_response', N'🧑‍🤝‍🧑 Helping Hands Relay Race

Objective: Practice teamwork by racing to deliver helpful items to a pretend neighbor in need.

Materials: A few ''helpful items'' (blanket, water bottle, toy) | 2 cones to mark start and finish

Follow the steps below to play!', NULL, N'Working together makes helping a neighbor faster and more fun!', 10, N'sequence_steps', N'{"steps": ["Set up a start line and a ''neighbor''s house'' finish line.", "Split into teams, each with a set of helpful items.", "Take turns running one item at a time to the neighbor''s house.", "First team to deliver all their items wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_3, N'short_response', N'🗣️ Turn-Taking Talk Show

Objective: Practice interviewing and listening skills through a pretend talk show about community helpers.

Materials: A pretend microphone (or any object)

Follow the steps below to play!', NULL, N'A good host listens as much as they talk!', 11, N'sequence_steps', N'{"steps": ["One player is the host, another plays a community helper guest.", "The host asks the guest 2-3 questions about their job.", "The guest answers while the host listens without interrupting.", "Switch roles and pick a new helper to interview!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_3, N'short_response', N'🌈 Best Season Debate Match

Objective: Practice a for/against debate structure with an audience vote at the end.

Materials: None — just two debaters and an audience

Follow the steps below to play!', NULL, N'Even a friendly disagreement can be fun when everyone listens respectfully!', 12, N'sequence_steps', N'{"steps": ["Two players each pick a different favorite season.", "Each shares two reasons why their season is the best.", "The audience listens to both sides.", "Audience votes by clapping for the argument they found most convincing!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_3, N'short_response', N'🚦 Community Rule Makers

Objective: Practice proposing, discussing, and voting on a fair rule as a group.

Materials: Paper | Marker

Follow the steps below to play!', NULL, N'Rules made together are rules everyone is happy to follow!', 13, N'sequence_steps', N'{"steps": ["Think of a rule that could make a group game more fun or fair.", "Share your idea with the group and explain why.", "Vote on whether to adopt the new rule.", "Write down the rule and use it in your next game!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_3, N'short_response', N'🗳️ Silent Ballot Practice

Objective: Practice the idea of a private vote by folding and submitting a silent ballot.

Materials: Small paper slips | Pencils | A box

Follow the steps below to play!', NULL, N'A private vote lets everyone choose freely, without feeling pressured!', 14, N'sequence_steps', N'{"steps": ["Present a fun choice, like a favorite game to play next.", "Write your choice privately on a folded slip of paper.", "Place your folded ballot in the box without showing anyone.", "Unfold and count all the ballots together to find the winner!"]}');

    DECLARE @cat_civic_4 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (4, 'civic', N'Community & Civics Games', 'space_heavy', 7, N'Learn how communities work together through a fun civics game!', 0);
    SET @cat_civic_4 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_4, N'short_response', N'🗳️ Secret Ballot Election

Objective: Practice the process of a secret ballot election from voting to counting results.

Materials: Small paper ballots | Pencils | A closed box or envelope

Follow the steps below to play!', NULL, N'A secret ballot lets everyone vote honestly, based on their own opinion!', 1, N'sequence_steps', N'{"steps": ["Present two choices for the group to decide, like a class game or snack.", "Each person writes their choice privately, folds it, and drops it in the box.", "Once everyone has voted, open the box and read each ballot aloud.", "Tally the results and announce the winner!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_4, N'short_response', N'⚖️ Debate Club: Cats vs Dogs

Objective: Practice a formal debate structure with an opening statement, a rebuttal, and a closing statement.

Materials: A timer or phone stopwatch

Follow the steps below to play!', NULL, N'A strong rebuttal responds calmly and directly to the other side''s point!', 2, N'sequence_steps', N'{"steps": ["Two debaters each pick a side: Team Cats or Team Dogs.", "Each gives a short opening statement explaining their side.", "Each debater responds to the other''s point with a respectful rebuttal.", "Both give a short closing statement, then the audience votes!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_4, N'short_response', N'🏛️ Mock Town Council Meeting

Objective: Practice proposing and voting on a rule in a simple simulated town council meeting.

Materials: Simple name tags for roles (mayor, council members) | Paper | Pencil

Follow the steps below to play!', NULL, N'Good decisions come from asking questions before voting!', 3, N'sequence_steps', N'{"steps": ["Assign roles: one mayor and a few council members.", "One council member proposes a silly new town rule, like ''Fridays are pajama day.''", "Council members discuss and ask questions about the proposal.", "The council votes, and the mayor announces the result!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_4, N'short_response', N'🤝 Kindness Challenge Card Game

Objective: Practice planning and reporting back on a small act of kindness.

Materials: Cards with kindness challenges written on them | A container to draw from

Follow the steps below to play!', NULL, N'A completed kindness challenge is a little gift to your whole community!', 4, N'sequence_steps', N'{"steps": ["Draw a kindness challenge card, like ''compliment three people today.''", "Complete the challenge sometime before the next meeting.", "Come back and share how it went with the group.", "Draw a new challenge card and try again!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_4, N'short_response', N'🍕 Best Pizza Topping Debate

Objective: Practice building a structured for/against argument with supporting reasons and a rebuttal.

Materials: A timer or phone stopwatch

Follow the steps below to play!', NULL, N'Backing up your opinion with reasons makes it much more convincing!', 5, N'sequence_steps', N'{"steps": ["Two debaters each pick a favorite pizza topping.", "Each shares two reasons supporting their topping.", "Each debater offers one respectful rebuttal to the other''s reasons.", "The audience votes for the most convincing argument!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_4, N'short_response', N'🌍 Global Communities Passport Project

Objective: Practice researching and comparing how communities differ around the world.

Materials: A few ''country'' research stations with facts and pictures | A simple passport booklet (folded paper)

Follow the steps below to play!', NULL, N'Every community solves everyday needs in its own unique way!', 6, N'sequence_steps', N'{"steps": ["Visit each station and read facts about that community''s homes, food, or celebrations.", "Write or draw one thing you learned in your passport.", "Compare that community to your own — what''s similar, what''s different?", "Share your favorite discovery with the group!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_4, N'short_response', N'📬 City Planner Delivery Challenge

Objective: Practice planning the most efficient mail delivery route across a mock city map.

Materials: A drawn map of a mock city with many delivery stops | Pencil | Ruler (optional)

Follow the steps below to play!', NULL, N'Careful planning helps a whole city run more smoothly!', 7, N'sequence_steps', N'{"steps": ["Study the map and count how many stops need a delivery.", "Plan a route that reaches every stop using the shortest path you can find.", "Trace your final route and measure roughly how far it travels.", "Compare your route''s length with a partner''s — whose is shorter?"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_4, N'short_response', N'🧑‍⚖️ Fair or Not Fair Game

Objective: Practice discussing and voting on whether everyday scenarios are fair.

Materials: Scenario cards describing simple situations (like sharing a swing fairly)

Follow the steps below to play!', NULL, N'Thinking about fairness helps us treat everyone in our community kindly!', 8, N'sequence_steps', N'{"steps": ["Read a scenario card out loud to the group.", "Discuss whether the situation seems fair or not, and why.", "Vote as a group: fair or not fair?", "Talk about what would make it more fair, if needed!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_4, N'short_response', N'🗣️ Two-Minute Persuasive Speech: Best Season

Objective: Practice preparing and delivering a short, structured persuasive speech.

Materials: A timer or phone stopwatch | Notecards (optional)

Follow the steps below to play!', NULL, N'A clear beginning, middle, and end makes any speech easier to follow!', 9, N'sequence_steps', N'{"steps": ["Pick your favorite season and think of 2-3 reasons it''s the best.", "Prepare a short speech with a beginning, middle, and end.", "Deliver your two-minute speech to a partner or small group.", "Ask your listeners which reason stood out most!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_4, N'short_response', N'🏘️ Design-a-Community Project Game

Objective: Practice designing and presenting a small community with clear helper roles.

Materials: Paper | Markers or crayons

Follow the steps below to play!', NULL, N'A well-designed community has helpers for every important need!', 10, N'sequence_steps', N'{"steps": ["In small teams, draw a small community with a school, park, and a few helper buildings.", "Decide what job each building and helper serves.", "Present your community design to the other teams.", "Ask each other questions about how your communities work!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_4, N'short_response', N'🤗 Neighbor Helper Simulation

Objective: Practice brainstorming solutions to a scenario where a neighbor needs help.

Materials: Scenario cards describing a neighbor in need (like an elderly neighbor''s mail piling up)

Follow the steps below to play!', NULL, N'Noticing when someone needs help is the first step to being a great neighbor!', 11, N'sequence_steps', N'{"steps": ["Read a neighbor-in-need scenario card out loud.", "Brainstorm 2-3 ways the group could help in that situation.", "Vote on the best idea as a group.", "Talk about how it would feel to actually help that neighbor!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_4, N'short_response', N'🗳️ Majority Rules Game Show

Objective: Practice quick voting and understanding the concept of a majority.

Materials: Paper | Pencil (for tallying)

Follow the steps below to play!', NULL, N'A majority means more than half the group agrees on the same choice!', 12, N'sequence_steps', N'{"steps": ["Ask a quick, silly question, like ''cereal or toast for breakfast?''", "Everyone votes with a raised hand.", "Tally the votes and discuss which choice has the majority.", "Play several quick rounds with new silly questions!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_4, N'short_response', N'🌐 Compare Two Communities Game

Objective: Practice comparing and contrasting features of two different communities.

Materials: Pictures or facts about two different communities (a city and a small town, for example) | Paper divided into two columns

Follow the steps below to play!', NULL, N'Comparing communities helps us see how people everywhere solve similar needs!', 13, N'sequence_steps', N'{"steps": ["Look closely at facts or pictures from both communities.", "List similarities in one column and differences in the other.", "Talk about why each community might have grown that way.", "Share your favorite similarity and difference with the group!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_4, N'short_response', N'🎤 Rebuttal Ready: Best School Subject Debate

Objective: Practice listening carefully to an opposing argument and responding respectfully.

Materials: A timer or phone stopwatch

Follow the steps below to play!', NULL, N'The best rebuttals show you were really listening to the other side!', 14, N'sequence_steps', N'{"steps": ["Two debaters each pick a different favorite school subject.", "Each shares one reason their subject is the most fun.", "Each debater listens carefully, then responds respectfully to the other''s point.", "The audience votes for the response that listened best!"]}');

    DECLARE @cat_civic_5 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (5, 'civic', N'Community & Civics Games', 'space_heavy', 7, N'Learn how communities work together through a fun civics game!', 0);
    SET @cat_civic_5 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_5, N'short_response', N'🗳️ Class Election Simulation

Objective: Practice a full simple election process: nomination, speech, secret ballot, and counting results.

Materials: Paper ballots | A ballot box | Pencils

Follow the steps below to play!', NULL, N'A fair election gives every candidate a chance to be heard before the vote!', 1, N'sequence_steps', N'{"steps": ["Two or three classmates volunteer to be candidates for a fun class role, like ''Game Time Captain.''", "Each candidate gives a short speech about how they''d do the job well.", "Everyone votes privately on a paper ballot and places it in the box.", "Count the ballots together and announce the winner!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_5, N'short_response', N'⚖️ Formal Debate: Summer vs Winter

Objective: Practice a structured debate with judged scoring based on strength of arguments.

Materials: A timer or phone stopwatch | Paper and pencil for judges to score

Follow the steps below to play!', NULL, N'Clear reasoning is even more convincing than a loud voice!', 2, N'sequence_steps', N'{"steps": ["Two debaters each pick a season, summer or winter, to defend.", "Each gives an opening statement with two supporting reasons.", "Each responds to the other''s argument with a rebuttal.", "Judges (the rest of the group) score based on clarity and reasoning, then announce a winner!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_5, N'short_response', N'🏛️ Community Council Role-Play

Objective: Practice debating and voting on a mock community project as council members.

Materials: Role name tags (council members) | Paper describing the proposed project (like a new park bench)

Follow the steps below to play!', NULL, N'Good community decisions come from hearing many different points of view!', 3, N'sequence_steps', N'{"steps": ["Assign each player a council member role.", "One player proposes a small community project and explains its benefits.", "Council members ask questions and share opinions, for and against.", "The council votes, and the result is announced to the ''community''!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_5, N'short_response', N'🤲 Helping Hands Service Project Plan

Objective: Practice planning a simple neighborhood helping project from idea to action steps.

Materials: Paper | Pencil

Follow the steps below to play!', NULL, N'Even the biggest helping projects start with one clear, simple plan!', 4, N'sequence_steps', N'{"steps": ["Brainstorm a small way to help your neighborhood, like a trash pickup or card-making for neighbors.", "Write down 3 clear steps needed to make the project happen.", "Decide who could help with each step.", "Share your plan with the group and get feedback!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_5, N'short_response', N'🍦 Persuasive Pitch: Best Dessert

Objective: Practice a full persuasive speech structure with a hook, reasons, and a closing call to action.

Materials: A timer or phone stopwatch | Notecards (optional)

Follow the steps below to play!', NULL, N'A strong opening hook makes people want to listen to the rest of your argument!', 5, N'sequence_steps', N'{"steps": ["Pick your favorite dessert and think of an attention-grabbing opening line.", "Add 2-3 clear reasons why it''s the best.", "End with a strong closing line that sums up your point.", "Deliver your pitch to a partner and ask what part convinced them most!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_5, N'short_response', N'🌍 World Communities Research Relay

Objective: Practice quickly recalling facts about different communities worldwide through a relay quiz.

Materials: Fact cards about communities in different countries | 2 team areas

Follow the steps below to play!', NULL, N'Learning quick facts about communities helps us appreciate how connected our world is!', 6, N'sequence_steps', N'{"steps": ["Split into two teams, each near a stack of shuffled fact-question cards.", "One player runs up, reads a question, and answers it as a team.", "If correct, keep the card; if not, place it back and try the next one.", "The team with the most correct cards after the relay wins!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_5, N'short_response', N'📮 Logistics Challenge: City Delivery Planner

Objective: Practice optimizing a delivery route around distance and obstacles on a map.

Materials: A drawn map with delivery stops and a few ''obstacles'' (like a closed road) | Pencil

Follow the steps below to play!', NULL, N'Great logistics planning means solving problems before they slow you down!', 7, N'sequence_steps', N'{"steps": ["Study the map, noting all delivery stops and any blocked roads.", "Plan the shortest route that still avoids every obstacle.", "Trace your final route and estimate its total distance.", "Compare with a partner and discuss which route works best and why!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_5, N'short_response', N'🧑‍⚖️ Debate the Rule: Recess Length

Objective: Practice a structured for/against debate with an audience vote after hearing both sides.

Materials: A timer or phone stopwatch

Follow the steps below to play!', NULL, N'Fair debates always let both sides finish before anyone votes!', 8, N'sequence_steps', N'{"steps": ["One debater argues for a longer recess, the other for keeping it the same.", "Each gives an opening statement with supporting reasons.", "Each responds to the other''s argument with a brief rebuttal.", "The audience votes after hearing both full sides!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_5, N'short_response', N'🗳️ Ranked Choice Snack Vote

Objective: Practice the concept of ranked-choice voting by ranking multiple snack options.

Materials: Paper ballots listing 3-4 snack choices | Pencils

Follow the steps below to play!', NULL, N'Ranked-choice voting lets people show more than just their single favorite!', 9, N'sequence_steps', N'{"steps": ["List 3-4 snack choices on each ballot.", "Each voter ranks the snacks from favorite (1) to least favorite.", "Collect the ballots and count first-choice votes first.", "If no snack has a majority, remove the lowest and recount using next choices!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_5, N'short_response', N'🏘️ Build-a-Better-Community Design Challenge

Objective: Practice designing a community solution to a specific need and presenting it clearly.

Materials: Paper | Markers

Follow the steps below to play!', NULL, N'The best community designs start by really listening to what people need!', 10, N'sequence_steps', N'{"steps": ["In teams, pick one community need, like more places to play or more green space.", "Design a simple community feature that solves that need.", "Prepare a short presentation explaining your design and its benefits.", "Present to the group and answer any questions!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_5, N'short_response', N'🤝 Kindness Ripple Effect Game

Objective: Practice tracing how one kind act can help multiple people, one after another.

Materials: Paper | Pencil

Follow the steps below to play!', NULL, N'One kind act can ripple out and touch more people than you''d ever guess!', 11, N'sequence_steps', N'{"steps": ["Start with one small kind act, like helping a friend carry books.", "Think about who that act might inspire to be kind too.", "Draw an arrow chain showing the kindness spreading to 3-4 more people.", "Share your kindness chain with the group!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_5, N'short_response', N'🌐 Similarities & Differences Community Map

Objective: Practice comparing community features across two countries using a map.

Materials: Two country maps or fact sheets | Paper divided into a Venn diagram

Follow the steps below to play!', NULL, N'Even far-apart communities often share more in common than we expect!', 12, N'sequence_steps', N'{"steps": ["Research or read facts about two different countries'' communities.", "Fill in the Venn diagram with unique features on each side and shared features in the middle.", "Discuss why some features might be shared and others different.", "Share your most interesting finding with the group!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_5, N'short_response', N'🎤 Two-Sided Speech: Best Class Pet

Objective: Practice preparing arguments for both sides of a topic, then arguing an assigned side.

Materials: A timer or phone stopwatch | Notecards

Follow the steps below to play!', NULL, N'Understanding both sides of an argument makes you a stronger, fairer thinker!', 13, N'sequence_steps', N'{"steps": ["Pick two possible class pets and prepare 2 reasons supporting each one.", "Get randomly assigned one side to argue, even if it''s not your personal favorite.", "Deliver a short speech defending your assigned side.", "Talk afterward about how it felt to argue a side you didn''t originally pick!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_5, N'short_response', N'🧭 Civic Puzzle: Match the Rule to the Reason

Objective: Practice matching everyday community rules to the reasons they help everyone.

Materials: Cards with simple community rules | Cards with matching reasons

Follow the steps below to play!', NULL, N'Most community rules exist for a good reason — even the ones that seem small!', 14, N'sequence_steps', N'{"steps": ["Spread out the rule cards and the reason cards.", "Read a rule, like ''wait your turn in line.''", "Find the reason card that best explains why that rule helps everyone.", "Match all the pairs and discuss any surprising ones!"]}');

    DECLARE @cat_civic_6 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (6, 'civic', N'Community & Civics Games', 'space_heavy', 7, N'Learn how communities work together through a fun civics game!', 0);
    SET @cat_civic_6 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_6, N'short_response', N'🗳️ Full Class Election Day

Objective: Practice a complete simulated election, including nominations, speeches, secret ballots, and results.

Materials: Paper ballots | A ballot box | Pencils | A timer for speeches

Follow the steps below to play!', NULL, N'A trustworthy election depends on every vote being counted honestly and fairly!', 1, N'sequence_steps', N'{"steps": ["Nominate 2-3 candidates for a fun classroom role.", "Each candidate prepares and delivers a one-minute speech about their ideas.", "Everyone votes by secret ballot and places it in the box.", "Count the ballots together, announce results, and reflect on what made a speech convincing!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_6, N'short_response', N'⚖️ Structured Debate Tournament: Best Season

Objective: Practice a timed, judged debate tournament format with a reflection on persuasive techniques.

Materials: A timer or phone stopwatch | Judging notes (paper and pencil)

Follow the steps below to play!', NULL, N'Reflecting on what worked helps you become an even stronger speaker next time!', 2, N'sequence_steps', N'{"steps": ["Form small teams, each defending a different season.", "Each team gets a timed round for opening statements, rebuttals, and closing arguments.", "Judges score each round on clarity, evidence, and respectfulness.", "After scoring, discuss as a group what made the winning team''s argument convincing!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_6, N'short_response', N'🏛️ Mock City Council Budget Game

Objective: Practice debating and voting on how to allocate a pretend community budget.

Materials: Paper ''budget bills'' (fake money or tokens) | Cards listing project options (park, library books, sports court)

Follow the steps below to play!', NULL, N'Community budgets always involve tough choices about what matters most!', 3, N'sequence_steps', N'{"steps": ["Give the group a fixed pretend budget and 3-4 project options to fund.", "Each project ''sponsor'' pitches why their project deserves funding.", "The council discusses trade-offs, since the budget can''t fund everything.", "Vote on the final budget split and reflect on the toughest trade-off you made!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_6, N'short_response', N'🤝 Community Service Project Pitch

Objective: Practice pitching a service project idea and reflecting on what made a pitch convincing.

Materials: Paper | Pencil | A timer

Follow the steps below to play!', NULL, N'The most convincing pitches clearly connect the idea to a real community need!', 4, N'sequence_steps', N'{"steps": ["Each person or team prepares a short pitch for a community service project idea.", "Deliver your pitch to the group, including the problem it solves and how it helps.", "The group votes on which pitch they''d most want to support.", "Discuss together what specifically made the winning pitch so convincing!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_6, N'short_response', N'🍕 Persuasive Speech Showdown: Pizza Toppings

Objective: Practice a full persuasive speech structure with peer reflection on technique.

Materials: A timer or phone stopwatch | Notecards

Follow the steps below to play!', NULL, N'Even a silly topic is a great way to practice serious persuasive speaking skills!', 5, N'sequence_steps', N'{"steps": ["Prepare a persuasive speech about your favorite pizza topping with a hook, evidence, and a call to action.", "Deliver your speech to the group within the time limit.", "Listeners give one piece of specific feedback about what was convincing.", "Reflect on which feedback you''d use to improve your speech next time!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_6, N'short_response', N'🌍 Global Citizenship Simulation

Objective: Practice representing a community''s needs and customs in a collaborative world-summit discussion.

Materials: Role cards describing different (fictional or general) communities and their needs

Follow the steps below to play!', NULL, N'Understanding another community''s perspective is the first step toward global cooperation!', 6, N'sequence_steps', N'{"steps": ["Each player or team represents a community with its own needs and customs.", "Take turns sharing what your community values and needs most.", "Discuss as a group how different communities could support one another.", "Reflect on what you learned about communities different from your own!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_6, N'short_response', N'📦 Supply Chain Delivery Strategy Game

Objective: Practice planning an optimized delivery network and discussing trade-offs as a team.

Materials: A map with multiple delivery hubs and destinations | Pencil | Paper for notes

Follow the steps below to play!', NULL, N'Good planning balances many trade-offs, not just speed or cost alone!', 7, N'sequence_steps', N'{"steps": ["Study the map showing hubs, destinations, and distances.", "As a team, plan the most efficient way to deliver to every destination.", "Discuss trade-offs, like speed versus cost, as you finalize your plan.", "Compare your team''s strategy with another team''s and discuss the differences!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_6, N'short_response', N'🧑‍⚖️ Formal Debate: Should Homework Be Optional

Objective: Practice a fully structured debate with a reflection component on persuasive strategies used.

Materials: A timer or phone stopwatch | Notecards

Follow the steps below to play!', NULL, N'Great debaters can explain the other side''s view even while disagreeing with it!', 8, N'sequence_steps', N'{"steps": ["Two teams prepare arguments for and against optional homework.", "Each side delivers opening statements, then a rebuttal round.", "Each side gives a closing statement summarizing their strongest point.", "As a group, reflect on which specific arguments and techniques were most convincing!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_6, N'short_response', N'🗳️ Ranked Choice Voting Challenge

Objective: Practice ranked-choice voting with multiple rounds of elimination and recounting.

Materials: Ballots listing 4-5 favorite game choices | Pencils | Paper for tallying rounds

Follow the steps below to play!', NULL, N'Ranked-choice voting can reveal a group''s true favorite, even without an easy majority!', 9, N'sequence_steps', N'{"steps": ["Rank all the choices on your ballot from favorite to least favorite.", "Count first-choice votes; if no choice has a majority, eliminate the lowest.", "Redistribute those ballots to voters'' next choice and recount.", "Repeat until one choice has a majority, then reflect on how the result changed each round!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_6, N'short_response', N'🏘️ Ideal Community Design Pitch

Objective: Practice designing, pitching, and voting on ideal community features as a team.

Materials: Paper | Markers | A timer for pitches

Follow the steps below to play!', NULL, N'The strongest community designs solve a real problem in a clear, simple way!', 10, N'sequence_steps', N'{"steps": ["In teams, design an ideal small community addressing a real need (green space, safety, fun).", "Prepare a short pitch explaining your design''s biggest benefit.", "Present to the group and take questions.", "Vote for a favorite design and reflect on what made it stand out!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_6, N'short_response', N'🤲 Kindness Campaign Planning Game

Objective: Practice planning and pitching a mini kindness campaign with a persuasive case.

Materials: Paper | Markers

Follow the steps below to play!', NULL, N'A well-planned kindness campaign can spread good feelings through an entire community!', 11, N'sequence_steps', N'{"steps": ["Brainstorm a small kindness campaign idea, like a compliment wall or a thank-you note drive.", "Plan how it would work and who it would help.", "Pitch your campaign idea persuasively to the group.", "Reflect on what part of your pitch felt most convincing and why!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_6, N'short_response', N'🌐 Compare Global Communities Debate

Objective: Practice debating which of two general community approaches solves a shared problem better.

Materials: Fact cards describing two different (generic) community approaches to a challenge, like recycling | A timer

Follow the steps below to play!', NULL, N'Comparing different solutions helps us find the best ideas from everywhere!', 12, N'sequence_steps', N'{"steps": ["Read about two different ways communities might handle the same challenge.", "Each debater or team defends one approach with supporting reasons.", "Listen and respond respectfully to the other side''s argument.", "Reflect as a group on the strengths of both approaches!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_6, N'short_response', N'🎤 Convincing Argument Reflection Circle

Objective: Practice reflecting on what specifically makes a persuasive argument convincing.

Materials: None — just a group after a debate or speech activity

Follow the steps below to play!', NULL, N'Noticing exactly what makes an argument work helps you build stronger arguments yourself!', 13, N'sequence_steps', N'{"steps": ["After a mini debate or speech, sit in a circle together.", "Each person shares one specific thing a teammate said that was convincing.", "Discuss patterns — was it evidence, tone, structure, or something else?", "Write down one takeaway to use in your own next speech!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_6, N'short_response', N'🧭 Civic Values Sorting Debate

Objective: Practice sorting and debating which community values matter most in a given scenario.

Materials: Cards listing community values (fairness, safety, kindness, honesty) | A scenario card

Follow the steps below to play!', NULL, N'Thoughtful communities weigh many values, not just one, before deciding!', 14, N'sequence_steps', N'{"steps": ["Read a scenario where a community must make a decision.", "Sort the value cards in order of what matters most for that scenario.", "Debate your ranking with a partner who sorted differently.", "Reflect on how different values can lead to different, still-reasonable choices!"]}');

    DECLARE @cat_civic_7 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (7, 'civic', N'Community & Civics Games', 'space_heavy', 7, N'Learn how communities work together through a fun civics game!', 0);
    SET @cat_civic_7 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_7, N'short_response', N'🗳️ Student Government Mock Election

Objective: Practice a full mock election process with platform statements, speeches, and secret ballots.

Materials: Paper ballots | A ballot box | Pencils | A timer for speeches

Follow the steps below to play!', NULL, N'The best platforms clearly explain how they''ll help the whole group, not just one person!', 1, N'sequence_steps', N'{"steps": ["Candidates prepare a short, non-partisan platform statement, like ''more art supplies'' or ''a weekly game day.''", "Each candidate delivers a one-to-two-minute speech to the group.", "Everyone votes by secret ballot and places it in the box.", "Count the results together and discuss what made each platform appealing!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_7, N'short_response', N'⚖️ Championship Debate: Cats vs Dogs Finals

Objective: Practice an advanced debate structure including a cross-examination round.

Materials: A timer or phone stopwatch | Notecards

Follow the steps below to play!', NULL, N'A great cross-examination question makes the other side think harder about their argument!', 2, N'sequence_steps', N'{"steps": ["Two teams prepare arguments for Team Cats or Team Dogs.", "Each side gives an opening statement, then a cross-examination round of direct questions.", "Each side gives a rebuttal responding to the questions raised.", "Judges score the debate and explain what won them over in the closing discussion!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_7, N'short_response', N'🏛️ Community Budget Council Simulation

Objective: Practice negotiating and voting to allocate a mock community budget across competing projects.

Materials: Pretend budget tokens | Project proposal cards (park upgrade, library, recycling program)

Follow the steps below to play!', NULL, N'Real community budgeting almost always requires compromise between good ideas!', 3, N'sequence_steps', N'{"steps": ["Distribute a limited set of budget tokens to the council.", "Each project proposal gets pitched with its cost and benefits.", "Council members negotiate and can combine or scale back projects to fit the budget.", "Vote on the final budget allocation and reflect on the compromises made!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_7, N'short_response', N'🤝 Neighbor-in-Need Case Study Game

Objective: Practice analyzing a scenario, proposing solutions, debating them, and voting on the best plan.

Materials: A detailed neighbor-in-need scenario card | Paper for notes

Follow the steps below to play!', NULL, N'The best help matches exactly what a neighbor actually needs!', 4, N'sequence_steps', N'{"steps": ["Read a detailed scenario about a neighbor facing a challenge.", "In small groups, brainstorm and write down 2-3 possible ways to help.", "Each group presents its plan and answers questions from others.", "Vote on the strongest plan and discuss what made it effective!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_7, N'short_response', N'🍕 Ultimate Persuasion Challenge: Best Topping

Objective: Practice advanced persuasive speaking including a rebuttal round and audience Q&A.

Materials: A timer or phone stopwatch | Notecards

Follow the steps below to play!', NULL, N'Handling tough questions calmly is one of the most powerful persuasive skills!', 5, N'sequence_steps', N'{"steps": ["Prepare a persuasive speech defending your favorite pizza topping with strong evidence.", "Deliver your speech, then face a rebuttal from an opposing speaker.", "Take 1-2 questions from the audience and respond on the spot.", "Reflect afterward on which question was hardest to answer and why!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_7, N'short_response', N'🌍 Global Citizen Summit Role-Play

Objective: Practice representing different community perspectives and negotiating a shared solution.

Materials: Role cards describing different community perspectives on a shared, generic issue (like sharing a park space)

Follow the steps below to play!', NULL, N'Great negotiators look for solutions where everyone gains something important!', 6, N'sequence_steps', N'{"steps": ["Each player represents a different community perspective on the shared issue.", "Take turns explaining your community''s needs and concerns.", "Work together to negotiate a solution that respects multiple perspectives.", "Reflect on which part of the negotiation was hardest to agree on!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_7, N'short_response', N'📦 City Logistics Strategy Game

Objective: Practice advanced route and resource optimization with team strategy discussion.

Materials: A complex map with multiple hubs, destinations, and limited resources (like a set number of delivery trucks) | Paper for planning

Follow the steps below to play!', NULL, N'Smart resource strategy means making the most of what you have, not wishing for more!', 7, N'sequence_steps', N'{"steps": ["Study the map and the limited resources available for deliveries.", "As a team, strategize the most efficient way to serve every destination.", "Present your strategy and reasoning to another team.", "Discuss the trade-offs each team made and what you''d change next time!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_7, N'short_response', N'🧑‍⚖️ Formal Debate: School Uniforms vs Free Dress

Objective: Practice a fully judged, structured debate on a lighthearted school policy topic.

Materials: A timer or phone stopwatch | Judging score sheets

Follow the steps below to play!', NULL, N'Even a lighthearted topic deserves careful evidence and respectful listening!', 8, N'sequence_steps', N'{"steps": ["Two teams prepare arguments for uniforms or free dress at school.", "Each side presents opening statements, a rebuttal round, and closing statements.", "Judges score based on evidence, clarity, and respectfulness.", "Announce the winner and discuss what argument was the turning point!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_7, N'short_response', N'🗳️ Election Reform Lab

Objective: Practice comparing different generic voting methods through mini-elections and discussing their pros and cons.

Materials: Paper ballots set up for three formats: show of hands, secret ballot, ranked choice | Pencils

Follow the steps below to play!', NULL, N'The way we vote can shape the outcome just as much as what we vote for!', 9, N'sequence_steps', N'{"steps": ["Run the same fun mini-election three times using a different voting method each time.", "Record the results of each method.", "Compare whether the winner changed depending on the method used.", "Discuss as a group the pros and cons of each voting method!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_7, N'short_response', N'🏘️ Future Community Design Lab

Objective: Practice designing a future community that solves a specific challenge and defending the design.

Materials: Paper | Markers | A timer for presentations

Follow the steps below to play!', NULL, N'Great designs get even better after facing tough, thoughtful questions!', 10, N'sequence_steps', N'{"steps": ["Pick a specific challenge a future community might face, like limited space or clean energy needs.", "Design a community solution addressing that challenge.", "Present your design and defend it against questions from the group.", "Reflect on which question challenged your design the most, and how you''d improve it!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_7, N'short_response', N'🤲 Kindness Initiative Pitch Competition

Objective: Practice pitching a kindness initiative competitively and reflecting on persuasive strengths.

Materials: Paper | Markers | A timer for pitches

Follow the steps below to play!', NULL, N'The most convincing pitches make the impact of an idea feel real and personal!', 11, N'sequence_steps', N'{"steps": ["Design a kindness initiative for your school or neighborhood.", "Prepare a short, energetic pitch explaining its impact.", "Present your pitch competition-style to a panel of ''judges'' (the group).", "Judges vote and explain what made the winning pitch so convincing!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_7, N'short_response', N'🌐 Cross-Culture Community Debate

Objective: Practice debating a shared generic community challenge from two different cultural perspectives.

Materials: Fact cards describing two general cultural approaches to a shared challenge (like sharing food during a festival) | A timer

Follow the steps below to play!', NULL, N'Every culture has wisdom to share about building strong communities!', 12, N'sequence_steps', N'{"steps": ["Learn about two different cultural approaches to the same kind of community challenge.", "Each debater or team defends the strengths of one approach.", "Respond respectfully to questions and challenges from the other side.", "Reflect on what each approach can teach the other!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_7, N'short_response', N'🎤 Convincing Case Reflection Lab

Objective: Practice a deep group reflection on the specific persuasive techniques used across recent debates.

Materials: Notes or memories from a recent debate activity | Paper for group notes

Follow the steps below to play!', NULL, N'The best speakers are always studying what makes other arguments work!', 13, N'sequence_steps', N'{"steps": ["As a group, recall a few of the strongest arguments made in recent debates.", "Discuss what techniques made each one effective — evidence, structure, tone, or timing.", "Sort the techniques from most to least persuasive as a group.", "Each person writes one technique they want to try in their next speech!"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civic_7, N'short_response', N'🧭 Civic Roles Simulation Game

Objective: Practice taking on different civic roles in one scenario and reflecting on each role''s importance.

Materials: Role cards (voter, council member, volunteer, community reporter) | A shared scenario card

Follow the steps below to play!', NULL, N'A strong community needs every kind of civic role working together!', 14, N'sequence_steps', N'{"steps": ["Assign each player a different civic role within the same community scenario.", "Each role takes an action appropriate to their part — voting, proposing, volunteering, or reporting.", "Act out how the scenario unfolds as each role contributes.", "Reflect together on why every one of these roles matters to a healthy community!"]}');

END
GO

DELETE FROM dbo.WeeklyPacketPlan;
GO