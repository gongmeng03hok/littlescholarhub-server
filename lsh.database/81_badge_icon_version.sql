-- 81_badge_icon_version.sql
--
-- /art/*.svg is cached for 24 hours (max-age=86400), which is right for art
-- that rarely changes but means a redraw is invisible to anyone who loaded the
-- previous version that day. That is exactly what happened: the badges were
-- redrawn and deployed, the server served the new files, and the browser kept
-- showing the old ones.
--
-- Versioning the URL rather than renaming the file: the path on disk stays
-- stable, and the query string moves whenever the art does. Bump the token on
-- the next redraw.

SET NOCOUNT ON;

UPDATE dbo.Badges
   SET icon_url = N'/art/badge_' + slug + N'.svg?v=20260903b'
 WHERE icon_url IS NOT NULL;

PRINT 'badge icon_url versioned: ' + CAST(@@ROWCOUNT AS NVARCHAR(8));
