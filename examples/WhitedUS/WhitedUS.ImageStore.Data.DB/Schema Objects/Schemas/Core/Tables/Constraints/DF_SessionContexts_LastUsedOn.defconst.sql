ALTER TABLE [Core].[SessionContexts]
    ADD CONSTRAINT [DF_SessionContexts_LastUsedOn] DEFAULT (getutcdate()) FOR [LastUsedOn];

