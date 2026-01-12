ALTER TABLE [Security].[Users]
    ADD CONSTRAINT [DF_Users_CreationDate4] DEFAULT (getutcdate()) FOR [LastPasswordChangedDate];

