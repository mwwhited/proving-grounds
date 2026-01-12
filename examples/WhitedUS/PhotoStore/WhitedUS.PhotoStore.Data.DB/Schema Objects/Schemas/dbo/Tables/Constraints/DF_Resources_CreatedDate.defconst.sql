ALTER TABLE [dbo].[Resources]
    ADD CONSTRAINT [DF_Resources_CreatedDate] DEFAULT (getdate()) FOR [CreatedDate];

