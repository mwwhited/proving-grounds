
-- =============================================
-- Author:		Matthew Whited
-- Create date: 10/22/2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[State_Update]
	@stateId		INT,
	@name			NVARCHAR(200),
	@description	NVARCHAR(MAX),
	@taskTypeID		INT
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE States
	SET Name			= @name,
		[Description]	= @description,
		TaskTypeID		= @taskTypeID 
	WHERE StateID	= @stateId 

	SELECT 
		 @stateId		AS [StateID]
		,@name			AS [Name]
		,@description	AS [Description]
		,@taskTypeID	AS TaskTypeID
		
END