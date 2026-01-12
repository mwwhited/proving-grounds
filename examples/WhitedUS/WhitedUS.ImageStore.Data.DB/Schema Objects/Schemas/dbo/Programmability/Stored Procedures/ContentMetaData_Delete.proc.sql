-- =============================================
-- Author:		Matthew Whited
-- Create date: 11/6/2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE ContentMetaData_Delete
	@ContentMetaID	BIGINT
AS
BEGIN
	SET NOCOUNT ON;

	DELETE
	FROM ContentMetaData
	WHERE ContentMetaID = @ContentMetaID 
END