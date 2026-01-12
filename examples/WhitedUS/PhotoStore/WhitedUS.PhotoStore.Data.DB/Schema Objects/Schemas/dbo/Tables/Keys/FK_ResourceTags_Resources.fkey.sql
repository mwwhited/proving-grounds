ALTER TABLE [dbo].[ResourceTags]
    ADD CONSTRAINT [FK_ResourceTags_Resources] FOREIGN KEY ([ResourceID]) REFERENCES [dbo].[Resources] ([ResourceID]) ON DELETE CASCADE ON UPDATE NO ACTION;

