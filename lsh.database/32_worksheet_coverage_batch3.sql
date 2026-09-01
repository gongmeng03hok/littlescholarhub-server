-- 32_worksheet_coverage_batch3.sql
-- Third batch toward "at least 5 worksheets per subject per grade". See
-- 30_worksheet_coverage_batch1.sql for the full initiative description and
-- the tracking query. pdf_generator_key values correspond to functions
-- added under "Coverage batch 3" in services/worksheet_pdf_generator.py.
--
-- Note: since batch 2, two new non-cultural subjects (science, writing) were
-- added elsewhere, expanding the tracked grid from 72 to 88 combinations.
-- This batch does not touch those; it closes out the 8 combinations that
-- were sitting at 3/5 (2 added each, now complete at 5):
--   feelings/4th, feelings/2nd, logic/5th, manners/1st, manners/TK,
--   manners/K, workbooks/4th, workbooks/3rd
--
-- Still short after this batch: everything at 2/5 (the bulk of art, logic,
-- manners, phonics, reading, story, workbooks at various grades), the 3
-- combos at 1/5 (science/2nd, science/5th, writing/3rd), and all 13
-- zero-coverage combos across science and writing. Re-run the tracking
-- query in batch 1's file (add science/writing to see the full picture)
-- to see current state.

INSERT INTO dbo.Worksheets (subject_id, grade_id, title, description, estimated_min, pdf_generator_key, teacher_name)
VALUES
-- feelings/2nd (subject_id=8, grade_id=3): 3 -> 5
(8, 3, N'My Feelings Thermometer',       N'Learn that feelings can be a little strong or very strong.',            10, 'feelings_thermometer',            N'Little Scholars Hub Team'),
(8, 3, N'Feelings Match-Up',             N'Match each feeling word to how it looks or feels.',                     10, 'feelings_match_face_word',        N'Little Scholars Hub Team'),

-- feelings/4th (subject_id=8, grade_id=5): 3 -> 5
(8, 5, N'Feelings Vocabulary Builder',   N'Match each feeling word to its meaning.',                               10, 'feelings_vocabulary_builder',     N'Little Scholars Hub Team'),
(8, 5, N'Feelings Detective: Body Language Clues', N'Read each body-language clue, then guess the feeling.',       15, 'feelings_body_language_clues',    N'Little Scholars Hub Team'),

-- logic/5th (subject_id=7, grade_id=6): 3 -> 5
(7, 6, N'Logic Grid: Library Mystery',   N'Use the clues to fill in the grid and solve the puzzle.',              20, 'logic_grid_library_mystery',      N'Little Scholars Hub Team'),
(7, 6, N'Number Sequence Detective',     N'Find the rule, then continue each advanced pattern.',                  15, 'number_sequence_detective_5',     N'Little Scholars Hub Team'),

-- manners/TK (subject_id=9, grade_id=0): 3 -> 5
(9, 0, N'Tracing Polite Words',          N'Trace each polite word, then write it once on your own.',              10, 'tracing_polite_words',            N'Little Scholars Hub Team'),
(9, 0, N'Kind or Unkind?',               N'Read each scene, then circle Kind or Unkind.',                         10, 'kind_or_unkind_circle',           N'Little Scholars Hub Team'),

-- manners/K (subject_id=9, grade_id=1): 3 -> 5
(9, 1, N'Good Listener Checklist',       N'Check off each good-listening habit as you practice it.',              10, 'good_listener_checklist',         N'Little Scholars Hub Team'),
(9, 1, N'Manners at the Table',          N'Learn four good manners to use at mealtime.',                          10, 'manners_at_the_table',            N'Little Scholars Hub Team'),

-- manners/1st (subject_id=9, grade_id=2): 3 -> 5
(9, 2, N'Table Manners Checklist',       N'Check off each table manner as you practice it at a meal.',            10, 'table_manners_checklist',         N'Little Scholars Hub Team'),
(9, 2, N'Polite Words Match-Up',         N'Match each polite phrase to what it means.',                           10, 'polite_words_match',              N'Little Scholars Hub Team'),

-- workbooks/3rd (subject_id=6, grade_id=4): 3 -> 5
(6, 4, N'Flashcard Maker: Study Skills', N'Learn how to make your own flashcards to study smarter.',              10, 'flashcard_maker_study_skills',    N'Little Scholars Hub Team'),
(6, 4, N'Multiplication Fact Fluency',   N'Practice your times tables until they feel automatic.',                10, 'multiplication_fact_fluency_drill', N'Little Scholars Hub Team'),

-- workbooks/4th (subject_id=6, grade_id=5): 3 -> 5
(6, 5, N'Outline a Topic',               N'Practice organizing your ideas into a simple outline before you write.', 15, 'outline_a_topic',               N'Little Scholars Hub Team'),
(6, 5, N'Multi-Step Word Problems',      N'Read carefully -- each problem takes two steps to solve.',             15, 'multi_step_word_problems_4',      N'Little Scholars Hub Team');
