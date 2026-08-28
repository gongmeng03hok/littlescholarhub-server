-- 30_worksheet_coverage_batch1.sql
-- First batch toward "at least 5 worksheets per subject per grade" (9 core
-- subjects x 8 grades = 72 combinations). Each row's pdf_generator_key
-- corresponds to a hand-written generator function added in the same batch
-- to services/worksheet_pdf_generator.py (GENERATORS dict, "Coverage batch 1"
-- section) — no filler/placeholder content, same quality bar as existing
-- worksheets.
--
-- Batch 1 targets:
--   - 7 combinations that were exactly 1 short of 5 (now complete):
--       math/1st, math/5th, math/6th, phonics/TK, art/TK, art/2nd, logic/3rd
--   - 12 combinations that had only 1 worksheet (now at 2, still short of 5):
--       phonics/2nd, phonics/6th, reading/1st, reading/2nd, reading/3rd,
--       story/4th, story/5th, story/6th, workbooks/TK, workbooks/K,
--       workbooks/1st, workbooks/5th
--
-- Still short of 5 after this batch — tracked for the next session(s):
--   every (subject, grade) combination not listed above. Query to check
--   current coverage:
--     SELECT s.slug AS subject, g.label AS grade, COUNT(*) AS worksheet_count
--     FROM dbo.Worksheets w
--     JOIN dbo.Subjects s ON w.subject_id = s.subject_id
--     JOIN dbo.Grades   g ON w.grade_id   = g.grade_id
--     WHERE s.is_cultural = 0
--     GROUP BY s.slug, g.label
--     ORDER BY worksheet_count, s.slug;

INSERT INTO dbo.Worksheets (subject_id, grade_id, title, description, estimated_min, pdf_generator_key, teacher_name)
VALUES
-- Quick-win completions (were at 4, now at 5)
(3, 2, N'Subtraction Hop 1–10',            N'Subtract the numbers, staying between 0 and 10.',                       10, 'subtraction_hop_10',        N'Little Scholars Hub Team'),
(3, 6, N'Fraction Fundamentals',           N'Add fractions that already share a denominator.',                       15, 'fraction_fundamentals',     N'Little Scholars Hub Team'),
(3, 7, N'Ratios & Percents',               N'Find each percentage of the total.',                                    15, 'ratios_percents_6',         N'Little Scholars Hub Team'),
(1, 0, N'Rhyming Words Match',             N'Say each word, then circle the ones that rhyme.',                       10, 'rhyming_words_match',       N'Little Scholars Hub Team'),
(4, 0, N'Draw the Happy Sun',              N'Draw, then color, your own happy sun.',                                 15, 'draw_happy_sun',            N'Little Scholars Hub Team'),
(4, 3, N'Draw the Rocket Ship',            N'Draw, then color, your own rocket ship.',                               15, 'draw_rocket_ship',          N'Little Scholars Hub Team'),
(7, 4, N'Pattern Detective',               N'Find the rule, then continue each pattern.',                            15, 'pattern_detective_3',       N'Little Scholars Hub Team'),

-- Worst-gap combinations (were at 1, now at 2)
(1, 3, N'Silent E Magic',                  N'Add a silent e to the end — watch the vowel change its sound!',        10, 'silent_e_magic',            N'Little Scholars Hub Team'),
(1, 7, N'Multisyllabic Word Chunking',     N'Clap out each chunk (syllable), then check your count.',               10, 'phonics_word_chunking_6',   N'Little Scholars Hub Team'),
(2, 2, N'Story Sequence: What Happened First?', N'Read the story, then put the events in order.',                   15, 'story_sequence_1',          N'Little Scholars Hub Team'),
(2, 3, N'Main Idea & Details Practice',    N'Read the passage, then find the main idea and supporting details.',    15, 'main_idea_details_2',       N'Little Scholars Hub Team'),
(2, 4, N'Compare & Contrast: Two Habitats', N'Read about both habitats, then compare and contrast.',                20, 'compare_contrast_habitats', N'Little Scholars Hub Team'),
(5, 5, N'Build-a-Story: Choose Your Character', N'Fill in each story-building step, then write the full story.',    20, 'build_a_story_character',   N'Little Scholars Hub Team'),
(5, 6, N'Story Starters: Mystery Edition', N'Pick a mysterious opening line and continue the story.',               20, 'story_starters_mystery',    N'Little Scholars Hub Team'),
(5, 7, N'Write Your Own Fable',            N'Plan and draft a short fable with a clear moral.',                      25, 'write_your_own_fable',      N'Little Scholars Hub Team'),
(6, 0, N'TK Practice Pack: Week 1',        N'A short weekly mix of counting, letters, shapes, and listening.',      15, 'practice_pack_tk',          N'Little Scholars Hub Team'),
(6, 1, N'Kindergarten Practice Pack: Week 1', N'A short weekly mix of counting, letters, shapes, and listening.',   15, 'practice_pack_k',           N'Little Scholars Hub Team'),
(6, 2, N'1st Grade Practice Pack: Week 1', N'A short weekly mix of math, reading, writing, and spelling.',          20, 'practice_pack_1',           N'Little Scholars Hub Team'),
(6, 6, N'5th Grade Practice Pack: Week 1', N'A short weekly mix of math, reading, writing, and vocabulary.',        20, 'practice_pack_5',           N'Little Scholars Hub Team');
GO
