ALTER TABLE [Storage].[ContentItemsInRoles]
    ADD CONSTRAINT [DF_ContentItemsInRoles_IsPublisher] DEFAULT ((0)) FOR [Publish];

