-- ============================================================
--  Little Scholars Hub — Migration 015
--  Updates hero.subtagline copy (adds tap/print screen-time
--  callout, drops "-infused" and "in the house")
-- ============================================================

USE LittleScholarHub;
GO

UPDATE dbo.AppConfig
SET config_value = N'A 2-minute assessment builds your child''s weekly plan — tap on a tablet or print on paper, you decide the screen time. Reading, math, logic, feelings, manners, art, plus three culture tracks (中文 · भारत · Español). Written by real bilingual teachers, not an algorithm. One price covers every child.',
    updated_at = SYSUTCDATETIME()
WHERE config_key = 'hero.subtagline';
GO
