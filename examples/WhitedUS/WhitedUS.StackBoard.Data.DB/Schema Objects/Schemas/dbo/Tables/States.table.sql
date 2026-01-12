CREATE TABLE [dbo].[States] (
    [StateID]     INT            IDENTITY (1, 1) NOT NULL,
    [Name]        NVARCHAR (200) NOT NULL,
    [Description] NVARCHAR (MAX) NULL,
    [TaskTypeID]  INT            NOT NULL
);

