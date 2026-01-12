CREATE TABLE [Storage].[ContentMetaData] (
    [ContentMetaDataID] BIGINT         IDENTITY (1, 1) NOT NULL,
    [ContentItemID]     INT            NOT NULL,
    [ContentMetaTypeID] INT            NOT NULL,
    [Value]             NVARCHAR (MAX) NOT NULL,
    [Length]            AS             (len([Value])) PERSISTED,
    [CreationDate]      DATETIME       NOT NULL,
    [LastWriteDate]     DATETIME       NOT NULL
);

