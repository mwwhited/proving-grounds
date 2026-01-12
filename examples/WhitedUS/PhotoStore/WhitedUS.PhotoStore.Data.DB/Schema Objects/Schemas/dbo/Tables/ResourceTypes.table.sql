CREATE TABLE [dbo].[ResourceTypes] (
    [ResourceTypeID] INT            IDENTITY (1, 1) NOT NULL,
    [Label]          NVARCHAR (50)  NOT NULL,
    [MimeType]       NVARCHAR (256) NOT NULL,
    [Extension]      NVARCHAR (50)  NOT NULL
);



