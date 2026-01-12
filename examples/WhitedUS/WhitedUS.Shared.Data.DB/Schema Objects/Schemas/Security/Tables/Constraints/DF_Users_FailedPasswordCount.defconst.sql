ALTER TABLE [Security].[Users]
    ADD CONSTRAINT [DF_Users_FailedPasswordCount] DEFAULT ((0)) FOR [FailedPasswordCount];

