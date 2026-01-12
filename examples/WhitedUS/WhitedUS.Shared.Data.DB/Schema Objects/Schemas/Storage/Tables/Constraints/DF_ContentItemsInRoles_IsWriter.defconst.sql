ALTER TABLE [Storage].[ContentItemsInRoles]
    ADD CONSTRAINT [DF_ContentItemsInRoles_IsWriter] DEFAULT ((0)) FOR [Write];

