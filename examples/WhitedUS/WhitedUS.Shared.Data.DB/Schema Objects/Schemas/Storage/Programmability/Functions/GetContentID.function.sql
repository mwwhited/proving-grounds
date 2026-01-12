






-- =============================================
-- Author:		Matthew Whited
-- Create date: 11/8/2011
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION Storage.[GetContentID]
(
	@StructureID HIERARCHYID
)
RETURNS INT
AS
BEGIN
	-- Return the result of the function
	RETURN (SELECT TOP 1 ContentItemID 
			FROM ContentItems i 
			WHERE i.StructureID = @StructureID
			)

END