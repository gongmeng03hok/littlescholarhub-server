-- 32_stories_media_and_solar_system.sql
-- Part of the Archive.org content integration:
--   1. Adds cover-thumbnail and source-attribution columns to Stories, for
--      content adapted from the Internet Archive Children's Library (IACL).
--   2. Adds "Solar System" as a 10th (non-cultural) subject, sourced from
--      Archive.org's solarsystemcollection (NASA/JPL public-domain images).
--
-- Video content from archive.org's "artsandmusicvideos" and
-- "animationandcartoons" collections was deliberately EXCLUDED — both turned
-- out to be unmoderated fan-upload buckets (copyrighted fan edits, unclear
-- licensing) rather than curated archives, not appropriate to pipe into a
-- children's product. See conversation/decision log, not re-litigated here.

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID('dbo.Stories') AND name = 'thumbnail_url')
BEGIN
    ALTER TABLE dbo.Stories ADD thumbnail_url NVARCHAR(512) NULL;
    PRINT 'Added Stories.thumbnail_url';
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID('dbo.Stories') AND name = 'source_url')
BEGIN
    ALTER TABLE dbo.Stories ADD source_url NVARCHAR(512) NULL;
    PRINT 'Added Stories.source_url';
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID('dbo.Stories') AND name = 'source_attribution')
BEGIN
    ALTER TABLE dbo.Stories ADD source_attribution NVARCHAR(256) NULL;
    PRINT 'Added Stories.source_attribution';
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.Subjects WHERE slug = 'solar_system')
BEGIN
    INSERT INTO dbo.Subjects (subject_id, slug, label, icon, is_cultural)
    VALUES (17, 'solar_system', N'Solar System', N'🪐', 0);
    PRINT 'Added Solar System subject';
END
GO
