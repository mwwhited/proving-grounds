

CREATE VIEW [dbo].[Folders_Publish]
AS --
	SELECT 
		*
	FROM Folders
	WHERE 
		EXISTS (
			SELECT TOP 1 *
			FROM FoldersInRoles
			JOIN aspnet.Roles ON FoldersInRoles.RoleID = Roles.RoleID
			JOIN aspnet.UsersInRoles ON UsersInRoles.RoleID = FoldersInRoles.RoleID
			WHERE 
				UsersInRoles.UserID = dbo.GetUserID()
				AND FoldersInRoles.IsPublisher = 1
				AND Folders.StructureID.IsDescendantOf(FoldersInRoles.StructureID) = 1
		)