-- ============================================================
--  Little Scholars Hub — Migration 019
--  Adds: generic cross-subject achievement badges
--  Run AFTER 06_badges.sql
-- ============================================================

USE LittleScholarHub;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.Badges WHERE slug='first_worksheet')
BEGIN
    INSERT INTO dbo.Badges (slug,label,icon,description,xp_value) VALUES
    ('first_worksheet',         'First Steps',        '📄','Open your first worksheet in any subject.', 10);
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.Badges WHERE slug='first_culture_worksheet')
BEGIN
    INSERT INTO dbo.Badges (slug,label,icon,description,xp_value) VALUES
    ('first_culture_worksheet', 'Culture Explorer',   '🏮','Open your first culture-track worksheet.',  15);
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.Badges WHERE slug='first_mini_book')
BEGIN
    INSERT INTO dbo.Badges (slug,label,icon,description,xp_value) VALUES
    ('first_mini_book',         'Bookworm',           '📕','Read your first mini-book.',                10);
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.Badges WHERE slug='first_language_switch')
BEGIN
    INSERT INTO dbo.Badges (slug,label,icon,description,xp_value) VALUES
    ('first_language_switch',   'Polyglot',           '🌐','Try a worksheet in a different language.',  15);
END
GO

-- Homework-scanner milestone stickers
IF NOT EXISTS (SELECT 1 FROM dbo.Badges WHERE slug='homework_1st_scan')
BEGIN
    INSERT INTO dbo.Badges (slug,label,icon,description,xp_value) VALUES
    ('homework_1st_scan',  'First Scan!',       '📸','Scan your first piece of homework.',      10);
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.Badges WHERE slug='homework_5_scans')
BEGIN
    INSERT INTO dbo.Badges (slug,label,icon,description,xp_value) VALUES
    ('homework_5_scans',   'Scan Streak',       '🗂️','Scan 5 pieces of homework.',              25);
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.Badges WHERE slug='homework_10_scans')
BEGIN
    INSERT INTO dbo.Badges (slug,label,icon,description,xp_value) VALUES
    ('homework_10_scans',  'Homework Hero',     '🦸','Scan 10 pieces of homework.',             40);
END
GO
