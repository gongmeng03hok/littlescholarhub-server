-- 53_stem_sel_stories_batch1.sql
-- First batch of original TK–1st stories, written for this platform.
--
-- WHY THESE: 2026 market research (Scholastic read-aloud lists, Amazon
-- children's science bestsellers, picture-book trend reports) points the same
-- way — roughly half of new titles now sit in social-emotional learning or
-- STEM, and the strongest early-reader format is the "Let's-Read-and-Find-Out"
-- shape: one science idea carried by a small narrative, ending in a discovery
-- the child makes with the character. That is also the Magic School Bus shape.
--
-- These are ORIGINAL texts. No commercial title is reproduced or adapted —
-- the research informed theme, structure and reading level only.
--
-- Voice matches the existing house style (see story_id 12, "Pip the Little
-- Cloud"): 120–160 words, short sentences, one gentle turn, a warm close.
-- Character names come from the pool already used by question_generator.py.
--
-- Illustrations live at /art/story_*.svg (src/public/art), drawn in the same
-- cream/terracotta language as the question art.

SET NOCOUNT ON;

-- TK — plant life cycle + patience
IF NOT EXISTS (SELECT 1 FROM dbo.Stories WHERE title = N'The Seed Who Waited')
INSERT INTO dbo.Stories
    (grade_id, language_id, title, body_text, read_min, theme_tag, vocab_json,
     is_published, thumbnail_url, source_attribution)
VALUES
    (0, 1, N'The Seed Who Waited',
N'Deep in the dark soil, a small seed sat very still.

"Nothing is happening," said the seed. "Am I broken?"

A worm wriggled past. "You are busy," said the worm. "Busy is quiet sometimes."

So the seed waited. Rain came and softened her shell. The sun warmed the ground above her.

Then one morning the seed felt a tiny push. A root, growing down. A small green shoot, growing up.

Up and up the shoot climbed, until it poked into the bright, wide world.

By summer the seed was a flower with six red petals, nodding in the wind.

She had not been broken at all. She had been growing the whole time.',
     3, N'science_nature',
     N'[{"word":"soil","definition":"the dirt that plants grow in"},{"word":"root","definition":"the part of a plant that grows down and drinks water"},{"word":"shoot","definition":"the new green stem that grows up"},{"word":"petals","definition":"the colored parts of a flower"}]',
     1, N'/art/story_seed_who_waited.svg', N'Little Scholars Hub — original story');

-- K — light and shadow + observation
IF NOT EXISTS (SELECT 1 FROM dbo.Stories WHERE title = N'Ada and the Shadow That Moved')
INSERT INTO dbo.Stories
    (grade_id, language_id, title, body_text, read_min, theme_tag, vocab_json,
     is_published, thumbnail_url, source_attribution)
VALUES
    (1, 1, N'Ada and the Shadow That Moved',
N'Ada found a long dark shape on the playground. It had her arms. It had her hat.

"A shadow!" she said. "Hello, shadow."

She jumped. The shadow jumped. She waved. It waved back.

Then Ada noticed something strange. In the morning her shadow stretched long and thin, all the way to the fence. At lunchtime it hid in a small puddle under her shoes. By afternoon it was long again — but pointing the other way.

"Shadow, why do you keep moving?"

Her teacher smiled. "A shadow happens when you block the sunlight. The sun moves across the sky all day, so your shadow moves too."

Ada looked up at the sun. Then she looked down at her feet.

"So I am not the one moving," she said. "The light is."',
     4, N'science_light',
     N'[{"word":"shadow","definition":"the dark shape made when something blocks light"},{"word":"block","definition":"to stop something from getting through"},{"word":"sunlight","definition":"the light that comes from the sun"},{"word":"stretch","definition":"to get longer"}]',
     1, N'/art/story_ada_shadow.svg', N'Little Scholars Hub — original story');

-- 1st — forces and materials + thinking like a scientist
IF NOT EXISTS (SELECT 1 FROM dbo.Stories WHERE title = N'Mei and the Magnet Mystery')
INSERT INTO dbo.Stories
    (grade_id, language_id, title, body_text, read_min, theme_tag, vocab_json,
     is_published, thumbnail_url, source_attribution)
VALUES
    (2, 1, N'Mei and the Magnet Mystery',
N'Mei''s paperclip jumped.

It had been sitting on her desk, minding its own business. Then it slid all by itself, straight toward her pencil case.

"Did you see that?" Mei whispered.

Inside the pencil case was a small silver magnet. Mei held it near the paperclip. The clip leapt up and stuck fast.

"Magic," said Arjun.

"Let us find out," said Mei.

They tried the magnet on everything they could reach. It grabbed the paperclip. It grabbed the scissors. It grabbed the leg of the metal chair. It did nothing at all to the eraser, the crayon, or Arjun''s plastic ruler.

Mei made two piles and looked at them for a long time.

"It only pulls some metals," she said. "Not everything."

Arjun grinned. "So it is not magic."

"Better," said Mei. "It is a rule. And now we know it."',
     5, N'science_forces',
     N'[{"word":"magnet","definition":"an object that can pull some metals toward it"},{"word":"attract","definition":"to pull something closer"},{"word":"metal","definition":"a hard, shiny material like iron or steel"},{"word":"material","definition":"what an object is made of"}]',
     1, N'/art/story_mei_magnet.svg', N'Little Scholars Hub — original story');
GO

SELECT story_id, grade_id, title, read_min, theme_tag, thumbnail_url
FROM dbo.Stories
WHERE source_attribution = N'Little Scholars Hub — original story'
ORDER BY grade_id;
GO
