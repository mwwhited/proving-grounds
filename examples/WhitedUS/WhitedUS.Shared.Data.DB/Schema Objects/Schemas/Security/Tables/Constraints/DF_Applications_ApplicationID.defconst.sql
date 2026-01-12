ALTER TABLE [Security].[Applications]
    ADD CONSTRAINT [DF_Applications_ApplicationID] DEFAULT (newid()) FOR [ApplicationID];

