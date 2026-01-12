ALTER TABLE [Security].[UsersInRoles]
    ADD CONSTRAINT [FK_UsersInRoles_Users] FOREIGN KEY ([UserID]) REFERENCES [Security].[Users] ([UserID]) ON DELETE NO ACTION ON UPDATE NO ACTION;

