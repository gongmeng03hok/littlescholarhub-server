-- 31_worksheet_coverage_batch2.sql
-- Second batch toward "at least 5 worksheets per subject per grade". See
-- 30_worksheet_coverage_batch1.sql for the full initiative description and
-- the tracking query. pdf_generator_key values correspond to functions
-- added under "Coverage batch 2" in services/worksheet_pdf_generator.py.
--
-- Batch 2 targets:
--   - 12 combinations that were at 3 (2 added each, now complete at 5):
--       phonics/1st, reading/K, reading/5th, reading/6th, math/K, math/TK,
--       math/2nd, art/K, art/1st, story/1st, workbooks/2nd, logic/4th
--   - manners/TK, manners/K, manners/1st (1 added each, now at 3 — manners
--     was flat at 2 across every single grade, the weakest subject overall)
--
-- Still short after this batch: everything not listed above, including all
-- of "feelings" (2-3 everywhere), most of "workbooks"/"logic"/"story"/"manners"
-- at higher grades, and the batch-1 leftovers (phonics 2nd/6th etc. at 2).
-- Re-run the tracking query in batch 1's file to see current state.

INSERT INTO dbo.Worksheets (subject_id, grade_id, title, description, estimated_min, pdf_generator_key, teacher_name)
VALUES
-- phonics/1st: 3 -> 5
(1, 2, N'CVC Word Building',              N'Blend each consonant-vowel-consonant word, then read it aloud.',        10, 'cvc_word_building',          N'Little Scholars Hub Team'),
(1, 2, N'Digraph Detectives: sh, ch, th', N'Circle the digraph (2 letters, 1 sound) in each word.',                 10, 'digraph_detectives',         N'Little Scholars Hub Team'),

-- reading/K: 3 -> 5
(2, 1, N'Retell the Story: Beginning, Middle, End', N'Read the story, then retell it in three parts.',              15, 'retell_beginning_middle_end', N'Little Scholars Hub Team'),
(2, 1, N'Picture Clues: Guess the Word',  N'Use the clues to guess each word.',                                     10, 'picture_clue_riddles',       N'Little Scholars Hub Team'),

-- reading/5th: 3 -> 5
(2, 6, N'Cause & Effect: The Big Storm',  N'Find each cause-and-effect pair in the passage.',                       20, 'cause_effect_storm',         N'Little Scholars Hub Team'),
(2, 6, N'Author''s Purpose Practice',     N'Decide whether each passage is meant to persuade, inform, or entertain.', 15, 'authors_purpose_practice',  N'Little Scholars Hub Team'),

-- reading/6th: 3 -> 5
(2, 7, N'Inference Practice: Reading Between the Lines', N'Use clues from the text to make inferences.',            20, 'inference_practice_6',       N'Little Scholars Hub Team'),
(2, 7, N'Summarizing Nonfiction',         N'Read the passage, then write a short, accurate summary.',               20, 'summarizing_nonfiction_6',   N'Little Scholars Hub Team'),

-- math/K: 3 -> 5
(3, 1, N'Shapes & Counting',              N'Answer each shape question, counting carefully.',                       15, 'shapes_and_counting_k',      N'Little Scholars Hub Team'),
(3, 1, N'More or Less Than 10',           N'Circle MORE or LESS to compare each number to 5.',                      10, 'more_or_less_10',            N'Little Scholars Hub Team'),

-- math/TK: 3 -> 5
(3, 0, N'Count and Match 1–5',            N'Count each group, then write the number.',                              10, 'count_and_match_5',          N'Little Scholars Hub Team'),
(3, 0, N'Big and Small Sorting',          N'Find, sort, and compare big and small things.',                         15, 'big_and_small_sorting',      N'Little Scholars Hub Team'),

-- math/2nd: 3 -> 5
(3, 3, N'Skip Counting by 2s, 5s, 10s',   N'Fill in the missing numbers in each skip-counting pattern.',            10, 'skip_counting_2_5_10',       N'Little Scholars Hub Team'),
(3, 3, N'Telling Time to the Half Hour',  N'Read each clock description and write the time.',                       15, 'telling_time_half_hour',     N'Little Scholars Hub Team'),

-- art/K: 3 -> 5
(4, 1, N'Draw the Butterfly',             N'Draw, then color, your own butterfly.',                                 15, 'draw_butterfly',             N'Little Scholars Hub Team'),
(4, 1, N'Draw Your Family',               N'Draw, then color, your own family.',                                    15, 'draw_your_family',           N'Little Scholars Hub Team'),

-- art/1st: 3 -> 5
(4, 2, N'Draw the Rainbow',               N'Draw, then color, your own rainbow.',                                   15, 'draw_rainbow',               N'Little Scholars Hub Team'),
(4, 2, N'Draw a Spaceship Adventure',     N'Draw, then color, your own spaceship adventure.',                       15, 'draw_spaceship',             N'Little Scholars Hub Team'),

-- story/1st: 3 -> 5
(5, 2, N'Silly Sentence Mad-Libs',        N'Fill in the blanks first, then read your silly story.',                 15, 'silly_mad_libs',             N'Little Scholars Hub Team'),
(5, 2, N'My Weekend Story',               N'Write about your weekend, then draw your favorite part.',               15, 'my_weekend_story',           N'Little Scholars Hub Team'),

-- workbooks/2nd: 3 -> 5
(6, 3, N'2nd Grade Practice Pack: Week 1', N'A short weekly mix of math, reading, writing, and spelling.',          20, 'practice_pack_2_week1',      N'Little Scholars Hub Team'),
(6, 3, N'2nd Grade Practice Pack: Week 2', N'A short weekly mix of math, reading, writing, and spelling.',          20, 'practice_pack_2_week2',      N'Little Scholars Hub Team'),

-- logic/4th: 3 -> 5
(7, 5, N'Odd One Out: Categorization',    N'Find the item that doesn''t belong in each group, and explain why.',    15, 'odd_one_out_4',              N'Little Scholars Hub Team'),
(7, 5, N'Code Breaker: Simple Cipher',    N'Use A=1, B=2, C=3... to decode and encode secret messages.',            15, 'code_breaker_cipher',        N'Little Scholars Hub Team'),

-- manners: 2 -> 3 across TK/K/1st (weakest subject overall, chipping away)
(9, 0, N'Good Manners Checklist',         N'Check off each good manner as you practice it today.',                  10, 'good_manners_checklist_tk',  N'Little Scholars Hub Team'),
(9, 1, N'Sharing & Taking Turns',         N'Learn and practice how to share and take turns kindly.',                15, 'sharing_taking_turns',       N'Little Scholars Hub Team'),
(9, 2, N'Saying Sorry the Right Way',     N'Learn the 3 parts of a real apology, then practice writing one.',       15, 'saying_sorry_right_way',     N'Little Scholars Hub Team');
GO
