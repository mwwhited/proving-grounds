-- =============================================
-- Author:		Matthew Whited
-- Create date: 10/22/2011
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION GetFoldersByParentID
(	
	@ParentID INT
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT *
	FROM [Folders]
	WHERE StructureID.GetAncestor(1) = (
		SELECT StructureID
		FROM Folders i
		WHERE i.FolderID = @ParentID
		)	
)