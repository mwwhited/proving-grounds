ALTER TABLE [Storage].[ContentTiles]
    ADD CONSTRAINT [FK_ContentTiles_ContentTypes] FOREIGN KEY ([ContentTypeID]) REFERENCES [Storage].[ContentTypes] ([ContentTypeID]) ON DELETE NO ACTION ON UPDATE NO ACTION;

