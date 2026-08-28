-- ============================================================
--  Little Scholars Hub — Migration 003
--  Adds: role column, KidProfiles table, AppConfig table
--  Run AFTER 01_schema.sql and 02_seed.sql
-- ============================================================

USE LittleScholarHub;
GO

-- ─── 1. Add role to Families ────────────────────────────────
IF NOT EXISTS (
    SELECT 1 FROM sys.columns
    WHERE object_id = OBJECT_ID('dbo.Families') AND name = 'role'
)
BEGIN
    ALTER TABLE dbo.Families
        ADD role VARCHAR(10) NOT NULL DEFAULT 'parent'
            CONSTRAINT CK_Family_Role CHECK (role IN ('admin','parent'));
    PRINT 'Added role column to Families';
END
GO

-- ─── 2. KidProfiles table ───────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'KidProfiles' AND type = 'U')
BEGIN
    CREATE TABLE dbo.KidProfiles (
        kid_profile_id INT           NOT NULL CONSTRAINT PK_KidProfiles PRIMARY KEY IDENTITY,
        child_id       INT           NOT NULL CONSTRAINT FK_KP_Child
                                         REFERENCES dbo.Children(child_id) ON DELETE CASCADE,
        display_name   NVARCHAR(64)  NOT NULL,
        pin_hash       VARCHAR(256)  NULL,
        avatar_slug    VARCHAR(32)   NOT NULL DEFAULT 'star',
        created_at     DATETIME2     NOT NULL DEFAULT SYSUTCDATETIME(),
        CONSTRAINT UQ_KidProfile_Child UNIQUE (child_id)
    );
    PRINT 'Created KidProfiles table';
END
GO

-- ─── 3. AppConfig table ─────────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'AppConfig' AND type = 'U')
BEGIN
    CREATE TABLE dbo.AppConfig (
        config_key   VARCHAR(128)   NOT NULL CONSTRAINT PK_AppConfig PRIMARY KEY,
        config_value NVARCHAR(MAX)  NOT NULL,
        config_type  VARCHAR(16)    NOT NULL DEFAULT 'text'
                         CONSTRAINT CK_Config_Type CHECK (config_type IN ('text','json','boolean','number')),
        label        NVARCHAR(256)  NULL,
        section      VARCHAR(64)    NULL,
        updated_by   INT            NULL CONSTRAINT FK_Config_Family
                                        REFERENCES dbo.Families(family_id),
        updated_at   DATETIME2      NOT NULL DEFAULT SYSUTCDATETIME()
    );
    PRINT 'Created AppConfig table';
END
GO

-- ─── 4. Seed AppConfig ──────────────────────────────────────
MERGE dbo.AppConfig AS t
USING (VALUES
  ('hero.tagline',           'One calm plan. Nine subjects. Your family''s language.',  'text',    'Hero tagline',              'hero'),
  ('hero.subtagline',        'A 2-minute assessment builds your child''s weekly plan — reading, math, logic, feelings, manners, art, and three culture-infused tracks. Written by real bilingual teachers, not an algorithm. One price covers every child in the house.',
                                                                                         'text',    'Hero sub-tagline',          'hero'),
  ('hero.cta_primary',       'Build my child''s plan →',                                'text',    'Primary CTA label',         'hero'),
  ('hero.cta_secondary',     'See pricing',                                              'text',    'Secondary CTA label',       'hero'),
  ('hero.badge_worksheets',  '100+',                                                     'text',    'Worksheets badge',          'hero'),
  ('hero.badge_languages',   '4',                                                        'text',    'Languages badge',           'hero'),
  ('hero.badge_price',       '1 price',                                                  'text',    'Price badge',               'hero'),
  ('trust.item1',            '✓ 14-day free trial',                                      'text',    'Trust badge 1',             'hero'),
  ('trust.item2',            '✓ 30-day money back',                                      'text',    'Trust badge 2',             'hero'),
  ('trust.item3',            '✓ Cancel anytime',                                         'text',    'Trust badge 3',             'hero'),
  ('trust.item4',            '✓ COPPA & kid-privacy-first',                              'text',    'Trust badge 4',             'hero'),
  ('pricing.explorer_price', '0',      'number', 'Explorer price',           'pricing'),
  ('pricing.family_price',   '14.99',  'number', 'Family monthly price',     'pricing'),
  ('pricing.family_annual',  '129',    'number', 'Family annual price',      'pricing'),
  ('pricing.family_save',    '51',     'number', 'Family annual saving',     'pricing'),
  ('pricing.shipped_price',  '29.99',  'number', 'Shipped monthly price',    'pricing'),
  ('pricing.shipped_annual', '299',    'number', 'Shipped annual price',     'pricing'),
  ('pricing.shipped_save',   '61',     'number', 'Shipped annual saving',    'pricing'),
  ('assessment.total_questions','15',  'number', 'Total assessment steps',   'assessment'),
  ('assessment.subtitle',    '18 short questions · ~2 min · skip any', 'text', 'Assessment subtitle', 'assessment'),
  ('community.officehours_day',   'Wednesday',          'text', 'Office hours day',       'community'),
  ('community.officehours_time',  '7:00 pm PT',         'text', 'Office hours time',      'community'),
  ('community.officehours_host',  'Ms. Chen · credentialed bilingual teacher', 'text', 'Host name', 'community'),
  ('community.officehours_topic', 'How to introduce Tang Shi to a 1st grader without overwhelming them',
                                                         'text', 'This week topic',        'community'),
  ('community.officehours_next',  'Wed 29',              'text', 'Next session label',     'community'),
  ('community.discord_url',       '#',                   'text', 'Discord URL',            'community'),
  ('community.discord_members',   '1,240',               'text', 'Discord members',        'community'),
  ('community.wechat_members',    '860',                 'text', 'WeChat members',         'community'),
  ('community.whatsapp_hindi_members',   '520',          'text', 'Hindi WhatsApp count',   'community'),
  ('community.whatsapp_espanol_members', '740',          'text', 'Espanol WhatsApp count', 'community'),
  ('feature.kid_mode_enabled',        'true',  'boolean', 'Enable kid mode',           'features'),
  ('feature.audio_stories_enabled',   'true',  'boolean', 'Enable audio stories',      'features'),
  ('feature.office_hours_enabled',    'true',  'boolean', 'Show office hours',         'features'),
  ('feature.referral_enabled',        'true',  'boolean', 'Show referral section',     'features'),
  ('feature.school_licensing_enabled','true',  'boolean', 'Show school licensing',     'features'),
  ('referral.code_example',  'LSH-FAM-2026', 'text', 'Sample referral code', 'referral'),
  ('referral.description',   'Your referral gets their first month of Family free. When they subscribe, your next month is on us.',
                                              'text', 'Referral description', 'referral'),
  ('social.tiktok_handle',       '@littlescholarshub',          'text', 'TikTok handle',     'social'),
  ('social.instagram_handle',    '@littlescholarshub',          'text', 'Instagram handle',  'social'),
  ('social.xiaohongshu_handle',  '小学霸中心 · LittleScholarsHub','text','Xiaohongshu handle','social'),
  ('school.classroom_price',     '4',   'number', 'Classroom $/student',    'school'),
  ('school.afterschool_price',   '3',   'number', 'Afterschool $/student',  'school'),
  ('school.classroom_max',       '30',  'number', 'Max classroom students', 'school')
) AS s(config_key, config_value, config_type, label, section)
ON t.config_key = s.config_key
WHEN MATCHED THEN
    UPDATE SET config_value=s.config_value, config_type=s.config_type,
               label=s.label, section=s.section, updated_at=SYSUTCDATETIME()
WHEN NOT MATCHED THEN
    INSERT (config_key, config_value, config_type, label, section)
    VALUES (s.config_key, s.config_value, s.config_type, s.label, s.section);
PRINT 'AppConfig seeded';
GO

-- ─── 5. Seed admin account ──────────────────────────────────
-- Default password: Admin@LSH2026 — CHANGE IN PRODUCTION via /api/admin/set-password
IF NOT EXISTS (SELECT 1 FROM dbo.Families WHERE role='admin')
BEGIN
    INSERT INTO dbo.Families
        (email, password_hash, plann, language_id, referral_code, role)
    VALUES (
        'admin@littlescholarhub.com',
        '$2b$12$placeholder.run.python.hash_password.Admin@LSH2026',
        'shipped', 1, 'LSH-ADM-00000001', 'admin'
    );
    PRINT 'Admin placeholder inserted — update password_hash via Python before use';
END
GO
