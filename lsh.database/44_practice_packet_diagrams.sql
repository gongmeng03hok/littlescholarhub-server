-- 44_practice_packet_diagrams.sql
-- Adds optional visual diagrams to practice-packet questions, so kids get a
-- picture to reason from instead of pure text (e.g. an actual analog clock
-- for "Telling Time to the Hour" instead of "The hour hand points to 6...").
-- diagram_type is a small, extensible vocabulary the UI knows how to render;
-- diagram_data is the structured payload for that type (JSON).

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID('dbo.PacketQuestions') AND name = 'diagram_type')
BEGIN
    ALTER TABLE dbo.PacketQuestions ADD diagram_type VARCHAR(20) NULL
        CHECK (diagram_type IN ('clock', 'emoji'));
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID('dbo.PacketQuestions') AND name = 'diagram_data')
BEGIN
    ALTER TABLE dbo.PacketQuestions ADD diagram_data NVARCHAR(MAX) NULL;
END
GO

-- ── Telling Time to the Hour — replace the awkward "hour hand points to X"
-- text with a real clock diagram + a plain question. ──────────────────────
UPDATE dbo.PacketQuestions
SET prompt = N'What time does the clock show?',
    diagram_type = 'clock',
    diagram_data = N'{"hour":3,"minute":0}'
WHERE category_id = (SELECT category_id FROM dbo.PacketCategories WHERE grade_id=1 AND category_name=N'Telling Time to the Hour')
  AND answer_text = N'3:00';

UPDATE dbo.PacketQuestions
SET prompt = N'What time does the clock show?',
    diagram_type = 'clock',
    diagram_data = N'{"hour":7,"minute":0}'
WHERE category_id = (SELECT category_id FROM dbo.PacketCategories WHERE grade_id=1 AND category_name=N'Telling Time to the Hour')
  AND answer_text = N'7:00';

UPDATE dbo.PacketQuestions
SET prompt = N'What time does the clock show?',
    diagram_type = 'clock',
    diagram_data = N'{"hour":10,"minute":0}'
WHERE category_id = (SELECT category_id FROM dbo.PacketCategories WHERE grade_id=1 AND category_name=N'Telling Time to the Hour')
  AND answer_text = N'10:00';

UPDATE dbo.PacketQuestions
SET prompt = N'What time does the clock show?',
    diagram_type = 'clock',
    diagram_data = N'{"hour":1,"minute":0}'
WHERE category_id = (SELECT category_id FROM dbo.PacketCategories WHERE grade_id=1 AND category_name=N'Telling Time to the Hour')
  AND answer_text = N'1:00';

UPDATE dbo.PacketQuestions
SET prompt = N'What time does the clock show?',
    diagram_type = 'clock',
    diagram_data = N'{"hour":5,"minute":0}'
WHERE category_id = (SELECT category_id FROM dbo.PacketCategories WHERE grade_id=1 AND category_name=N'Telling Time to the Hour')
  AND answer_text = N'5:00';

UPDATE dbo.PacketQuestions
SET prompt = N'What time does the clock show?',
    diagram_type = 'clock',
    diagram_data = N'{"hour":8,"minute":0}'
WHERE category_id = (SELECT category_id FROM dbo.PacketCategories WHERE grade_id=1 AND category_name=N'Telling Time to the Hour')
  AND answer_text = N'8:00';

UPDATE dbo.PacketQuestions
SET prompt = N'What time does the clock show?',
    diagram_type = 'clock',
    diagram_data = N'{"hour":12,"minute":0}'
WHERE category_id = (SELECT category_id FROM dbo.PacketCategories WHERE grade_id=1 AND category_name=N'Telling Time to the Hour')
  AND answer_text = N'12:00';

UPDATE dbo.PacketQuestions
SET prompt = N'What time does the clock show?',
    diagram_type = 'clock',
    diagram_data = N'{"hour":6,"minute":0}'
WHERE category_id = (SELECT category_id FROM dbo.PacketCategories WHERE grade_id=1 AND category_name=N'Telling Time to the Hour')
  AND answer_text = N'6:00';


-- ── CVC Word Building — add a picture cue so kids can check the word they
-- just built means what they think, before/after filling the blank. ──────
UPDATE dbo.PacketQuestions SET diagram_type='emoji', diagram_data=N'{"emoji":"🐱"}' WHERE category_id=(SELECT category_id FROM dbo.PacketCategories WHERE grade_id=1 AND category_name=N'CVC Word Building') AND prompt LIKE N'c_t%';
UPDATE dbo.PacketQuestions SET diagram_type='emoji', diagram_data=N'{"emoji":"🐶"}' WHERE category_id=(SELECT category_id FROM dbo.PacketCategories WHERE grade_id=1 AND category_name=N'CVC Word Building') AND prompt LIKE N'd_g%';
UPDATE dbo.PacketQuestions SET diagram_type='emoji', diagram_data=N'{"emoji":"🐷"}' WHERE category_id=(SELECT category_id FROM dbo.PacketCategories WHERE grade_id=1 AND category_name=N'CVC Word Building') AND prompt LIKE N'p_g%';
UPDATE dbo.PacketQuestions SET diagram_type='emoji', diagram_data=N'{"emoji":"☀️"}' WHERE category_id=(SELECT category_id FROM dbo.PacketCategories WHERE grade_id=1 AND category_name=N'CVC Word Building') AND prompt LIKE N's_n%';
UPDATE dbo.PacketQuestions SET diagram_type='emoji', diagram_data=N'{"emoji":"🛏️"}' WHERE category_id=(SELECT category_id FROM dbo.PacketCategories WHERE grade_id=1 AND category_name=N'CVC Word Building') AND prompt LIKE N'b_d%';
UPDATE dbo.PacketQuestions SET diagram_type='emoji', diagram_data=N'{"emoji":"🎩"}' WHERE category_id=(SELECT category_id FROM dbo.PacketCategories WHERE grade_id=1 AND category_name=N'CVC Word Building') AND prompt LIKE N'h_t%';
UPDATE dbo.PacketQuestions SET diagram_type='emoji', diagram_data=N'{"emoji":"🗺️"}' WHERE category_id=(SELECT category_id FROM dbo.PacketCategories WHERE grade_id=1 AND category_name=N'CVC Word Building') AND prompt LIKE N'm_p%';
UPDATE dbo.PacketQuestions SET diagram_type='emoji', diagram_data=N'{"emoji":"🔝"}' WHERE category_id=(SELECT category_id FROM dbo.PacketCategories WHERE grade_id=1 AND category_name=N'CVC Word Building') AND prompt LIKE N't_p%';
UPDATE dbo.PacketQuestions SET diagram_type='emoji', diagram_data=N'{"emoji":"☕"}' WHERE category_id=(SELECT category_id FROM dbo.PacketCategories WHERE grade_id=1 AND category_name=N'CVC Word Building') AND prompt LIKE N'c_p%';
UPDATE dbo.PacketQuestions SET diagram_type='emoji', diagram_data=N'{"emoji":"🥅"}' WHERE category_id=(SELECT category_id FROM dbo.PacketCategories WHERE grade_id=1 AND category_name=N'CVC Word Building') AND prompt LIKE N'n_t%';
UPDATE dbo.PacketQuestions SET diagram_type='emoji', diagram_data=N'{"emoji":"🐛"}' WHERE category_id=(SELECT category_id FROM dbo.PacketCategories WHERE grade_id=1 AND category_name=N'CVC Word Building') AND prompt LIKE N'b_g%';
UPDATE dbo.PacketQuestions SET diagram_type='emoji', diagram_data=N'{"emoji":"🪵"}' WHERE category_id=(SELECT category_id FROM dbo.PacketCategories WHERE grade_id=1 AND category_name=N'CVC Word Building') AND prompt LIKE N'l_g%';
UPDATE dbo.PacketQuestions SET diagram_type='emoji', diagram_data=N'{"emoji":"🖊️"}' WHERE category_id=(SELECT category_id FROM dbo.PacketCategories WHERE grade_id=1 AND category_name=N'CVC Word Building') AND prompt LIKE N'p_n%';
UPDATE dbo.PacketQuestions SET diagram_type='emoji', diagram_data=N'{"emoji":"🐠"}' WHERE category_id=(SELECT category_id FROM dbo.PacketCategories WHERE grade_id=1 AND category_name=N'CVC Word Building') AND prompt LIKE N'f_n%';
UPDATE dbo.PacketQuestions SET diagram_type='emoji', diagram_data=N'{"emoji":"🧶"}' WHERE category_id=(SELECT category_id FROM dbo.PacketCategories WHERE grade_id=1 AND category_name=N'CVC Word Building') AND prompt LIKE N'r_g%';


-- ── Rhyming Word Identification — a picture of the target word helps kids
-- who can't yet decode it fluently. ────────────────────────────────────────
UPDATE dbo.PacketQuestions SET diagram_type='emoji', diagram_data=N'{"emoji":"🐱"}' WHERE category_id=(SELECT category_id FROM dbo.PacketCategories WHERE grade_id=1 AND category_name=N'Rhyming Word Identification') AND prompt LIKE N'%"cat"%';
UPDATE dbo.PacketQuestions SET diagram_type='emoji', diagram_data=N'{"emoji":"☀️"}' WHERE category_id=(SELECT category_id FROM dbo.PacketCategories WHERE grade_id=1 AND category_name=N'Rhyming Word Identification') AND prompt LIKE N'%"sun"%';
UPDATE dbo.PacketQuestions SET diagram_type='emoji', diagram_data=N'{"emoji":"🐶"}' WHERE category_id=(SELECT category_id FROM dbo.PacketCategories WHERE grade_id=1 AND category_name=N'Rhyming Word Identification') AND prompt LIKE N'%"dog"%';
UPDATE dbo.PacketQuestions SET diagram_type='emoji', diagram_data=N'{"emoji":"🐝"}' WHERE category_id=(SELECT category_id FROM dbo.PacketCategories WHERE grade_id=1 AND category_name=N'Rhyming Word Identification') AND prompt LIKE N'%"bee"%';
UPDATE dbo.PacketQuestions SET diagram_type='emoji', diagram_data=N'{"emoji":"🐷"}' WHERE category_id=(SELECT category_id FROM dbo.PacketCategories WHERE grade_id=1 AND category_name=N'Rhyming Word Identification') AND prompt LIKE N'%"pig"%';
UPDATE dbo.PacketQuestions SET diagram_type='emoji', diagram_data=N'{"emoji":"📦"}' WHERE category_id=(SELECT category_id FROM dbo.PacketCategories WHERE grade_id=1 AND category_name=N'Rhyming Word Identification') AND prompt LIKE N'%"box"%';
UPDATE dbo.PacketQuestions SET diagram_type='emoji', diagram_data=N'{"emoji":"🛏️"}' WHERE category_id=(SELECT category_id FROM dbo.PacketCategories WHERE grade_id=1 AND category_name=N'Rhyming Word Identification') AND prompt LIKE N'%"red"%';
UPDATE dbo.PacketQuestions SET diagram_type='emoji', diagram_data=N'{"emoji":"🎂"}' WHERE category_id=(SELECT category_id FROM dbo.PacketCategories WHERE grade_id=1 AND category_name=N'Rhyming Word Identification') AND prompt LIKE N'%"cake"%';
UPDATE dbo.PacketQuestions SET diagram_type='emoji', diagram_data=N'{"emoji":"🐔"}' WHERE category_id=(SELECT category_id FROM dbo.PacketCategories WHERE grade_id=1 AND category_name=N'Rhyming Word Identification') AND prompt LIKE N'%"hen"%';
UPDATE dbo.PacketQuestions SET diagram_type='emoji', diagram_data=N'{"emoji":"🧹"}' WHERE category_id=(SELECT category_id FROM dbo.PacketCategories WHERE grade_id=1 AND category_name=N'Rhyming Word Identification') AND prompt LIKE N'%"mop"%';
UPDATE dbo.PacketQuestions SET diagram_type='emoji', diagram_data=N'{"emoji":"⚽"}' WHERE category_id=(SELECT category_id FROM dbo.PacketCategories WHERE grade_id=1 AND category_name=N'Rhyming Word Identification') AND prompt LIKE N'%"ball"%';
UPDATE dbo.PacketQuestions SET diagram_type='emoji', diagram_data=N'{"emoji":"🌧️"}' WHERE category_id=(SELECT category_id FROM dbo.PacketCategories WHERE grade_id=1 AND category_name=N'Rhyming Word Identification') AND prompt LIKE N'%"rain"%';
GO
