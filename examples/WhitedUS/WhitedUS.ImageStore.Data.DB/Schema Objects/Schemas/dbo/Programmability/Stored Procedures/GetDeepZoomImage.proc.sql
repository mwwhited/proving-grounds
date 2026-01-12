
-- =============================================
-- Author:		Matthew Whited
-- Create date: 11/7/2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetDeepZoomImage]
	@TileSize		INT				= 256,
	@OverLap		INT				= 0,
	@Format			NVARCHAR(100)	= 'JPG',
	@ContentFrameID	INT
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT 
		@TileSize	"@TileSize"
		,@OverLap	"@OverLap"
		,@Format	"@Format"
		,[Width]	"Size/@Width"
		,[Height]	"Size/@Height"
	FROM ContentFrames
	WHERE ContentFrameID = @ContentFrameID
	FOR XML PATH('Image')

END