-- 85_outdoor_games_always_on.sql
-- "Outdoor Games" (subject_area 'health') currently only surfaces on
-- ~1-in-4 weeks, since 'health' is one of ten tier-B subject_areas and only
-- @groups_per_week=3 are active in any given week (see
-- usp_GetOrCreateWeeklyPacket's tier-B block rotation). Marking it is_core
-- makes it show every grade, every week, unconditionally and on top of
-- whatever tier A/B already picked — is_core rows are inserted before the
-- floor/ceiling logic runs and are never trimmed (same mechanism already
-- used by the 8 "Emotional Regulation" categories). target_count set to 5
-- per the explicit ask (was 7).

UPDATE dbo.PacketCategories
SET is_core = 1, target_count = 5
WHERE category_name = 'Outdoor Games';

-- Clear cached plans so every grade/week regenerates under the new setting.
DELETE FROM dbo.WeeklyPacketPlan;
GO
