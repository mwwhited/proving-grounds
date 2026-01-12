
CREATE VIEW [dbo].[Folders_Read]
AS --
	SELECT 
		*
	FROM Folders
	WHERE 
		IsPublic = 1
		OR EXISTS (
			SELECT TOP 1 *
			FROM FoldersInRoles
			JOIN aspnet.Roles ON FoldersInRoles.RoleID = Roles.RoleID
			JOIN aspnet.UsersInRoles ON UsersInRoles.RoleID = FoldersInRoles.RoleID
			WHERE 
				UsersInRoles.UserID = dbo.GetUserID()
				AND FoldersInRoles.IsReader = 1
				AND Folders.StructureID.IsDescendantOf(FoldersInRoles.StructureID) = 1
		)