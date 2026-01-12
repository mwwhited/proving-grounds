ALTER TABLE [Security].[Users]
    ADD CONSTRAINT [DF_Users_IsEnabled] DEFAULT ((0)) FOR [IsApproved];

