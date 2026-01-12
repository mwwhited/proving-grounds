CREATE TABLE [Storage].[ContentMetaTypes] (
    [ContentMetaTypeID] INT            IDENTITY (1, 1) NOT NULL,
    [Name]              NVARCHAR (200) NOT NULL,
    [Description]       NVARCHAR (MAX) NULL,
    [ClrType]           NVARCHAR (MAX) NULL
);

