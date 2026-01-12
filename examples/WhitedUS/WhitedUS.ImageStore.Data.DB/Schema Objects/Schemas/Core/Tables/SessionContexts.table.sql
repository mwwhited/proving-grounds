CREATE TABLE [Core].[SessionContexts] (
    [SessionContextID]  BIGINT           IDENTITY (1, 1) NOT NULL,
    [Context]           VARBINARY (128)  NOT NULL,
    [ContextID]         AS               (CONVERT([uniqueidentifier],[Context],(0))) PERSISTED,
    [ASPNET_UserID]     UNIQUEIDENTIFIER NULL,
    [ApplicationName]   NVARCHAR (MAX)   NULL,
    [ExecutingAssembly] NVARCHAR (MAX)   NULL,
    [CreatedOn]         DATETIME         NOT NULL,
    [LastUsedOn]        DATETIME         NOT NULL
);





