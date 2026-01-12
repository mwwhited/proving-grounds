

-- =============================================
-- Author:		Matthew Whited
-- Create date: 10/22/2011
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION Storage.[GetContentByBranch]
(	
	@ContentItemID INT
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT *
	FROM ContentItems
	WHERE StructureID.IsDescendantOf((
		SELECT TOP 1 StructureID
		FROM ContentItems i
		WHERE i.ContentItemID = @ContentItemID
		)) = 1
)