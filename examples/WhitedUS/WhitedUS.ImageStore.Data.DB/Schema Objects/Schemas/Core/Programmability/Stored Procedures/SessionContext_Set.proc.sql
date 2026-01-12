

-- =============================================
-- Author:		Matthew Whited
-- Create date: 11/10/2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [Core].[SessionContext_Set]
	@Context			VARBINARY(128)
AS
BEGIN
	SET NOCOUNT ON;

	SET CONTEXT_INFO @Context;
	
	UPDATE Core.SessionContexts
	SET LastUsedOn = GETUTCDATE()
	WHERE Context = CONTEXT_INFO();
	
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