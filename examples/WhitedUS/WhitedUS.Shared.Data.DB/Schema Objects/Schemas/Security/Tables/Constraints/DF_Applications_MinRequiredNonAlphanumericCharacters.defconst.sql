ALTER TABLE [Security].[Applications]
    ADD CONSTRAINT [DF_Applications_MinRequiredNonAlphanumericCharacters] DEFAULT ((0)) FOR [MinRequiredNonAlphanumericCharacters];

