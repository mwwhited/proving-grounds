ALTER TABLE [Security].[Users]
    ADD CONSTRAINT [DF_Users_IsServiceAccount] DEFAULT ((0)) FOR [IsServiceAccount];

