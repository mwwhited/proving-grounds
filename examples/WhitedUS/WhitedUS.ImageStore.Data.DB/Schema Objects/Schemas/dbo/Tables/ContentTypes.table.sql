CREATE TABLE [dbo].[ContentTypes] (
    [ContentTypeID] INT             IDENTITY (1, 1) NOT NULL,
    [Name]          NVARCHAR (200)  NOT NULL,
    [Description]   NVARCHAR (MAX)  NULL,
    [Extension]     NVARCHAR (10)   NULL,
    [MimeType]      NVARCHAR (1024) NULL,
    [IsSingleFrame] BIT             NOT NULL
);



