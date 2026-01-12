
-- =============================================
-- Author:		Matthew Whited
-- Create date: 09/12/2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[MediaTypes_Insert]
	@Name			NVARCHAR(50),
	@CodeTypeID		INT
AS
BEGIN
	SET NOCOUNT ON;
	
	INSERT INTO MediaTypes (
		Name,
		CodeTypeID
	) VALUES (
		@Name
		,@CodeTypeID
	)
	
	DECLARE @insertedID INT = @@IDENTITY
	
	SELECT @insertedID LocalID
	
END