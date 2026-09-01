-- 40_worksheet_coverage_batch11.sql
-- Eleventh batch toward "at least 5 worksheets per subject per grade". See
-- 30_worksheet_coverage_batch1.sql for the full initiative description.
-- pdf_generator_key values correspond to functions added under
-- "Coverage batch 11" in services/worksheet_pdf_generator.py.
--
-- Closes every remaining 2/5 combo (12 of them) fully to 5/5:
--   art/5th, feelings/K, feelings/3rd, feelings/1st, logic/2nd, logic/6th,
--   manners/5th, manners/3rd, math/3rd, reading/3rd, reading/1st,
--   reading/4th
-- After this batch, only science/2nd, science/5th, writing/3rd remain
-- below 5 (all at 1/5 -- see 33_worksheet_coverage_batch4.sql for context
-- on the pre-existing "game" content_type item there).

INSERT INTO dbo.Worksheets (subject_id, grade_id, title, description, estimated_min, pdf_generator_key, teacher_name)
VALUES
-- art/5th (subject_id=4, grade_id=6): 2 -> 5
(4, 6, N'Landscape Layers',             N'Learn how foreground, middle ground, and background create depth.',   15, 'landscape_layers_5',            N'Little Scholars Hub Team'),
(4, 6, N'Proportion & Scale',           N'Learn how artists use proportion to make drawings look realistic.',    15, 'proportion_and_scale_5',        N'Little Scholars Hub Team'),
(4, 6, N'Printmaking Basics',           N'Learn the basics of stamping and repeating a design to create a print.', 10, 'printmaking_basics_5',        N'Little Scholars Hub Team'),

-- feelings/K (subject_id=8, grade_id=1): 2 -> 5
(8, 1, N'My Calm-Down Toolkit',         N'Check off calming strategies you can try when you feel upset.',        10, 'calm_down_toolkit_k',           N'Little Scholars Hub Team'),
(8, 1, N'Feelings and Faces',           N'Match each face description to the feeling word.',                     10, 'feelings_and_faces_k',          N'Little Scholars Hub Team'),
(8, 1, N'Kind Words I Can Say',         N'Learn kind phrases to say to help a friend feel better.',              10, 'kind_words_i_can_say_k',        N'Little Scholars Hub Team'),

-- feelings/3rd (subject_id=8, grade_id=4): 2 -> 5
(8, 4, N'Feelings Journal Prompts',     N'Practice writing about your feelings using guided prompts.',           10, 'feelings_journal_prompts_3',    N'Little Scholars Hub Team'),
(8, 4, N'Feeling Word Upgrade',         N'Practice choosing a more specific word instead of a basic feeling word.', 10, 'feeling_word_upgrade_3',     N'Little Scholars Hub Team'),
(8, 4, N'Problem Size & Reaction Size', N'Practice matching the size of your reaction to the size of the problem.', 10, 'problem_size_and_reaction_3', N'Little Scholars Hub Team'),

-- feelings/1st (subject_id=8, grade_id=2): 2 -> 5
(8, 2, N'Feelings Have Names',          N'Match each feeling word to what it means.',                            10, 'feelings_have_names_1',         N'Little Scholars Hub Team'),
(8, 2, N'What Makes Me Feel...',        N'Reflect on what causes different feelings for you.',                   10, 'what_makes_me_feel_1',          N'Little Scholars Hub Team'),
(8, 2, N'Calm-Down Choices',            N'Check off the calming strategies you know how to use.',                10, 'calm_down_choices_1',           N'Little Scholars Hub Team'),

-- logic/2nd (subject_id=7, grade_id=3): 2 -> 5
(7, 3, N'Logic Grid: Pet Pals',         N'Use the clues to figure out which friend owns which pet.',             15, 'logic_grid_simple_2',           N'Little Scholars Hub Team'),
(7, 3, N'Guess My Number',              N'Use number clues to figure out the mystery number.',                   10, 'guess_my_number_2',             N'Little Scholars Hub Team'),
(7, 3, N'True for All, or Just Some?',  N'Practice telling the difference between always-true and sometimes-true statements.', 10, 'true_for_all_or_some_2', N'Little Scholars Hub Team'),

-- logic/6th (subject_id=7, grade_id=7): 2 -> 5
(7, 7, N'Deductive Reasoning',          N'Practice drawing certain conclusions from two true facts.',            10, 'deductive_reasoning_6',         N'Little Scholars Hub Team'),
(7, 7, N'Logical Fallacies Intro',      N'Learn to spot flawed reasoning in arguments.',                         15, 'logical_fallacies_intro_6',     N'Little Scholars Hub Team'),
(7, 7, N'Advanced Logic Grid: Race Results', N'Use the clues to figure out the exact finishing order of four teams.', 15, 'advanced_logic_grid_6',   N'Little Scholars Hub Team'),

-- manners/5th (subject_id=9, grade_id=6): 2 -> 5
(9, 6, N'Manners During a Conflict',    N'Learn how to stay respectful even when you disagree with someone.',    10, 'conflict_manners_5',            N'Little Scholars Hub Team'),
(9, 6, N'Manners with Technology',      N'Learn polite habits for phones, group chats, and online gaming.',      10, 'manners_with_technology_5',     N'Little Scholars Hub Team'),
(9, 6, N'Including Others',             N'Practice noticing when someone feels left out, and including them.',  10, 'including_others_5',            N'Little Scholars Hub Team'),

-- manners/3rd (subject_id=9, grade_id=4): 2 -> 5
(9, 4, N'Classroom Manners',            N'Check off each classroom manner as you practice it.',                  10, 'classroom_manners_3',           N'Little Scholars Hub Team'),
(9, 4, N'Borrowing & Returning Politely', N'Learn the polite steps for borrowing something from someone.',      10, 'borrowing_and_returning_3',     N'Little Scholars Hub Team'),
(9, 4, N'Manners with Siblings',        N'Practice respectful habits for sharing space and things at home.',     10, 'manners_with_siblings_3',       N'Little Scholars Hub Team'),

-- math/3rd (subject_id=3, grade_id=4): 2 -> 5
(3, 4, N'Area & Perimeter',             N'Practice finding the area and perimeter of a rectangle.',              15, 'area_and_perimeter_3',          N'Little Scholars Hub Team'),
(3, 4, N'Division Basics',              N'Divide each number evenly.',                                           10, 'division_intro_3',              N'Little Scholars Hub Team'),
(3, 4, N'Telling Time to the Minute',   N'Practice reading a clock and calculating elapsed time.',                15, 'telling_time_to_the_minute_3',  N'Little Scholars Hub Team'),

-- reading/3rd (subject_id=2, grade_id=4): 2 -> 5
(2, 4, N'Making Inferences',            N'Practice using clues to make a smart guess about what''s happening.',  15, 'making_inferences_3',           N'Little Scholars Hub Team'),
(2, 4, N'Summarizing a Story',          N'Practice retelling a story''s most important parts in just a few sentences.', 15, 'summarizing_a_story_3',   N'Little Scholars Hub Team'),
(2, 4, N'Nonfiction Text Features',     N'Match each text feature to what it does.',                             10, 'text_features_nonfiction_3',    N'Little Scholars Hub Team'),

-- reading/1st (subject_id=2, grade_id=2): 2 -> 5
(2, 2, N'Beginning, Middle, End',       N'Practice breaking a story into its three main parts.',                 10, 'beginning_middle_end_1',        N'Little Scholars Hub Team'),
(2, 2, N'Predicting What Happens Next', N'Practice guessing what will happen next in a story, using clues.',     10, 'predicting_what_happens_next_1', N'Little Scholars Hub Team'),
(2, 2, N'Who, What, Where?',            N'Practice answering simple questions about a short passage.',           10, 'who_what_where_1',              N'Little Scholars Hub Team'),

-- reading/4th (subject_id=2, grade_id=5): 2 -> 5
(2, 5, N'Theme vs. Topic',              N'Practice telling the difference between a story''s topic and its theme.', 10, 'theme_vs_topic_4',            N'Little Scholars Hub Team'),
(2, 5, N'Comparing Two Texts',          N'Practice comparing and contrasting two different texts on a similar topic.', 15, 'comparing_two_texts_4',    N'Little Scholars Hub Team'),
(2, 5, N'Author''s Word Choice',        N'Practice noticing how specific word choices affect a reader''s imagination.', 15, 'authors_word_choice_4',   N'Little Scholars Hub Team');
