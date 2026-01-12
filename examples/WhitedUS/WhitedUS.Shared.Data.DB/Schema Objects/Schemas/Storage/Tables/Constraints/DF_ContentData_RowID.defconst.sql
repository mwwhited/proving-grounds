ALTER TABLE [Storage].[ContentData]
    ADD CONSTRAINT [DF_ContentData_RowID] DEFAULT (newid()) FOR [RowID];

