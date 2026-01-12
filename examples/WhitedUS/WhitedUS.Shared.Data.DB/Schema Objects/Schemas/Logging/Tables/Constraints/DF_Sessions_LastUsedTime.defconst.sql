ALTER TABLE [Logging].[Sessions]
    ADD CONSTRAINT [DF_Sessions_LastUsedTime] DEFAULT (getutcdate()) FOR [LastUsedTime];

