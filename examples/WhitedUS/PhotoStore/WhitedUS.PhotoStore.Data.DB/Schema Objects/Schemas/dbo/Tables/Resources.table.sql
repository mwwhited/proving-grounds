CREATE TABLE [dbo].[Resources] (
    [ResourceID]     INT            IDENTITY (1, 1) NOT NULL,
    [ResourceTypeID] INT            NOT NULL,
    [BasePathID]     INT            NOT NULL,
    [Folder]         NVARCHAR (256) NOT NULL,
    [Name]           NVARCHAR (100) NOT NULL,
    [Extension]      NVARCHAR (50)  NULL,
    [CreatedDate]    DATETIME       NOT NULL,
    [MaxFactor]      TINYINT        NOT NULL
);









