-- =============================================
-- Author:		Matthew Whited
-- Create date: 10/22/2011
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION GetFoldersByBranch
(	
	@CurrentID INT
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT *
	FROM [Folders]
	WHERE StructureID.IsDescendantOf((
		SELECT StructureID
		FROM Folders i
		WHERE i.FolderID = @CurrentID
		)) = 1
)