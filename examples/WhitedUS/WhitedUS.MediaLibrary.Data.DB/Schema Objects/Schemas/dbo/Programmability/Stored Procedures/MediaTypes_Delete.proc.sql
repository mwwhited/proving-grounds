
-- =============================================
-- Author:		Matthew Whited
-- Create date: 09/12/2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[MediaTypes_Delete]
	@LocalID		INT
AS
BEGIN
	SET NOCOUNT ON;
	
	DELETE 
	FROM MediaTypes
	WHERE MediaTypes.LocalID = @LocalID
	
	SELECT @LocalID LocalID
	
END