-- 57_remove_old_weekly_packet_worksheets.sql
-- Removes the old reportlab-based "weekly_packet" Worksheets rows — that
-- content_type is retired in favor of the DB-driven Weekly Packets system
-- (dbo.PacketCategories / dbo.PacketQuestions, see 43_practice_packets.sql
-- onward), which now has its own standalone screen in every portal.

DELETE FROM dbo.Worksheets WHERE content_type = 'weekly_packet';
GO
