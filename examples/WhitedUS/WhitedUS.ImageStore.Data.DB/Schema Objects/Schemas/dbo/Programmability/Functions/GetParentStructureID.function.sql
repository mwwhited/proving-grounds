/*-- =============================================
-- Author:		Matthew Whited
-- Create date: 10/20/2011
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION GetParentStructureID
(
	@StructureID HIERARCHYID
)
RETURNS HIERARCHYID
AS
BEGIN
	-- Return the result of the function
	RETURN (SELECT TOP 1 [StructureID] 
			FROM [Folders] i 
			WHERE i.[StructureID] = @StructureID.GetAncestor(1))

END*/