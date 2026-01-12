
-- =============================================
-- Author:		Matthew Whited
-- Create date: 11/7/2011
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetUserID]
(
)
RETURNS UNIQUEIDENTIFIER
AS
BEGIN
	DECLARE @userID UNIQUEIDENTIFIER

	SET @userID = CASE dbo.IsGuid(HOST_NAME())
			WHEN 1 THEN CAST(HOST_NAME() AS UNIQUEIDENTIFIER)
			ELSE '00000000-0000-0000-0000-000000000000'
		END

	RETURN @userID

END