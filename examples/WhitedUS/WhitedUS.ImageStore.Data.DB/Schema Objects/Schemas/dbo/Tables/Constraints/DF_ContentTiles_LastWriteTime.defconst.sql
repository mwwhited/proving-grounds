ALTER TABLE [dbo].[ContentTiles]
    ADD CONSTRAINT [DF_ContentTiles_LastWriteTime] DEFAULT (getutcdate()) FOR [LastWriteTime];

