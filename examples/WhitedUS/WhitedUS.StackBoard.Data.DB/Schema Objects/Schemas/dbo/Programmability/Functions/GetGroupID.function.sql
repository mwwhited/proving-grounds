-- =============================================
-- Author:		Matthew Whited
-- Create date: 10/20/2011
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetGroupID]
(
	@hid HIERARCHYID
)
RETURNS INT
AS
BEGIN
	-- Return the result of the function
	RETURN (SELECT TOP 1 GroupID 
			FROM Groups i 
			WHERE i.HId = @hid)

END