ALTER TABLE [Security].[Applications]
    ADD CONSTRAINT [DF_Applications_EnablePasswordReset] DEFAULT ((0)) FOR [EnablePasswordReset];

