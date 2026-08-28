-- ============================================================
--  Little Scholars Hub — Migration 012
--  Adds: UploadedFiles table (binary file storage in DB)
--  Used by: POST /api/admin/uploads, GET /api/content/files/<id>
--  Run AFTER 01_schema.sql .. 11_content_library.sql
-- ============================================================

USE LittleScholarHub;
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'UploadedFiles' AND type = 'U')
BEGIN
    CREATE TABLE dbo.UploadedFiles (
        file_id      INT             NOT NULL CONSTRAINT PK_UploadedFiles PRIMARY KEY IDENTITY,
        filename     NVARCHAR(255)   NOT NULL,
        mime_type    NVARCHAR(100)   NOT NULL,
        file_size    INT             NOT NULL,
        data         VARBINARY(MAX)  NOT NULL,
        uploaded_by  INT             NULL CONSTRAINT FK_UploadedFiles_Family
                                         REFERENCES dbo.Families(family_id),
        created_at   DATETIME2       NOT NULL DEFAULT SYSUTCDATETIME()
    );
    PRINT 'Created UploadedFiles table';
END
GO
