ALTER TABLE [dbo].[Tasks]
    ADD CONSTRAINT [DF_Tasks_ModifiedDate] DEFAULT (getutcdate()) FOR [ModifiedDate];

