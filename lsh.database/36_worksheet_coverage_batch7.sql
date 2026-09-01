-- 36_worksheet_coverage_batch7.sql
-- Seventh batch toward "at least 5 worksheets per subject per grade". See
-- 30_worksheet_coverage_batch1.sql for the full initiative description.
-- pdf_generator_key values correspond to functions added under
-- "Coverage batch 7" in services/worksheet_pdf_generator.py.
--
-- Closes the last 5 combos batch 4 brought to 2/5, fully to 5/5:
--   science/4th, science/6th, writing/4th, writing/5th, writing/6th
-- This finishes off every combo batch 4 touched -- science and writing
-- are now fully closed EXCEPT science/2nd, science/5th, writing/3rd,
-- which are still at 1/5 (the pre-existing "game" content_type item, see
-- 33_worksheet_coverage_batch4.sql for context on that separate pilot).
--
-- Still short after this batch: the ~42 combos at 2/5 across art, feelings,
-- logic, manners, math, phonics, reading, story (minus the 8 batch 5
-- closed), and science/2nd, science/5th, writing/3rd at 1/5.

INSERT INTO dbo.Worksheets (subject_id, grade_id, title, description, estimated_min, pdf_generator_key, teacher_name)
VALUES
-- science/4th (subject_id=19, grade_id=5): 2 -> 5
(19, 5, N'Ecosystems Vocabulary',       N'Match each ecosystem term to its definition.',                         10, 'ecosystems_intro_4',            N'Little Scholars Hub Team'),
(19, 5, N'Layers of the Earth',         N'Learn the four layers of the Earth, from crust to core.',              15, 'earth_layers_4',                N'Little Scholars Hub Team'),
(19, 5, N'Magnets & Forces',            N'Test what you know about how magnets attract and repel.',              10, 'magnets_and_forces_4',          N'Little Scholars Hub Team'),

-- science/6th (subject_id=19, grade_id=7): 2 -> 5
(19, 7, N'Human Body Systems',          N'Match each body system to its job.',                                   10, 'human_body_systems_6',          N'Little Scholars Hub Team'),
(19, 7, N'Newton''s Three Laws of Motion', N'Learn the three basic laws that explain how objects move.',        15, 'newtons_laws_intro_6',          N'Little Scholars Hub Team'),
(19, 7, N'Energy Pyramid',              N'Learn how energy flows and decreases through an ecosystem.',           15, 'ecosystem_energy_pyramid_6',    N'Little Scholars Hub Team'),

-- writing/4th (subject_id=18, grade_id=5): 2 -> 5
(18, 5, N'Compare & Contrast Writing',  N'Practice comparing two things using signal words.',                    15, 'compare_contrast_writing_4',    N'Little Scholars Hub Team'),
(18, 5, N'Strong Story Openings',       N'Practice three ways to hook a reader in your first sentence.',         10, 'strong_openings_4',             N'Little Scholars Hub Team'),
(18, 5, N'Editing Marks Practice',      N'Learn basic proofreading marks, then use them to fix a sentence.',     10, 'editing_marks_practice_4',      N'Little Scholars Hub Team'),

-- writing/5th (subject_id=18, grade_id=6): 2 -> 5
(18, 6, N'Writing Dialogue',            N'Learn the punctuation rules for writing conversation between characters.', 10, 'writing_dialogue_5',        N'Little Scholars Hub Team'),
(18, 6, N'Sensory Details',             N'Practice using your five senses to write vivid descriptions.',         10, 'sensory_details_5',             N'Little Scholars Hub Team'),
(18, 6, N'Thesis Statement Practice',   N'Learn what makes a strong thesis statement, then write your own.',     10, 'thesis_statement_practice_5',   N'Little Scholars Hub Team'),

-- writing/6th (subject_id=18, grade_id=7): 2 -> 5
(18, 7, N'Five-Paragraph Essay Structure', N'Learn the five parts of a classic essay outline.',                  15, 'essay_structure_recap_6',       N'Little Scholars Hub Team'),
(18, 7, N'Active vs. Passive Voice',    N'Practice identifying and rewriting passive-voice sentences.',          10, 'active_vs_passive_voice_6',     N'Little Scholars Hub Team'),
(18, 7, N'Citing Evidence',             N'Practice supporting a claim about a text with specific evidence.',     10, 'citing_evidence_6',             N'Little Scholars Hub Team');
