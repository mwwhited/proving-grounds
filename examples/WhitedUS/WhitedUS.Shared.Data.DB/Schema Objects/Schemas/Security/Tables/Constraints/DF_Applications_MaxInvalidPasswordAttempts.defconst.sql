ALTER TABLE [Security].[Applications]
    ADD CONSTRAINT [DF_Applications_MaxInvalidPasswordAttempts] DEFAULT ((5)) FOR [MaxInvalidPasswordAttempts];

