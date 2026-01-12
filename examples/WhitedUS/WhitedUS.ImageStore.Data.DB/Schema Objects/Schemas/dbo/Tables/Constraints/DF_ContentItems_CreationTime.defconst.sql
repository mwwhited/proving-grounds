ALTER TABLE [dbo].[ContentItems]
    ADD CONSTRAINT [DF_ContentItems_CreationTime] DEFAULT (getutcdate()) FOR [CreationTime];

