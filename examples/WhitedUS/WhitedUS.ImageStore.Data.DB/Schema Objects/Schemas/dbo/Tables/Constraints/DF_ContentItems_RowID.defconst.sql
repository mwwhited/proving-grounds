ALTER TABLE [dbo].[ContentItems]
    ADD CONSTRAINT [DF_ContentItems_RowID] DEFAULT (newid()) FOR [RowID];

