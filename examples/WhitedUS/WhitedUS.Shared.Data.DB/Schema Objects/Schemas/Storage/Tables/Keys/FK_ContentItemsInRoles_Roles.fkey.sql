ALTER TABLE [Storage].[ContentItemsInRoles]
    ADD CONSTRAINT [FK_ContentItemsInRoles_Roles] FOREIGN KEY ([RoleID]) REFERENCES [Security].[Roles] ([RoleID]) ON DELETE NO ACTION ON UPDATE NO ACTION;

