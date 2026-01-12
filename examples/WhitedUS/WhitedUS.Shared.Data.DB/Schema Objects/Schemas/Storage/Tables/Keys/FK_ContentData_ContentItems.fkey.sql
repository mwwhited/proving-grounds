ALTER TABLE [Storage].[ContentData]
    ADD CONSTRAINT [FK_ContentData_ContentItems] FOREIGN KEY ([ContentItemID]) REFERENCES [Storage].[ContentItems] ([ContentItemID]) ON DELETE NO ACTION ON UPDATE NO ACTION;

