ALTER TABLE [Storage].[ContentTiles]
    ADD CONSTRAINT [DF_ContentTiles_LastWriteTime] DEFAULT (getutcdate()) FOR [LastWriteTime];

