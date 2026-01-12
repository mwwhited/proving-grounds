CREATE TABLE [Logging].[Sessions] (
    [SessionID]         BIGINT           IDENTITY (1, 1) NOT NULL,
    [ContextInfo]       BINARY (128)     NOT NULL,
    [UserID]            UNIQUEIDENTIFIER NOT NULL,
    [EntryPoint]        NVARCHAR (MAX)   NULL,
    [EntryPointVersion] NVARCHAR (50)    NULL,
    [Executing]         NVARCHAR (MAX)   NULL,
    [ExecutingVersion]  NVARCHAR (50)    NULL,
    [StartedTime]       DATETIME         NOT NULL,
    [LastUsedTime]      DATETIME         NOT NULL
);

