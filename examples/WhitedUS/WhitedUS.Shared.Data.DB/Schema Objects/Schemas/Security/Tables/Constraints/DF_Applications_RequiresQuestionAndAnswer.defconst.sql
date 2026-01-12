ALTER TABLE [Security].[Applications]
    ADD CONSTRAINT [DF_Applications_RequiresQuestionAndAnswer] DEFAULT ((0)) FOR [RequiresQuestionAndAnswer];

