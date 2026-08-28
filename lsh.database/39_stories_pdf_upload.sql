-- 39_stories_pdf_upload.sql
-- Lets admin upload a real PDF story (stored as a BLOB in dbo.UploadedFiles,
-- same pattern as worksheet uploads). Stories.pdf_url references the
-- streamed blob; body_text holds the extracted text (used for on-screen
-- reading and as the source for auto-generated read-aloud audio).

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID('dbo.Stories') AND name = 'pdf_url')
BEGIN
    ALTER TABLE dbo.Stories ADD pdf_url NVARCHAR(512) NULL;
    PRINT 'Added Stories.pdf_url';
END
GO
