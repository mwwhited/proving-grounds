-- =============================================
-- Author:		Matthew Whited
-- Create date: 11/14/2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE Storage.GetContentByPath
	@input		NVARCHAR(MAX)
AS
BEGIN
	SET NOCOUNT ON;

	WITH PartPositions AS (		-- find values in in path string
		SELECT 0 StartPosition, 1 [EndPosition] 
		UNION ALL 
		SELECT [EndPosition], CONVERT(INT,CHARINDEX('/', REPLACE(@input, '\', '/'), [EndPosition]) + LEN('/')) 
		FROM PartPositions 
		WHERE [EndPosition] > StartPosition 
	), PathParts As (			-- split path parts into a row set
		SELECT 
			ROW_NUMBER() OVER (ORDER BY StartPosition)-1 [Level]
			,SUBSTRING(@input,StartPosition,CASE 
				WHEN [EndPosition] > LEN('/') THEN [EndPosition]-StartPosition-LEN('/') 
				ELSE LEN(@input) - StartPosition + 1 
			END) [Value]
		FROM PartPositions 
		WHERE StartPosition > 0 
	), PathSubset AS (			-- match path parts to content items
		SELECT
			ci.ContentItemID
			,ci.Name
			,ci.StructureIDLevel		AS [Level]
			,ci.StructureID
		FROM Storage.ContentItems ci
		JOIN PathParts sp
			ON ci.Name = sp.[Value]
			AND ci.StructureIDLevel = sp.[Level]
	), CheckedPaths As (		-- resolve full path
		SELECT *
		FROM PathSubset
		WHERE [Level] = 0
		UNION ALL 
		SELECT PathSubset.*
		FROM PathSubset
		JOIN CheckedPaths ON PathSubset.StructureID.GetAncestor(1) = CheckedPaths.StructureID
	), SelectedContentItem AS (	-- select row only if all sections of the path match
		SELECT TOP 1 *
		FROM Storage.ContentItems
		WHERE ContentItemID = (
			SELECT TOP 1 ContentItemID
			FROM CheckedPaths
			WHERE CheckedPaths.[Level] = (
				SELECT MAX([Level])
				FROM PathParts
			)
		)
	)
	SELECT *
	FROM SelectedContentItem
	
END