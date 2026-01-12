ALTER TABLE [dbo].[ContentFrames]
    ADD CONSTRAINT [FK_ContentFrames_ContentTypes] FOREIGN KEY ([ContentTypeID]) REFERENCES [dbo].[ContentTypes] ([ContentTypeID]) ON DELETE NO ACTION ON UPDATE NO ACTION;

