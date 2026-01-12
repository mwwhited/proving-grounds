

-- =============================================
-- Author:		Matthew Whited
-- Create date: 10/30/2011
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[ContentType_Delete]
	@ContentTypeID INT
AS
BEGIN
	SET NOCOUNT ON;
	
	DELETE
	FROM ContentTypes
	WHERE ContentTypeID = @ContentTypeID	

END