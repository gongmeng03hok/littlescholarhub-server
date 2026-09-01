-- 34_worksheet_coverage_batch5.sql
-- Fifth batch toward "at least 5 worksheets per subject per grade". See
-- 30_worksheet_coverage_batch1.sql for the full initiative description and
-- the tracking query. pdf_generator_key values correspond to functions
-- added under "Coverage batch 5" in services/worksheet_pdf_generator.py.
--
-- Unlike batch 4 (which spread 2 worksheets each across 13 zero-coverage
-- combos for breadth), this batch fully closes 8 combos from 2/5 to 5/5,
-- picked across 8 different subjects for balanced progress:
--   art/4th, feelings/5th, logic/TK, manners/6th, math/4th, phonics/3rd,
--   reading/2nd, story/6th

INSERT INTO dbo.Worksheets (subject_id, grade_id, title, description, estimated_min, pdf_generator_key, teacher_name)
VALUES
-- art/4th (subject_id=4, grade_id=5): 2 -> 5
(4, 5, N'Color Wheel Basics',           N'Learn primary and secondary colors, then color the wheel.',            15, 'color_wheel_basics',              N'Little Scholars Hub Team'),
(4, 5, N'Symmetry Art: Mirror Wings',   N'Draw a design on one side, then mirror it exactly on the other.',      15, 'symmetry_line_art',               N'Little Scholars Hub Team'),
(4, 5, N'Shading Techniques',           N'Learn four ways artists use pencil marks to show light and shadow.',   15, 'shading_techniques_practice',     N'Little Scholars Hub Team'),

-- feelings/5th (subject_id=8, grade_id=6): 2 -> 5
(8, 6, N'Conflict Resolution Steps',    N'Learn four steps to solve a disagreement calmly and fairly.',          10, 'conflict_resolution_steps',       N'Little Scholars Hub Team'),
(8, 6, N'Understanding My Triggers',    N'Reflect on what sets off strong feelings, and plan ahead.',            10, 'emotional_triggers_reflection',   N'Little Scholars Hub Team'),
(8, 6, N'Seeing Both Sides',            N'Practice understanding a situation from two different perspectives.',  10, 'empathy_perspective_taking_5',    N'Little Scholars Hub Team'),

-- logic/TK (subject_id=7, grade_id=0): 2 -> 5
(7, 0, N'Same or Different?',           N'Look at each pair and decide if they are the same or different.',      10, 'same_or_different_tk',            N'Little Scholars Hub Team'),
(7, 0, N'What Comes Next?',             N'Look at the pattern, then say what comes next.',                       10, 'what_comes_next_tk',              N'Little Scholars Hub Team'),
(7, 0, N'Which One is Different?',      N'Look at each group and find the one that does not match.',            10, 'which_one_is_different_tk',       N'Little Scholars Hub Team'),

-- manners/6th (subject_id=9, grade_id=7): 2 -> 5
(9, 7, N'Digital Manners',              N'Learn how good manners apply to texting, gaming, and social media.',   10, 'digital_manners_6',               N'Little Scholars Hub Team'),
(9, 7, N'Respectful Disagreement',      N'Learn how to disagree with someone while staying kind and respectful.', 10, 'respectful_disagreement_6',      N'Little Scholars Hub Team'),
(9, 7, N'Respecting Different Cultures', N'Practice showing respect for customs and traditions different from your own.', 10, 'cultural_respect_manners_6', N'Little Scholars Hub Team'),

-- math/4th (subject_id=3, grade_id=5): 2 -> 5
(3, 5, N'Factors & Multiples',          N'Practice finding factors and multiples of numbers.',                   15, 'factors_and_multiples_4',         N'Little Scholars Hub Team'),
(3, 5, N'Fraction Basics',              N'Learn what a fraction means, then compare and simplify.',              15, 'fraction_basics_4',               N'Little Scholars Hub Team'),
(3, 5, N'Multiplication Word Problems', N'Multiply carefully to solve each real-world problem.',                 15, 'multi_digit_multiplication_word_problems_4', N'Little Scholars Hub Team'),

-- phonics/3rd (subject_id=1, grade_id=4): 2 -> 5
(1, 4, N'R-Controlled Vowels',          N'Match each r-controlled vowel pattern to its sound example.',          10, 'r_controlled_vowels_3',           N'Little Scholars Hub Team'),
(1, 4, N'Prefixes & Suffixes',          N'Match each word part to what it means.',                               10, 'prefixes_suffixes_3',             N'Little Scholars Hub Team'),
(1, 4, N'Compound Words & Contractions', N'Build compound words, then shorten phrases into contractions.',       10, 'compound_words_contractions_3',   N'Little Scholars Hub Team'),

-- reading/2nd (subject_id=2, grade_id=3): 2 -> 5
(2, 3, N'Context Clues',                N'Use clues in the sentence to guess what each bolded word means.',      10, 'context_clues_2',                 N'Little Scholars Hub Team'),
(2, 3, N'Fact or Opinion?',             N'Decide whether each sentence is a fact or an opinion.',                10, 'fact_or_opinion_2',               N'Little Scholars Hub Team'),
(2, 3, N'Story Sequencing',             N'Practice putting story events in the correct order.',                  10, 'story_sequencing_2',              N'Little Scholars Hub Team'),

-- story/6th (subject_id=5, grade_id=7): 2 -> 5
(5, 7, N'Plot Diagram Planner',         N'Plan a story using all five parts of a classic plot diagram.',         15, 'plot_diagram_6',                  N'Little Scholars Hub Team'),
(5, 7, N'Character Motivation',         N'Explore what drives a character''s actions in a story.',               15, 'character_motivation_6',          N'Little Scholars Hub Team'),
(5, 7, N'Write a Plot Twist',           N'Practice creating surprising, satisfying plot twists.',                15, 'write_a_plot_twist_6',            N'Little Scholars Hub Team');
