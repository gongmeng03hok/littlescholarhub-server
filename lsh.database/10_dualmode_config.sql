-- ============================================================
--  Little Scholars Hub — Migration 010
--  Seeds AppConfig with the "dualMode" landing-page section
--  (Two ways to learn — digital vs. print). Run AFTER 07/08 migrations.
-- ============================================================

USE LittleScholarHub;
GO

MERGE dbo.AppConfig AS t
USING (VALUES
  (N'dualMode.eyebrow',         N'Built for busy parents', N'text', N'Dual-mode eyebrow', N'dualMode'),
  (N'dualMode.title',           N'Two ways to learn.', N'text', N'Dual-mode title', N'dualMode'),
  (N'dualMode.title_highlight', N'You decide screen time.', N'text', N'Dual-mode title accent', N'dualMode'),
  (N'dualMode.subtitle',        N'Every worksheet works two ways — tap on a tablet for game-style practice, or print on paper for screen-free learning. The same lesson, your choice. Less screen guilt on the days you need it most.',
                                N'text', N'Dual-mode subtitle', N'dualMode'),
  (N'dualMode.divider',         N'or', N'text', N'Dual-mode divider label', N'dualMode'),
  (N'dualMode.cards',
   N'[{"icon":"📱","title":"Digital · interactive","body":"Kids tap to fill, drag, and paint with instant feedback and audio. Auto-saves progress so they can pick up after dinner.","features":["Game-style chimes & confetti for ages 4-8","Voice-over in English, 中文, हिन्दी, Español","Phone, tablet, or laptop — no app install"]},{"icon":"🖨️","title":"Print · screen-free","body":"One click downloads a PDF — every worksheet in our library. Pencil-and-paper learning that builds the fine motor skills tablets can''t.","features":["Letter & A4 · black-and-white friendly (toner-light)","Quarterly printed workbook on the Family plan · Shipped","Works on the road, in the car, at grandma''s house"]}]',
   N'json', N'Dual-mode cards (digital / print)', N'dualMode'),
  (N'dualMode.stats',
   N'[{"num":"0 min","label":"screen time required"},{"num":"100%","label":"printable, every worksheet"},{"num":"4 langs","label":"tap or print, your call"}]',
   N'json', N'Dual-mode stat row', N'dualMode'),
  (N'dualMode.disclaimer',
   N'Why both? AAP screen time guidance + 2026 state laws (Iowa, Oklahoma, Kansas) cap classroom screens for K–5. Print-first families shouldn''t have to give up modern bilingual content. We built for both.',
   N'text', N'Dual-mode disclaimer', N'dualMode')
) AS s(config_key, config_value, config_type, label, section)
ON t.config_key = s.config_key
WHEN MATCHED THEN
    UPDATE SET config_value=s.config_value, config_type=s.config_type,
               label=s.label, section=s.section, updated_at=SYSUTCDATETIME()
WHEN NOT MATCHED THEN
    INSERT (config_key, config_value, config_type, label, section)
    VALUES (s.config_key, s.config_value, s.config_type, s.label, s.section);
PRINT 'dualMode AppConfig seeded';
GO
