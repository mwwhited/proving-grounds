


-- =============================================
-- Author:		Matthew Whited
-- Create date: 10/30/2011
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[ContentTile_Update]
	@ContentFrameID	INT,
	@X				INT,
	@Y				INT,
	@Level			INT,
	@Data			VARBINARY(MAX),
	@ContentTypeID	INT,
	@ContentTileID	BIGINT
AS
BEGIN
	SET NOCOUNT ON;
	
	UPDATE ContentTiles
	SET 
		[ContentFrameID] = @ContentFrameID
		,[X] = @X
		,[Y] = @Y
		,[Level] = @Level
		,[Data] = @Data
		,[ContentTypeID] = @ContentTypeID
		,[LastWriteTime] = GETUTCDATE()
	WHERE ContentTileID = @ContentTileID		
	
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
	WHERE ContentTileID = @ContentTileID

END