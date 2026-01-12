ALTER TABLE [Storage].[ContentMetaData]
    ADD CONSTRAINT [FK_ContentMetaData_ContentMetaTypes] FOREIGN KEY ([ContentMetaTypeID]) REFERENCES [Storage].[ContentMetaTypes] ([ContentMetaTypeID]) ON DELETE NO ACTION ON UPDATE NO ACTION;

