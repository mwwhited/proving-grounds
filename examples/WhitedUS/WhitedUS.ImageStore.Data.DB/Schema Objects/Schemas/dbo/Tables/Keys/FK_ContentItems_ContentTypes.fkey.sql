ALTER TABLE [dbo].[ContentItems]
    ADD CONSTRAINT [FK_ContentItems_ContentTypes] FOREIGN KEY ([ContentTypeID]) REFERENCES [dbo].[ContentTypes] ([ContentTypeID]) ON DELETE NO ACTION ON UPDATE NO ACTION;

