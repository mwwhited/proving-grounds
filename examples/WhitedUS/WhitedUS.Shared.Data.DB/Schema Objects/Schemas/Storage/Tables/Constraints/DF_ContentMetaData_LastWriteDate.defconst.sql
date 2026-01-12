ALTER TABLE [Storage].[ContentMetaData]
    ADD CONSTRAINT [DF_ContentMetaData_LastWriteDate] DEFAULT (getutcdate()) FOR [LastWriteDate];

