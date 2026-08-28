-- ============================================================
--  Little Scholars Hub — Migration 016
--  Adds: teacher role, Families approval/teacher-profile columns,
--        Classrooms, StudentClassroomLink
--  Run AFTER 01_schema.sql .. 15_hero_content_update.sql
-- ============================================================

USE LittleScholarHub;
GO

-- ─── 1. Widen Families.role to allow 'teacher' ──────────────
IF EXISTS (
    SELECT 1 FROM sys.check_constraints
    WHERE name = 'CK_Family_Role' AND parent_object_id = OBJECT_ID('dbo.Families')
)
BEGIN
    ALTER TABLE dbo.Families DROP CONSTRAINT CK_Family_Role;
    PRINT 'Dropped old CK_Family_Role';
END
GO

ALTER TABLE dbo.Families
    ADD CONSTRAINT CK_Family_Role CHECK (role IN ('admin','parent','teacher'));
GO

-- ─── 2. Families approval + teacher-profile columns ─────────
IF NOT EXISTS (
    SELECT 1 FROM sys.columns
    WHERE object_id = OBJECT_ID('dbo.Families') AND name = 'is_approved'
)
BEGIN
    ALTER TABLE dbo.Families ADD is_approved BIT NOT NULL DEFAULT 1;
    PRINT 'Added is_approved column to Families';
END
GO

IF NOT EXISTS (
    SELECT 1 FROM sys.columns
    WHERE object_id = OBJECT_ID('dbo.Families') AND name = 'teacher_name'
)
BEGIN
    ALTER TABLE dbo.Families ADD teacher_name NVARCHAR(128) NULL;
    PRINT 'Added teacher_name column to Families';
END
GO

IF NOT EXISTS (
    SELECT 1 FROM sys.columns
    WHERE object_id = OBJECT_ID('dbo.Families') AND name = 'teacher_school'
)
BEGIN
    ALTER TABLE dbo.Families ADD teacher_school NVARCHAR(128) NULL;
    PRINT 'Added teacher_school column to Families';
END
GO

-- ─── 3. Classrooms table ─────────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'Classrooms' AND type = 'U')
BEGIN
    CREATE TABLE dbo.Classrooms (
        classroom_id     INT           NOT NULL CONSTRAINT PK_Classrooms PRIMARY KEY IDENTITY,
        teacher_family_id INT          NOT NULL CONSTRAINT FK_Classroom_Teacher
                                            REFERENCES dbo.Families(family_id) ON DELETE CASCADE,
        classroom_name    NVARCHAR(128) NOT NULL,
        school_name       NVARCHAR(128) NULL,
        classroom_code    CHAR(8)       NOT NULL CONSTRAINT UQ_Classroom_Code UNIQUE,
        created_at        DATETIME2     NOT NULL DEFAULT SYSUTCDATETIME(),
        is_active         BIT           NOT NULL DEFAULT 1
    );
    PRINT 'Created Classrooms table';
END
GO

-- ─── 4. StudentClassroomLink table ───────────────────────────
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'StudentClassroomLink' AND type = 'U')
BEGIN
    CREATE TABLE dbo.StudentClassroomLink (
        link_id      INT       NOT NULL CONSTRAINT PK_StudentClassroomLink PRIMARY KEY IDENTITY,
        child_id     INT       NOT NULL CONSTRAINT FK_SCL_Child
                                    REFERENCES dbo.Children(child_id) ON DELETE CASCADE,
        classroom_id INT       NOT NULL CONSTRAINT FK_SCL_Classroom
                                    REFERENCES dbo.Classrooms(classroom_id),
        joined_at    DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        CONSTRAINT UQ_SCL_ChildClassroom UNIQUE (child_id, classroom_id)
    );
    PRINT 'Created StudentClassroomLink table';
END
GO
