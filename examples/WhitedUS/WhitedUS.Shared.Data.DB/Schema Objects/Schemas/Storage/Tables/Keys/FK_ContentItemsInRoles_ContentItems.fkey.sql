ALTER TABLE [Storage].[ContentItemsInRoles]
    ADD CONSTRAINT [FK_ContentItemsInRoles_ContentItems] FOREIGN KEY ([ContentItemID]) REFERENCES [Storage].[ContentItems] ([ContentItemID]) ON DELETE NO ACTION ON UPDATE NO ACTION;

