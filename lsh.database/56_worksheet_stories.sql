-- 56_worksheet_stories.sql
-- Gives every "<Theme> Story - Grade <N>" worksheet a real story to read.
--
-- Eleven worksheets promised reading material and had none: dbo.Worksheets has
-- no text column, and these rows never referenced dbo.Stories. The child opened
-- a "story" and got an activity PDF.
--
-- Adds Worksheets.story_id, writes the eleven stories, and links them.
--
-- REFERENCE, NOT SOURCE: written after reviewing what sells — Scholastic's
-- read-aloud lists, Amazon's children's bestsellers, and 2026 middle-grade
-- craft guidance (open on a hook; one main plot; a character the reader can
-- connect with; suspense carried to the last line). Junie B. Jones / Mercy
-- Watson voice for K–2, Magic Tree House pacing for 3–6. Every word below is
-- original to this platform; no commercial title is reproduced or adapted.
--
-- Length scales with grade: ~90 words at TK to ~320 at 6th.

SET NOCOUNT ON;

IF NOT EXISTS (SELECT 1 FROM sys.columns
               WHERE object_id = OBJECT_ID('dbo.Worksheets') AND name = 'story_id')
BEGIN
    ALTER TABLE dbo.Worksheets ADD story_id INT NULL
        CONSTRAINT FK_Worksheet_Story REFERENCES dbo.Stories(story_id);
    PRINT 'Added Worksheets.story_id';
END
GO

DECLARE @orig NVARCHAR(512) = N'Little Scholars Hub — original story';

-- ── TK · fantasy ────────────────────────────────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM dbo.Stories WHERE title = N'The Dragon in the Teapot')
INSERT INTO dbo.Stories (grade_id, language_id, title, body_text, read_min, theme_tag, vocab_json, is_published, thumbnail_url, source_attribution)
VALUES (0, 1, N'The Dragon in the Teapot',
N'Grandma''s teapot had a very small dragon inside it.

He was green. He was the size of a thumb. And he was always warm.

"Is the tea hot?" Grandma would ask.

The little dragon would puff. Just once. Just a little.

And the tea would steam.

Nobody else knew he was there. But every time Grandma poured, she smiled at the spout.

"Thank you," she whispered.

The little dragon puffed again, and the whole kitchen smelled like ginger and rain.',
 3, N'fantasy',
 N'[{"word":"teapot","definition":"a pot with a spout for pouring tea"},{"word":"puff","definition":"to blow out a small breath of air"},{"word":"steam","definition":"the warm mist that rises from hot water"},{"word":"whisper","definition":"to talk very quietly"}]',
 1, N'/art/wstory_fantasy_tk.svg', @orig);

-- ── K · ocean ───────────────────────────────────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM dbo.Stories WHERE title = N'The Crab Who Grew Too Big')
INSERT INTO dbo.Stories (grade_id, language_id, title, body_text, read_min, theme_tag, vocab_json, is_published, thumbnail_url, source_attribution)
VALUES (1, 1, N'The Crab Who Grew Too Big',
N'One morning, Bo the hermit crab could not fit in his shell.

He pushed. He wiggled. He held his breath. It was no use. He had grown.

So Bo went shopping along the sand.

He tried a bottle cap. Too flat.

He tried a tin can. Too loud — it went CLANG on the rocks.

He tried a sea sponge. Too soft. It squished.

Then, half buried by the tide, Bo found a smooth white shell with a curl at the end.

He backed in slowly.

It fit.

Bo waved his claws at the sea and went on his way — a little bigger than yesterday, and quite pleased about it.',
 4, N'ocean',
 N'[{"word":"hermit crab","definition":"a crab that lives inside a shell it finds"},{"word":"tide","definition":"the sea moving up and down the beach"},{"word":"sponge","definition":"a soft sea animal full of holes"},{"word":"claws","definition":"the sharp pincers on a crab"}]',
 1, N'/art/wstory_ocean_k.svg', @orig);

-- ── 1st · space ─────────────────────────────────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM dbo.Stories WHERE title = N'Ravi Counts the Stars')
INSERT INTO dbo.Stories (grade_id, language_id, title, body_text, read_min, theme_tag, vocab_json, is_published, thumbnail_url, source_attribution)
VALUES (2, 1, N'Ravi Counts the Stars',
N'Ravi decided he would count every star.

He took a blanket to the roof. He took a pencil. He started at the bright one over the water tank.

"One. Two. Three. Four…"

By forty he had lost his place. By sixty the sky seemed to have more stars than when he began.

His grandmother climbed up with two cups of warm milk.

"How many?" she asked.

"I keep losing them," said Ravi. "There are too many."

"Then stop counting," she said, "and start looking."

She traced her finger through the sky. Four stars in a crooked line. Three more below.

"That one is a hunter," she said. "That one is a plough. When you cannot count a thing, look for the shape of it."

Ravi lay back on the blanket. He did not count a single star after that.

He found six shapes instead.',
 5, N'space',
 N'[{"word":"trace","definition":"to draw a line along something with your finger"},{"word":"crooked","definition":"not straight"},{"word":"plough","definition":"a farm tool; also a group of stars shaped like one"},{"word":"shape","definition":"the outline or form of something"}]',
 1, N'/art/wstory_space_1st.svg', @orig);

-- ── 1st · nature ────────────────────────────────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM dbo.Stories WHERE title = N'Who Made These Tracks?')
INSERT INTO dbo.Stories (grade_id, language_id, title, body_text, read_min, theme_tag, vocab_json, is_published, thumbnail_url, source_attribution)
VALUES (2, 1, N'Who Made These Tracks?',
N'It rained all night. In the morning the path behind the school was soft mud — and the mud was covered in footprints.

Sofia crouched down.

"Something came through here," she said.

The first tracks were tiny, in pairs, with a long drag between them. "Mouse," said her teacher. "That drag is its tail."

The next were small hands. Really small hands, with five fingers. "Raccoon," said her teacher. "They walk on their palms, like us."

Then Sofia found something new. Two long ovals, side by side, pressed deep.

She looked at them for a long time.

"These ones are heavy," she said. "And they stopped here. Then they turned around."

Her teacher smiled. "Now you are not just seeing tracks. You are reading them."

Sofia followed the heavy prints all the way to the fence, where a deer had stood, looked back at the school, and gone.',
 5, N'nature',
 N'[{"word":"track","definition":"a footprint left behind by an animal"},{"word":"crouch","definition":"to bend down low"},{"word":"drag","definition":"a mark made by something pulled along"},{"word":"oval","definition":"a shape like a stretched circle"}]',
 1, N'/art/wstory_nature_1st.svg', @orig);

-- ── 2nd · dinosaurs ─────────────────────────────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM dbo.Stories WHERE title = N'The Bone in the Backyard')
INSERT INTO dbo.Stories (grade_id, language_id, title, body_text, read_min, theme_tag, vocab_json, is_published, thumbnail_url, source_attribution)
VALUES (3, 1, N'The Bone in the Backyard',
N'Leo found the bone under the lemon tree.

It was longer than his arm, grey as a stone, and heavier than it looked. He carried it inside with both hands.

"Dinosaur," he said.

His sister laughed. Leo did not laugh. He got a notebook.

He wrote down where he found it. He drew it from the top and from the side. He measured it with a piece of string, then measured the string with a ruler: forty-one centimetres. He photographed it next to a spoon so anyone could see how big it was.

On Saturday the family took it to the museum.

The scientist turned the bone over twice. She looked at the notebook for longer than she looked at the bone.

"I have bad news and good news," she said. "The bad news is that this is a cow bone. About sixty years old."

Leo''s shoulders dropped.

"The good news," she said, "is that you did all of this exactly right. The notes. The scale. The drawings. Most people bring me a bone in a plastic bag and no information at all."

She handed the notebook back.

"Keep digging," she said. "And keep writing it down. That part is the science."',
 6, N'dinosaurs',
 N'[{"word":"measure","definition":"to find out how long or heavy something is"},{"word":"scale","definition":"something of known size placed next to an object to show how big it is"},{"word":"scientist","definition":"a person who studies how the world works"},{"word":"evidence","definition":"facts that help you know if something is true"}]',
 1, N'/art/wstory_dino_2nd.svg', @orig);

-- ── 2nd · sports ────────────────────────────────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM dbo.Stories WHERE title = N'The Slowest Runner on the Team')
INSERT INTO dbo.Stories (grade_id, language_id, title, body_text, read_min, theme_tag, vocab_json, is_published, thumbnail_url, source_attribution)
VALUES (3, 1, N'The Slowest Runner on the Team',
N'Everybody knew Mia was the slowest runner in second grade.

So when Coach put her in the relay team, the others went quiet.

"Four runners," said Coach. "One baton. It has to get all the way round without touching the ground."

They practised every lunchtime for two weeks. Mia was still the slowest. But something else was happening: Mia never dropped the baton. Not once. Not even the day it rained.

On sports day, the first runner went out fast. The second went faster. The third came into the last bend a whole step ahead.

Then he reached back, and Mia reached forward, and the baton went from his hand into hers as smoothly as a door closing.

She ran her lap. She was passed by two runners. She came third.

Her team came second overall — because the other two teams had dropped the baton.

Coach crouched down beside her afterwards.

"You know why you were on that team?"

Mia shook her head.

"Because a relay is not four people running," he said. "It is three handovers. And nobody in this school has hands like yours."',
 6, N'sports',
 N'[{"word":"relay","definition":"a race where teammates take turns running"},{"word":"baton","definition":"the stick passed between runners in a relay"},{"word":"handover","definition":"the moment one runner passes to the next"},{"word":"practise","definition":"to do something again and again to get better"}]',
 1, N'/art/wstory_sports_2nd.svg', @orig);

-- ── 3rd · animals ───────────────────────────────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM dbo.Stories WHERE title = N'The Dog Who Knew the Bus')
INSERT INTO dbo.Stories (grade_id, language_id, title, body_text, read_min, theme_tag, vocab_json, is_published, thumbnail_url, source_attribution)
VALUES (4, 1, N'The Dog Who Knew the Bus',
N'There was a brown dog at the bus stop every afternoon at ten past four.

Not at four. Not at half past. Ten past.

Zara noticed him in September. By October she was saving half her sandwich for him. He never took it from her hand — he waited until she set it down, then ate it neatly, then sat again, facing the road.

"He''s waiting for someone," said her mother.

"He''s waiting for the bus," said Zara.

They were both right.

In November the dog stopped coming. Zara asked the shopkeeper on the corner, who asked the woman at number 12, who knew.

The dog belonged to Mr Oyelaran, who had ridden the 4:10 bus home from the market every day for eleven years. He had gone into hospital in November. The dog had been taken in by his neighbour, three streets away, and would not settle.

Zara wrote the address on a piece of paper.

That Saturday she walked three streets with her mother, knocked on a stranger''s door, and asked whether the brown dog might like a walk.

They went to the bus stop. They sat down. At ten past four, the bus came and went, and Mr Oyelaran was not on it.

The dog stood up anyway. He always would.

Zara scratched his ears.

"I know," she said. "Me too. We''ll come back tomorrow."',
 7, N'animals',
 N'[{"word":"neatly","definition":"in a careful, tidy way"},{"word":"settle","definition":"to become calm and comfortable in a place"},{"word":"neighbour","definition":"someone who lives near you"},{"word":"routine","definition":"something you do the same way every day"}]',
 1, N'/art/wstory_animals_3rd.svg', @orig);

-- ── 3rd · holidays ──────────────────────────────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM dbo.Stories WHERE title = N'Three Kitchens')
INSERT INTO dbo.Stories (grade_id, language_id, title, body_text, read_min, theme_tag, vocab_json, is_published, thumbnail_url, source_attribution)
VALUES (4, 1, N'Three Kitchens',
N'Amara''s family kept three calendars on the fridge, and all of them were right.

In February her mother''s side filled the kitchen with steam and folded dumplings until midnight. Amara was in charge of pressing the edges shut. "A good seal," her grandmother said, "keeps the luck inside."

In October her father''s side lit small clay lamps and set them along the windowsill and the front step, so many that the house glowed from outside. Amara was in charge of the matches, which made her feel about fourteen years old.

And in December the whole street did something else again, with a tree and paper chains, and Amara was in charge of nothing at all, which was restful.

At school a boy asked her which one was her real holiday.

Amara thought about it for a whole day before she answered him.

"They''re all real," she said. "It''s the same family in three kitchens."

She thought that was the end of it. But the boy came back the next week and asked what a good seal on a dumpling looked like.

So she showed him, using a folded piece of paper, at the lunch table, twelve times, until he got it right.',
 7, N'holidays',
 N'[{"word":"calendar","definition":"a chart showing the days and months of the year"},{"word":"seal","definition":"to close something tightly"},{"word":"clay","definition":"soft earth that hardens when it is baked"},{"word":"restful","definition":"calm and relaxing"}]',
 1, N'/art/wstory_holidays_3rd.svg', @orig);

-- ── 4th · vehicles ──────────────────────────────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM dbo.Stories WHERE title = N'The Last Bus of the Night')
INSERT INTO dbo.Stories (grade_id, language_id, title, body_text, read_min, theme_tag, vocab_json, is_published, thumbnail_url, source_attribution)
VALUES (5, 1, N'The Last Bus of the Night',
N'The 11:40 was always empty, which was why Femi liked driving it.

Forty-one minutes, eighteen stops, and nobody to please but the road. He knew every pothole on the ring route by the sound it made.

That Tuesday, a boy got on at stop nine.

He was maybe seven. He had a backpack with a broken zip and a bus ticket that had expired in March. He sat directly behind Femi, which nobody ever did, and said nothing at all.

Femi drove three more stops, watching him in the long mirror.

"Where are you headed, chief?"

"Grandma''s."

"Where''s Grandma?"

The boy thought about this seriously. "Near the big roundabout. With the green door."

There were, Femi knew, four roundabouts on this route and a great many green doors.

He could have called it in. Instead he drove to the depot, parked the bus under the lights, made two cups of tea, and sat on the step with the boy while the night controller made phone calls.

They talked about the bus. Femi explained the air brakes, which go *pssh*, and let the boy press the button that opens the middle doors. He pressed it eleven times.

At half past one, a woman came running across the depot yard in slippers, and the boy ran the other way, and neither of them said anything sensible for about a minute.

Afterwards, Femi finished the route. Eighteen stops. Nobody aboard.

He took the potholes slowly, the way you do when you are thinking.',
 8, N'vehicles',
 N'[{"word":"depot","definition":"the place where buses are kept and repaired"},{"word":"route","definition":"the path a bus follows"},{"word":"expired","definition":"no longer able to be used"},{"word":"controller","definition":"the person who manages where buses and drivers go"}]',
 1, N'/art/wstory_vehicles_4th.svg', @orig);

-- ── 5th · fantasy ───────────────────────────────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM dbo.Stories WHERE title = N'The Boy Who Traded His Shadow')
INSERT INTO dbo.Stories (grade_id, language_id, title, body_text, read_min, theme_tag, vocab_json, is_published, thumbnail_url, source_attribution)
VALUES (6, 1, N'The Boy Who Traded His Shadow',
N'The shadow merchant came to the village once a year, and she always set up her stall at the far end of the market, where the light was strange.

"One wish," she said, when Tomas stopped in front of her. "Paid for in shadow. I take the whole thing or nothing."

"What would I even need a shadow for?"

The merchant smiled as though he had asked a very good question badly.

Tomas wished for the thing he had wanted since he was six: to be the fastest runner in the valley. He was, from that afternoon, and it was every bit as good as he had imagined.

He noticed the first problem in July.

It was the heat. Everyone else went and stood in the shade of the walnut tree at midday — and Tomas found he could stand there too, but it made no difference to him at all. Shade is a thing that shadows understand. His body had forgotten how.

The second problem was smaller and worse. His little sister, who was four, would not sit next to him at supper. She could not say why. She said he looked "unfinished".

In September, Tomas walked to the far end of the market in the strange light and asked for his shadow back.

"Of course," said the merchant. "The price is the wish."

"Take it."

He was slow again by the time he reached the end of the row. He was also, he noticed, casting a long thin shape across the cobbles that moved when he moved.

At supper his sister climbed onto the bench beside him without being asked, and Tomas found that he did not mind about the running very much at all.',
 9, N'fantasy',
 N'[{"word":"merchant","definition":"a person who buys and sells things"},{"word":"stall","definition":"a small open shop at a market"},{"word":"cobbles","definition":"round stones used to pave a street"},{"word":"bargain","definition":"an agreement to trade one thing for another"}]',
 1, N'/art/wstory_fantasy_5th.svg', @orig);

-- ── 6th · ocean ─────────────────────────────────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM dbo.Stories WHERE title = N'What the Tide Left')
INSERT INTO dbo.Stories (grade_id, language_id, title, body_text, read_min, theme_tag, vocab_json, is_published, thumbnail_url, source_attribution)
VALUES (7, 1, N'What the Tide Left',
N'Nadia had been cataloguing the beach for two hundred and six days.

It had started as a school project and stopped being one around day thirty. Every morning before the tide turned she walked the same four hundred metres of sand with a notebook, a pencil on a string, and a bucket, and she wrote down what the sea had left behind.

Her columns were: DATE. ITEM. MATERIAL. GUESS AT ORIGIN.

Mostly it was plastic. Bottle caps, in astonishing numbers. Fragments of crate. A doll''s arm, which she had recorded without comment and thought about for a week. Fishing line, always fishing line, in loops that she cut apart before putting them in the bucket, because she had once found a gull that had not been so lucky.

On day one hundred and ninety she started noticing a pattern.

The bottle caps came in after storms from the south-east. The crate fragments came in on the spring tides. And the fishing line arrived, reliably, on the mornings after the trawlers worked the shelf — which she knew because she could see their lights from her window.

She had not set out to prove anything. She had set out to make a list. But two hundred days of a list is not a list any more; it is data, and data has a shape.

In March she wrote to the harbour office. She was eleven, so she was careful to attach the tables, and the photographs, and the dates, and to keep her sentences short.

They did not write back for five weeks.

Then a woman from the marine office came out to the beach on a Tuesday morning with a folder under her arm, found Nadia at the tide line with her notebook, and said: "You''re the one with the fishing line."

They walked the four hundred metres together.

By June there were bins on the quay with lids that locked, and a rule about line disposal that the trawler crews grumbled about and mostly followed.

Nadia is on day six hundred and forty now. She still walks it every morning. The columns have not changed.',
 11, N'ocean',
 N'[{"word":"catalogue","definition":"to make an organised list of things"},{"word":"fragment","definition":"a small broken piece of something"},{"word":"data","definition":"facts and numbers collected to study"},{"word":"quay","definition":"a landing place where boats load and unload"}]',
 1, N'/art/wstory_ocean_6th.svg', @orig);
GO

-- ── Link each worksheet to its story ────────────────────────────────────────
UPDATE w SET w.story_id = s.story_id
FROM dbo.Worksheets w JOIN dbo.Stories s ON s.title = N'The Dragon in the Teapot'        WHERE w.worksheet_id = 58;
UPDATE w SET w.story_id = s.story_id
FROM dbo.Worksheets w JOIN dbo.Stories s ON s.title = N'The Crab Who Grew Too Big'        WHERE w.worksheet_id = 66;
UPDATE w SET w.story_id = s.story_id
FROM dbo.Worksheets w JOIN dbo.Stories s ON s.title = N'Ravi Counts the Stars'            WHERE w.worksheet_id = 74;
UPDATE w SET w.story_id = s.story_id
FROM dbo.Worksheets w JOIN dbo.Stories s ON s.title = N'Who Made These Tracks?'           WHERE w.worksheet_id = 80;
UPDATE w SET w.story_id = s.story_id
FROM dbo.Worksheets w JOIN dbo.Stories s ON s.title = N'The Bone in the Backyard'         WHERE w.worksheet_id = 82;
UPDATE w SET w.story_id = s.story_id
FROM dbo.Worksheets w JOIN dbo.Stories s ON s.title = N'The Slowest Runner on the Team'   WHERE w.worksheet_id = 88;
UPDATE w SET w.story_id = s.story_id
FROM dbo.Worksheets w JOIN dbo.Stories s ON s.title = N'The Dog Who Knew the Bus'         WHERE w.worksheet_id = 90;
UPDATE w SET w.story_id = s.story_id
FROM dbo.Worksheets w JOIN dbo.Stories s ON s.title = N'Three Kitchens'                   WHERE w.worksheet_id = 96;
UPDATE w SET w.story_id = s.story_id
FROM dbo.Worksheets w JOIN dbo.Stories s ON s.title = N'The Last Bus of the Night'        WHERE w.worksheet_id = 104;
UPDATE w SET w.story_id = s.story_id
FROM dbo.Worksheets w JOIN dbo.Stories s ON s.title = N'The Boy Who Traded His Shadow'    WHERE w.worksheet_id = 112;
UPDATE w SET w.story_id = s.story_id
FROM dbo.Worksheets w JOIN dbo.Stories s ON s.title = N'What the Tide Left'               WHERE w.worksheet_id = 120;
GO

-- The read-the-story activity sheets work on any text; point them at a story
-- at their own grade so they are never orphaned either.
UPDATE w SET w.story_id = s.story_id
FROM dbo.Worksheets w JOIN dbo.Stories s ON s.title = N'The Crab Who Grew Too Big'  WHERE w.worksheet_id = 197; -- Retell: Beginning/Middle/End (K)
UPDATE w SET w.story_id = s.story_id
FROM dbo.Worksheets w JOIN dbo.Stories s ON s.title = N'Who Made These Tracks?'     WHERE w.worksheet_id = 185; -- Story Sequence (1st)
GO

SELECT w.worksheet_id, w.title AS worksheet, s.title AS story, s.grade_id
FROM dbo.Worksheets w JOIN dbo.Stories s ON w.story_id = s.story_id
ORDER BY w.worksheet_id;
GO
