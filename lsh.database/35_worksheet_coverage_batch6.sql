-- 35_worksheet_coverage_batch6.sql
-- Sixth batch toward "at least 5 worksheets per subject per grade". See
-- 30_worksheet_coverage_batch1.sql for the full initiative description and
-- 33_worksheet_coverage_batch4.sql for how science/writing got their first
-- 2 worksheets each. pdf_generator_key values correspond to functions
-- added under "Coverage batch 6" in services/worksheet_pdf_generator.py.
--
-- Closes 8 of the 13 combos batch 4 brought to 2/5, fully to 5/5:
--   science: TK, K, 1st, 3rd
--   writing: TK, K, 1st, 2nd
--
-- Still short after this batch: science/4th, science/6th, writing/4th,
-- writing/5th, writing/6th (the other 5 batch-4 combos, still at 2/5), plus
-- the ~50 combos across the original 9 subjects at 2/5 minus the 8 batch 5
-- already closed, plus science/2nd, science/5th, writing/3rd at 1/5.

INSERT INTO dbo.Worksheets (subject_id, grade_id, title, description, estimated_min, pdf_generator_key, teacher_name)
VALUES
-- science/TK (subject_id=19, grade_id=0): 2 -> 5
(19, 0, N'Weather Words',               N'Match each weather word to what it looks like.',                       10, 'weather_types_tk',              N'Little Scholars Hub Team'),
(19, 0, N'Hot or Cold?',                N'Circle Hot or Cold for each thing.',                                   10, 'hot_or_cold_tk',                N'Little Scholars Hub Team'),
(19, 0, N'Animal Babies',               N'Match each animal to the name of its baby.',                           10, 'animal_babies_match_tk',        N'Little Scholars Hub Team'),

-- science/K (subject_id=19, grade_id=1): 2 -> 5
(19, 1, N'Float or Sink?',              N'Circle Float or Sink for each object in water.',                       10, 'things_that_float_or_sink_k',   N'Little Scholars Hub Team'),
(19, 1, N'Animal Habitats',             N'Match each animal to where it lives.',                                 10, 'animal_habitats_match_k',       N'Little Scholars Hub Team'),
(19, 1, N'Day Sky, Night Sky',          N'Compare what the sky looks like during the day and at night.',         10, 'day_sky_night_sky_k',           N'Little Scholars Hub Team'),

-- science/1st (subject_id=19, grade_id=2): 2 -> 5
(19, 2, N'Animal Body Coverings',       N'Match each body covering to what it does.',                            10, 'animal_body_coverings_1',       N'Little Scholars Hub Team'),
(19, 2, N'Push or Pull?',               N'Decide if each action is a push force or a pull force.',               10, 'push_or_pull_1',                N'Little Scholars Hub Team'),
(19, 2, N'Plant Parts & Jobs',          N'Match each plant part to its job.',                                    10, 'plant_parts_and_jobs_1',        N'Little Scholars Hub Team'),

-- science/3rd (subject_id=19, grade_id=4): 2 -> 5
(19, 4, N'Types of Rocks',              N'Match each rock type to how it forms.',                                10, 'rock_types_match_3',            N'Little Scholars Hub Team'),
(19, 4, N'States of Matter: Changes',   N'Name the change each time matter switches from one state to another.', 15, 'states_of_matter_changes_3',    N'Little Scholars Hub Team'),
(19, 4, N'Animal Adaptations',          N'Learn how special features help animals survive.',                     15, 'animal_adaptations_3',          N'Little Scholars Hub Team'),

-- writing/TK (subject_id=18, grade_id=0): 2 -> 5
(18, 0, N'Writing Shapes Practice',     N'Practice the basic strokes and shapes used to write letters.',         10, 'writing_shapes_practice_tk',    N'Little Scholars Hub Team'),
(18, 0, N'My Favorite Things',          N'Draw three of your favorite things, then write what each one is.',     10, 'my_favorite_things_tk',         N'Little Scholars Hub Team'),
(18, 0, N'My Family',                   N'Draw your family, then label who everyone is.',                        10, 'family_members_labels_tk',      N'Little Scholars Hub Team'),

-- writing/K (subject_id=18, grade_id=1): 2 -> 5
(18, 1, N'Writing About Pictures',      N'Practice writing a complete sentence about what you see.',             10, 'writing_about_pictures_k',      N'Little Scholars Hub Team'),
(18, 1, N'Joining Words with AND',      N'Practice using the word AND to connect two or more things.',           10, 'using_and_in_lists_k',          N'Little Scholars Hub Team'),
(18, 1, N'Label a Scene',               N'Draw a scene, label what''s in it, then write a sentence about it.',   10, 'labeling_a_scene_k',            N'Little Scholars Hub Team'),

-- writing/1st (subject_id=18, grade_id=2): 2 -> 5
(18, 2, N'Writing Exclamations',        N'Practice writing sentences that show strong feeling.',                 10, 'writing_exclamations_1',        N'Little Scholars Hub Team'),
(18, 2, N'Friendly Letter Basics',      N'Learn the three parts of a friendly letter, then write one.',          15, 'friendly_letter_basics_1',      N'Little Scholars Hub Team'),
(18, 2, N'Sequence Words',              N'Match each sequence word to when it''s used in a story.',              10, 'sequence_words_1',              N'Little Scholars Hub Team'),

-- writing/2nd (subject_id=18, grade_id=3): 2 -> 5
(18, 3, N'Informational Writing',       N'Practice writing true facts about a topic you know well.',             15, 'informational_writing_intro_2', N'Little Scholars Hub Team'),
(18, 3, N'Similes: Like or As',         N'Match each simile to what it''s comparing.',                           10, 'similes_intro_2',               N'Little Scholars Hub Team'),
(18, 3, N'Writing a Thank-You Note',    N'Learn the parts of a thank-you note, then write your own.',            10, 'writing_a_thank_you_note_2',    N'Little Scholars Hub Team');
