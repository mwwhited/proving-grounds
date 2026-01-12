



-- =============================================
-- Author:		Matthew Whited
-- Create date: 10/22/2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[TaskType_Insert]
	@name			NVARCHAR(200),
	@description	NVARCHAR(MAX),
	@handlerType		NVARCHAR(MAX),
	@configuration	XML
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO TaskTypes (
		Name,
		[Description],
		HandlerType,
		Configuration 
	) VALUES (
		@name,
		@description,
		@handlerType,
		@configuration
	)	
	
	DECLARE @insertedId INT = @@IDENTITY
	SELECT 
		@insertedId			AS [TaskTypeID]
		,@name				AS [Name]
		,@description		AS [Description]
		,@handlerType		AS [HandlerType]
		,@configuration		AS [Configuration]

END