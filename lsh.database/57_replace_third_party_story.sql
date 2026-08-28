-- 57_replace_third_party_story.sql
-- Retires story 23 and replaces it with an original.
--
-- story_id 23 was titled "MIA-life-story-book". The title was the smallest
-- problem with it:
--   * its body is "A Day in the Life of Mia — By learnenglishteam.com", i.e.
--     someone else's material, with no source_attribution and no source_url;
--   * the string "LEARNENGLISHTEAM.COM" appears SIX times inside body_text;
--   * because narration is generated from body_text, the audio read that
--     watermark aloud to children — on a paid platform.
--
-- So it is renamed to its real title, credited honestly, and unpublished
-- rather than quietly relabelled. Nothing is deleted: set is_published back to
-- 1 if the rights turn out to be in order.
--
-- An original replacement fills the same slot, because the slot was useful —
-- a 1st-grade story about the order of a day is good sequencing practice.

SET NOCOUNT ON;

UPDATE dbo.Stories
SET title              = N'A Day in the Life of Mia',
    source_attribution = N'learnenglishteam.com — third-party text, rights unverified',
    source_url         = N'https://learnenglishteam.com',
    theme_tag          = N'daily_life',
    is_published       = 0
WHERE story_id = 23;
GO

-- Original replacement, same grade and purpose.
IF NOT EXISTS (SELECT 1 FROM dbo.Stories WHERE title = N'Kofi''s Backwards Day')
INSERT INTO dbo.Stories
    (grade_id, language_id, title, body_text, read_min, theme_tag, vocab_json,
     is_published, thumbnail_url, source_attribution)
VALUES
    (2, 1, N'Kofi''s Backwards Day',
N'Kofi woke up and put his shoes on first.

Then his socks. Over the shoes.

"That is not the order," said his sister.

At breakfast he drank his milk, then poured it. The second pour went everywhere.

"Not the order," said his sister.

He waved goodbye at the door, then remembered his bag, then remembered his lunch, then remembered his coat, and had to wave goodbye three more times.

At school his teacher asked the class to write the story of their morning.

Kofi wrote: FIRST. NEXT. THEN. LAST.

He filled them in slowly, one at a time, saying each one out loud.

Socks first. Then shoes. Pour, then drink. Bag, coat, lunch — then the door.

The next morning he did every single thing in the right order, and it took him half as long.

"How did you do that?" said his sister.

"I wrote it down last night," said Kofi. "The hard part is not the doing. It is the order."',
     5, N'daily_life',
     N'[{"word":"order","definition":"the way things follow one after another"},{"word":"first","definition":"the one that happens at the start"},{"word":"next","definition":"the one that comes after"},{"word":"last","definition":"the one that happens at the end"}]',
     1, N'/art/wstory_kofi_order.svg', N'Little Scholars Hub — original story');
GO

SELECT story_id, title, is_published, source_attribution
FROM dbo.Stories
WHERE story_id = 23 OR title = N'Kofi''s Backwards Day';
GO
