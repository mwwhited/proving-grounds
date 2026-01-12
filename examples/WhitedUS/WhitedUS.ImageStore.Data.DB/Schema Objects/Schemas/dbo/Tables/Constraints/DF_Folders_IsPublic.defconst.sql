ALTER TABLE [dbo].[Folders]
    ADD CONSTRAINT [DF_Folders_IsPublic] DEFAULT ((0)) FOR [IsPublic];

