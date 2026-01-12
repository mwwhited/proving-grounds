ALTER TABLE [dbo].[ResourceTags]
    ADD CONSTRAINT [DF_ResourceTags_CreatedOn] DEFAULT (getdate()) FOR [CreatedOn];

