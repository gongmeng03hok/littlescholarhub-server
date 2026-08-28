-- 54_story_illustrations.sql
-- Every published story now has its own illustration.
--
-- Before this, 13 of 24 published stories had thumbnail_url NULL, so the story
-- list and reader showed text with no picture — for a TK–6 audience that is the
-- half of the page a pre-reader actually uses.
--
-- Art lives at /art/story_*.svg (lsh.web/src/public/art, copied to dist on
-- export), drawn in the same cream/terracotta language as the question icons.
-- Each scene is specific to its story, not a generic subject placeholder.

SET NOCOUNT ON;

UPDATE dbo.Stories SET thumbnail_url = N'/art/story_kai_dragon.svg'      WHERE story_id = 1;   -- Kai and the Dragon
UPDATE dbo.Stories SET thumbnail_url = N'/art/story_arjuna_why.svg'      WHERE story_id = 2;   -- Arjuna Asks Why
UPDATE dbo.Stories SET thumbnail_url = N'/art/story_tortuga_conejo.svg'  WHERE story_id = 3;   -- La Tortuga y el Conejo
UPDATE dbo.Stories SET thumbnail_url = N'/art/story_pip_cloud.svg'       WHERE story_id = 12;  -- Pip the Little Cloud
UPDATE dbo.Stories SET thumbnail_url = N'/art/story_brave_boat.svg'      WHERE story_id = 13;  -- The Brave Little Boat
UPDATE dbo.Stories SET thumbnail_url = N'/art/story_zia_wind.svg'        WHERE story_id = 14;  -- Zia and the Whispering Wind
UPDATE dbo.Stories SET thumbnail_url = N'/art/story_mixed_backpack.svg'  WHERE story_id = 15;  -- The Mixed-Up Backpack
UPDATE dbo.Stories SET thumbnail_url = N'/art/story_clockwork_cat.svg'   WHERE story_id = 16;  -- The Clockwork Cat
UPDATE dbo.Stories SET thumbnail_url = N'/art/story_library_door.svg'    WHERE story_id = 17;  -- Mira and the Library Door
UPDATE dbo.Stories SET thumbnail_url = N'/art/story_cartographer.svg'    WHERE story_id = 18;  -- The Cartographer of Nowhere
UPDATE dbo.Stories SET thumbnail_url = N'/art/story_lighthouse.svg'      WHERE story_id = 19;  -- The Lighthouse Keeper's Apprentice
UPDATE dbo.Stories SET thumbnail_url = N'/art/story_little_star.svg'     WHERE story_id = 20;  -- The Little Star (unpublished)
UPDATE dbo.Stories SET thumbnail_url = N'/art/story_luna_colt.svg'       WHERE story_id = 24;  -- Luna and the Lost Colt
GO

-- Give the untagged rows a theme so they group with everything else.
UPDATE dbo.Stories SET theme_tag = N'original' WHERE story_id = 23 AND theme_tag IS NULL;
UPDATE dbo.Stories SET theme_tag = N'original' WHERE story_id = 20 AND theme_tag IS NULL;
GO

SELECT COUNT(*) AS published,
       SUM(CASE WHEN thumbnail_url IS NULL THEN 1 ELSE 0 END) AS still_missing_art,
       SUM(CASE WHEN audio_url     IS NULL THEN 1 ELSE 0 END) AS still_missing_audio
FROM dbo.Stories WHERE is_published = 1;
GO
