-- 59_add_more_diagrams.sql
-- Attaches the four new diagram types (added in 58_more_diagram_types.sql)
-- to real, matching questions: ten-frames for TK counting, angle diagrams
-- for 4th grade angle classification, and labeled rectangles / plotted
-- coordinate points for 4th/5th/6th grade geometry & coordinate-plane
-- categories. Matched by exact question_id (verified against the live
-- prompts before writing this migration) so it is safe to run once.

-- TK — Counting Objects 1–10 → ten_frame (count = the answer itself)
UPDATE dbo.PacketQuestions SET diagram_type='ten_frame', diagram_data=N'{"count": 3}'  WHERE question_id=1021;
UPDATE dbo.PacketQuestions SET diagram_type='ten_frame', diagram_data=N'{"count": 5}'  WHERE question_id=1022;
UPDATE dbo.PacketQuestions SET diagram_type='ten_frame', diagram_data=N'{"count": 7}'  WHERE question_id=1023;
UPDATE dbo.PacketQuestions SET diagram_type='ten_frame', diagram_data=N'{"count": 2}'  WHERE question_id=1024;
UPDATE dbo.PacketQuestions SET diagram_type='ten_frame', diagram_data=N'{"count": 9}'  WHERE question_id=1025;
UPDATE dbo.PacketQuestions SET diagram_type='ten_frame', diagram_data=N'{"count": 4}'  WHERE question_id=1026;
UPDATE dbo.PacketQuestions SET diagram_type='ten_frame', diagram_data=N'{"count": 6}'  WHERE question_id=1027;
UPDATE dbo.PacketQuestions SET diagram_type='ten_frame', diagram_data=N'{"count": 10}' WHERE question_id=1028;
UPDATE dbo.PacketQuestions SET diagram_type='ten_frame', diagram_data=N'{"count": 1}'  WHERE question_id=1029;
UPDATE dbo.PacketQuestions SET diagram_type='ten_frame', diagram_data=N'{"count": 8}'  WHERE question_id=1030;
UPDATE dbo.PacketQuestions SET diagram_type='ten_frame', diagram_data=N'{"count": 3}'  WHERE question_id=1031;
UPDATE dbo.PacketQuestions SET diagram_type='ten_frame', diagram_data=N'{"count": 6}'  WHERE question_id=1032;

-- 4th grade — Area & Perimeter (Rectangles) → rectangle_dims (plain-rectangle rows only, not the L-shaped composites)
UPDATE dbo.PacketQuestions SET diagram_type='rectangle_dims', diagram_data=N'{"width": 12, "height": 7, "unit": " cm"}'  WHERE question_id=1208;
UPDATE dbo.PacketQuestions SET diagram_type='rectangle_dims', diagram_data=N'{"width": 9, "height": 6, "unit": " cm"}'   WHERE question_id=1209;
UPDATE dbo.PacketQuestions SET diagram_type='rectangle_dims', diagram_data=N'{"width": 15, "height": 4, "unit": " cm"}'  WHERE question_id=1210;
UPDATE dbo.PacketQuestions SET diagram_type='rectangle_dims', diagram_data=N'{"width": 11, "height": 8, "unit": " cm"}'  WHERE question_id=1211;
UPDATE dbo.PacketQuestions SET diagram_type='rectangle_dims', diagram_data=N'{"width": 13, "height": 9, "unit": " cm"}'  WHERE question_id=1212;
UPDATE dbo.PacketQuestions SET diagram_type='rectangle_dims', diagram_data=N'{"width": 7, "height": 7, "unit": " cm"}'   WHERE question_id=1213;
UPDATE dbo.PacketQuestions SET diagram_type='rectangle_dims', diagram_data=N'{"width": 10, "height": 6, "unit": " cm"}'  WHERE question_id=1214;
UPDATE dbo.PacketQuestions SET diagram_type='rectangle_dims', diagram_data=N'{"width": 14, "height": 5, "unit": " cm"}'  WHERE question_id=1215;
UPDATE dbo.PacketQuestions SET diagram_type='rectangle_dims', diagram_data=N'{"width": 16, "height": 9, "unit": " cm"}'  WHERE question_id=1216;
UPDATE dbo.PacketQuestions SET diagram_type='rectangle_dims', diagram_data=N'{"width": 12, "height": 12, "unit": " cm"}' WHERE question_id=1217;

-- 4th grade — Angles & Angle Measurement → angle (the "Classify this angle: N°" rows)
UPDATE dbo.PacketQuestions SET diagram_type='angle', diagram_data=N'{"degrees": 45}'  WHERE question_id=1226;
UPDATE dbo.PacketQuestions SET diagram_type='angle', diagram_data=N'{"degrees": 120}' WHERE question_id=1227;
UPDATE dbo.PacketQuestions SET diagram_type='angle', diagram_data=N'{"degrees": 90}'  WHERE question_id=1228;
UPDATE dbo.PacketQuestions SET diagram_type='angle', diagram_data=N'{"degrees": 160}' WHERE question_id=1229;
UPDATE dbo.PacketQuestions SET diagram_type='angle', diagram_data=N'{"degrees": 30}'  WHERE question_id=1230;
UPDATE dbo.PacketQuestions SET diagram_type='angle', diagram_data=N'{"degrees": 75}'  WHERE question_id=1231;
UPDATE dbo.PacketQuestions SET diagram_type='angle', diagram_data=N'{"degrees": 100}' WHERE question_id=1232;
UPDATE dbo.PacketQuestions SET diagram_type='angle', diagram_data=N'{"degrees": 179}' WHERE question_id=1233;

-- 5th grade — Coordinate Plane (quadrant 1) → coordinate_point
UPDATE dbo.PacketQuestions SET diagram_type='coordinate_point', diagram_data=N'{"x": 4, "y": 2, "size": 11}'  WHERE question_id=1572;
UPDATE dbo.PacketQuestions SET diagram_type='coordinate_point', diagram_data=N'{"x": 6, "y": 1, "size": 11}'  WHERE question_id=1573;
UPDATE dbo.PacketQuestions SET diagram_type='coordinate_point', diagram_data=N'{"x": 5, "y": 3, "size": 11}'  WHERE question_id=1574;
UPDATE dbo.PacketQuestions SET diagram_type='coordinate_point', diagram_data=N'{"x": 5, "y": 3, "size": 11}'  WHERE question_id=1575;
UPDATE dbo.PacketQuestions SET diagram_type='coordinate_point', diagram_data=N'{"x": 7, "y": 9, "size": 11}'  WHERE question_id=1576;
UPDATE dbo.PacketQuestions SET diagram_type='coordinate_point', diagram_data=N'{"x": 2, "y": 8, "size": 11}'  WHERE question_id=1577;
UPDATE dbo.PacketQuestions SET diagram_type='coordinate_point', diagram_data=N'{"x": 0, "y": 6, "size": 11}'  WHERE question_id=1578;
UPDATE dbo.PacketQuestions SET diagram_type='coordinate_point', diagram_data=N'{"x": 8, "y": 0, "size": 11}'  WHERE question_id=1579;
UPDATE dbo.PacketQuestions SET diagram_type='coordinate_point', diagram_data=N'{"x": 3, "y": 7, "size": 11}'  WHERE question_id=1580;
UPDATE dbo.PacketQuestions SET diagram_type='coordinate_point', diagram_data=N'{"x": 9, "y": 4, "size": 11}'  WHERE question_id=1581;
UPDATE dbo.PacketQuestions SET diagram_type='coordinate_point', diagram_data=N'{"x": 1, "y": 10, "size": 11}' WHERE question_id=1582;
UPDATE dbo.PacketQuestions SET diagram_type='coordinate_point', diagram_data=N'{"x": 10, "y": 1, "size": 11}' WHERE question_id=1583;

-- 6th grade — Coordinate Plane (All Four Quadrants) → coordinate_point (skips the two distance rows)
UPDATE dbo.PacketQuestions SET diagram_type='coordinate_point', diagram_data=N'{"x": 3, "y": 5, "size": 10}'    WHERE question_id=1931;
UPDATE dbo.PacketQuestions SET diagram_type='coordinate_point', diagram_data=N'{"x": -4, "y": 2, "size": 10}'   WHERE question_id=1932;
UPDATE dbo.PacketQuestions SET diagram_type='coordinate_point', diagram_data=N'{"x": -6, "y": -3, "size": 10}'  WHERE question_id=1933;
UPDATE dbo.PacketQuestions SET diagram_type='coordinate_point', diagram_data=N'{"x": 5, "y": -7, "size": 10}'   WHERE question_id=1934;
UPDATE dbo.PacketQuestions SET diagram_type='coordinate_point', diagram_data=N'{"x": 4, "y": 6, "size": 10}'    WHERE question_id=1935;
UPDATE dbo.PacketQuestions SET diagram_type='coordinate_point', diagram_data=N'{"x": -3, "y": 5, "size": 10}'   WHERE question_id=1936;
UPDATE dbo.PacketQuestions SET diagram_type='coordinate_point', diagram_data=N'{"x": 2, "y": -8, "size": 10}'   WHERE question_id=1937;
UPDATE dbo.PacketQuestions SET diagram_type='coordinate_point', diagram_data=N'{"x": -5, "y": -2, "size": 10}'  WHERE question_id=1938;
UPDATE dbo.PacketQuestions SET diagram_type='coordinate_point', diagram_data=N'{"x": -1, "y": -9, "size": 10}'  WHERE question_id=1939;
UPDATE dbo.PacketQuestions SET diagram_type='coordinate_point', diagram_data=N'{"x": 8, "y": 1, "size": 10}'    WHERE question_id=1940;
UPDATE dbo.PacketQuestions SET diagram_type='coordinate_point', diagram_data=N'{"x": -2, "y": 6, "size": 10}'   WHERE question_id=1943;
GO
