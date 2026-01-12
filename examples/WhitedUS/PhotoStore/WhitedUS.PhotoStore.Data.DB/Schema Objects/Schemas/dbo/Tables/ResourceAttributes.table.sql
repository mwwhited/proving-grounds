CREATE TABLE [dbo].[ResourceAttributes] (
    [ResourceAttributeID]     BIGINT         IDENTITY (1, 1) NOT NULL,
    [ResourceAttributeTypeID] INT            NOT NULL,
    [ResourceID]              INT            NOT NULL,
    [Value]                   NVARCHAR (MAX) NOT NULL
);



