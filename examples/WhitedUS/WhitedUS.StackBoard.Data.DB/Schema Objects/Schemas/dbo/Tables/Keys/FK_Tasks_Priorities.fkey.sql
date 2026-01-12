ALTER TABLE [dbo].[Tasks]
    ADD CONSTRAINT [FK_Tasks_Priorities] FOREIGN KEY ([PriorityID]) REFERENCES [dbo].[Priorities] ([PriorityID]) ON DELETE NO ACTION ON UPDATE NO ACTION;

