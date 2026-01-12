


-- =============================================
-- Author:		Matthew Whited
-- Create date: 10/22/2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[TaskType_Update]
	@taskTypeId		INT,
	@name			NVARCHAR(200),
	@description	NVARCHAR(MAX),
	@handlerType	NVARCHAR(MAX),
	@configuration	XML
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE TaskTypes
	SET [Name]			= @name,
		[Description]	= @description,
		[HandlerType]	= @handlerType,
		[Configuration] = @configuration
	WHERE TaskTypeID	= @taskTypeId 

	SELECT 
		 @taskTypeId	AS [TaskTypeID]
		,@name			AS [Name]
		,@description	AS [Description]
		,@handlerType	AS [HandlerType]
		,@configuration	AS [Configuration]
		
END