ALTER TABLE [Security].[Users]
    ADD CONSTRAINT [DF_Users_UserID] DEFAULT (newid()) FOR [UserID];

