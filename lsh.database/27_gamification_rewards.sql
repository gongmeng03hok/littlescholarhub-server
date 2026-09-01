-- ============================================================
--  Little Scholars Hub — Migration 27  (rewards: gems / stars / chest + avatar)
--  Extends the gamification layer (11_gamification.sql). Safe to re-run.
--  Run after 11_gamification.sql and 07_migrations.sql (KidProfiles).
-- ============================================================

USE LittleScholarHub;
GO

-- ─── Gems & stars on the per-child game stats ───────────────────────────────
IF COL_LENGTH('dbo.ChildGameStats','gems') IS NULL
    ALTER TABLE dbo.ChildGameStats ADD gems  INT NOT NULL DEFAULT 0;
GO
IF COL_LENGTH('dbo.ChildGameStats','stars') IS NULL
    ALTER TABLE dbo.ChildGameStats ADD stars INT NOT NULL DEFAULT 0;
GO

-- ─── Chosen treasure-chest style on the kid profile (avatar_slug already exists) ──
IF COL_LENGTH('dbo.KidProfiles','chest_style') IS NULL
    ALTER TABLE dbo.KidProfiles ADD chest_style VARCHAR(24) NOT NULL DEFAULT 'classic';
GO
