IF DB_ID(N'ArtTrackerDb') IS NULL
BEGIN
    CREATE DATABASE [ArtTrackerDb];
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.sql_logins WHERE name = N'art_tracker_app')
BEGIN
    CREATE LOGIN [art_tracker_app]
    WITH PASSWORD = '8820087e#9795_4805_925f#b7987c933a4a';
END
GO

USE [ArtTrackerDb];
GO

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = N'art_tracker_app')
BEGIN
    CREATE USER [art_tracker_app] FOR LOGIN [art_tracker_app];
END
GO

IF NOT EXISTS
(
    SELECT 1
    FROM sys.database_role_members drm
    JOIN sys.database_principals r ON drm.role_principal_id = r.principal_id
    JOIN sys.database_principals m ON drm.member_principal_id = m.principal_id
    WHERE r.name = N'db_owner'
      AND m.name = N'art_tracker_app'
)
BEGIN
    ALTER ROLE db_owner ADD MEMBER [art_tracker_app];
END
GO