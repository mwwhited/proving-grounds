ALTER TABLE [dbo].[FoldersInRoles]
    ADD CONSTRAINT [DF_FoldersInRoles_IsReader] DEFAULT ((0)) FOR [IsReader];

