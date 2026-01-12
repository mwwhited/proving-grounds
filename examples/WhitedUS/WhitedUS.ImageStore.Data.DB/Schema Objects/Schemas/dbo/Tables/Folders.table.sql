CREATE TABLE [dbo].[Folders] (
    [FolderID]          INT                 IDENTITY (1, 1) NOT NULL,
    [RowID]             UNIQUEIDENTIFIER    ROWGUIDCOL NOT NULL,
    [StructureID]       [sys].[hierarchyid] NOT NULL,
    [Name]              NVARCHAR (200)      NOT NULL,
    [MappedPath]        NVARCHAR (MAX)      NOT NULL,
    [IsPublic]          BIT                 NOT NULL,
    [CreationTime]      DATETIME            NOT NULL,
    [LastAccessTime]    DATETIME            NOT NULL,
    [LastWriteTime]     DATETIME            NOT NULL,
    [ParentStructureID] AS                  ([StructureID].[GetAncestor]((1))) PERSISTED,
    [ParentFolderID]    AS                  ([dbo].[GetParentFolderID]([StructureID])),
    [StructureIDString] AS                  ([StructureID].[ToString]()),
    [StructureIDLevel]  AS                  ([StructureID].[GetLevel]()) PERSISTED
);









