ALTER TABLE [dbo].[ResourceAttributes]
    ADD CONSTRAINT [FK_ResourceAttributes_ResourceAttributeTypes] FOREIGN KEY ([ResourceAttributeTypeID]) REFERENCES [dbo].[ResourceAttributeTypes] ([ResourceAttributeTypeID]) ON DELETE NO ACTION ON UPDATE NO ACTION;

