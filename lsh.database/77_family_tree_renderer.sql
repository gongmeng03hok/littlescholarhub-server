-- 77_family_tree_renderer.sql
--
-- Point the three family worksheets at the family_tree renderer.
--
-- Worksheets.content_data is what actually decides how a printable is drawn:
--
--     {"renderer": "draw_your_own", "params": {...}}
--
-- and routes/content.py short-circuits on it, so the Python generator for
-- this key was never reached. Rewriting that generator changed nothing on the
-- live site. 299 published rows render from content_data - it is the main
-- path, not a special case.
--
-- draw_your_own produces a dashed rectangle with a dashed ellipse in it, which
-- is what a child asked to draw their family was given. family_tree draws real
-- family-member outlines arranged as a tree, and bands its layout by grade.

SET NOCOUNT ON;

UPDATE dbo.Worksheets
   SET content_data = N'{"renderer": "family_tree", "params": {}}'
 WHERE worksheet_id IN (210, 482, 483);

PRINT 'family worksheets repointed: ' + CAST(@@ROWCOUNT AS NVARCHAR(8));
