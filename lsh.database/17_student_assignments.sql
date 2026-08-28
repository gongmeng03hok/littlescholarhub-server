-- ============================================================
--  Little Scholars Hub — Migration 017
--  Adds: StudentAssignments (teacher -> classroom/child worksheet assignments)
--  Run AFTER 16_teacher_classroom_schema.sql
-- ============================================================

USE LittleScholarHub;
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'StudentAssignments' AND type = 'U')
BEGIN
    CREATE TABLE dbo.StudentAssignments (
        assignment_id  INT           NOT NULL CONSTRAINT PK_StudentAssignments PRIMARY KEY IDENTITY,
        classroom_id   INT           NOT NULL CONSTRAINT FK_SA_Classroom
                                          REFERENCES dbo.Classrooms(classroom_id) ON DELETE CASCADE,
        child_id       INT           NULL CONSTRAINT FK_SA_Child
                                          REFERENCES dbo.Children(child_id),
        worksheet_id   INT           NOT NULL CONSTRAINT FK_SA_Worksheet
                                          REFERENCES dbo.Worksheets(worksheet_id),
        note           NVARCHAR(512) NULL,
        assigned_at    DATETIME2     NOT NULL DEFAULT SYSUTCDATETIME(),
        completed_at   DATETIME2     NULL
    );
    PRINT 'Created StudentAssignments table';
END
GO
