ALTER TABLE [Storage].[ContentMetaData]
    ADD CONSTRAINT [FK_ContentMetaData_ContentItems1] FOREIGN KEY ([ContentItemID]) REFERENCES [Storage].[ContentItems] ([ContentItemID]) ON DELETE NO ACTION ON UPDATE NO ACTION;

