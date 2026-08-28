-- 51_grade_order_tk_before_k.sql
-- Restores the grade picker order to TK, K, 1st … 6th.
--
-- Supersedes the last two statements of 29_classroom_grade.sql, which set
-- K before TK ("the school's convention"). TK (Transitional Kindergarten) is
-- the year *before* Kindergarten, so listing K first put the youngest band in
-- second place on the public "Peek inside — pick a grade" picker and in the
-- teacher classroom picker. Product owner's call: TK leads.
--
-- This matches what every other layer already assumed: the API fallback
-- STATIC_GRADES in routes/content.py, the frontend fallback GRADES in
-- constants/theme.ts, and the original 02_seed.sql all order TK first — only
-- the live DB row drifted.
--
-- Idempotent: safe to re-run, and safe if 29 is ever re-applied after this.

UPDATE dbo.Grades SET sort_order = 0 WHERE grade_id = 0;  -- TK
UPDATE dbo.Grades SET sort_order = 1 WHERE grade_id = 1;  -- K
GO

-- Remaining grades keep their existing positions (1st=2 … 6th=7); assert the
-- full ordering so a future edit that renumbers one row shows up here.
UPDATE dbo.Grades SET sort_order = 2 WHERE grade_id = 2;  -- 1st
UPDATE dbo.Grades SET sort_order = 3 WHERE grade_id = 3;  -- 2nd
UPDATE dbo.Grades SET sort_order = 4 WHERE grade_id = 4;  -- 3rd
UPDATE dbo.Grades SET sort_order = 5 WHERE grade_id = 5;  -- 4th
UPDATE dbo.Grades SET sort_order = 6 WHERE grade_id = 6;  -- 5th
UPDATE dbo.Grades SET sort_order = 7 WHERE grade_id = 7;  -- 6th
GO

SELECT grade_id, label, sort_order FROM dbo.Grades ORDER BY sort_order;
GO
