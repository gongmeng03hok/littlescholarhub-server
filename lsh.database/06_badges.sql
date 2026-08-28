-- ============================================================
--  Little Scholars Hub  —  Badge tracking table
--  Run AFTER 05_math_weekly.sql
-- ============================================================

USE LittleScholarHub;
GO

CREATE TABLE dbo.ChildBadges (
    cb_id      INT          NOT NULL CONSTRAINT PK_ChildBadges PRIMARY KEY IDENTITY,
    child_id   INT          NOT NULL CONSTRAINT FK_CB_Child
                                REFERENCES dbo.Children(child_id) ON DELETE CASCADE,
    badge_slug VARCHAR(32)  NOT NULL CONSTRAINT FK_CB_Badge
                                REFERENCES dbo.Badges(slug),
    earned_at  DATETIME2    NOT NULL DEFAULT SYSUTCDATETIME(),
    CONSTRAINT UQ_ChildBadge UNIQUE (child_id, badge_slug)
);

-- View: child badge shelf
CREATE OR ALTER VIEW dbo.vw_ChildBadges AS
SELECT
    cb.child_id,
    c.nickname,
    b.slug,
    b.label,
    b.icon,
    b.xp_value,
    cb.earned_at
FROM dbo.ChildBadges cb
JOIN dbo.Children c ON cb.child_id = c.child_id
JOIN dbo.Badges   b ON cb.badge_slug = b.slug;
GO
