ALTER TABLE [dbo].[Scalings]
    ADD CONSTRAINT [DF_Scalings_CreatedDate] DEFAULT (getdate()) FOR [CreatedDate];

