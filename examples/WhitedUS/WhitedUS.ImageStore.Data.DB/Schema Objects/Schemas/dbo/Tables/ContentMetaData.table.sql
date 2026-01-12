CREATE TABLE [dbo].[ContentMetaData] (
    [ContentMetaID] BIGINT         IDENTITY (1, 1) NOT NULL,
    [ContentItemID] INT            NOT NULL,
    [Name]          NVARCHAR (200) NOT NULL,
    [Value]         NVARCHAR (MAX) NOT NULL,
    [Length]        AS             (len([Value])) PERSISTED,
    [CreationDate]  DATETIME       NOT NULL,
    [LastWriteDate] DATETIME       NOT NULL
);

