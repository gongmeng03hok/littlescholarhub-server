-- 58_more_diagram_types.sql
-- Widens the PacketQuestions.diagram_type check constraint to allow four
-- new graphical diagram types, on top of the existing 'clock'/'emoji':
--   'ten_frame'       {count}                      — counting (TK/K)
--   'angle'           {degrees}                    — angle measurement
--   'rectangle_dims'  {width, height, unit?}        — area/perimeter
--   'coordinate_point'{x, y, size?}                 — coordinate plane
-- Rendering lives in lsh.web/src/components/WeeklyPacketView.tsx.

IF EXISTS (SELECT 1 FROM sys.check_constraints WHERE name = 'CK__PacketQue__diagr__66EA454A')
BEGIN
    ALTER TABLE dbo.PacketQuestions DROP CONSTRAINT CK__PacketQue__diagr__66EA454A;
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.check_constraints WHERE name = 'CK_PacketQuestions_diagram_type')
BEGIN
    ALTER TABLE dbo.PacketQuestions ADD CONSTRAINT CK_PacketQuestions_diagram_type
        CHECK (diagram_type IN ('emoji', 'clock', 'ten_frame', 'angle', 'rectangle_dims', 'coordinate_point'));
END
GO
