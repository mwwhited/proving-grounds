CREATE TABLE [dbo].[ContentItems] (
    [ContentItemID]  INT                        IDENTITY (1, 1) NOT NULL,
    [RowID]          UNIQUEIDENTIFIER           ROWGUIDCOL NOT NULL,
    [Name]           NVARCHAR (200)             NOT NULL,
    [Description]    NVARCHAR (MAX)             NULL,
    [CreationTime]   DATETIME                   NOT NULL,
    [LastAccessTime] DATETIME                   NOT NULL,
    [LastWriteTime]  DATETIME                   NOT NULL,
    [Data]           VARBINARY (MAX) FILESTREAM NOT NULL,
    [ContentTypeID]  INT                        NOT NULL,
    [FolderID]       INT                        NOT NULL,
    [Length]         AS                         (len([Data])) PERSISTED,
    UNIQUE NONCLUSTERED ([RowID] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF) ON [PRIMARY],
    CONSTRAINT [UQ_ContentItems_RowID] UNIQUE NONCLUSTERED ([RowID] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF) ON [PRIMARY]
);





