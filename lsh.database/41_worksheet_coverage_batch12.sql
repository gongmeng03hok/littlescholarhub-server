-- 41_worksheet_coverage_batch12.sql
-- Twelfth and FINAL batch of the "at least 5 worksheets per subject per
-- grade" initiative. See 30_worksheet_coverage_batch1.sql for the full
-- description. pdf_generator_key values correspond to functions added
-- under "Coverage batch 12 (final)" in services/worksheet_pdf_generator.py.
--
-- Closes the last 3 stragglers, each from 1/5 to 5/5:
--   science/2nd, science/5th, writing/3rd
-- Each previously had only a single pre-existing "game" content_type item
-- (see 33_worksheet_coverage_batch4.sql for context on that separate
-- interactive-game pilot from 2026-08-08, left untouched throughout this
-- initiative). This batch adds 4 ordinary hand-crafted PDF worksheets to
-- each, bringing all 88 of 88 tracked (subject, grade) combinations to
-- 5+ worksheets for the first time.

INSERT INTO dbo.Worksheets (subject_id, grade_id, title, description, estimated_min, pdf_generator_key, teacher_name)
VALUES
-- science/2nd (subject_id=19, grade_id=3): 1 -> 5
(19, 3, N'Life Cycle of a Frog',        N'Learn and order the four stages of a frog''s life.',                   15, 'life_cycle_of_a_frog_2',        N'Little Scholars Hub Team'),
(19, 3, N'Magnets: Push and Pull',      N'Learn how magnets attract and repel objects.',                         10, 'magnet_push_pull_2',            N'Little Scholars Hub Team'),
(19, 3, N'Weather Tools',               N'Match each weather tool to what it does.',                             10, 'weather_tools_2',               N'Little Scholars Hub Team'),
(19, 3, N'Animal Groups',               N'Learn about three groups of animals: mammals, birds, and fish.',       10, 'animal_groups_2',               N'Little Scholars Hub Team'),

-- science/5th (subject_id=19, grade_id=6): 1 -> 5
(19, 6, N'States of Matter: How Particles Move', N'Learn how particle movement explains solids, liquids, and gases.', 15, 'states_of_matter_particles_5', N'Little Scholars Hub Team'),
(19, 6, N'Photosynthesis',              N'Learn how plants make their own food using sunlight, water, and air.', 10, 'photosynthesis_5',              N'Little Scholars Hub Team'),
(19, 6, N'Simple Circuits',             N'Learn how a complete circuit lets electricity flow to power a light.', 15, 'simple_circuits_5',             N'Little Scholars Hub Team'),
(19, 6, N'Weathering & Erosion',        N'Match each Earth-science term to its definition.',                     10, 'weathering_and_erosion_5',      N'Little Scholars Hub Team'),

-- writing/3rd (subject_id=18, grade_id=4): 1 -> 5
(18, 4, N'Fixing Run-On Sentences',     N'Practice breaking run-on sentences into correct, complete sentences.', 10, 'editing_for_run_ons_3',         N'Little Scholars Hub Team'),
(18, 4, N'Writing a Book Report',       N'Practice summarizing and reviewing a book you have read.',             15, 'writing_a_book_report_3',       N'Little Scholars Hub Team'),
(18, 4, N'Stronger Word Choices',       N'Practice swapping overused adjectives for more specific ones.',        10, 'using_strong_adjectives_3',     N'Little Scholars Hub Team'),
(18, 4, N'Writing Clear Directions',    N'Practice writing step-by-step directions in the correct order.',      10, 'writing_directions_3',          N'Little Scholars Hub Team');
