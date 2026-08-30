-- 78_coloring_outlines.sql
--
-- Eleven worksheets printed a dashed rectangle with a dashed ellipse in it.
-- Six are titled "Color the ..." and had nothing to color.
--
-- Each now points at the color_outline renderer with a shape to draw: a real
-- contour in open strokes, sized to the page, with big regions a crayon can
-- land inside. Titles, facts and footer labels are unchanged - they were
-- already right; only the drawing was missing.

SET NOCOUNT ON;

UPDATE dbo.Worksheets SET content_data = N'{"renderer": "color_outline", "params": {"title": "Draw the Magical Unicorn", "facts": ["Unicorns are legendary creatures shown as horses with a single spiral horn.", "The unicorn has been a symbol of purity and grace in folklore for over 2,000 years.", "Give yours a rainbow mane — real or magical, it''s your choice!"], "footer_label": "Draw & Color · TK", "shape": "unicorn"}}'
 WHERE worksheet_id = 8;   -- Color the Magical Unicorn
UPDATE dbo.Worksheets SET content_data = N'{"renderer": "color_outline", "params": {"title": "Draw the T-Rex Friend", "facts": ["Tyrannosaurus rex means ''tyrant lizard king'' in Latin.", "T-Rex lived about 66–68 million years ago, at the very end of the age of dinosaurs.", "A T-Rex tooth could be as long as a banana!"], "footer_label": "Draw & Color · TK", "shape": "trex"}}'
 WHERE worksheet_id = 9;   -- Color the T-Rex Friend
UPDATE dbo.Worksheets SET content_data = N'{"renderer": "color_outline", "params": {"title": "Draw the Garden Flower", "facts": ["Flowers use bright colors and scents to attract bees and butterflies.", "A flower''s petals protect the pollen and seeds growing at its center.", "This is a lovely one to make for someone you love — try adding a stem and leaves!"], "footer_label": "Draw & Color · TK", "shape": "flower"}}'
 WHERE worksheet_id = 10;   -- Color the Garden Flower
UPDATE dbo.Worksheets SET content_data = N'{"renderer": "color_outline", "params": {"title": "Draw the Happy Sun", "facts": ["The sun is a giant star — so big that about 1.3 million Earths could fit inside it.", "Sunlight takes about 8 minutes to travel from the sun to Earth.", "Give your sun a big smile and some warm, wiggly rays!"], "footer_label": "Draw & Color · TK", "shape": "sun"}}'
 WHERE worksheet_id = 180;   -- Draw the Happy Sun
UPDATE dbo.Worksheets SET content_data = N'{"renderer": "color_outline", "params": {"title": "Draw the Friendly Shark", "facts": ["Sharks have swum in Earth''s oceans for over 400 million years — before trees existed!", "A shark''s skeleton is made of cartilage, the same flexible material as your ears.", "Most sharks are shy around people and would rather swim away."], "footer_label": "Draw & Color · K", "shape": "shark"}}'
 WHERE worksheet_id = 23;   -- Color the Friendly Shark
UPDATE dbo.Worksheets SET content_data = N'{"renderer": "color_outline", "params": {"title": "Draw the Butterfly", "facts": ["A butterfly tastes with its feet, not its tongue.", "Butterflies start life as caterpillars before transforming inside a chrysalis.", "Add colorful, symmetrical patterns to both wings — try making one side match the other!"], "footer_label": "Draw & Color · Kindergarten", "shape": "butterfly"}}'
 WHERE worksheet_id = 209;   -- Draw the Butterfly
UPDATE dbo.Worksheets SET content_data = N'{"renderer": "color_outline", "params": {"title": "Draw the Race Car", "facts": ["The fastest race cars can reach speeds over 200 miles per hour.", "Race cars have wide, smooth tires called slicks for extra grip on the track.", "Add racing stripes and a big number to your car!"], "footer_label": "Draw & Color · Grade 1", "shape": "race_car"}}'
 WHERE worksheet_id = 27;   -- Color the Race Car
UPDATE dbo.Worksheets SET content_data = N'{"renderer": "color_outline", "params": {"title": "Draw the Rainbow", "facts": ["A rainbow forms when sunlight passes through raindrops and bends into different colors.", "Rainbows always have the same color order: red, orange, yellow, green, blue, indigo, violet.", "Try coloring all 7 stripes in the correct order!"], "footer_label": "Draw & Color · Grade 1", "shape": "rainbow"}}'
 WHERE worksheet_id = 211;   -- Draw the Rainbow
UPDATE dbo.Worksheets SET content_data = N'{"renderer": "color_outline", "params": {"title": "Draw a Spaceship Adventure", "facts": ["The International Space Station orbits Earth about every 90 minutes.", "Astronauts float in space because they''re in constant free-fall around Earth.", "Add stars, planets, and maybe a friendly alien to your scene!"], "footer_label": "Draw & Color · Grade 1", "shape": "spaceship"}}'
 WHERE worksheet_id = 212;   -- Draw a Spaceship Adventure
UPDATE dbo.Worksheets SET content_data = N'{"renderer": "color_outline", "params": {"title": "Draw the Fairy-Tale Castle", "facts": ["Real castles had thick stone walls and moats to keep everyone safe.", "Tall towers let guards see far across the land to spot visitors.", "Add flags, windows, and maybe a dragon flying nearby!"], "footer_label": "Draw & Color · Grade 2", "shape": "castle"}}'
 WHERE worksheet_id = 33;   -- Color the Fairy-Tale Castle
UPDATE dbo.Worksheets SET content_data = N'{"renderer": "color_outline", "params": {"title": "Draw the Rocket Ship", "facts": ["A rocket needs to reach about 25,000 miles per hour to escape Earth''s gravity.", "Rockets carry their own oxygen so they can fly even where there''s no air.", "Add fins, windows, and a trail of fire blasting out the bottom!"], "footer_label": "Draw & Color · Grade 2", "shape": "rocket"}}'
 WHERE worksheet_id = 181;   -- Draw the Rocket Ship

PRINT 'coloring outlines wired: 11';
