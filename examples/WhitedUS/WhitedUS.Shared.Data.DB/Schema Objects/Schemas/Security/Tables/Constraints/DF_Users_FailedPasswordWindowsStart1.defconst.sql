ALTER TABLE [Security].[Users]
    ADD CONSTRAINT [DF_Users_FailedPasswordWindowsStart1] DEFAULT ('1/1/1754') FOR [FailedAnswerWindowsStart];

