ALTER TABLE [dbo].[ContentItems]
    ADD CONSTRAINT [DF_ContentItems_LastWriteTime] DEFAULT (getutcdate()) FOR [LastWriteTime];

