
-- =============================================
-- Author:		Matthew Whited
-- Create date: 10/30/2011
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[ContentFrame_Delete]
	@ContentFrameID INT
AS
BEGIN
	SET NOCOUNT ON;
	
	DELETE
	FROM ContentFrames
	WHERE ContentFrameID = @ContentFrameID		

END