


-- =============================================
-- Author:		Matthew Whited
-- Create date: 11/7/2011
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [Security].[GetUserID]
(
)
RETURNS UNIQUEIDENTIFIER
AS
BEGIN
	DECLARE @userID UNIQUEIDENTIFIER

	SET @userID = (
		SELECT TOP 1 UserID
		FROM [Logging].[Sessions]
		WHERE [ContextInfo] = CONTEXT_INFO()
	)

	RETURN @userID

END