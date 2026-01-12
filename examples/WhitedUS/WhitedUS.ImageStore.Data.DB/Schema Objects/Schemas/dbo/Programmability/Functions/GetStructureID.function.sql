

-- =============================================
-- Author:		Matthew Whited
-- Create date: 11/8/2011
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetStructureID]
(
	@FolderID INT
)
RETURNS HIERARCHYID
AS
BEGIN
	-- Return the result of the function
	RETURN (SELECT TOP 1 StructureID 
			FROM [Folders] i 
			WHERE i.FolderID = @FolderID)

END