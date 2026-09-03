-- 80_space_badge_emoji.sql
--
-- The badge art is now space mission patches, so the emoji fallback should be
-- space too - it is what shows anywhere the drawing cannot load, and a flame
-- next to a rocket patch reads as a different badge.
--
-- Each emoji matches its patch: rocket for the launch, boot print for first
-- steps on the moon, telescope for the first scan, alien for the language
-- switch. N'' prefix throughout: without it these become the character '?',
-- which is exactly how 17 of the previous set were destroyed.

SET NOCOUNT ON;

UPDATE dbo.Badges SET icon = N'🚀'  WHERE slug = 'first_sheet';              -- rocket lifting off
UPDATE dbo.Badges SET icon = N'👣'  WHERE slug = 'first_worksheet';          -- boot print on the moon
UPDATE dbo.Badges SET icon = N'🗺'  WHERE slug = 'first_mini_book';          -- star map
UPDATE dbo.Badges SET icon = N'🔭'  WHERE slug = 'homework_1st_scan';        -- telescope
UPDATE dbo.Badges SET icon = N'🪐'  WHERE slug = 'first_culture_worksheet';  -- ringed planet
UPDATE dbo.Badges SET icon = N'👽'  WHERE slug = 'first_language_switch';    -- alien
UPDATE dbo.Badges SET icon = N'🔥'  WHERE slug = 'streak_3';                 -- rocket flames
UPDATE dbo.Badges SET icon = N'⭐'  WHERE slug = 'level_5';                  -- helmet / rising star
UPDATE dbo.Badges SET icon = N'☄'  WHERE slug = 'speed_star';               -- comet
UPDATE dbo.Badges SET icon = N'✨'  WHERE slug = 'xp_100';                   -- single star
UPDATE dbo.Badges SET icon = N'🛰'  WHERE slug = 'homework_5_scans';         -- satellite
UPDATE dbo.Badges SET icon = N'☀'  WHERE slug = 'perfect_day';              -- sun
UPDATE dbo.Badges SET icon = N'🎯'  WHERE slug = 'drill_master';             -- asteroid in crosshairs
UPDATE dbo.Badges SET icon = N'🌟'  WHERE slug = 'level_10';                 -- astronaut
UPDATE dbo.Badges SET icon = N'🔥'  WHERE slug = 'streak_7';                 -- rocket flames
UPDATE dbo.Badges SET icon = N'🛸'  WHERE slug = 'homework_10_scans';        -- space station
UPDATE dbo.Badges SET icon = N'🚩'  WHERE slug = 'topic_mastered';           -- flag on a planet
UPDATE dbo.Badges SET icon = N'💫'  WHERE slug = 'xp_1000';                  -- supernova
UPDATE dbo.Badges SET icon = N'🌌'  WHERE slug = 'streak_30';                -- spiral galaxy
UPDATE dbo.Badges SET icon = N'🌎'  WHERE slug = 'week_warrior';             -- orbit paths
UPDATE dbo.Badges SET icon = N'🌠'  WHERE slug = 'xp_500';                   -- star cluster

PRINT 'space emoji set';
