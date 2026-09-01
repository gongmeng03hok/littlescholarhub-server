-- 33_worksheet_coverage_batch4.sql
-- Fourth batch toward "at least 5 worksheets per subject per grade". See
-- 30_worksheet_coverage_batch1.sql for the full initiative description and
-- 32_worksheet_coverage_batch3.sql for how the grid grew from 72 to 88
-- combos when the "science" (subject_id=19) and "writing" (subject_id=18)
-- subjects appeared. pdf_generator_key values correspond to functions added
-- under "Coverage batch 4" in services/worksheet_pdf_generator.py.
--
-- This batch does NOT aim to fully close any combo to 5. Instead it
-- prioritizes the worst gaps first: the 13 combos sitting at ZERO
-- worksheets (a completely empty picker tab, worse than a thin list) get
-- 2 new hand-crafted worksheets each, bringing them to 2/5. Getting every
-- one of these off zero matters more right now than fully finishing a
-- smaller number of combos. science/2nd and science/5th already have 1
-- pre-existing "game" content_type item each (not a pdf_generator_key
-- worksheet -- a separate interactive tap-game pilot, left as-is) and were
-- not touched this batch.
--
-- Targets (0 -> 2 each):
--   science:  TK, K, 1st, 3rd, 4th, 6th   (6 combos)
--   writing:  TK, K, 1st, 2nd, 4th, 5th, 6th  (7 combos)
--
-- Still short after this batch: every combo above still needs 3 more to
-- reach 5. Also untouched: the 3 combos at 1/5 (science/2nd, science/5th,
-- writing/3rd) and the ~46 combos across the original 9 subjects still at
-- 2/5. Re-run the tracking query in batch 1's file to see current state.

INSERT INTO dbo.Worksheets (subject_id, grade_id, title, description, estimated_min, pdf_generator_key, teacher_name)
VALUES
-- science/TK (subject_id=19, grade_id=0): 0 -> 2
(19, 0, N'My Five Senses',              N'Match each sense to the body part you use.',                            10, 'five_senses_match',             N'Little Scholars Hub Team'),
(19, 0, N'Living or Nonliving?',        N'Circle Living or Nonliving for each thing.',                            10, 'living_or_nonliving_tk',        N'Little Scholars Hub Team'),

-- science/K (subject_id=19, grade_id=1): 0 -> 2
(19, 1, N'The Four Seasons',            N'Match each season to how it looks and feels.',                         10, 'four_seasons_match',            N'Little Scholars Hub Team'),
(19, 1, N'What Plants Need',            N'Learn the four things every plant needs to grow.',                     10, 'what_plants_need_k',            N'Little Scholars Hub Team'),

-- science/1st (subject_id=19, grade_id=2): 0 -> 2
(19, 2, N'Solids & Liquids: True or False', N'Circle True or False for each statement about solids and liquids.', 10, 'solids_liquids_true_false_1', N'Little Scholars Hub Team'),
(19, 2, N'Day and Night',               N'Match each word to what happens at that time.',                        10, 'day_and_night_match_1',         N'Little Scholars Hub Team'),

-- science/3rd (subject_id=19, grade_id=4): 0 -> 2
(19, 4, N'Butterfly Life Cycle',        N'Learn and order the four stages of a butterfly''s life.',              15, 'butterfly_life_cycle',          N'Little Scholars Hub Team'),
(19, 4, N'Simple Machines Match-Up',    N'Match each simple machine to a real-life example.',                    10, 'simple_machines_match_3',       N'Little Scholars Hub Team'),

-- science/4th (subject_id=19, grade_id=5): 0 -> 2
(19, 5, N'Forms of Energy',             N'Match each type of energy to a real example.',                         10, 'forms_of_energy_match',         N'Little Scholars Hub Team'),
(19, 5, N'Forest Food Chain',           N'Learn how energy passes from plants to animals in a food chain.',      15, 'forest_food_chain',             N'Little Scholars Hub Team'),

-- science/6th (subject_id=19, grade_id=7): 0 -> 2
(19, 7, N'Cell Parts & Functions',      N'Match each cell part to its job.',                                     10, 'cell_parts_match_6',            N'Little Scholars Hub Team'),
(19, 7, N'Physical vs. Chemical Change', N'Sort each example as a physical change or a chemical change.',        15, 'physical_vs_chemical_change_6', N'Little Scholars Hub Team'),

-- writing/TK (subject_id=18, grade_id=0): 0 -> 2
(18, 0, N'Label the Picture',           N'Draw a picture, then write the word underneath it.',                   10, 'label_the_picture_tk',          N'Little Scholars Hub Team'),
(18, 0, N'Trace My First Words',        N'Trace each word, then write it once on your own.',                     10, 'trace_first_sight_words',       N'Little Scholars Hub Team'),

-- writing/K (subject_id=18, grade_id=1): 0 -> 2
(18, 1, N'Finish My Sentence',          N'Complete each sentence, then check your capital letter and period.',   10, 'writing_simple_sentences_k',    N'Little Scholars Hub Team'),
(18, 1, N'Capital Letters & Periods',   N'Rewrite each sentence with a capital letter and a period.',            10, 'capital_letter_period_check',   N'Little Scholars Hub Team'),

-- writing/1st (subject_id=18, grade_id=2): 0 -> 2
(18, 2, N'Statements & Questions',      N'Decide if each sentence is a statement or a question, then punctuate it.', 10, 'sentence_types_practice',    N'Little Scholars Hub Team'),
(18, 2, N'Descriptive Words',           N'Add a describing word (adjective) to make each sentence more interesting.', 10, 'descriptive_words_practice', N'Little Scholars Hub Team'),

-- writing/2nd (subject_id=18, grade_id=3): 0 -> 2
(18, 3, N'Story Elements Planner',      N'Plan your story by filling in each part.',                             15, 'story_elements_planner',        N'Little Scholars Hub Team'),
(18, 3, N'Powerful Adjectives',         N'Match each adjective to what it describes.',                           10, 'using_adjectives_2',            N'Little Scholars Hub Team'),

-- writing/4th (subject_id=18, grade_id=5): 0 -> 2
(18, 5, N'Paragraph Structure Builder', N'Build a paragraph with a topic sentence, three details, and a closing sentence.', 15, 'paragraph_structure_intro', N'Little Scholars Hub Team'),
(18, 5, N'Transition Words',            N'Match each transition word to what it signals in writing.',            10, 'transition_words_match',        N'Little Scholars Hub Team'),

-- writing/5th (subject_id=18, grade_id=6): 0 -> 2
(18, 6, N'Show, Don''t Tell',           N'Practice turning a telling sentence into a showing sentence with vivid details.', 15, 'show_dont_tell_practice', N'Little Scholars Hub Team'),
(18, 6, N'Strong Verb Swap',            N'Match each overused word to stronger, more specific choices.',         10, 'strong_verbs_swap',             N'Little Scholars Hub Team'),

-- writing/6th (subject_id=18, grade_id=7): 0 -> 2
(18, 7, N'The Writing Process',         N'Learn the five steps every writer uses, from first idea to final draft.', 10, 'writing_process_steps',       N'Little Scholars Hub Team'),
(18, 7, N'Figurative Language Match-Up', N'Match each figurative-language term to an example.',                  10, 'figurative_language_id',        N'Little Scholars Hub Team');
