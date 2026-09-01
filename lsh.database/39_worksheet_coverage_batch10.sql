-- 39_worksheet_coverage_batch10.sql
-- Tenth batch toward "at least 5 worksheets per subject per grade". See
-- 30_worksheet_coverage_batch1.sql for the full initiative description.
-- pdf_generator_key values correspond to functions added under
-- "Coverage batch 10" in services/worksheet_pdf_generator.py.
--
-- Fully closes two entire subjects across their remaining 2/5 grades:
--   story: K, 2nd, 3rd, 4th, 5th (all 2 -> 5)
--   phonics: 2nd, 4th, 5th, 6th (all 2 -> 5)
-- `story` and `phonics` are now complete across all 8 grades each.

INSERT INTO dbo.Worksheets (subject_id, grade_id, title, description, estimated_min, pdf_generator_key, teacher_name)
VALUES
-- story/K (subject_id=5, grade_id=1): 2 -> 5
(5, 1, N'Simple Story Map',             N'Fill in the four parts of a story after you hear one.',                10, 'simple_story_map_k',            N'Little Scholars Hub Team'),
(5, 1, N'Act It Out',                   N'Practice acting out a character from a story you know.',               10, 'act_it_out_k',                  N'Little Scholars Hub Team'),
(5, 1, N'How Do Story Characters Feel?', N'Match each story moment to the feeling the character has.',          10, 'story_feelings_k',              N'Little Scholars Hub Team'),

-- story/2nd (subject_id=5, grade_id=3): 2 -> 5
(5, 3, N'Story Problem & Solution',     N'Practice identifying a character''s problem and how it gets solved.',  10, 'story_problem_and_solution_2',  N'Little Scholars Hub Team'),
(5, 3, N'Setting Details',              N'Practice imagining and describing where and when a story takes place.', 10, 'setting_details_2',           N'Little Scholars Hub Team'),
(5, 3, N'Five-Finger Retell',           N'Use your hand to remember the five parts of retelling a story.',       10, 'retelling_with_5_fingers_2',    N'Little Scholars Hub Team'),

-- story/3rd (subject_id=5, grade_id=4): 2 -> 5
(5, 4, N'Comic Strip Story',            N'Plan a four-panel comic strip with a beginning, problem, and ending.', 15, 'comic_strip_story_3',           N'Little Scholars Hub Team'),
(5, 4, N'Story Theme',                  N'Practice telling the difference between what happens and the lesson.', 10, 'story_theme_intro_3',          N'Little Scholars Hub Team'),
(5, 4, N'Write an Alternate Ending',    N'Practice rewriting the ending of a story you already know.',           15, 'alternate_ending_3',            N'Little Scholars Hub Team'),

-- story/4th (subject_id=5, grade_id=5): 2 -> 5
(5, 5, N'Setting the Scene',            N'Practice writing settings that create a specific mood.',                15, 'setting_the_scene_4',           N'Little Scholars Hub Team'),
(5, 5, N'Types of Story Conflict',      N'Match each type of conflict to its description.',                      10, 'conflict_types_4',              N'Little Scholars Hub Team'),
(5, 5, N'Story Mountain Planner',       N'Plan your story using the shape of a mountain.',                       15, 'story_mountain_planner_4',      N'Little Scholars Hub Team'),

-- story/5th (subject_id=5, grade_id=6): 2 -> 5
(5, 6, N'Foreshadowing',                N'Learn how authors hint at what''s coming later in a story.',           10, 'foreshadowing_intro_5',         N'Little Scholars Hub Team'),
(5, 6, N'Point of View',                N'Match each point of view to how the narrator tells the story.',        10, 'point_of_view_5',               N'Little Scholars Hub Team'),
(5, 6, N'Dynamic vs. Static Characters', N'Learn the difference between characters who change and those who stay the same.', 10, 'dynamic_vs_static_characters_5', N'Little Scholars Hub Team'),

-- phonics/2nd (subject_id=1, grade_id=3): 2 -> 5
(1, 3, N'Vowel Teams',                  N'Match each vowel team to the sound it makes.',                         10, 'vowel_teams_2',                 N'Little Scholars Hub Team'),
(1, 3, N'Soft C and Soft G',            N'Learn when C and G make their soft sounds instead of their hard sounds.', 10, 'soft_c_and_g_2',              N'Little Scholars Hub Team'),
(1, 3, N'Building Compound Words',      N'Match each pair of small words to the compound word they make.',      10, 'compound_word_building_2',      N'Little Scholars Hub Team'),

-- phonics/4th (subject_id=1, grade_id=5): 2 -> 5
(1, 5, N'Roots: Bio, Tele, Aqua, Photo', N'Match each word root to what it means.',                              10, 'roots_bio_tele_aqua_photo_4',   N'Little Scholars Hub Team'),
(1, 5, N'Tricky Homophones',            N'Match each set of homophones to what each word means.',                10, 'homophones_4',                  N'Little Scholars Hub Team'),
(1, 5, N'Syllable Types',               N'Learn three types of syllables and how they change a vowel''s sound.', 10, 'syllable_types_4',              N'Little Scholars Hub Team'),

-- phonics/5th (subject_id=1, grade_id=6): 2 -> 5
(1, 6, N'Advanced Prefixes',            N'Match each prefix to its meaning.',                                    10, 'prefixes_advanced_5',           N'Little Scholars Hub Team'),
(1, 6, N'Where Words Come From',        N'Learn how English words often come from Latin or Greek roots.',       10, 'word_origins_5',                N'Little Scholars Hub Team'),
(1, 6, N'Spelling Patterns: I Before E', N'Learn the i-before-e rule and its exceptions.',                       10, 'spelling_patterns_5',           N'Little Scholars Hub Team'),

-- phonics/6th (subject_id=1, grade_id=7): 2 -> 5
(1, 7, N'Silent Letters',               N'Match each silent-letter pattern to an example word.',                 10, 'silent_letters_6',              N'Little Scholars Hub Team'),
(1, 7, N'Word Stress & Syllables',      N'Learn how stressing a different syllable can change a word''s meaning.', 10, 'stress_and_syllables_6',      N'Little Scholars Hub Team'),
(1, 7, N'Commonly Confused Words',      N'Match each word pair to how they are different.',                      10, 'commonly_confused_words_6',     N'Little Scholars Hub Team');
