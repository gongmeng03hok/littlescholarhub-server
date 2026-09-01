-- ============================================================
--  Little Scholars Hub — Migration 11  (Gamification)
--  Daily rewards · XP/levels · milestone badges · opt-in leaderboard
--  Safe to re-run (all IF NOT EXISTS guarded). Run after 01–10.
-- ============================================================

USE LittleScholarHub;
GO

-- ─── 1. Per-child game stats (XP, level, coins, daily check-in) ──────────────
IF OBJECT_ID('dbo.ChildGameStats','U') IS NULL
BEGIN
    CREATE TABLE dbo.ChildGameStats (
        child_id           INT       NOT NULL CONSTRAINT PK_ChildGameStats PRIMARY KEY
                               CONSTRAINT FK_CGS_Child REFERENCES dbo.Children(child_id),
        total_xp           INT       NOT NULL DEFAULT 0,
        level              INT       NOT NULL DEFAULT 1,
        coins              INT       NOT NULL DEFAULT 0,
        last_checkin_date  DATE      NULL,
        checkin_streak     INT       NOT NULL DEFAULT 0,
        best_checkin_streak INT      NOT NULL DEFAULT 0,
        updated_at         DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
    );
END;
GO

-- ─── 2. Opt-in leaderboard consent + coarse region (parent controlled) ──────
--  Region is a COARSE label only (state/country) — never a precise location.
IF COL_LENGTH('dbo.Families','show_on_leaderboard') IS NULL
    ALTER TABLE dbo.Families ADD show_on_leaderboard BIT NOT NULL DEFAULT 0;   -- opt-in, default OFF
GO
IF COL_LENGTH('dbo.Families','region') IS NULL
    ALTER TABLE dbo.Families ADD region NVARCHAR(64) NULL;
GO

-- ─── 3. Milestone badge catalogue seed (only if Badges table is empty-ish) ──
--  Badges/ChildBadges already exist (06_badges.sql). Add level/streak milestones.
IF OBJECT_ID('dbo.Badges','U') IS NOT NULL
BEGIN
    MERGE dbo.Badges AS t
    USING (VALUES
        ('level_5',   N'Rising Star',   N'⭐', N'Reach level 5',            15),
        ('level_10',  N'Super Scholar', N'🌟', N'Reach level 10',           30),
        ('streak_7',  N'Week Warrior',  N'🔥', N'7-day check-in streak',    20),
        ('streak_30', N'Unstoppable',   N'🏆', N'30-day check-in streak',   50),
        ('xp_1000',   N'XP Champion',   N'💎', N'Earn 1000 total XP',       40)
    ) AS s(slug, label, icon, description, xp_value)
    ON t.slug = s.slug
    WHEN NOT MATCHED THEN
        INSERT (slug, label, icon, description, xp_value)
        VALUES (s.slug, s.label, s.icon, s.description, s.xp_value);
END;
GO

-- ─── 4. Opt-in leaderboard view (nickname + avatar + coarse region ONLY) ────
--  NEVER exposes email, real name, or precise location. Parent opt-in gated.
CREATE OR ALTER VIEW dbo.vw_Leaderboard AS
SELECT
    c.child_id,
    c.nickname                              AS display_name,
    ISNULL(kp.avatar_slug, 'star')          AS avatar_slug,
    ISNULL(f.region, 'Global')              AS region,
    gs.total_xp,
    gs.level
FROM dbo.ChildGameStats gs
JOIN dbo.Children  c ON gs.child_id  = c.child_id
JOIN dbo.Families  f ON c.family_id  = f.family_id
LEFT JOIN dbo.KidProfiles kp ON c.child_id = kp.child_id
WHERE f.show_on_leaderboard = 1;           -- opt-in only
GO
