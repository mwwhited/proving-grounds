ALTER TABLE [dbo].[ContentMetaData]
    ADD CONSTRAINT [DF_ContentMetaData_CreatedDate] DEFAULT (getutcdate()) FOR [CreationDate];

