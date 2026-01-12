ALTER TABLE [dbo].[Resources]
    ADD CONSTRAINT [FK_Resources_ResourceTypes] FOREIGN KEY ([ResourceTypeID]) REFERENCES [dbo].[ResourceTypes] ([ResourceTypeID]) ON DELETE NO ACTION ON UPDATE NO ACTION;

