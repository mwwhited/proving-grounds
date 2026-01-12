
-- =============================================
-- Author:		Matthew Whited
-- Create date: 11/7/2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetDeepZoomCollection]
	@TileSize		INT				= 256,
	@Format			NVARCHAR(100)	= 'JPG',
	@FolderID		INT				= NULL,
	@Recursive		BIT				= NULL,
	@ContentItemID	INT				= NULL
AS
BEGIN
	SET NOCOUNT ON;
;
	WITH Frames AS (
		SELECT 
			[Items].[Name]
			,Frames.[Index]
			,[Frames].[ContentFrameID]
			,[Frames].[Width]
			,[Frames].[Height]
		FROM Folders		AS [Folders]
		JOIN ContentItems	AS [Items]
			ON [Folders].[FolderID] = [Items].[FolderID]
		JOIN ContentFrames	As [Frames]
			ON [Items].[ContentItemID] = [Frames].[ContentItemID]

		WHERE (
				@Recursive = 1 
				AND StructureID.IsDescendantOf((
					SELECT TOP 1 StructureID
					FROM Folders i
					WHERE i.FolderID = @FolderID
					)) = 1
		) 
		OR [Folders].[FolderID] = @FolderID
		OR [Items].[ContentItemID] = @ContentItemID
		OR (
			@FolderID IS NULL 
			AND @Recursive IS NULL 
			AND @ContentItemID IS NULL
			)
	)
	SELECT 
		/*CAST(CEILING(LOG(CASE 
			WHEN MAX(Width) > MAX(Height) THEN MAX(Width)
			ELSE MAX(Height)
		END)/LOG(2)) AS SMALLINT)*/ 0	"@MaxLevel"
		,@TileSize					"@TileSize"
		,@Format					"@Format"
		,(SELECT COUNT(*)
			FROM Frames
		)							"@NextItemId"
		,CAST((
			SELECT 
				[ContentFrameID]	"@N"
				,[ContentFrameID]	"@Id"
				,[Width]			"Size/@Width"
				,[Height]			"Size/@Height"		
			FROM Frames
			FOR XML PATH('I')
		) AS XML)					"Items"
	--FROM Frames
	FOR XML PATH('Collection')
END