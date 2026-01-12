ALTER TABLE [dbo].[ContentMetaData]
    ADD CONSTRAINT [DF_ContentMetaData_LastWriteDate] DEFAULT (getutcdate()) FOR [LastWriteDate];

