-- 76_family_tree_by_age.sql
--
-- "Draw Your Family" (ws210) printed a dashed rectangle with a dashed ellipse
-- in the middle of it. The generator now draws real family-member outlines
-- and arranges them as a tree, laid out three ways:
--
--     TK / K    three big figures, thick lines, a name line under each
--     1st-2nd   parents joined by a bar, children hanging below
--     3rd+      grandparents, parents, children, with name and age lines
--
-- Only Kindergarten existed, so the other two bands had no way in. These rows
-- are cloned from ws210 so every catalog column carries over unchanged.

SET NOCOUNT ON;
DECLARE @g INT, @t NVARCHAR(200), @d NVARCHAR(1000), @th NVARCHAR(400);


-- The page is headed "My Family Tree"; the card said "Draw Your Family".
UPDATE dbo.Worksheets
   SET title = N'My Family Tree',
       description = N'Trace each person, color them in, and write their name.'
 WHERE worksheet_id = 210;


SET @g = 3; SET @t = N'My Family Tree'; SET @d = N'Color your family tree, then write everyone''s name.'; SET @th = NULL;
IF NOT EXISTS (SELECT 1 FROM dbo.Worksheets
               WHERE title = @t AND grade_id = @g)
BEGIN
    INSERT INTO dbo.Worksheets ([grade_id], [title], [description], [thumbnail_url], [subject_id], [language_id], [difficulty_id], [pdf_url], [estimated_min], [teacher_name], [is_published], [created_at], [content_type], [interest_tag], [page_count], [view_count], [rating_avg], [rating_count], [social_badge], [is_trending], [is_free], [pdf_generator_key], [owner_family_id], [week_of], [game_data], [video_url], [steps_json], [materials], [story_id], [content_data])
    SELECT @g, @t, @d, @th, [subject_id], [language_id], [difficulty_id], [pdf_url], [estimated_min], [teacher_name], [is_published], [created_at], [content_type], [interest_tag], [page_count], [view_count], [rating_avg], [rating_count], [social_badge], [is_trending], [is_free], [pdf_generator_key], [owner_family_id], [week_of], [game_data], [video_url], [steps_json], [materials], [story_id], [content_data]
      FROM dbo.Worksheets WHERE worksheet_id = 210;

    UPDATE dbo.Worksheets
       SET thumbnail_url = N'/art/ws_' + CAST(SCOPE_IDENTITY() AS NVARCHAR(12)) + N'.svg'
     WHERE worksheet_id = SCOPE_IDENTITY();

    PRINT 'added My Family Tree at grade_id 3 -> ws' + CAST(SCOPE_IDENTITY() AS NVARCHAR(12));
END


SET @g = 5; SET @t = N'My Family Tree'; SET @d = N'Complete your family tree: color it, then add each name and age.'; SET @th = NULL;
IF NOT EXISTS (SELECT 1 FROM dbo.Worksheets
               WHERE title = @t AND grade_id = @g)
BEGIN
    INSERT INTO dbo.Worksheets ([grade_id], [title], [description], [thumbnail_url], [subject_id], [language_id], [difficulty_id], [pdf_url], [estimated_min], [teacher_name], [is_published], [created_at], [content_type], [interest_tag], [page_count], [view_count], [rating_avg], [rating_count], [social_badge], [is_trending], [is_free], [pdf_generator_key], [owner_family_id], [week_of], [game_data], [video_url], [steps_json], [materials], [story_id], [content_data])
    SELECT @g, @t, @d, @th, [subject_id], [language_id], [difficulty_id], [pdf_url], [estimated_min], [teacher_name], [is_published], [created_at], [content_type], [interest_tag], [page_count], [view_count], [rating_avg], [rating_count], [social_badge], [is_trending], [is_free], [pdf_generator_key], [owner_family_id], [week_of], [game_data], [video_url], [steps_json], [materials], [story_id], [content_data]
      FROM dbo.Worksheets WHERE worksheet_id = 210;

    UPDATE dbo.Worksheets
       SET thumbnail_url = N'/art/ws_' + CAST(SCOPE_IDENTITY() AS NVARCHAR(12)) + N'.svg'
     WHERE worksheet_id = SCOPE_IDENTITY();

    PRINT 'added My Family Tree at grade_id 5 -> ws' + CAST(SCOPE_IDENTITY() AS NVARCHAR(12));
END

