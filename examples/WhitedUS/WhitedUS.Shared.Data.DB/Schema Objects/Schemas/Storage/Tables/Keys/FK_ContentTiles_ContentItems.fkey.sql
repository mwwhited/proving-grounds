ALTER TABLE [Storage].[ContentTiles]
    ADD CONSTRAINT [FK_ContentTiles_ContentItems] FOREIGN KEY ([ContentItemID]) REFERENCES [Storage].[ContentData] ([ContentDataID]) ON DELETE NO ACTION ON UPDATE NO ACTION;

