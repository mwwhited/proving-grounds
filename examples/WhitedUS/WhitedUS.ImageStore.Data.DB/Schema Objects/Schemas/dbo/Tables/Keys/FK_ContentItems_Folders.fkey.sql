ALTER TABLE [dbo].[ContentItems]
    ADD CONSTRAINT [FK_ContentItems_Folders] FOREIGN KEY ([FolderID]) REFERENCES [dbo].[Folders] ([FolderID]) ON DELETE NO ACTION ON UPDATE NO ACTION;

