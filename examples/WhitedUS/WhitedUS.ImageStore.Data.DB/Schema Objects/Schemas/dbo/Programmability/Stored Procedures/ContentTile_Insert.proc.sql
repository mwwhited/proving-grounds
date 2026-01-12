

-- =============================================
-- Author:		Matthew Whited
-- Create date: 10/30/2011
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[ContentTile_Insert]
	@ContentFrameID	INT,
	@X				INT,
	@Y				INT,
	@Level			INT,
	@Data			VARBINARY(MAX),
	@ContentTypeID	INT
AS
BEGIN
	SET NOCOUNT ON;
	
	INSERT INTO ContentTiles (
		ContentFrameID
		,X
		,Y
		,[Level]
		,Data
		,ContentTypeID
     ) VALUES (
		@ContentFrameID 
		,@X
		,@Y
		,@Level
		,@Data
		,@ContentTypeID
	)
	
	DECLARE @insertedID INT = @@IDENTITY	
	SELECT 
		[ContentTileID]
		,[ContentFrameID]
		,[X]
		,[Y]
		,[Level]
		--,[Data]
		,[ContentTypeID]
		,[LastWriteTime]
	FROM ContentTiles
	WHERE [ContentTileID] = @insertedID

END