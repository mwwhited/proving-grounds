ALTER TABLE [dbo].[ContentTiles]
    ADD CONSTRAINT [FK_ContentTiles_ContentTypes] FOREIGN KEY ([ContentTypeID]) REFERENCES [dbo].[ContentTypes] ([ContentTypeID]) ON DELETE NO ACTION ON UPDATE NO ACTION;

