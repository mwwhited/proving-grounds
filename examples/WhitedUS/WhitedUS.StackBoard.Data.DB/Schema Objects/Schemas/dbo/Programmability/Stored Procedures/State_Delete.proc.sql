
-- =============================================
-- Author:		Matthew Whited
-- Create date: 10/22/2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[State_Delete]
	@stateId		INT
AS
BEGIN
	SET NOCOUNT ON;

	DELETE States
	WHERE StateID = @stateId 
	
	SELECT 
		 @stateId	AS StateID

END