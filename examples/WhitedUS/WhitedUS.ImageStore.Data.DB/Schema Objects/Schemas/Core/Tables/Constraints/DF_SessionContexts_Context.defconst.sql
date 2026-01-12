ALTER TABLE [Core].[SessionContexts]
    ADD CONSTRAINT [DF_SessionContexts_Context] DEFAULT (context_info()) FOR [Context];

