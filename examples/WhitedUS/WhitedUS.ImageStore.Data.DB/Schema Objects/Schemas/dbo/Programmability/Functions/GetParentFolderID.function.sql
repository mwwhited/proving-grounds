-- =============================================
-- Author:		Matthew Whited
-- Create date: 10/20/2011
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION GetParentFolderID
(
	@StructureID HIERARCHYID
)
RETURNS INT
AS
BEGIN
	-- Return the result of the function
	RETURN (SELECT TOP 1 [FolderID] 
			FROM [Folders] i 
			WHERE i.[StructureID] = @StructureID.GetAncestor(1))

END