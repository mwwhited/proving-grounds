ALTER TABLE [Security].[Roles]
    ADD CONSTRAINT [DF_Roles_RoleID] DEFAULT (newid()) FOR [RoleID];

