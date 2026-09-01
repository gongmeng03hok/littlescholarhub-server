-- 38_worksheet_coverage_batch9.sql
-- Ninth batch toward "at least 5 worksheets per subject per grade". See
-- 30_worksheet_coverage_batch1.sql for the full initiative description.
-- pdf_generator_key values correspond to functions added under
-- "Coverage batch 9" in services/worksheet_pdf_generator.py.
--
-- Closes 8 combos from 2/5 to 5/5, picked across 6 different subjects:
--   workbooks/1st, workbooks/5th, workbooks/6th, art/3rd, feelings/6th,
--   logic/1st, manners/4th, reading/TK
-- This finishes off `workbooks` for real this time (see 37's correction
-- note) -- all 8 grades now at 5+.

INSERT INTO dbo.Worksheets (subject_id, grade_id, title, description, estimated_min, pdf_generator_key, teacher_name)
VALUES
-- workbooks/1st (subject_id=6, grade_id=2): 2 -> 5
(6, 2, N'Counting Coins',               N'Practice adding up the value of pennies, nickels, dimes, and quarters.', 10, 'counting_coins_1',            N'Little Scholars Hub Team'),
(6, 2, N'Reading a Calendar',           N'Practice answering questions about days, weeks, and dates.',            10, 'reading_a_simple_calendar_1', N'Little Scholars Hub Team'),
(6, 2, N'Two-Step Directions',          N'Practice following directions that have two steps, in order.',         10, 'two_step_directions_1',       N'Little Scholars Hub Team'),

-- workbooks/5th (subject_id=6, grade_id=6): 2 -> 5
(6, 6, N'Time Management Planner',      N'Practice planning and prioritizing your tasks for the day.',            10, 'time_management_planner_5',   N'Little Scholars Hub Team'),
(6, 6, N'Cornell Note-Taking Method',   N'Learn a structured way to take and organize notes.',                    15, 'note_taking_cornell_method_5', N'Little Scholars Hub Team'),
(6, 6, N'Percent Word Problems',        N'Find the percentage of each number.',                                   15, 'percent_word_problems_5',     N'Little Scholars Hub Team'),

-- workbooks/6th (subject_id=6, grade_id=7): 2 -> 5
(6, 7, N'Research Skills Intro',        N'Learn how to judge whether a source is reliable, and why citing sources matters.', 15, 'research_skills_intro_6', N'Little Scholars Hub Team'),
(6, 7, N'SMART Goal Setting',           N'Learn a five-part framework for setting goals you can actually reach.', 15, 'goal_setting_smart_6',        N'Little Scholars Hub Team'),
(6, 7, N'Budgeting Basics',             N'Learn the basics of income, expenses, and saving money.',               15, 'budgeting_basics_6',          N'Little Scholars Hub Team'),

-- art/3rd (subject_id=4, grade_id=4): 2 -> 5
(4, 4, N'Drawing Texture',              N'Practice using line patterns to make a drawing look rough, smooth, or bumpy.', 15, 'drawing_texture_3',      N'Little Scholars Hub Team'),
(4, 4, N'Still Life Basics',            N'Learn how to observe and draw a simple arrangement of everyday objects.', 15, 'still_life_basics_3',       N'Little Scholars Hub Team'),
(4, 4, N'Paper Collage Art',            N'Learn how to build a picture out of torn and glued paper pieces.',      15, 'paper_collage_art_3',         N'Little Scholars Hub Team'),

-- feelings/6th (subject_id=8, grade_id=7): 2 -> 5
(8, 7, N'Managing Big Emotions',        N'Practice a simple process for naming, rating, and coping with strong feelings.', 10, 'managing_big_emotions_6', N'Little Scholars Hub Team'),
(8, 7, N'Handling Peer Pressure',       N'Practice responding to situations where friends pressure you to do something.', 10, 'peer_pressure_scenarios_6', N'Little Scholars Hub Team'),
(8, 7, N'Self-Esteem Reflection',       N'Practice recognizing your strengths and reframing negative self-talk.', 10, 'self_esteem_reflection_6',    N'Little Scholars Hub Team'),

-- logic/1st (subject_id=7, grade_id=2): 2 -> 5
(7, 2, N'Sorting by Two Rules',         N'Practice sorting the same group of items two different ways.',         10, 'sorting_by_two_rules_1',      N'Little Scholars Hub Team'),
(7, 2, N'What Doesn''t Belong?',        N'Find the item that doesn''t fit with the others in each group.',       10, 'what_doesnt_belong_1',        N'Little Scholars Hub Team'),
(7, 2, N'If-Then Thinking',             N'Practice figuring out what should happen next, based on a situation.', 10, 'if_then_thinking_1',          N'Little Scholars Hub Team'),

-- manners/4th (subject_id=9, grade_id=5): 2 -> 5
(9, 5, N'Manners in Public',            N'Learn good manners for movie theaters, restaurants, and public transportation.', 10, 'manners_in_public_4',   N'Little Scholars Hub Team'),
(9, 5, N'Email & Message Etiquette',    N'Learn how to write a polite, clear message or email.',                 10, 'email_and_message_etiquette_4', N'Little Scholars Hub Team'),
(9, 5, N'Handling Mistakes Gracefully', N'Practice owning up to a mistake and making it right.',                 10, 'handling_mistakes_gracefully_4', N'Little Scholars Hub Team'),

-- reading/TK (subject_id=2, grade_id=0): 2 -> 5
(2, 0, N'Picture Walk & Prediction',    N'Practice guessing what a story is about by looking at the pictures first.', 10, 'picture_walk_prediction_tk', N'Little Scholars Hub Team'),
(2, 0, N'Parts of a Book',              N'Learn to identify the front cover, back cover, and title of a book.',  10, 'parts_of_a_book_tk',          N'Little Scholars Hub Team'),
(2, 0, N'Listening Comprehension',      N'Practice answering simple questions about a story someone reads to you.', 10, 'listening_comprehension_tk', N'Little Scholars Hub Team');
