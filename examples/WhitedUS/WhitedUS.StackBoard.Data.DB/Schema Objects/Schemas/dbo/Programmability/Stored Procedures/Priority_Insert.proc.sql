

-- =============================================
-- Author:		Matthew Whited
-- Create date: 10/22/2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Priority_Insert]
	@name			NVARCHAR(200),
	@description	NVARCHAR(MAX),
	@weight			INT
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO Priorities (
		Name,
		[Description],
		[Weight]
	) VALUES (
		@name,
		@description,
		@weight
	)	
	
	DECLARE @insertedId INT = @@IDENTITY
	SELECT 
		@insertedId		AS [PriorityID]
		,@name			AS [Name]
		,@description	AS [Description]
		,@weight		AS [Weight]

END