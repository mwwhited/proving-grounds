CREATE TABLE [Storage].[ContentItems] (
    [ContentItemID]     INT                 IDENTITY (1, 1) NOT NULL,
    [ContentTypeID]     INT                 NOT NULL,
    [RowID]             UNIQUEIDENTIFIER    ROWGUIDCOL NOT NULL,
    [Name]              NVARCHAR (200)      NOT NULL,
    [Description]       NVARCHAR (MAX)      NULL,
    [MappedPath]        NVARCHAR (MAX)      NOT NULL,
    [CreationTime]      DATETIME            NOT NULL,
    [LastAccessTime]    DATETIME            NOT NULL,
    [LastWriteTime]     DATETIME            NOT NULL,
    [StructureID]       [sys].[hierarchyid] NOT NULL,
    [StructureIDLevel]  AS                  ([StructureID].[GetLevel]()) PERSISTED,
    [ParentStructureID] AS                  ([StructureID].[GetAncestor]((1))) PERSISTED,
    [ParentID]          AS                  ([Storage].[GetContentID]([StructureID].[GetAncestor]((1))))
);

