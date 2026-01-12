CREATE TABLE [dbo].[ContentFrames] (
    [ContentFrameID] INT                        IDENTITY (1, 1) NOT NULL,
    [RowID]          UNIQUEIDENTIFIER           ROWGUIDCOL NOT NULL,
    [LastWriteTime]  DATETIME                   NOT NULL,
    [Data]           VARBINARY (MAX) FILESTREAM NULL,
    [ContentTypeID]  INT                        NOT NULL,
    [ContentItemID]  INT                        NOT NULL,
    [Index]          INT                        NOT NULL,
    [Width]          INT                        NOT NULL,
    [Height]         INT                        NOT NULL,
    [Length]         AS                         (len([Data])) PERSISTED,
    UNIQUE NONCLUSTERED ([RowID] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF) ON [PRIMARY],
    CONSTRAINT [UQ_ContentFrame_RowID] UNIQUE NONCLUSTERED ([RowID] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF) ON [PRIMARY]
);







