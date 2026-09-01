-- ============================================================
--  Little Scholars Hub — Migration 020
--  Adds: Referrals (track "give a month, get a month" signups),
--        OfficeHourRSVPs (weekly teacher office-hours RSVPs)
--  Run AFTER 01_schema.sql .. 19_badges_expansion.sql
-- ============================================================

USE LittleScholarHub;
GO

-- ─── 1. Referrals table ──────────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'Referrals' AND type = 'U')
BEGIN
    CREATE TABLE dbo.Referrals (
        referral_id         INT           NOT NULL CONSTRAINT PK_Referrals PRIMARY KEY IDENTITY,
        referrer_family_id  INT           NOT NULL CONSTRAINT FK_Referral_Referrer
                                              REFERENCES dbo.Families(family_id),
        referred_family_id  INT           NOT NULL CONSTRAINT FK_Referral_Referred
                                              REFERENCES dbo.Families(family_id),
        code_used           CHAR(16)      NOT NULL,
        created_at          DATETIME2     NOT NULL DEFAULT SYSUTCDATETIME(),
        CONSTRAINT UQ_Referral_Referred UNIQUE (referred_family_id)
    );
    PRINT 'Created Referrals table';
END
GO

-- ─── 2. OfficeHourRSVPs table ────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'OfficeHourRSVPs' AND type = 'U')
BEGIN
    CREATE TABLE dbo.OfficeHourRSVPs (
        rsvp_id        INT           NOT NULL CONSTRAINT PK_OfficeHourRSVPs PRIMARY KEY IDENTITY,
        family_id      INT           NOT NULL CONSTRAINT FK_RSVP_Family
                                          REFERENCES dbo.Families(family_id) ON DELETE CASCADE,
        session_label  NVARCHAR(32)  NOT NULL,
        created_at     DATETIME2     NOT NULL DEFAULT SYSUTCDATETIME(),
        CONSTRAINT UQ_RSVP_FamilySession UNIQUE (family_id, session_label)
    );
    PRINT 'Created OfficeHourRSVPs table';
END
GO
