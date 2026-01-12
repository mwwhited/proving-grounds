ALTER TABLE [dbo].[FoldersInRoles]
    ADD CONSTRAINT [DF_FoldersInRoles_IsPublisher] DEFAULT ((0)) FOR [IsPublisher];

