CREATE TABLE [Storage].[ContentItemsInRoles] (
    [AssignmentID]  INT              IDENTITY (1, 1) NOT NULL,
    [ContentItemID] INT              NOT NULL,
    [RoleID]        UNIQUEIDENTIFIER NOT NULL,
    [List]          BIT              NOT NULL,
    [Read]          BIT              NOT NULL,
    [Write]         BIT              NOT NULL,
    [Publish]       BIT              NOT NULL
);

