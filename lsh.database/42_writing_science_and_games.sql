-- 42_writing_science_and_games.sql
-- 1. Adds "Writing" and "Science" as first-class subjects (previously only
--    partially covered inside "workbooks"/"reading").
-- 2. Adds a real-time interactive "game" content type to Worksheets: a
--    game_data JSON column holding either a tap_answer (multiple-choice,
--    instant feedback) or tap_match (tap-to-pair) activity, played in the
--    browser via GamePlayerModal — not a PDF. All content below is
--    original, hand-authored, matching the existing worksheet quality bar.

IF NOT EXISTS (SELECT 1 FROM dbo.Subjects WHERE subject_id = 18)
BEGIN
    INSERT INTO dbo.Subjects (subject_id, slug, label, icon, is_cultural)
    VALUES (18, 'writing', N'Writing', N'✍️', 0);
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.Subjects WHERE subject_id = 19)
BEGIN
    INSERT INTO dbo.Subjects (subject_id, slug, label, icon, is_cultural)
    VALUES (19, 'science', N'Science', N'🔬', 0);
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID('dbo.Worksheets') AND name = 'game_data')
BEGIN
    ALTER TABLE dbo.Worksheets ADD game_data NVARCHAR(MAX) NULL;
END
GO

IF EXISTS (SELECT 1 FROM sys.check_constraints WHERE name = 'CK_WS_ContentType')
BEGIN
    ALTER TABLE dbo.Worksheets DROP CONSTRAINT CK_WS_ContentType;
END
GO

ALTER TABLE dbo.Worksheets ADD CONSTRAINT CK_WS_ContentType
    CHECK (content_type IN ('workbook', 'mini_book', 'coloring', 'worksheet', 'space_image', 'iacl_book', 'weekly_packet', 'game'));
GO

INSERT INTO dbo.Worksheets
    (subject_id, grade_id, title, description, estimated_min, content_type, teacher_name, is_published, is_free, game_data)
VALUES
(3, 2, N'Addition Tap Race', N'Tap the correct answer as fast as you can — 10 addition facts to 20.', 8,
 'game', N'Little Scholars Hub Team', 1, 1,
 N'{"type":"tap_answer","questions":[
   {"prompt":"6 + 7 = ?","choices":["12","13","14","11"],"correct":1},
   {"prompt":"9 + 5 = ?","choices":["13","15","14","16"],"correct":2},
   {"prompt":"8 + 8 = ?","choices":["15","17","18","16"],"correct":3},
   {"prompt":"4 + 9 = ?","choices":["12","13","11","14"],"correct":1},
   {"prompt":"7 + 6 = ?","choices":["12","14","13","15"],"correct":2},
   {"prompt":"3 + 15 = ?","choices":["17","18","19","16"],"correct":1},
   {"prompt":"11 + 6 = ?","choices":["16","18","17","15"],"correct":2},
   {"prompt":"9 + 9 = ?","choices":["17","18","19","16"],"correct":1},
   {"prompt":"5 + 12 = ?","choices":["16","18","17","15"],"correct":2},
   {"prompt":"10 + 8 = ?","choices":["17","19","18","16"],"correct":2}
 ]}'),

(19, 3, N'Animal Habitats Match', N'Tap an animal, then tap the habitat where it lives, to make a matching pair.', 6,
 'game', N'Little Scholars Hub Team', 1, 1,
 N'{"type":"tap_match","pairs":[
   ["Polar Bear","Arctic Ice"],
   ["Camel","Desert"],
   ["Clownfish","Coral Reef"],
   ["Frog","Pond"],
   ["Owl","Forest"],
   ["Kangaroo","Grassland"]
 ]}'),

(18, 4, N'Noun or Verb?', N'Tap whether the bold word in each sentence is a noun (a person, place, or thing) or a verb (an action).', 7,
 'game', N'Little Scholars Hub Team', 1, 1,
 N'{"type":"tap_answer","questions":[
   {"prompt":"The dog RAN across the yard.","choices":["Noun","Verb"],"correct":1},
   {"prompt":"My sister found a shiny ROCK.","choices":["Noun","Verb"],"correct":0},
   {"prompt":"We will SWIM at the lake today.","choices":["Noun","Verb"],"correct":1},
   {"prompt":"The TEACHER read us a story.","choices":["Noun","Verb"],"correct":0},
   {"prompt":"Please CLOSE the door quietly.","choices":["Noun","Verb"],"correct":1},
   {"prompt":"A big TRUCK drove down the street.","choices":["Noun","Verb"],"correct":0},
   {"prompt":"She SINGS every morning in the shower.","choices":["Noun","Verb"],"correct":1},
   {"prompt":"The BIRD built a nest in the tree.","choices":["Noun","Verb"],"correct":0},
   {"prompt":"He JUMPS over the puddles on his way to school.","choices":["Noun","Verb"],"correct":1},
   {"prompt":"I packed my LUNCH in a blue bag.","choices":["Noun","Verb"],"correct":0}
 ]}'),

(19, 6, N'Water Cycle Steps', N'Tap each step of the water cycle, then tap the matching description.', 6,
 'game', N'Little Scholars Hub Team', 1, 1,
 N'{"type":"tap_match","pairs":[
   ["Evaporation","Sun heats water and turns it into vapor"],
   ["Condensation","Water vapor cools and forms clouds"],
   ["Precipitation","Water falls back to Earth as rain or snow"],
   ["Collection","Water gathers in rivers, lakes, and oceans"]
 ]}');
GO
