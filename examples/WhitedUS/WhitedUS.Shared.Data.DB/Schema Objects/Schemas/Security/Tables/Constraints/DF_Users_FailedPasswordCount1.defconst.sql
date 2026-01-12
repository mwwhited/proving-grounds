ALTER TABLE [Security].[Users]
    ADD CONSTRAINT [DF_Users_FailedPasswordCount1] DEFAULT ((0)) FOR [FailedAnswerCount];

