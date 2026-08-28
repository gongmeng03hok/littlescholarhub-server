-- 59_decodable_readers_and_story_questions.sql
--
-- 1) "Decodable: Sam the Cat" (ws 24) and "Mini-Book: I See a Cat" (ws 11)
--    print real text on their sheet and showed none in the app. The bodies here
--    are VERBATIM from those sheets. A decodable must never be paraphrased: the
--    sheet's own questions refer to these exact sentences, and every word sits
--    inside the short-a pattern the child has been taught.
--
-- 2) A reading worksheet showed a story and then asked the GENERIC comprehension
--    questions, so a child could read about Sam the cat and be asked about a
--    puppy. dbo.Stories gains questions_json, and the reading quiz uses the
--    story's own questions when it has them.

SET NOCOUNT ON;

IF NOT EXISTS (SELECT 1 FROM sys.columns
               WHERE object_id = OBJECT_ID('dbo.Stories') AND name = 'questions_json')
BEGIN
    -- JSON: [{"q":"...","options":["..."],"answer":"..."}]
    ALTER TABLE dbo.Stories ADD questions_json NVARCHAR(MAX) NULL;
    PRINT 'Added Stories.questions_json';
END
GO

-- ws 24 · Sam the Cat (text verbatim from the printed sheet)
IF NOT EXISTS (SELECT 1 FROM dbo.Stories WHERE title = N'Sam the Cat')
INSERT INTO dbo.Stories
    (grade_id, language_id, title, body_text, read_min, theme_tag, vocab_json,
     is_published, thumbnail_url, source_attribution)
VALUES (1, 1, N'Sam the Cat', N'Sam is a cat. Sam is fat.

Sam sat on a mat.

"Nap, Sam, nap!" said Dad.

Sam sat and had a nap on the mat.', 3, N'animals', N'[{"word": "sat", "definition": "sat down and stayed there"}, {"word": "mat", "definition": "a small flat rug on the floor"}, {"word": "nap", "definition": "a short sleep"}, {"word": "had", "definition": "took or got something"}]',
        1, N'/art/rstory_sam_cat.svg', N'Little Scholars Hub - original story');

UPDATE w SET w.story_id = s.story_id
FROM dbo.Worksheets w JOIN dbo.Stories s ON s.title = N'Sam the Cat'
WHERE w.worksheet_id = 24;
GO

-- ws 11 · I See a Cat (text verbatim from the printed sheet)
IF NOT EXISTS (SELECT 1 FROM dbo.Stories WHERE title = N'I See a Cat')
INSERT INTO dbo.Stories
    (grade_id, language_id, title, body_text, read_min, theme_tag, vocab_json,
     is_published, thumbnail_url, source_attribution)
VALUES (1, 1, N'I See a Cat', N'I see a cat.

I see a cat run.

I see a cat jump.

I see a cat nap.

I see a cat play.

I see a cat eat.

I see a cat purr.

I love my cat!', 3, N'animals', N'[{"word": "see", "definition": "to look at something with your eyes"}, {"word": "run", "definition": "to move fast on your feet"}, {"word": "purr", "definition": "the soft rumble a happy cat makes"}, {"word": "love", "definition": "to care about someone very much"}]',
        1, N'/art/rstory_i_see_cat.svg', N'Little Scholars Hub - original story');

UPDATE w SET w.story_id = s.story_id
FROM dbo.Worksheets w JOIN dbo.Stories s ON s.title = N'I See a Cat'
WHERE w.worksheet_id = 11;
GO
UPDATE dbo.Stories SET questions_json = N'[{"q": "Who is fat?", "options": ["Sam", "Dad", "The mat"], "answer": "Sam"}, {"q": "Where did Sam sit?", "options": ["On the mat", "On a hat", "In a van"], "answer": "On the mat"}, {"q": "What did Sam do on the mat?", "options": ["Had a nap", "Ran fast", "Ate a pan"], "answer": "Had a nap"}]' WHERE title = N'Sam the Cat';
UPDATE dbo.Stories SET questions_json = N'[{"q": "What does the cat do after it runs?", "options": ["Jumps", "Eats", "Purrs"], "answer": "Jumps"}, {"q": "What sound does a happy cat make?", "options": ["A purr", "A bark", "A moo"], "answer": "A purr"}, {"q": "How does the reader feel about the cat?", "options": ["They love it", "They fear it", "They ignore it"], "answer": "They love it"}]' WHERE title = N'I See a Cat';
UPDATE dbo.Stories SET questions_json = N'[{"q": "Where was the dinosaur?", "options": ["Under the kitchen table", "In the garden", "On the roof"], "answer": "Under the kitchen table"}, {"q": "What did the dinosaur refuse to eat?", "options": ["A shoe", "A carrot", "A leaf"], "answer": "A shoe"}, {"q": "What does the dinosaur eat?", "options": ["Plants", "Shoes", "Rocks"], "answer": "Plants"}]' WHERE title = N'The Dinosaur Under the Table';
UPDATE dbo.Stories SET questions_json = N'[{"q": "Where was Ada standing at first?", "options": ["Behind a tree", "On the line", "In the goal"], "answer": "Behind a tree"}, {"q": "What happened when the whistle went?", "options": ["Everybody ran", "Everybody sat", "It started raining"], "answer": "Everybody ran"}, {"q": "Where did Ada finish in the race?", "options": ["In the middle", "First", "Last"], "answer": "In the middle"}]' WHERE title = N'The Line and the Whistle';
UPDATE dbo.Stories SET questions_json = N'[{"q": "What did Biscuit sit on?", "options": ["The homework", "The window", "The door"], "answer": "The homework"}, {"q": "Why was Biscuit sitting there, according to Zara''s father?", "options": ["It was where she was looking", "It was cold", "He was hungry"], "answer": "It was where she was looking"}, {"q": "What solved the problem?", "options": ["A cushion in the warm spot", "Shutting the door", "Moving the lamp"], "answer": "A cushion in the warm spot"}]' WHERE title = N'The Cat Who Sat on the Homework';
UPDATE dbo.Stories SET questions_json = N'[{"q": "Why would the lantern not light?", "options": ["The candle was too short", "The paper was wet", "There was no match"], "answer": "The candle was too short"}, {"q": "What did the grandmother do?", "options": ["Added a second candle", "Bought a new lantern", "Told her never mind"], "answer": "Added a second candle"}, {"q": "Why did Mei walk slowly?", "options": ["So it would not blow out", "Her shoes hurt", "She was tired"], "answer": "So it would not blow out"}]' WHERE title = N'The Lantern That Would Not Light';
UPDATE dbo.Stories SET questions_json = N'[{"q": "Why did the truck stop?", "options": ["It was taller than the bridge", "It ran out of fuel", "The road was closed"], "answer": "It was taller than the bridge"}, {"q": "What was Leo''s idea?", "options": ["Let the air out of the tyres", "Build the bridge higher", "Turn the truck around"], "answer": "Let the air out of the tyres"}, {"q": "Where did Leo get the idea?", "options": ["From his bike", "From a book", "From the driver"], "answer": "From his bike"}]' WHERE title = N'The Truck That Was Too Tall';
UPDATE dbo.Stories SET questions_json = N'[{"q": "How big was the door?", "options": ["The size of a cat", "The size of Sofia", "The size of a book"], "answer": "The size of a cat"}, {"q": "What did Sofia do when she could not fit?", "options": ["Wrote a note", "Broke the door", "Told her teacher"], "answer": "Wrote a note"}, {"q": "What did the reply ask her not to move?", "options": ["The atlas", "The lamp", "The carpet"], "answer": "The atlas"}]' WHERE title = N'The Door in the Bookcase';
UPDATE dbo.Stories SET questions_json = N'[{"q": "What is a hydrophone?", "options": ["A microphone for underwater", "A kind of boat", "A type of whale"], "answer": "A microphone for underwater"}, {"q": "What made the fast clicking sound?", "options": ["Shrimp", "The whale", "The boat engine"], "answer": "Shrimp"}, {"q": "Why can the whale be heard so far away?", "options": ["Sound travels faster in water", "Whales are very loud at close range", "The headphones were powerful"], "answer": "Sound travels faster in water"}]' WHERE title = N'The Sound the Whale Made';
UPDATE dbo.Stories SET questions_json = N'[{"q": "What did the fallen oak turn out to be?", "options": ["Two trees grown together", "A hollow trunk", "A very young tree"], "answer": "Two trees grown together"}, {"q": "What is inosculation?", "options": ["Two trunks growing and healing together", "A disease of oak trees", "A way of counting rings"], "answer": "Two trunks growing and healing together"}, {"q": "How many rings did Arjun count?", "options": ["Ninety-four", "Ninety", "Sixty"], "answer": "Ninety-four"}]' WHERE title = N'The Tree That Was Two Trees';
UPDATE dbo.Stories SET questions_json = N'[{"q": "How long does sunlight take to reach Earth?", "options": ["About eight minutes", "About one second", "About a day"], "answer": "About eight minutes"}, {"q": "How did Mei work it out?", "options": ["She divided distance by speed", "She looked it up", "Her grandfather told her"], "answer": "She divided distance by speed"}, {"q": "What did she use to watch the eclipse?", "options": ["A pinhole card", "Sunglasses", "A telescope"], "answer": "A pinhole card"}]' WHERE title = N'Eight Minutes Ago';
UPDATE dbo.Stories SET questions_json = N'[{"q": "What was Femi doing wrong at 340 metres?", "options": ["Lifting his head to look", "Kicking too hard", "Breathing too often"], "answer": "Lifting his head to look"}, {"q": "What happened when his head came up?", "options": ["His hips went down", "He swam faster", "He lost his goggles"], "answer": "His hips went down"}, {"q": "What was the result of swimming it blind?", "options": ["His fastest ever time", "He came last", "He was disqualified"], "answer": "His fastest ever time"}]' WHERE title = N'The Last Fifty Metres';
UPDATE dbo.Stories SET questions_json = N'[{"q": "What can a footprint tell you honestly?", "options": ["The shape of the foot and the speed", "The colour of the animal", "Whether it had feathers"], "answer": "The shape of the foot and the speed"}, {"q": "How fast was this animal moving?", "options": ["Walking, about five km an hour", "Running flat out", "Standing still"], "answer": "Walking, about five km an hour"}, {"q": "What did Dr Achebe say palaeontology is really about?", "options": ["Being careful about what the rock actually says", "Knowing what dinosaurs looked like", "Finding the biggest fossil"], "answer": "Being careful about what the rock actually says"}]' WHERE title = N'What the Footprint Did Not Say';
UPDATE dbo.Stories SET questions_json = N'[{"q": "How many people did the grandmother usually cook for?", "options": ["Nineteen", "Nine", "Thirty"], "answer": "Nineteen"}, {"q": "Why did nobody come that year?", "options": ["Illness, travel and a muted group message", "They were not invited", "The food was late"], "answer": "Illness, travel and a muted group message"}, {"q": "What did the grandmother decide to do?", "options": ["Take the food to a community centre", "Freeze it all", "Cancel next year"], "answer": "Take the food to a community centre"}]' WHERE title = N'The Year Nobody Came';
UPDATE dbo.Stories SET questions_json = N'[{"q": "How long did Ravi run his experiment?", "options": ["Eleven weeks", "Eleven days", "One afternoon"], "answer": "Eleven weeks"}, {"q": "What happened when his sister went instead?", "options": ["The crows stayed away", "The crows came faster", "Nothing changed"], "answer": "The crows stayed away"}, {"q": "What did the research show crows can do?", "options": ["Recognise faces and tell other crows", "Count to ten", "Copy human speech"], "answer": "Recognise faces and tell other crows"}]' WHERE title = N'The Crow That Kept Score';

GO
SELECT COUNT(*) AS stories_with_questions FROM dbo.Stories WHERE questions_json IS NOT NULL;
GO
