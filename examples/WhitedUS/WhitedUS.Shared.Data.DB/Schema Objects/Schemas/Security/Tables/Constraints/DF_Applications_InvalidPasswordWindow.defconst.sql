ALTER TABLE [Security].[Applications]
    ADD CONSTRAINT [DF_Applications_InvalidPasswordWindow] DEFAULT ('0:05') FOR [InvalidPasswordWindow];

