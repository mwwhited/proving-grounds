ALTER TABLE [Security].[Applications]
    ADD CONSTRAINT [DF_Applications_PasswordAttemptWindow] DEFAULT ((5)) FOR [PasswordAttemptWindow];

