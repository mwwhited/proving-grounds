-- =============================================
-- Author:		Matthew Whited
-- Create date: 11/14/2011
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION Storage.ResolvePathFromID
(
	@ContentItemID	INT
)
RETURNS NVARCHAR(MAX)
AS
BEGIN
	DECLARE @resolvedPath NVARCHAR(MAX)

	SELECT TOP 1 @resolvedPath = (
			SELECT 
				CASE
					WHEN EXISTS (
						SELECT *
						FROM Storage.ContentItems children
						WHERE children.StructureID.IsDescendantOf(parents.StructureID) = 1
							AND children.StructureID != parents.StructureID
					) THEN parents.Name + '/'
					ELSE parents.Name
				END
			FROM Storage.ContentItems parents
			WHERE selection.StructureID.IsDescendantOf(parents.StructureID) = 1 
			ORDER BY parents.StructureID
			FOR XML PATH('')
		)
	FROM Storage.ContentItems selection
	WHERE selection.ContentItemID = @ContentItemID

	RETURN @resolvedPath

END