
-- =============================================
-- Author:		Matthew Whited
-- Create date: 10/22/2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[State_Insert]
	@name			NVARCHAR(200),
	@description	NVARCHAR(MAX),
	@taskTypeID		INT
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO States (
		Name,
		[Description],
		TaskTypeID 
	) VALUES (
		@name,
		@description,
		@taskTypeID
	)	
	
	DECLARE @insertedId INT = @@IDENTITY
	SELECT 
		@insertedId			AS [StateID]
		,@name				AS [Name]
		,@description		AS [Description]
		,@taskTypeID		AS [TaskTypeID]
	FROM Priorities

END