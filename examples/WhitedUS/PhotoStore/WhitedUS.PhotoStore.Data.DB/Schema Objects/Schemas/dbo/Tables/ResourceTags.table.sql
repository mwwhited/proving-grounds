CREATE TABLE [dbo].[ResourceTags] (
    [ResourceTagID] BIGINT   IDENTITY (1, 1) NOT NULL,
    [ResourceID]    INT      NOT NULL,
    [TagID]         INT      NOT NULL,
    [CreatedOn]     DATETIME NOT NULL
);



