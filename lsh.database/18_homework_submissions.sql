-- ============================================================
--  Little Scholars Hub — Migration 018
--  Adds: HomeworkSubmissions (photo homework scans, AI or teacher graded)
--  Run AFTER 12_uploaded_files.sql and 17_student_assignments.sql
-- ============================================================

USE LittleScholarHub;
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'HomeworkSubmissions' AND type = 'U')
BEGIN
    CREATE TABLE dbo.HomeworkSubmissions (
        submission_id  INT           NOT NULL CONSTRAINT PK_HomeworkSubmissions PRIMARY KEY IDENTITY,
        child_id       INT           NOT NULL CONSTRAINT FK_HS_Child
                                          REFERENCES dbo.Children(child_id) ON DELETE CASCADE,
        worksheet_id   INT           NULL CONSTRAINT FK_HS_Worksheet
                                          REFERENCES dbo.Worksheets(worksheet_id),
        image_file_id  INT           NOT NULL CONSTRAINT FK_HS_File
                                          REFERENCES dbo.UploadedFiles(file_id),
        mode           VARCHAR(10)   NOT NULL DEFAULT 'ai'
                                          CONSTRAINT CK_HS_Mode CHECK (mode IN ('ai','teacher')),
        classroom_id   INT           NULL CONSTRAINT FK_HS_Classroom
                                          REFERENCES dbo.Classrooms(classroom_id),
        score          INT           NULL,
        feedback_json  NVARCHAR(MAX) NULL,
        submitted_at   DATETIME2     NOT NULL DEFAULT SYSUTCDATETIME(),
        reviewed_at    DATETIME2     NULL
    );
    PRINT 'Created HomeworkSubmissions table';
END
GO
