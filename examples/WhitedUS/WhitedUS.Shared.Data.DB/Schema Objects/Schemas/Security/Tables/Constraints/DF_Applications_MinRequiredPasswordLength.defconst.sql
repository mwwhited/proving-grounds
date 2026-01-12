ALTER TABLE [Security].[Applications]
    ADD CONSTRAINT [DF_Applications_MinRequiredPasswordLength] DEFAULT ((8)) FOR [MinRequiredPasswordLength];

