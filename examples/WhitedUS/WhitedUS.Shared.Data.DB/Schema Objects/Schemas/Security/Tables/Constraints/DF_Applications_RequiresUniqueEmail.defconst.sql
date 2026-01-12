ALTER TABLE [Security].[Applications]
    ADD CONSTRAINT [DF_Applications_RequiresUniqueEmail] DEFAULT ((0)) FOR [RequiresUniqueEmail];

