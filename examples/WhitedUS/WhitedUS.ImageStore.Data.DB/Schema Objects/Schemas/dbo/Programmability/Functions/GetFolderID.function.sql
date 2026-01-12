
-- =============================================
-- Author:		Matthew Whited
-- Create date: 11/7/2011
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetFolderID]
(
	@StructureID HIERARCHYID
)
RETURNS INT
AS
BEGIN
	-- Return the result of the function
	RETURN (SELECT TOP 1 [FolderID] 
			FROM [Folders] i 
			WHERE i.[StructureID] = @StructureID)

END