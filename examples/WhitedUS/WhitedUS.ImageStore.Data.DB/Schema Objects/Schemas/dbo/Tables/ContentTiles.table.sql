CREATE TABLE [dbo].[ContentTiles] (
    [ContentTileID]  BIGINT          IDENTITY (1, 1) NOT NULL,
    [ContentFrameID] INT             NOT NULL,
    [X]              INT             NOT NULL,
    [Y]              INT             NOT NULL,
    [Level]          INT             NOT NULL,
    [Data]           VARBINARY (MAX) NOT NULL,
    [ContentTypeID]  INT             NOT NULL,
    [LastWriteTime]  DATETIME        NOT NULL,
    [Length]         AS              (len([Data])) PERSISTED
);





