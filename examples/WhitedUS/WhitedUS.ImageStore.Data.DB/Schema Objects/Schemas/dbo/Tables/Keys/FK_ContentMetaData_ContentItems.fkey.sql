ALTER TABLE [dbo].[ContentMetaData]
    ADD CONSTRAINT [FK_ContentMetaData_ContentItems] FOREIGN KEY ([ContentItemID]) REFERENCES [dbo].[ContentItems] ([ContentItemID]) ON DELETE CASCADE ON UPDATE NO ACTION;

