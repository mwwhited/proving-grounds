-- =============================================
-- Author:		Matthew Whited
-- Create date: 10/22/2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE Priority_Delete
	@priorityId		INT
AS
BEGIN
	SET NOCOUNT ON;

	DELETE Priorities
	WHERE PriorityID = @priorityId 
	
	SELECT 
		 @priorityId	AS [PriorityID]

END