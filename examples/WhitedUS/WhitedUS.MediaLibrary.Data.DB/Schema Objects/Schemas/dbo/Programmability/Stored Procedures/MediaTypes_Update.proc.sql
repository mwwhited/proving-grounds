
-- =============================================
-- Author:		Matthew Whited
-- Create date: 09/12/2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[MediaTypes_Update]
	@LocalID		INT,
	@Name			NVARCHAR(50),
	@CodeTypeID		INT
AS
BEGIN
	SET NOCOUNT ON;
	
	UPDATE MediaTypes
	SET
		Name = @Name,
		CodeTypeID = @CodeTypeID
	WHERE MediaTypes.LocalID = @LocalID
	
	SELECT @LocalID LocalID
	
END