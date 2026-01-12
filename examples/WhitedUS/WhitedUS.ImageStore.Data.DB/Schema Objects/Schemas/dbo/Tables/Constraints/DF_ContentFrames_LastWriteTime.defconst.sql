ALTER TABLE [dbo].[ContentFrames]
    ADD CONSTRAINT [DF_ContentFrames_LastWriteTime] DEFAULT (getutcdate()) FOR [LastWriteTime];

