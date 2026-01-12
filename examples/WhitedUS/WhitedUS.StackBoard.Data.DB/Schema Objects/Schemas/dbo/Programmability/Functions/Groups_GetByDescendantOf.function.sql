
-- =============================================
-- Author:		Matthew Whited
-- Create date: 10/21/2011
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[Groups_GetByDescendantOf] 
(	
	@GroupID INT
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT 
		[GroupID]
		,[HId]
		,[Name]
		,[Description]
		,[HIdString]
		,[HIdLevel]
		,[ParentID]
	FROM Groups
	WHERE HID.IsDescendantOf((
			SELECT TOP 1 HID 
			FROM Groups 
			WHERE GroupID = @GroupID
		)) = 1
)