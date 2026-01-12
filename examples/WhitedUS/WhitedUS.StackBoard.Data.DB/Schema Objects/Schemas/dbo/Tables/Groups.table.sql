CREATE TABLE [dbo].[Groups] (
    [GroupID]     INT                 IDENTITY (1, 1) NOT NULL,
    [HId]         [sys].[hierarchyid] NOT NULL,
    [Name]        NVARCHAR (200)      NOT NULL,
    [Description] NVARCHAR (MAX)      NULL,
    [HIdString]   AS                  ([HId].[ToString]()),
    [HIdLevel]    AS                  ([HId].[GetLevel]()) PERSISTED,
    [ParentID]    AS                  ([dbo].[GetGroupID]([HId].[GetAncestor]((1))))
);

