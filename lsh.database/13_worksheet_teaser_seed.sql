-- ============================================================
--  Little Scholars Hub — Migration 013
--  Fixes double-encoded UTF-8 em-dashes from migration 011,
--  and fleshes out the sample worksheet library so every grade
--  (TK through 6th) has a real, varied set for the landing page
--  "Sample worksheets" teaser section.
--  Run AFTER 11_content_library.sql.
-- ============================================================

USE LittleScholarHub;
GO

-- ─── 1. Fix mangled em-dashes from the original (non-Unicode) INSERTs ──
UPDATE dbo.Worksheets
   SET description = N'Mother''s Day coloring page — color the garden flower.'
 WHERE title = N'Color the Garden Flower';
GO

UPDATE dbo.Worksheets
   SET description = N'End-of-year SEL workbook — read the scenario, choose the kind response.'
 WHERE title = N'Empathy Scenarios';
GO

-- ─── 2. Flesh out the library across every grade ───────────────────────
-- subject_id map: 1 phonics · 2 reading · 3 math · 4 art · 5 story · 6 workbooks
--                 7 logic · 9 manners · 10 pinyin · 12 tangshi · 14 letras
-- grade_id map:   0 TK · 1 K · 2 1st · 3 2nd · 4 3rd · 5 4th · 6 5th · 7 6th
-- difficulty_id:  1 warm-up · 2 on-level · 3 challenge

IF NOT EXISTS (SELECT 1 FROM dbo.Worksheets WHERE title = N'Trace Letters A–Z')
INSERT INTO dbo.Worksheets
  (subject_id, grade_id, language_id, difficulty_id, content_type, interest_tag,
   title, description, estimated_min, page_count, view_count, rating_avg, rating_count,
   social_badge, is_trending, teacher_name)
VALUES
  -- TK (grade_id 0)
  (1, 0, 1, 1, 'worksheet', NULL,
   N'Trace Letters A–Z', N'Dashed-guide letter tracing for little hands, one letter per line.',
   10, NULL, 184000, 4.9, 1240, 'tiktok', 1, N'Ms. Rivera'),
  (3, 0, 1, 1, 'worksheet', NULL,
   N'Trace Numbers 1–10', N'Dashed-guide number tracing paired with counting dots.',
   10, NULL, 151000, 4.9, 980, 'teachers', 1, N'Mrs. Kim'),
  (1, 0, 1, 1, 'worksheet', NULL,
   N'Beginning Sounds: S, M, T', N'Circle the picture that starts with the target sound.',
   10, NULL, 76000, 4.8, 410, NULL, 0, N'Ms. Rivera'),
  (5, 0, 1, 1, 'mini_book', 'animals',
   N'My First Numbers Mini-Book', N'An 8-page foldable counting book — 1 through 10 on the family farm.',
   10, 8, 33000, 4.8, 260, NULL, 0, N'Mrs. Kim'),

  -- K (grade_id 1)
  (3, 1, 1, 2, 'worksheet', NULL,
   N'1-Minute Math: Addition to 10', N'Timed fluency drill — add within 10, beat the clock.',
   5, NULL, 312000, 4.9, 2100, 'teachers', 1, N'Mrs. Patel'),
  (1, 1, 1, 2, 'worksheet', NULL,
   N'Sight Words Set 1', N'The, a, I, is, it — trace, read, and write each word twice.',
   10, NULL, 287000, 5.0, 1890, 'teachers', 1, N'Mr. Chen'),
  (4, 1, 1, 1, 'coloring', 'ocean',
   N'Color the Friendly Shark', N'A warm-up ocean coloring page — no wrong colors here.',
   10, 2, 84000, 4.9, 560, 'instagram', 1, N'Ms. Rivera'),
  (2, 1, 1, 2, 'worksheet', 'animals',
   N'Decodable: Sam the Cat', N'A short-a decodable reader with 3 comprehension questions.',
   10, NULL, 94000, 4.9, 640, NULL, 1, N'Mrs. Kim'),
  (10, 1, 1, 2, 'worksheet', NULL,
   N'Pinyin: Four Tones Drill', N'Practice mā má mǎ mà — same letters, four meanings.',
   10, NULL, 52000, 4.9, 310, NULL, 1, N'老师 Wang'),

  -- 1st (grade_id 2)
  (1, 2, 1, 2, 'worksheet', NULL,
   N'Sight Words Set 2', N'And, for, not, with, they — trace, read, and write each word twice.',
   10, NULL, 218000, 4.9, 1420, 'teachers', 1, N'Mr. Chen'),
  (4, 2, 1, 1, 'coloring', 'vehicles',
   N'Color the Race Car', N'A speedy warm-up coloring page for car-loving kids.',
   10, 2, 44000, 4.8, 290, NULL, 0, N'Ms. Rivera'),
  (5, 2, 1, 2, 'mini_book', 'holidays',
   N'Mini-Book: My Family''s Story', N'An 8-page fill-in-the-blank keepsake book about your family.',
   15, 8, 31000, 5.0, 210, 'instagram', 1, N'Mrs. Kim'),
  (12, 2, 1, 3, 'worksheet', NULL,
   N'Tang Shi: 静夜思 (Li Bai)', N'Trace and recite the classic "Quiet Night Thoughts" — pinyin + English included.',
   15, NULL, 29000, 5.0, 180, NULL, 1, N'老师 Wang'),
  (3, 2, 1, 2, 'worksheet', NULL,
   N'Number Bonds to 20', N'Fill in the missing partner — two numbers that always add to 20.',
   10, NULL, 156000, 4.9, 1020, 'teachers', 1, N'Mrs. Patel'),

  -- 2nd (grade_id 3)
  (3, 3, 1, 2, 'worksheet', NULL,
   N'1-Minute Math: Subtraction', N'Timed fluency drill — subtract within 20, beat the clock.',
   5, NULL, 274000, 4.9, 1780, 'teachers', 1, N'Mrs. Patel'),
  (6, 3, 1, 2, 'worksheet', NULL,
   N'Cursive A–Z Trace', N'Dashed-guide cursive practice for every letter of the alphabet.',
   15, NULL, 127000, 4.9, 860, 'instagram', 1, N'Ms. Rivera'),
  (4, 3, 1, 2, 'coloring', 'fantasy',
   N'Color the Fairy-Tale Castle', N'A detailed castle scene for kids who love to fill in every corner.',
   15, 2, 53000, 4.9, 360, 'instagram', 1, N'Ms. Rivera'),
  (4, 3, 1, 2, 'worksheet', NULL,
   N'Rangoli Geometry', N'Symmetrical dot-grid patterns inspired by Indian rangoli art.',
   15, NULL, 37000, 4.9, 240, 'instagram', 1, N'Priya Auntie'),
  (8, 3, 1, 2, 'worksheet', NULL,
   N'Calm-Down Cards', N'Six printable cards with a different calming strategy on each.',
   10, NULL, 92000, 4.9, 610, NULL, 1, N'Mr. Chen'),

  -- 3rd (grade_id 4)
  (3, 4, 1, 2, 'worksheet', NULL,
   N'1-Minute Math: Multiplication', N'Timed fluency drill — multiplication facts 1 through 10.',
   5, NULL, 498000, 4.9, 3200, 'teachers', 1, N'Mrs. Patel'),
  (6, 4, 1, 2, 'worksheet', NULL,
   N'Cursive Letter Pack', N'Joined-up cursive practice sheet, lowercase and uppercase.',
   15, NULL, 187000, 4.9, 1240, 'instagram', 1, N'Ms. Rivera'),
  (4, 4, 1, 2, 'coloring', 'nature',
   N'Color a Garden Mandala', N'A calming symmetrical mandala with a garden theme.',
   15, 2, 47000, 4.9, 320, NULL, 1, N'Ms. Rivera'),
  (14, 4, 1, 2, 'mini_book', 'holidays',
   N'Mini-Book: La Flor de Nochebuena', N'A bilingual Spanish/English mini-book for Día de los Muertos season.',
   15, 8, 22000, 4.9, 150, NULL, 1, N'Sra. Gomez'),
  (7, 4, 1, 2, 'worksheet', 'sports',
   N'Chess Mini-Lesson: Pawns', N'Learn how pawns move and capture, then solve one mini puzzle.',
   15, NULL, 62000, 4.9, 410, 'instagram', 1, N'Mr. Chen'),

  -- 4th (grade_id 5)
  (3, 5, 1, 2, 'worksheet', NULL,
   N'Long Multiplication Drill', N'Two-digit by two-digit multiplication with a worked example.',
   20, NULL, 228000, 4.9, 1490, NULL, 1, N'Mrs. Patel'),
  (6, 5, 1, 2, 'worksheet', NULL,
   N'Persuasive Essay Frame', N'Hook, claim, two reasons, counter-argument, and a closing line.',
   20, NULL, 108000, 4.9, 710, NULL, 1, N'Mr. Chen'),
  (4, 5, 1, 2, 'worksheet', 'holidays',
   N'Papel Picado Craft', N'Fold-and-cut instructions for a traditional Mexican paper banner.',
   20, NULL, 52000, 4.9, 340, 'instagram', 1, N'Sra. Gomez'),
  (7, 5, 1, 3, 'worksheet', 'animals',
   N'Logic Grid: Who Owns Which Pet?', N'Use the clues to fill in the grid and solve the puzzle.',
   15, NULL, 67000, 4.9, 440, 'instagram', 1, N'Mrs. Kim'),

  -- 5th (grade_id 6)
  (3, 6, 1, 2, 'worksheet', NULL,
   N'Long Division Mastery', N'Step-by-step long division with a worked example at the top.',
   20, NULL, 187000, 4.9, 1230, NULL, 1, N'Mrs. Patel'),
  (2, 6, 1, 2, 'worksheet', NULL,
   N'Theme & Tone Reading Pack', N'A short passage plus theme and tone comprehension questions.',
   15, NULL, 97000, 4.9, 640, NULL, 1, N'Mr. Chen'),
  (7, 6, 1, 2, 'worksheet', NULL,
   N'Sudoku 6×6', N'A gentle 6×6 introduction to sudoku logic for upper-elementary kids.',
   15, NULL, 48000, 4.8, 310, 'instagram', 1, N'Mrs. Kim'),
  (4, 6, 1, 2, 'worksheet', NULL,
   N'One-Point Perspective', N'Learn to draw a road, building, or tunnel using a single vanishing point.',
   20, NULL, 44000, 4.9, 290, 'instagram', 1, N'Ms. Rivera'),

  -- 6th (grade_id 7) — previously empty
  (3, 7, 1, 3, 'worksheet', NULL,
   N'Pre-Algebra: Variables', N'Solve for x in one- and two-step equations.',
   20, NULL, 156000, 4.9, 1030, NULL, 1, N'Mrs. Patel'),
  (6, 7, 1, 3, 'worksheet', NULL,
   N'Argument Essay Frame', N'Claim, two pieces of evidence, counter-claim, rebuttal, conclusion.',
   25, NULL, 94000, 4.9, 620, NULL, 1, N'Mr. Chen'),
  (3, 7, 1, 3, 'worksheet', NULL,
   N'Ratios & Proportions', N'Word problems solved with ratio tables and cross-multiplication.',
   20, NULL, 118000, 4.9, 780, NULL, 1, N'Mrs. Patel'),
  (2, 7, 1, 3, 'worksheet', NULL,
   N'Greek & Latin Roots', N'Match 8 common roots to their meaning, then build a new word with each.',
   15, NULL, 82000, 4.9, 540, NULL, 1, N'Mr. Chen'),
  (12, 7, 1, 3, 'worksheet', NULL,
   N'Tang Shi Capstone: Recite 20 Poems', N'A tracking sheet for the 20-poem Tang poetry recitation capstone.',
   20, NULL, 16000, 5.0, 110, NULL, 1, N'老师 Wang');
GO

PRINT 'Sample worksheet library seeded across all grades';
GO
