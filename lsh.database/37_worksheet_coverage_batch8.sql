-- 37_worksheet_coverage_batch8.sql
-- Eighth batch toward "at least 5 worksheets per subject per grade". See
-- 30_worksheet_coverage_batch1.sql for the full initiative description.
-- pdf_generator_key values correspond to functions added under
-- "Coverage batch 8" in services/worksheet_pdf_generator.py.
--
-- IMPORTANT CORRECTION: earlier session notes (batch 6 commit message,
-- memory) incorrectly claimed "workbooks" was fully done at 5+ across all
-- 8 grades. Re-running the tracking query at the start of this batch showed
-- that was wrong -- only workbooks/2nd, 3rd, 4th were ever closed (batches
-- 1-3); TK, K, 1st, 5th, 6th were still sitting at 2/5 the whole time. This
-- batch starts fixing that.
--
-- Closes 8 combos from 2/5 to 5/5, picked across 6 different subjects:
--   workbooks/TK, workbooks/K, art/6th, feelings/TK, logic/K, manners/2nd,
--   phonics/K, story/TK

INSERT INTO dbo.Worksheets (subject_id, grade_id, title, description, estimated_min, pdf_generator_key, teacher_name)
VALUES
-- workbooks/TK (subject_id=6, grade_id=0): 2 -> 5
(6, 0, N'Trace Shape Names',            N'Trace each shape word, then write it once on your own.',               10, 'shape_tracing_tk',              N'Little Scholars Hub Team'),
(6, 0, N'Shapes & Sides',               N'Match each shape to how many sides it has.',                           10, 'matching_shapes_tk',            N'Little Scholars Hub Team'),
(6, 0, N'Following Directions',         N'Check off each direction after you follow it.',                        10, 'following_directions_tk',       N'Little Scholars Hub Team'),

-- workbooks/K (subject_id=6, grade_id=1): 2 -> 5
(6, 1, N'Number Words 1-5',             N'Match each number to how it is spelled out as a word.',                10, 'writing_numbers_words_k',       N'Little Scholars Hub Team'),
(6, 1, N'Calendar Basics',              N'Learn the days of the week and practice using a calendar.',            10, 'calendar_basics_k',             N'Little Scholars Hub Team'),
(6, 1, N'Measuring with Objects',       N'Practice measuring things using everyday objects instead of a ruler.', 10, 'measuring_with_objects_k',      N'Little Scholars Hub Team'),

-- art/6th (subject_id=4, grade_id=7): 2 -> 5
(4, 7, N'Value Scale Practice',         N'Learn how artists use light and dark values to show depth.',           15, 'value_scale_practice_6',        N'Little Scholars Hub Team'),
(4, 7, N'Rule of Thirds',               N'Learn a simple trick artists use to make a composition more interesting.', 15, 'composition_rule_of_thirds_6', N'Little Scholars Hub Team'),
(4, 7, N'Warm & Cool Colors',           N'Learn how colors create warm or cool feelings, and how to mix them.',  10, 'warm_cool_colors_6',            N'Little Scholars Hub Team'),

-- feelings/TK (subject_id=8, grade_id=0): 2 -> 5
(8, 0, N'Naming My Feelings',           N'Match each face description to the feeling word.',                     10, 'naming_basic_feelings_tk',      N'Little Scholars Hub Team'),
(8, 0, N'How Do You Feel Today?',       N'Circle the feeling you have today, then draw your own face.',          10, 'how_do_you_feel_today_tk',      N'Little Scholars Hub Team'),
(8, 0, N'Balloon Breathing',            N'Learn a simple breathing trick to help you feel calm.',                 10, 'calm_down_breathing_tk',        N'Little Scholars Hub Team'),

-- logic/K (subject_id=7, grade_id=1): 2 -> 5
(7, 1, N'Sorting by One Rule',          N'Sort a group of items into two categories.',                           10, 'sorting_by_one_rule_k',         N'Little Scholars Hub Team'),
(7, 1, N'1st, 2nd, 3rd: Ordinal Numbers', N'Practice using ordinal numbers to describe order.',                  10, 'first_second_third_k',          N'Little Scholars Hub Team'),
(7, 1, N'True or False Logic',          N'Circle True or False for each statement.',                             10, 'true_or_false_logic_k',         N'Little Scholars Hub Team'),

-- manners/2nd (subject_id=9, grade_id=3): 2 -> 5
(9, 3, N'Phone Manners',                N'Learn how to politely answer and talk on the phone.',                  10, 'phone_manners_2',               N'Little Scholars Hub Team'),
(9, 3, N'Being a Good Sport',           N'Check off each good sportsmanship habit as you practice it.',          10, 'being_a_good_sport_2',          N'Little Scholars Hub Team'),
(9, 3, N'Manners with Guests',          N'Learn how to be a polite and welcoming host.',                         10, 'manners_with_guests_2',         N'Little Scholars Hub Team'),

-- phonics/K (subject_id=1, grade_id=1): 2 -> 5
(1, 1, N'Ending Sounds',                N'Match each group of words to their shared ending sound.',              10, 'ending_sounds_k',               N'Little Scholars Hub Team'),
(1, 1, N'Rhyming Pairs',                N'Match each word to a group of words that rhyme with it.',              10, 'rhyming_pairs_k',               N'Little Scholars Hub Team'),
(1, 1, N'Short A Word Family',          N'Practice reading and writing short-a words.',                          10, 'short_a_words_k',               N'Little Scholars Hub Team'),

-- story/TK (subject_id=5, grade_id=0): 2 -> 5
(5, 0, N'Finish the Story',             N'Listen to the story starter, then imagine what happens next.',         10, 'finish_the_story_tk',           N'Little Scholars Hub Team'),
(5, 0, N'Puppet Show Story Prompts',    N'Use toys or stuffed animals to act out silly story prompts.',          10, 'puppet_show_prompts_tk',        N'Little Scholars Hub Team'),
(5, 0, N'Story Order: What Happened First?', N'Listen to a simple story, then talk about the order of events.', 10, 'story_order_pictures_tk',       N'Little Scholars Hub Team');
