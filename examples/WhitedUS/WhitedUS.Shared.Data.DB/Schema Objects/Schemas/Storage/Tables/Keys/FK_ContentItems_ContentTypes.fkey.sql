ALTER TABLE [Storage].[ContentItems]
    ADD CONSTRAINT [FK_ContentItems_ContentTypes] FOREIGN KEY ([ContentTypeID]) REFERENCES [Storage].[ContentTypes] ([ContentTypeID]) ON DELETE NO ACTION ON UPDATE NO ACTION;

