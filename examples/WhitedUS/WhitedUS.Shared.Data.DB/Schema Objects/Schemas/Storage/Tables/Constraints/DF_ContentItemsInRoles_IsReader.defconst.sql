ALTER TABLE [Storage].[ContentItemsInRoles]
    ADD CONSTRAINT [DF_ContentItemsInRoles_IsReader] DEFAULT ((0)) FOR [Read];

