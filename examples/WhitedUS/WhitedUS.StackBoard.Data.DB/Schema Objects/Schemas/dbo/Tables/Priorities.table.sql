CREATE TABLE [dbo].[Priorities] (
    [PriorityID]  INT            IDENTITY (1, 1) NOT NULL,
    [Name]        NVARCHAR (200) NOT NULL,
    [Description] NVARCHAR (MAX) NULL,
    [Weight]      INT            NOT NULL
);





