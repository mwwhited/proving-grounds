ALTER TABLE [dbo].[Tasks]
    ADD CONSTRAINT [DF_Tasks_CreatedDate] DEFAULT (getutcdate()) FOR [CreatedDate];

