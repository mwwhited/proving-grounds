ALTER TABLE [Core].[SessionContexts]
    ADD CONSTRAINT [DF_SessionContexts_CreatedOn] DEFAULT (getutcdate()) FOR [CreatedOn];

