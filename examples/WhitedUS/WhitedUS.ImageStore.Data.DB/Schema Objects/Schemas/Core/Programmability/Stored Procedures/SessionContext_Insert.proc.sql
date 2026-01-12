

-- =============================================
-- Author:		Matthew Whited
-- Create date: 11/10/2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [Core].[SessionContext_Insert]
	@Aspnet_UserID		UNIQUEIDENTIFIER	= NULL,
	@ApplicationName	NVARCHAR(MAX)		= NULL,
	@ExecutingAssembly	NVARCHAR(MAX)		= NULL
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @SessionContextID	BIGINT,
			@Context			VARBINARY(128),
			@ContextID			UNIQUEIDENTIFIER

	SET @ContextID	= NEWID();
	SET @Context	= CAST(@ContextID AS VARBINARY(128))
	
	SET CONTEXT_INFO @Context;

	INSERT INTO [Core].[SessionContexts] (
		[ASPNET_UserID]
	   ,[ApplicationName]
	   ,[ExecutingAssembly]
	) VALUES (
		@Aspnet_UserID
	   ,@ApplicationName
	   ,@ExecutingAssembly
	);
	
	SELECT @SessionContextID = SCOPE_IDENTITY() 
	
	SELECT 
		[SessionContextID]
		,[Context]
		,[ContextID]
		,[ASPNET_UserID]
		,[ApplicationName]
		,[ExecutingAssembly]
		,[CreatedOn]
		,[LastUsedOn]
	FROM [SessionContexts]
	WHERE SessionContextID = @SessionContextID
	
END