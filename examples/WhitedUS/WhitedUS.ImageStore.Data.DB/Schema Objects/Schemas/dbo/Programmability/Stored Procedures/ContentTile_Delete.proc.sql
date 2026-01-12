


-- =============================================
-- Author:		Matthew Whited
-- Create date: 10/30/2011
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[ContentTile_Delete]
	@ContentTileID BIGINT
AS
BEGIN
	SET NOCOUNT ON;
	
	DELETE
	FROM ContentTiles
	WHERE ContentTileID = @ContentTileID	

END