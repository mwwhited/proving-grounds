
-- =============================================
-- Author:		Matthew Whited
-- Create date: 10/22/2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Priority_Update]
	@priorityId		INT,
	@name			NVARCHAR(200),
	@description	NVARCHAR(MAX),
	@weight			INT
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE Priorities
	SET Name			= @name,
		[Description]	= @description,
		[Weight]		= @weight
	WHERE PriorityID	= @priorityId 

	SELECT 
		 @priorityId	AS [PriorityID]
		,@name			AS [Name]
		,@description	AS [Description]
		,@weight		AS [Weight]

END