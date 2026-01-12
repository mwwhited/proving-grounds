ALTER TABLE [Security].[Users]
    ADD CONSTRAINT [DF_Users_IsOnline] DEFAULT ((0)) FOR [IsOnline];

