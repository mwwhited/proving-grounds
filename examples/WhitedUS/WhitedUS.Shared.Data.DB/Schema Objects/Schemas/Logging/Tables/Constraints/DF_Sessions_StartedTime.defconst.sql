ALTER TABLE [Logging].[Sessions]
    ADD CONSTRAINT [DF_Sessions_StartedTime] DEFAULT (getutcdate()) FOR [StartedTime];

