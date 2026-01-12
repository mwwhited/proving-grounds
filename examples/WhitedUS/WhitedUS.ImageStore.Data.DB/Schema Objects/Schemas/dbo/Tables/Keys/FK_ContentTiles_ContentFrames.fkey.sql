ALTER TABLE [dbo].[ContentTiles]
    ADD CONSTRAINT [FK_ContentTiles_ContentFrames] FOREIGN KEY ([ContentFrameID]) REFERENCES [dbo].[ContentFrames] ([ContentFrameID]) ON DELETE CASCADE ON UPDATE NO ACTION;



