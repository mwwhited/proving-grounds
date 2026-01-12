ALTER TABLE [Security].[Users]
    ADD CONSTRAINT [DF_Users_IsLockedOut] DEFAULT ((0)) FOR [IsLockedOut];

