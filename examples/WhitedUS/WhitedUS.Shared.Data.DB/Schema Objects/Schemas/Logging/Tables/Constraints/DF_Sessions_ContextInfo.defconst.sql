ALTER TABLE [Logging].[Sessions]
    ADD CONSTRAINT [DF_Sessions_ContextInfo] DEFAULT (context_info()) FOR [ContextInfo];

