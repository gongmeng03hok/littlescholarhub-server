-- 72_wisdom_and_story_art.sql
-- Pairs a glossy 3D illustration with every daily-wisdom line and with the
-- eight published stories that still had no picture.
--
-- dbo.DailyWisdom had no image column at all, so the Words-For-Today card was
-- text on a flat colour. Each row now points at an emblem chosen to match what
-- the line actually says -- footsteps for 'a thousand-mile journey starts under
-- your own foot', bamboo for 'gentleness outlasts force' -- so the picture
-- carries the meaning for a child who cannot yet read the words.
--
-- Art lives in lsh.web/src/public/art (survives a rebuild) and is served from
-- /art/<name>.svg. Filenames are stable, so a restyle needs no migration.

SET NOCOUNT ON;

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=OBJECT_ID('dbo.DailyWisdom') AND name='image_url')
  ALTER TABLE dbo.DailyWisdom ADD image_url nvarchar(256) NULL;
GO

UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_3.svg' WHERE wisdom_id=3;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_4.svg' WHERE wisdom_id=4;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_5.svg' WHERE wisdom_id=5;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_6.svg' WHERE wisdom_id=6;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_7.svg' WHERE wisdom_id=7;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_8.svg' WHERE wisdom_id=8;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_9.svg' WHERE wisdom_id=9;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_10.svg' WHERE wisdom_id=10;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_11.svg' WHERE wisdom_id=11;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_12.svg' WHERE wisdom_id=12;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_13.svg' WHERE wisdom_id=13;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_14.svg' WHERE wisdom_id=14;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_15.svg' WHERE wisdom_id=15;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_16.svg' WHERE wisdom_id=16;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_17.svg' WHERE wisdom_id=17;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_18.svg' WHERE wisdom_id=18;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_19.svg' WHERE wisdom_id=19;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_20.svg' WHERE wisdom_id=20;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_21.svg' WHERE wisdom_id=21;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_22.svg' WHERE wisdom_id=22;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_23.svg' WHERE wisdom_id=23;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_24.svg' WHERE wisdom_id=24;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_25.svg' WHERE wisdom_id=25;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_26.svg' WHERE wisdom_id=26;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_27.svg' WHERE wisdom_id=27;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_28.svg' WHERE wisdom_id=28;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_29.svg' WHERE wisdom_id=29;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_30.svg' WHERE wisdom_id=30;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_31.svg' WHERE wisdom_id=31;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_32.svg' WHERE wisdom_id=32;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_33.svg' WHERE wisdom_id=33;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_34.svg' WHERE wisdom_id=34;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_35.svg' WHERE wisdom_id=35;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_36.svg' WHERE wisdom_id=36;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_37.svg' WHERE wisdom_id=37;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_38.svg' WHERE wisdom_id=38;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_39.svg' WHERE wisdom_id=39;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_40.svg' WHERE wisdom_id=40;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_41.svg' WHERE wisdom_id=41;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_42.svg' WHERE wisdom_id=42;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_43.svg' WHERE wisdom_id=43;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_44.svg' WHERE wisdom_id=44;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_45.svg' WHERE wisdom_id=45;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_46.svg' WHERE wisdom_id=46;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_47.svg' WHERE wisdom_id=47;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_48.svg' WHERE wisdom_id=48;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_49.svg' WHERE wisdom_id=49;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_50.svg' WHERE wisdom_id=50;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_51.svg' WHERE wisdom_id=51;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_52.svg' WHERE wisdom_id=52;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_53.svg' WHERE wisdom_id=53;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_54.svg' WHERE wisdom_id=54;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_55.svg' WHERE wisdom_id=55;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_56.svg' WHERE wisdom_id=56;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_57.svg' WHERE wisdom_id=57;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_58.svg' WHERE wisdom_id=58;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_59.svg' WHERE wisdom_id=59;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_60.svg' WHERE wisdom_id=60;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_61.svg' WHERE wisdom_id=61;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_62.svg' WHERE wisdom_id=62;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_63.svg' WHERE wisdom_id=63;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_64.svg' WHERE wisdom_id=64;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_65.svg' WHERE wisdom_id=65;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_66.svg' WHERE wisdom_id=66;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_67.svg' WHERE wisdom_id=67;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_68.svg' WHERE wisdom_id=68;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_69.svg' WHERE wisdom_id=69;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_70.svg' WHERE wisdom_id=70;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_71.svg' WHERE wisdom_id=71;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_72.svg' WHERE wisdom_id=72;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_73.svg' WHERE wisdom_id=73;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_74.svg' WHERE wisdom_id=74;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_75.svg' WHERE wisdom_id=75;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_76.svg' WHERE wisdom_id=76;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_77.svg' WHERE wisdom_id=77;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_78.svg' WHERE wisdom_id=78;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_79.svg' WHERE wisdom_id=79;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_80.svg' WHERE wisdom_id=80;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_81.svg' WHERE wisdom_id=81;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_82.svg' WHERE wisdom_id=82;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_83.svg' WHERE wisdom_id=83;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_84.svg' WHERE wisdom_id=84;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_85.svg' WHERE wisdom_id=85;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_86.svg' WHERE wisdom_id=86;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_87.svg' WHERE wisdom_id=87;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_88.svg' WHERE wisdom_id=88;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_89.svg' WHERE wisdom_id=89;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_90.svg' WHERE wisdom_id=90;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_91.svg' WHERE wisdom_id=91;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_92.svg' WHERE wisdom_id=92;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_93.svg' WHERE wisdom_id=93;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_94.svg' WHERE wisdom_id=94;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_95.svg' WHERE wisdom_id=95;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_96.svg' WHERE wisdom_id=96;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_97.svg' WHERE wisdom_id=97;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_98.svg' WHERE wisdom_id=98;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_99.svg' WHERE wisdom_id=99;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_100.svg' WHERE wisdom_id=100;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_101.svg' WHERE wisdom_id=101;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_102.svg' WHERE wisdom_id=102;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_103.svg' WHERE wisdom_id=103;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_104.svg' WHERE wisdom_id=104;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_105.svg' WHERE wisdom_id=105;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_106.svg' WHERE wisdom_id=106;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_107.svg' WHERE wisdom_id=107;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_108.svg' WHERE wisdom_id=108;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_109.svg' WHERE wisdom_id=109;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_110.svg' WHERE wisdom_id=110;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_111.svg' WHERE wisdom_id=111;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_112.svg' WHERE wisdom_id=112;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_113.svg' WHERE wisdom_id=113;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_114.svg' WHERE wisdom_id=114;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_115.svg' WHERE wisdom_id=115;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_116.svg' WHERE wisdom_id=116;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_117.svg' WHERE wisdom_id=117;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_118.svg' WHERE wisdom_id=118;
UPDATE dbo.DailyWisdom SET image_url=N'/art/wisdom_119.svg' WHERE wisdom_id=119;

-- The eight published stories that had thumbnail_url NULL.
UPDATE dbo.Stories SET thumbnail_url=N'/art/story_tortoise_hare.svg' WHERE story_id=4 AND (thumbnail_url IS NULL OR thumbnail_url='');
UPDATE dbo.Stories SET thumbnail_url=N'/art/story_ant_grasshopper.svg' WHERE story_id=5 AND (thumbnail_url IS NULL OR thumbnail_url='');
UPDATE dbo.Stories SET thumbnail_url=N'/art/story_boy_cried_wolf.svg' WHERE story_id=6 AND (thumbnail_url IS NULL OR thumbnail_url='');
UPDATE dbo.Stories SET thumbnail_url=N'/art/story_lion_mouse.svg' WHERE story_id=7 AND (thumbnail_url IS NULL OR thumbnail_url='');
UPDATE dbo.Stories SET thumbnail_url=N'/art/story_cinderella.svg' WHERE story_id=8 AND (thumbnail_url IS NULL OR thumbnail_url='');
UPDATE dbo.Stories SET thumbnail_url=N'/art/story_red_riding_hood.svg' WHERE story_id=9 AND (thumbnail_url IS NULL OR thumbnail_url='');
UPDATE dbo.Stories SET thumbnail_url=N'/art/story_town_country_mouse.svg' WHERE story_id=10 AND (thumbnail_url IS NULL OR thumbnail_url='');
UPDATE dbo.Stories SET thumbnail_url=N'/art/story_golden_goose.svg' WHERE story_id=11 AND (thumbnail_url IS NULL OR thumbnail_url='');

SELECT (SELECT COUNT(*) FROM dbo.DailyWisdom WHERE image_url IS NOT NULL) AS wisdom_with_art,
       (SELECT COUNT(*) FROM dbo.DailyWisdom) AS wisdom_total,
       (SELECT COUNT(*) FROM dbo.Stories WHERE thumbnail_url IS NOT NULL AND is_published=1) AS pub_stories_with_art,
       (SELECT COUNT(*) FROM dbo.Stories WHERE is_published=1) AS pub_stories_total;
