ALTER TABLE [dbo].[ContentItems]
    ADD CONSTRAINT [DF_ContentItems_LastAccessTime] DEFAULT (getutcdate()) FOR [LastAccessTime];

