ALTER TABLE [dbo].[Folders]
    ADD CONSTRAINT [DF_Folders_RowID] DEFAULT (newid()) FOR [RowID];

