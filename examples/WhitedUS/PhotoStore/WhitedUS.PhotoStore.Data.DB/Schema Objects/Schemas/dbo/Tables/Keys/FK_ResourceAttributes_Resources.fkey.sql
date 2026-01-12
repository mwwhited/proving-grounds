ALTER TABLE [dbo].[ResourceAttributes]
    ADD CONSTRAINT [FK_ResourceAttributes_Resources] FOREIGN KEY ([ResourceID]) REFERENCES [dbo].[Resources] ([ResourceID]) ON DELETE CASCADE ON UPDATE NO ACTION;



