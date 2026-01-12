

-- =============================================
-- Author:		Matthew Whited
-- Create date: 10/22/2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[TaskType_Delete]
	@taskTypeID		INT
AS
BEGIN
	SET NOCOUNT ON;

	DELETE TaskTypes
	WHERE TaskTypeID = @taskTypeID 
	
	SELECT 
		 @taskTypeID	AS TaskTypeID

END