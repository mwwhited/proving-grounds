CREATE TABLE [Security].[Roles] (
    [RoleID]        UNIQUEIDENTIFIER NOT NULL,
    [Name]          NVARCHAR (200)   NOT NULL,
    [Description]   NVARCHAR (MAX)   NULL,
    [ApplicationID] UNIQUEIDENTIFIER NOT NULL
);

