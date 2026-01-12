CREATE TABLE [dbo].[Forms] (
    [FormID]      INT            IDENTITY (1, 1) NOT NULL,
    [Name]        NVARCHAR (200) NOT NULL,
    [Description] NVARCHAR (MAX) NULL,
    [Body]        NVARCHAR (MAX) NOT NULL,
    [Version]     FLOAT          NOT NULL
);

