ALTER TABLE [Security].[Users]
    ADD CONSTRAINT [DF_Users_CreationDate1] DEFAULT (getutcdate()) FOR [LastActivityDate];

