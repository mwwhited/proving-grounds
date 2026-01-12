ALTER TABLE [dbo].[ContentFrames]
    ADD CONSTRAINT [FK_ContentFrames_ContentItems] FOREIGN KEY ([ContentItemID]) REFERENCES [dbo].[ContentItems] ([ContentItemID]) ON DELETE CASCADE ON UPDATE NO ACTION;



