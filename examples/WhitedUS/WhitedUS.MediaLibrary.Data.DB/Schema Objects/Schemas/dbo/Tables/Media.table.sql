CREATE TABLE [dbo].[Media] (
    [LocalID]     INT            IDENTITY (1, 1) NOT NULL,
    [Title]       NVARCHAR (255) NOT NULL,
    [Rating]      NVARCHAR (50)  NULL,
    [Year]        NVARCHAR (50)  NULL,
    [Code]        NVARCHAR (50)  NULL,
    [Format]      NVARCHAR (50)  NULL,
    [Length]      NVARCHAR (50)  NULL,
    [MediaTypeID] INT            NOT NULL,
    [Have]        BIT            NOT NULL,
    [Notes]       NVARCHAR (255) NULL,
    [BoxTitle]    NVARCHAR (255) NULL,
    [DiskNumber]  NVARCHAR (255) NULL
);





