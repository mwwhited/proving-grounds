CREATE TABLE [dbo].[TaskTypes] (
    [TaskTypeID]    INT            IDENTITY (1, 1) NOT NULL,
    [Name]          NVARCHAR (200) NOT NULL,
    [Description]   NVARCHAR (MAX) NULL,
    [HandlerType]   NVARCHAR (MAX) NULL,
    [Configuration] XML            NULL
);



