-- =============================================
-- Author:		Matthew Whited
-- Create date: 09/11/2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE Media_Delete
	@LocalID		INT
AS
BEGIN
	SET NOCOUNT ON;
	
	DELETE 
	FROM Media
	WHERE Media.LocalID = @LocalID
	
	SELECT @LocalID LocalID
	
END