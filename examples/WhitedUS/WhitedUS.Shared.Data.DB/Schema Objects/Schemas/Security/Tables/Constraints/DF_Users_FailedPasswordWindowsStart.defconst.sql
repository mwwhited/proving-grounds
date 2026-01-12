ALTER TABLE [Security].[Users]
    ADD CONSTRAINT [DF_Users_FailedPasswordWindowsStart] DEFAULT ('1/1/1754') FOR [FailedPasswordWindowsStart];

