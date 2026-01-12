ALTER TABLE [dbo].[Resources]
    ADD CONSTRAINT [FK_Resources_BasePaths] FOREIGN KEY ([BasePathID]) REFERENCES [dbo].[BasePaths] ([BasePathID]) ON DELETE NO ACTION ON UPDATE NO ACTION;

