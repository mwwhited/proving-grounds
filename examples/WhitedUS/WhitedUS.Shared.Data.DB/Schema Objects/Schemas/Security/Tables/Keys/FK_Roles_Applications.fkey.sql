ALTER TABLE [Security].[Roles]
    ADD CONSTRAINT [FK_Roles_Applications] FOREIGN KEY ([ApplicationID]) REFERENCES [Security].[Applications] ([ApplicationID]) ON DELETE NO ACTION ON UPDATE NO ACTION;

