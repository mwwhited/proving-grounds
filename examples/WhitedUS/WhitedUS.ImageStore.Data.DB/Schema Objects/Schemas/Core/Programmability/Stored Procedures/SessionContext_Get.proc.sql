


-- =============================================
-- Author:		Matthew Whited
-- Create date: 11/10/2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [Core].[SessionContext_Get]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT 
		[SessionContextID]
		,[Context]
		,[ContextID]
		,[ASPNET_UserID]
		,[ApplicationName]
		,[ExecutingAssembly]
		,[CreatedOn]
		,[LastUsedOn]
	FROM Core.[SessionContexts]
	WHERE [Context] = CONTEXT_INFO()
	
END