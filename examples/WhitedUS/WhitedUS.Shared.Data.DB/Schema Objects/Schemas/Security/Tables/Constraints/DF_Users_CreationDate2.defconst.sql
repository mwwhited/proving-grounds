ALTER TABLE [Security].[Users]
    ADD CONSTRAINT [DF_Users_CreationDate2] DEFAULT (getutcdate()) FOR [LastLockoutDate];

