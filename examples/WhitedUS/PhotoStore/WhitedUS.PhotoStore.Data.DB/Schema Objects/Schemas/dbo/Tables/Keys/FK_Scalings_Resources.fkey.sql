ALTER TABLE [dbo].[Scalings]
    ADD CONSTRAINT [FK_Scalings_Resources] FOREIGN KEY ([ResourceID]) REFERENCES [dbo].[Resources] ([ResourceID]) ON DELETE CASCADE ON UPDATE NO ACTION;



