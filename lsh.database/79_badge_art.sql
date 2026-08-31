-- 79_badge_art.sql
--
-- 17 of the 21 badge icons were the literal character '?' (0x3f). The emoji
-- were destroyed on insert - almost certainly a missing N'' prefix, since the
-- four added later (level_5, level_10, streak_30, xp_1000) survived intact.
-- A child earning "First Worksheet!" was shown ?? at 30px.
--
-- Two fixes here:
--   * icon      restored, with N'' this time so it survives
--   * icon_url  new: a drawn medal per badge in the house style, so the shelf
--               is artwork rather than a row of system emoji
--
-- The emoji stays as the fallback for anywhere the image cannot load.

SET NOCOUNT ON;

IF COL_LENGTH('dbo.Badges', 'icon_url') IS NULL
    ALTER TABLE dbo.Badges ADD icon_url NVARCHAR(200) NULL;
GO

UPDATE dbo.Badges SET icon = N'📄', icon_url = N'/art/badge_first_sheet.svg'             WHERE slug = 'first_sheet';
UPDATE dbo.Badges SET icon = N'👣', icon_url = N'/art/badge_first_worksheet.svg'         WHERE slug = 'first_worksheet';
UPDATE dbo.Badges SET icon = N'🌍', icon_url = N'/art/badge_first_culture_worksheet.svg' WHERE slug = 'first_culture_worksheet';
UPDATE dbo.Badges SET icon = N'💬', icon_url = N'/art/badge_first_language_switch.svg'   WHERE slug = 'first_language_switch';
UPDATE dbo.Badges SET icon = N'📖', icon_url = N'/art/badge_first_mini_book.svg'         WHERE slug = 'first_mini_book';
UPDATE dbo.Badges SET icon = N'📸', icon_url = N'/art/badge_homework_1st_scan.svg'       WHERE slug = 'homework_1st_scan';
UPDATE dbo.Badges SET icon = N'📷', icon_url = N'/art/badge_homework_5_scans.svg'        WHERE slug = 'homework_5_scans';
UPDATE dbo.Badges SET icon = N'🦸', icon_url = N'/art/badge_homework_10_scans.svg'       WHERE slug = 'homework_10_scans';
UPDATE dbo.Badges SET icon = N'🎯', icon_url = N'/art/badge_drill_master.svg'            WHERE slug = 'drill_master';
UPDATE dbo.Badges SET icon = N'✅', icon_url = N'/art/badge_perfect_day.svg'             WHERE slug = 'perfect_day';
UPDATE dbo.Badges SET icon = N'⚡', icon_url = N'/art/badge_speed_star.svg'              WHERE slug = 'speed_star';
UPDATE dbo.Badges SET icon = N'🔥', icon_url = N'/art/badge_streak_3.svg'                WHERE slug = 'streak_3';
UPDATE dbo.Badges SET icon = N'🔥', icon_url = N'/art/badge_streak_7.svg'                WHERE slug = 'streak_7';
UPDATE dbo.Badges SET icon = N'🏆', icon_url = N'/art/badge_streak_30.svg'               WHERE slug = 'streak_30';
UPDATE dbo.Badges SET icon = N'⛰', icon_url = N'/art/badge_topic_mastered.svg'          WHERE slug = 'topic_mastered';
UPDATE dbo.Badges SET icon = N'📅', icon_url = N'/art/badge_week_warrior.svg'            WHERE slug = 'week_warrior';
UPDATE dbo.Badges SET icon = N'🔷', icon_url = N'/art/badge_xp_100.svg'                  WHERE slug = 'xp_100';
UPDATE dbo.Badges SET icon = N'💠', icon_url = N'/art/badge_xp_500.svg'                  WHERE slug = 'xp_500';
UPDATE dbo.Badges SET icon = N'💎', icon_url = N'/art/badge_xp_1000.svg'                 WHERE slug = 'xp_1000';
UPDATE dbo.Badges SET icon = N'⭐', icon_url = N'/art/badge_level_5.svg'                 WHERE slug = 'level_5';
UPDATE dbo.Badges SET icon = N'🌟', icon_url = N'/art/badge_level_10.svg'                WHERE slug = 'level_10';

PRINT 'badge art wired';
