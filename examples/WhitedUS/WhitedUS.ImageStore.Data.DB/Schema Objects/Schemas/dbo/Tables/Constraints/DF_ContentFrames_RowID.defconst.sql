ALTER TABLE [dbo].[ContentFrames]
    ADD CONSTRAINT [DF_ContentFrames_RowID] DEFAULT (newid()) FOR [RowID];

