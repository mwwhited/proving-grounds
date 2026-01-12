ALTER TABLE [Storage].[ContentMetaData]
    ADD CONSTRAINT [DF_ContentMetaData_CreatedDate] DEFAULT (getutcdate()) FOR [CreationDate];

