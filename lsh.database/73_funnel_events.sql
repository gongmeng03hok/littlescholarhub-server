-- 73_funnel_events.sql
-- First-party funnel telemetry.
--
-- Why not Google Analytics: the landing page promises "COPPA & kid-privacy-first",
-- and this is a product used by four-year-olds. Sending their browsing to a third
-- party would contradict the promise the site is sold on. This table is the whole
-- analytics stack -- our server, our database, nothing leaves the box.
--
-- Deliberately stores NO personal data:
--   * no IP address, no cookie, no user agent, no family_id, no child name
--   * `session_key` is a random value the browser holds in sessionStorage; it
--     dies when the tab closes and cannot be joined to an account
--   * `meta` is a short opaque label (a grade band, a step number), never text
--     a person typed
--
-- Retention: rows older than 180 days should be deleted. See the note at the end.

SET NOCOUNT ON;

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'FunnelEvents')
BEGIN
    CREATE TABLE dbo.FunnelEvents (
        event_id     bigint        IDENTITY(1,1) PRIMARY KEY,
        event_name   varchar(48)   NOT NULL,
        session_key  char(16)      NOT NULL,
        step         int           NULL,
        meta         nvarchar(64)  NULL,
        created_at   datetime2(0)  NOT NULL CONSTRAINT DF_FunnelEvents_created DEFAULT SYSUTCDATETIME()
    );

    -- The two queries this table exists to answer: "what happened today" and
    -- "how far did one visit get".
    CREATE INDEX IX_FunnelEvents_name_date ON dbo.FunnelEvents (event_name, created_at);
    CREATE INDEX IX_FunnelEvents_session   ON dbo.FunnelEvents (session_key, created_at);
END
GO

-- Housekeeping: keep six months. Run from cron, or call it after a report.
IF OBJECT_ID('dbo.usp_PruneFunnelEvents') IS NOT NULL
    DROP PROCEDURE dbo.usp_PruneFunnelEvents;
GO

CREATE PROCEDURE dbo.usp_PruneFunnelEvents
    @days int = 180
AS
BEGIN
    SET NOCOUNT ON;
    DELETE FROM dbo.FunnelEvents
    WHERE created_at < DATEADD(day, -@days, SYSUTCDATETIME());
    SELECT @@ROWCOUNT AS rows_pruned;
END
GO

SELECT COUNT(*) AS existing_events FROM dbo.FunnelEvents;
