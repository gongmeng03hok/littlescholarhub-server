-- 58_theme_reading_stories.sql
-- Gives every "<Theme> Reading - Grade N" worksheet a story to actually read.
--
-- 13 worksheets are titled "<Theme> Reading - Grade N" and 39 rows across the
-- catalog promised reading material with nothing behind it. These 13 are the
-- coherent set: each is a unique theme x grade pairing, covering every grade
-- TK-6th and all nine interest themes.
--
-- One original story each, written at its own level: ~110 words at TK rising to
-- ~320 at 6th, and themed to match the title, so "Ocean Reading - Grade 3rd"
-- is a story about the ocean at a 3rd-grade level.
--
-- Originals. Market research (Scholastic read-aloud lists, Amazon children's
-- bestsellers, 2026 middle-grade craft guidance) informed structure, hook and
-- reading level only; no commercial title is reproduced or adapted.

SET NOCOUNT ON;
DECLARE @orig NVARCHAR(512) = N'Little Scholars Hub - original story';
GO

-- ws 61 · sports · grade_id 0
IF NOT EXISTS (SELECT 1 FROM dbo.Stories WHERE title = N'The Line and the Whistle')
INSERT INTO dbo.Stories
    (grade_id, language_id, title, body_text, read_min, theme_tag, vocab_json,
     is_published, thumbnail_url, source_attribution)
VALUES (0, 1, N'The Line and the Whistle', N'Ada could not find the line.

Everyone else was standing on it. It was painted white on the grass, and it was right there, and Ada was standing behind a tree.

"Toes on the line!" called the coach.

Ada looked at her toes. She looked at the tree. She walked out and put her toes on the white paint, next to a boy in a yellow shirt.

The whistle went.

Everybody ran.

Ada ran too. Not first. Not last. Somewhere in the warm middle of all the feet.

When she stopped she was breathing hard and smiling, and the boy in the yellow shirt said, "You came!"

"I came," said Ada.', 3, N'sports', N'[{"word": "line", "definition": "a mark you stand on to start a race"}, {"word": "coach", "definition": "a person who teaches you a sport"}, {"word": "whistle", "definition": "a small thing you blow to make a loud sound"}, {"word": "middle", "definition": "not the front and not the back"}]',
        1, N'/art/rstory_sports_tk.svg', N'Little Scholars Hub - original story');

UPDATE w SET w.story_id = s.story_id
FROM dbo.Worksheets w JOIN dbo.Stories s ON s.title = N'The Line and the Whistle'
WHERE w.worksheet_id = 61;
GO

-- ws 55 · dinosaurs · grade_id 0
IF NOT EXISTS (SELECT 1 FROM dbo.Stories WHERE title = N'The Dinosaur Under the Table')
INSERT INTO dbo.Stories
    (grade_id, language_id, title, body_text, read_min, theme_tag, vocab_json,
     is_published, thumbnail_url, source_attribution)
VALUES (0, 1, N'The Dinosaur Under the Table', N'There was a dinosaur under the kitchen table.

He was small. He was green. He had three little spikes and one very long tail, and the tail went all the way to the fridge.

"Are you hungry?" asked Noah.

The dinosaur nodded.

Noah gave him a carrot. The dinosaur ate the carrot.

Noah gave him a leaf from the plant by the window. The dinosaur ate the leaf.

Noah gave him a shoe.

The dinosaur looked at the shoe. Then he looked at Noah.

"Not a shoe," said the dinosaur. "I eat plants."

So Noah took the shoe back, and they had leaves together, under the table, until dinner.', 3, N'dinosaurs', N'[{"word": "spikes", "definition": "sharp points on an animal''s back"}, {"word": "tail", "definition": "the long part at the back of an animal"}, {"word": "plants", "definition": "things that grow, like leaves and grass"}, {"word": "nodded", "definition": "moved your head up and down to say yes"}]',
        1, N'/art/rstory_dino_tk.svg', N'Little Scholars Hub - original story');

UPDATE w SET w.story_id = s.story_id
FROM dbo.Worksheets w JOIN dbo.Stories s ON s.title = N'The Dinosaur Under the Table'
WHERE w.worksheet_id = 55;
GO

-- ws 69 · holidays · grade_id 1
IF NOT EXISTS (SELECT 1 FROM dbo.Stories WHERE title = N'The Lantern That Would Not Light')
INSERT INTO dbo.Stories
    (grade_id, language_id, title, body_text, read_min, theme_tag, vocab_json,
     is_published, thumbnail_url, source_attribution)
VALUES (1, 1, N'The Lantern That Would Not Light', N'On the night of the lantern parade, Mei''s lantern would not light.

Every other lantern glowed. Red ones. Gold ones. One shaped like a rabbit. Mei''s paper lantern sat dark in her hands.

"The candle is too short," said her grandmother. "It cannot reach."

Mei''s eyes went hot.

Her grandmother did not say never mind. She sat down on the step, took out a second candle, and stood it upright in the little cup at the bottom.

"Now try."

Mei struck the match. The wick caught. The paper turned warm and orange from the inside, and the rabbit painted on the side looked suddenly awake.

Mei carried it the whole way. She walked slowly, so it would not blow out, and everyone behind her walked slowly too.', 4, N'holidays', N'[{"word": "lantern", "definition": "a paper or glass case with a light inside"}, {"word": "parade", "definition": "a line of people walking together to celebrate"}, {"word": "wick", "definition": "the string in a candle that burns"}, {"word": "upright", "definition": "standing straight up"}]',
        1, N'/art/rstory_holidays_k.svg', N'Little Scholars Hub - original story');

UPDATE w SET w.story_id = s.story_id
FROM dbo.Worksheets w JOIN dbo.Stories s ON s.title = N'The Lantern That Would Not Light'
WHERE w.worksheet_id = 69;
GO

-- ws 63 · animals · grade_id 1
IF NOT EXISTS (SELECT 1 FROM dbo.Stories WHERE title = N'The Cat Who Sat on the Homework')
INSERT INTO dbo.Stories
    (grade_id, language_id, title, body_text, read_min, theme_tag, vocab_json,
     is_published, thumbnail_url, source_attribution)
VALUES (1, 1, N'The Cat Who Sat on the Homework', N'Every night at seven o''clock, Biscuit sat on the homework.

Not near it. On it.

Zara would move him. Biscuit would wait. Zara would write two words. Biscuit would sit back down, exactly on the page, purring like a small engine.

"He is doing it on purpose," said Zara.

"He is sitting where you are looking," said her father.

Zara thought about that.

The next night she put a cushion on the table, right beside her book, in the warm spot under the lamp.

Biscuit walked over. He looked at the cushion. He looked at the homework.

He sat on the cushion.

Zara finished her whole page, with one hand writing and the other hand on a purring cat, which is the best way to finish a page.', 4, N'animals', N'[{"word": "purring", "definition": "the soft rumble a happy cat makes"}, {"word": "engine", "definition": "a machine that makes a rumbling sound"}, {"word": "cushion", "definition": "a soft pad to sit on"}, {"word": "exactly", "definition": "in just that spot, not a bit off"}]',
        1, N'/art/rstory_animals_k.svg', N'Little Scholars Hub - original story');

UPDATE w SET w.story_id = s.story_id
FROM dbo.Worksheets w JOIN dbo.Stories s ON s.title = N'The Cat Who Sat on the Homework'
WHERE w.worksheet_id = 63;
GO

-- ws 77 · vehicles · grade_id 2
IF NOT EXISTS (SELECT 1 FROM dbo.Stories WHERE title = N'The Truck That Was Too Tall')
INSERT INTO dbo.Stories
    (grade_id, language_id, title, body_text, read_min, theme_tag, vocab_json,
     is_published, thumbnail_url, source_attribution)
VALUES (2, 1, N'The Truck That Was Too Tall', N'The truck stopped under the bridge because it did not fit.

It was a big truck carrying a digger, and the digger''s arm stood up like a giraffe''s neck. The bridge sign said 3.8 METRES. The truck and the digger together were 4.0.

Cars honked. A man in a yellow vest scratched his head.

Leo watched from the pavement with his mother.

"They should build the bridge higher," said the man in the vest.

"Or," said Leo, "make the truck shorter."

The man turned around. "How?"

Leo pointed at the tyres.

They let the air out. A long slow hiss from all eight tyres, and the whole truck sank down. Just a little. Just enough. It rolled under the bridge with room to spare.

Leo''s mother looked at him for a long moment.

"Where did you get that?"

"It is what happens to my bike," said Leo, "when I forget to pump it."
', 5, N'vehicles', N'[{"word": "bridge", "definition": "a road built over another road or a river"}, {"word": "metres", "definition": "a way of measuring how tall something is"}, {"word": "tyres", "definition": "the rubber rings filled with air on a wheel"}, {"word": "hiss", "definition": "the sound air makes escaping slowly"}]',
        1, N'/art/rstory_vehicles_1st.svg', N'Little Scholars Hub - original story');

UPDATE w SET w.story_id = s.story_id
FROM dbo.Worksheets w JOIN dbo.Stories s ON s.title = N'The Truck That Was Too Tall'
WHERE w.worksheet_id = 77;
GO

-- ws 85 · fantasy · grade_id 3
IF NOT EXISTS (SELECT 1 FROM dbo.Stories WHERE title = N'The Door in the Bookcase')
INSERT INTO dbo.Stories
    (grade_id, language_id, title, body_text, read_min, theme_tag, vocab_json,
     is_published, thumbnail_url, source_attribution)
VALUES (3, 1, N'The Door in the Bookcase', N'There was a door in the bookcase, and it was exactly the size of a cat.

Sofia found it behind the atlas. It had a tiny brass handle, worn shiny, as though something had been opening it for a very long time.

She could not fit. She knew that at once. She was eight, and the door was the size of a cat.

So she did the only sensible thing. She wrote a note.

HELLO. WHO LIVES HERE?

She folded it small and pushed it under the door, and went to bed.

In the morning there was a note on the carpet, in handwriting so small she had to hold it near the lamp.

WE DO. PLEASE DO NOT MOVE THE ATLAS. IT IS OUR ROOF.

Sofia read it four times.

Then she put the atlas back exactly where it had been, and turned it so the spine was straight, and never told anybody. Except her grandmother, who was the only person she knew who would not laugh, and who said, after a while, "Yes. There was one in my house too."
', 6, N'fantasy', N'[{"word": "atlas", "definition": "a book of maps"}, {"word": "brass", "definition": "a shiny yellow metal"}, {"word": "handle", "definition": "the part you hold to open a door"}, {"word": "spine", "definition": "the edge of a book where the pages are joined"}]',
        1, N'/art/rstory_fantasy_2nd.svg', N'Little Scholars Hub - original story');

UPDATE w SET w.story_id = s.story_id
FROM dbo.Worksheets w JOIN dbo.Stories s ON s.title = N'The Door in the Bookcase'
WHERE w.worksheet_id = 85;
GO

-- ws 93 · ocean · grade_id 4
IF NOT EXISTS (SELECT 1 FROM dbo.Stories WHERE title = N'The Sound the Whale Made')
INSERT INTO dbo.Stories
    (grade_id, language_id, title, body_text, read_min, theme_tag, vocab_json,
     is_published, thumbnail_url, source_attribution)
VALUES (4, 1, N'The Sound the Whale Made', N'The hydrophone belonged to Nadia''s father, and she was not supposed to touch it.

It was a microphone that went into the water on a long cable. He used it for work. It lived in a padded case in the boot of the car.

On the last morning of the holiday, he let her.

They lowered it off the end of the jetty into the green water, and Nadia put on the headphones.

At first, nothing. A soft roar, like a shell held to your ear. Then clicking. Quick and sharp, like someone tapping a spoon on a cup.

"Shrimp," said her father. "Thousands of them."

Nadia listened for a long time.

And then, underneath everything, so low that she felt it in her jaw before she heard it, came a long slow note. It rose. It fell. It rose again and held, and went on holding, far longer than any person could sing.

Nadia did not move.

"Humpback," her father said quietly. "Maybe six kilometres out."

"Six kilometres," said Nadia. "And I can hear him."

"Sound travels four times faster in water than in air," said her father. "He is probably talking to someone forty kilometres away."

Nadia sat on the jetty with the headphones on until the tide turned, listening to a conversation she could not understand, between two animals she could not see.', 7, N'ocean', N'[{"word": "hydrophone", "definition": "a microphone made to listen underwater"}, {"word": "jetty", "definition": "a small pier that sticks out into the water"}, {"word": "humpback", "definition": "a kind of very large whale that sings"}, {"word": "travels", "definition": "moves from one place to another"}]',
        1, N'/art/rstory_ocean_3rd.svg', N'Little Scholars Hub - original story');

UPDATE w SET w.story_id = s.story_id
FROM dbo.Worksheets w JOIN dbo.Stories s ON s.title = N'The Sound the Whale Made'
WHERE w.worksheet_id = 93;
GO

-- ws 107 · nature · grade_id 5
IF NOT EXISTS (SELECT 1 FROM dbo.Stories WHERE title = N'The Tree That Was Two Trees')
INSERT INTO dbo.Stories
    (grade_id, language_id, title, body_text, read_min, theme_tag, vocab_json,
     is_published, thumbnail_url, source_attribution)
VALUES (5, 1, N'The Tree That Was Two Trees', N'The oak at the end of the field had a scar down its side, and Arjun had walked past it every day for six years without once wondering why.

Then the storm came, and the oak came down, and lying on its side in the wet grass it turned out to be two trees.

You could see it in the cut end. Two sets of rings, grown into each other, fused along one seam like two hands with the fingers laced.

"Inosculation," said Ms Oyelaran, who had come out to look at it with half the class. "It happens when two trunks grow close enough to rub. The bark wears away, the living wood underneath touches, and then it heals. But it heals together."

Arjun crouched down and put his palm flat on the cut.

"So which one was it?"

"Both. For about ninety years."

"But which one died?"

Ms Oyelaran was quiet for a moment.

"Neither," she said. "They shared water. They shared sugar. When one had a bad year, the other one carried it. That is what the seam is. Ninety years of carrying."

Arjun counted the rings on the way back, and lost count, and started again, and lost count again.

He came back on Saturday with a pencil and paper and counted properly: ninety-four.

He wrote the number down and folded it into his pocket, and he still has it.', 8, N'nature', N'[{"word": "scar", "definition": "a mark left where something healed"}, {"word": "fused", "definition": "joined so completely they became one"}, {"word": "seam", "definition": "the line where two things join"}, {"word": "rings", "definition": "the circles in a tree trunk, one for each year"}]',
        1, N'/art/rstory_nature_4th.svg', N'Little Scholars Hub - original story');

UPDATE w SET w.story_id = s.story_id
FROM dbo.Worksheets w JOIN dbo.Stories s ON s.title = N'The Tree That Was Two Trees'
WHERE w.worksheet_id = 107;
GO

-- ws 101 · space · grade_id 5
IF NOT EXISTS (SELECT 1 FROM dbo.Stories WHERE title = N'Eight Minutes Ago')
INSERT INTO dbo.Stories
    (grade_id, language_id, title, body_text, read_min, theme_tag, vocab_json,
     is_published, thumbnail_url, source_attribution)
VALUES (5, 1, N'Eight Minutes Ago', N'Mei''s grandfather asked her a question on the roof, and she is still thinking about it.

They were up there for the eclipse, with a box of pinhole cards he had made from a cereal packet. While they waited he pointed at the sun with his chin, never his finger, never his eyes, and said:

"How far away is that?"

"A hundred and fifty million kilometres," said Mei. She had looked it up.

"And how fast does light go?"

"Three hundred thousand kilometres every second."

Her grandfather waited.

Mei did the arithmetic slowly. On her fingers first, and then, when that failed, on the back of the cereal packet. A hundred and fifty million divided by three hundred thousand.

"Five hundred seconds," she said.

"Which is?"

"Eight minutes. And a bit."

"So," said her grandfather, "when you look at the sun, how old is what you are seeing?"

Mei stopped.

"Eight minutes old," she said. "I am seeing it late."

"You are seeing it late," he agreed. "Everything you have ever seen, you have seen late. Me included. Light takes time."

The moon slid across. The light on the rooftop went strange and silver, and the birds all went quiet at the wrong hour, and Mei watched it happen on a piece of cereal packet with a pinhole in it.

But mostly she thought about the eight minutes.', 8, N'space', N'[{"word": "eclipse", "definition": "when the moon passes in front of the sun"}, {"word": "pinhole", "definition": "a tiny hole that lets a small beam of light through"}, {"word": "arithmetic", "definition": "working with numbers"}, {"word": "kilometres", "definition": "a way of measuring long distances"}]',
        1, N'/art/rstory_space_4th.svg', N'Little Scholars Hub - original story');

UPDATE w SET w.story_id = s.story_id
FROM dbo.Worksheets w JOIN dbo.Stories s ON s.title = N'Eight Minutes Ago'
WHERE w.worksheet_id = 101;
GO

-- ws 115 · sports · grade_id 6
IF NOT EXISTS (SELECT 1 FROM dbo.Stories WHERE title = N'The Last Fifty Metres')
INSERT INTO dbo.Stories
    (grade_id, language_id, title, body_text, read_min, theme_tag, vocab_json,
     is_published, thumbnail_url, source_attribution)
VALUES (6, 1, N'The Last Fifty Metres', N'Femi had been swimming the 400 freestyle for four years, and he had never once got the last fifty metres right.

He knew it the way you know a hole in a tooth. The first three hundred and fifty were fine. Better than fine. He would come off the turn in second, sometimes first, and then the water would turn to concrete and everyone would go past him as though he were tied to the wall.

His coach filmed it.

They watched it together on a Tuesday, in the little office that smelled of chlorine, hunched over a phone.

"There," said Coach Bello. "Stop it there."

Femi stopped it.

"What is your head doing?"

"Nothing."

"Look again."

He looked again. At 340 metres his head came up. Just slightly. Just enough to glance sideways at lane four. And when the head came up the hips went down, and when the hips went down he was not swimming any more. He was ploughing.

"I am checking where they are," said Femi.

"I know. It costs you about a second and a half every time. You are losing the race in order to find out whether you are losing the race."

Femi did not say anything.

"Next Tuesday," said Coach Bello, "you swim it blind. Head down the whole last hundred. You will not know where anybody is until you touch."

It was the worst hundred metres of his life. He had no idea. He could have been first or last. He touched the wall, came up gasping, and looked at the board.

Second, by four hundredths.

But the time was two and a half seconds faster than he had ever swum, and Coach Bello was standing at the end of the lane with his arms folded, not smiling exactly, but close.', 9, N'sports', N'[{"word": "freestyle", "definition": "a swimming race where you choose your stroke"}, {"word": "chlorine", "definition": "the chemical that keeps pool water clean"}, {"word": "hips", "definition": "the part of your body where your legs join"}, {"word": "hundredths", "definition": "very small parts of a second"}]',
        1, N'/art/rstory_sports_5th.svg', N'Little Scholars Hub - original story');

UPDATE w SET w.story_id = s.story_id
FROM dbo.Worksheets w JOIN dbo.Stories s ON s.title = N'The Last Fifty Metres'
WHERE w.worksheet_id = 115;
GO

-- ws 109 · dinosaurs · grade_id 6
IF NOT EXISTS (SELECT 1 FROM dbo.Stories WHERE title = N'What the Footprint Did Not Say')
INSERT INTO dbo.Stories
    (grade_id, language_id, title, body_text, read_min, theme_tag, vocab_json,
     is_published, thumbnail_url, source_attribution)
VALUES (6, 1, N'What the Footprint Did Not Say', N'The trackway was in a quarry outside town. It was ninety metres long, and Zara''s class was allowed to walk beside it but not on it.

Twenty-eight footprints. Three toes each. Pressed into what had been mud a hundred and ten million years ago and was now grey stone, hard as a road.

"Big one," said someone.

"Not necessarily," said Dr Achebe.

She crouched by the first print and traced the air above it without touching.

"Here is what a footprint tells you honestly. The shape of a foot. Roughly how heavy the animal was. How far apart its steps were. From the step length you can work out speed. This one was walking, not running. About five kilometres an hour. About as fast as your mother walks to the shops."

"And what does it not tell you?" asked Zara.

Dr Achebe looked up at her with obvious pleasure.

"Almost everything else. It does not tell me what colour it was. It does not tell me whether it had feathers, though I think it probably did. It does not tell me if it was alone. There is one trackway here, but a herd may have walked on ground that did not preserve. It does not tell me if it was old, or young, or sick, or hungry, or frightened."

She stood up and brushed the dust off her knees.

"People will tell you palaeontology is about knowing what dinosaurs were like. It is not. It is about being extremely careful about the difference between what the rock says and what you would like it to say."

Zara wrote that down.

She has changed her mind about a great many things since. Not about that.', 9, N'dinosaurs', N'[{"word": "trackway", "definition": "a line of fossil footprints left by one animal"}, {"word": "quarry", "definition": "a place where stone is cut out of the ground"}, {"word": "preserve", "definition": "to keep something from being destroyed over time"}, {"word": "palaeontology", "definition": "the study of fossils and ancient life"}]',
        1, N'/art/rstory_dino_5th.svg', N'Little Scholars Hub - original story');

UPDATE w SET w.story_id = s.story_id
FROM dbo.Worksheets w JOIN dbo.Stories s ON s.title = N'What the Footprint Did Not Say'
WHERE w.worksheet_id = 109;
GO

-- ws 123 · holidays · grade_id 7
IF NOT EXISTS (SELECT 1 FROM dbo.Stories WHERE title = N'The Year Nobody Came')
INSERT INTO dbo.Stories
    (grade_id, language_id, title, body_text, read_min, theme_tag, vocab_json,
     is_published, thumbnail_url, source_attribution)
VALUES (7, 1, N'The Year Nobody Came', N'Every December, Amara''s grandmother cooked for nineteen people.

This is not an exaggeration. It was nineteen, and it had been nineteen for as long as anyone could remember, and the number was a fact of the house like the crack in the hallway tiles. Two long tables pushed together. The good cloth. The bowl that came out once a year.

The year Amara was twelve, four people had flu, three were stuck at an airport, and the rest of the family, through a chain of misunderstandings involving a group message that half of them had muted, believed the whole thing had been cancelled.

At two o''clock, the doorbell had not rung.

At three, her grandmother stopped watching the door. She went into the kitchen, and Amara followed, and they stood together looking at food for nineteen people.

Amara waited for her to cry, or to be angry, or to start putting it all in the fridge.

Instead her grandmother said, "Get your coat."

They filled the car. Every dish, wrapped in tea towels so it would not slide. They drove to the community centre on Fulton Road, where a woman Amara had never met opened the back door, looked at the boot of the car, and said only, "Oh." And then, "Come in, come in, quickly, it is freezing."

They served until half past six.

Amara does not remember what she said to anyone. She remembers a man who ate three helpings of the rice and then asked, very politely, whether he could take some to his brother.

On the way home her grandmother was quiet for a long time.

Then she said, "Nineteen was never the point. I only ever counted because it was easy to count."

They still cook for nineteen. Some years everybody comes. Some years the car gets loaded.

Amara is nineteen herself now, which she finds funny, and she does the driving.', 11, N'holidays', N'[{"word": "exaggeration", "definition": "saying something is bigger than it really is"}, {"word": "misunderstanding", "definition": "when people think different things about the same message"}, {"word": "community centre", "definition": "a building where local people meet and are helped"}, {"word": "helpings", "definition": "servings of food on a plate"}]',
        1, N'/art/rstory_holidays_6th.svg', N'Little Scholars Hub - original story');

UPDATE w SET w.story_id = s.story_id
FROM dbo.Worksheets w JOIN dbo.Stories s ON s.title = N'The Year Nobody Came'
WHERE w.worksheet_id = 123;
GO

-- ws 117 · animals · grade_id 7
IF NOT EXISTS (SELECT 1 FROM dbo.Stories WHERE title = N'The Crow That Kept Score')
INSERT INTO dbo.Stories
    (grade_id, language_id, title, body_text, read_min, theme_tag, vocab_json,
     is_published, thumbnail_url, source_attribution)
VALUES (7, 1, N'The Crow That Kept Score', N'The crows on Ravi''s road could tell people apart, and Ravi could prove it.

It started as an argument with his sister, who said all crows looked the same and therefore probably thought all people looked the same. Which is not an argument so much as a guess.

So Ravi did what you do. He got a notebook.

For eleven weeks he fed the crows on the wall behind the garages at the same time every afternoon. A handful of unsalted peanuts, always from the same blue tin. He wrote down the date, the number of birds, and how long they took to come down once he arrived.

Week one: forty seconds, two birds.

Week four: eleven seconds, five birds.

Week seven: they were already on the wall when he got there.

Then he ran the part he had been building towards. He asked his sister to go instead, at the same time, with the same tin, wearing his coat.

The crows did not come down at all. They watched her from the roof of the garages for six minutes, and then flew off.

His sister came back annoyed, which Ravi wrote down too, because it was data.

He looked it up afterwards and found he had accidentally repeated a real experiment. Researchers in Seattle had shown that crows recognise individual human faces, remember which ones treated them badly, and, this is the part that kept Ravi awake, tell other crows. Including crows that were never there. The grudge outlives the bird that formed it.

Ravi still feeds them. He is careful to be the one who does it.

His sister says this is because he is superstitious. Ravi says it is because he has read the literature.', 11, N'animals', N'[{"word": "experiment", "definition": "a careful test to find out if something is true"}, {"word": "data", "definition": "facts and numbers collected to study"}, {"word": "recognise", "definition": "to know someone or something you have seen before"}, {"word": "grudge", "definition": "a bad feeling kept about someone for a long time"}]',
        1, N'/art/rstory_animals_6th.svg', N'Little Scholars Hub - original story');

UPDATE w SET w.story_id = s.story_id
FROM dbo.Worksheets w JOIN dbo.Stories s ON s.title = N'The Crow That Kept Score'
WHERE w.worksheet_id = 117;
GO

SELECT w.worksheet_id, w.title AS worksheet, s.title AS story, s.grade_id, s.read_min
FROM dbo.Worksheets w JOIN dbo.Stories s ON w.story_id = s.story_id
WHERE w.title LIKE '%Reading - Grade%'
ORDER BY s.grade_id;
GO
