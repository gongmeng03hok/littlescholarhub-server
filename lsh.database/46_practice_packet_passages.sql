-- 46_practice_packet_passages.sql
-- Adds an optional per-category reading passage (intro_text), needed for
-- categories like "Reading Comprehension: Main Idea & Details" where a
-- passage is read once, then several questions refer back to it.

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID('dbo.PacketCategories') AND name = 'intro_text')
BEGIN
    ALTER TABLE dbo.PacketCategories ADD intro_text NVARCHAR(MAX) NULL;
END
GO
