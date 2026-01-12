ALTER TABLE [dbo].[FoldersInRoles]
    ADD CONSTRAINT [DF_FoldersInRoles_IsWriter] DEFAULT ((0)) FOR [IsWriter];

