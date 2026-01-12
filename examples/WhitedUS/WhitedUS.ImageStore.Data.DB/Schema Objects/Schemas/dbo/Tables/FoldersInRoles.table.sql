CREATE TABLE [dbo].[FoldersInRoles] (
    [AssignmentID] INT              IDENTITY (1, 1) NOT NULL,
    [FolderID]     INT              NOT NULL,
    [RoleID]       UNIQUEIDENTIFIER NOT NULL,
    [IsWriter]     BIT              NOT NULL,
    [IsPublisher]  BIT              NOT NULL,
    [IsReader]     BIT              NOT NULL,
    [StructureID]  AS               ([dbo].[GetStructureID]([FolderID]))
);







