ALTER TABLE [Security].[Users]
    ADD CONSTRAINT [DF_Users_CreationDate] DEFAULT (getutcdate()) FOR [CreationDate];

