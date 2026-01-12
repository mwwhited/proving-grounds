ALTER TABLE [Security].[Users]
    ADD CONSTRAINT [DF_Users_CreationDate3] DEFAULT (getutcdate()) FOR [LastLoginDate];

