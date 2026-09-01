-- ============================================================
--  Little Scholars Hub — Migration 027
--  Reward store: parent-curated item list (e.g. an Amazon link they
--  picked themselves) redeemable with a child's game-economy coins
--  (dbo.ChildGameStats.coins, see 11_gamification.sql). No real
--  payment/Amazon API integration — redemption just creates a
--  pending request the parent approves or denies.
-- ============================================================

USE LittleScholarHub;
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'RewardItems' AND type = 'U')
BEGIN
    CREATE TABLE dbo.RewardItems (
        reward_id    INT           NOT NULL CONSTRAINT PK_RewardItems PRIMARY KEY IDENTITY,
        family_id    INT           NOT NULL CONSTRAINT FK_RewardItems_Family
                                        REFERENCES dbo.Families(family_id) ON DELETE CASCADE,
        title        NVARCHAR(200) NOT NULL,
        description  NVARCHAR(500) NULL,
        image_url    NVARCHAR(1000) NULL,
        product_url  NVARCHAR(1000) NULL,   -- e.g. the parent's chosen Amazon product link
        point_cost   INT           NOT NULL CHECK (point_cost > 0),
        is_active    BIT           NOT NULL DEFAULT 1,
        created_at   DATETIME2     NOT NULL DEFAULT SYSUTCDATETIME()
    );
    PRINT 'Created RewardItems table';
END
GO

-- Optional per-child scoping: NULL = shared/visible to every kid in the
-- family, a specific child_id = only that kid can see/redeem it.
IF NOT EXISTS (
    SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID('dbo.RewardItems') AND name = 'child_id'
)
BEGIN
    ALTER TABLE dbo.RewardItems
        ADD child_id INT NULL CONSTRAINT FK_RewardItems_Child REFERENCES dbo.Children(child_id);
    PRINT 'Added RewardItems.child_id';
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'RewardRedemptions' AND type = 'U')
BEGIN
    CREATE TABLE dbo.RewardRedemptions (
        redemption_id  INT           NOT NULL CONSTRAINT PK_RewardRedemptions PRIMARY KEY IDENTITY,
        reward_id      INT           NOT NULL CONSTRAINT FK_RR_Reward REFERENCES dbo.RewardItems(reward_id),
        child_id       INT           NOT NULL CONSTRAINT FK_RR_Child REFERENCES dbo.Children(child_id),
        family_id      INT           NOT NULL CONSTRAINT FK_RR_Family REFERENCES dbo.Families(family_id),
        points_spent   INT           NOT NULL,
        status         VARCHAR(16)   NOT NULL DEFAULT 'pending'
                                        CONSTRAINT CK_RR_Status CHECK (status IN ('pending','approved','denied','fulfilled')),
        requested_at   DATETIME2     NOT NULL DEFAULT SYSUTCDATETIME(),
        resolved_at    DATETIME2     NULL,
        resolved_note  NVARCHAR(500) NULL
    );
    PRINT 'Created RewardRedemptions table';
END
GO
