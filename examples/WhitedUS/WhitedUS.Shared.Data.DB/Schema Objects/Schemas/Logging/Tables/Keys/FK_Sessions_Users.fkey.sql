ALTER TABLE [Logging].[Sessions]
    ADD CONSTRAINT [FK_Sessions_Users] FOREIGN KEY ([UserID]) REFERENCES [Security].[Users] ([UserID]) ON DELETE NO ACTION ON UPDATE NO ACTION;

