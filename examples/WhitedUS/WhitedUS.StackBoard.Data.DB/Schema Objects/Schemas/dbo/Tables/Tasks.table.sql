CREATE TABLE [dbo].[Tasks] (
    [TaskID]       INT                 IDENTITY (1, 1) NOT NULL,
    [HId]          [sys].[hierarchyid] NOT NULL,
    [TaskTypeID]   INT                 NOT NULL,
    [GroupID]      INT                 NOT NULL,
    [Subject]      NVARCHAR (200)      NOT NULL,
    [Description]  NVARCHAR (MAX)      NULL,
    [StateID]      INT                 NOT NULL,
    [PriorityID]   INT                 NOT NULL,
    [DueDate]      DATETIME            NULL,
    [MetaData]     XML                 NULL,
    [CreatedDate]  DATETIME            NOT NULL,
    [ModifiedDate] DATETIME            NOT NULL,
    [HIdString]    AS                  ([HId].[ToString]()),
    [HIdLevel]     AS                  ([HId].[GetLevel]()) PERSISTED,
    [ParentID]     AS                  ([dbo].[GetGroupID]([HId].[GetAncestor]((1))))
);

