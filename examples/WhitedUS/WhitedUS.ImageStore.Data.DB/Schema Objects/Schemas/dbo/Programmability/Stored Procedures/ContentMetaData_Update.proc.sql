

-- =============================================
-- Author:		Matthew Whited
-- Create date: 11/6/2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ContentMetaData_Update]
	@ContentItemID	INT,
	@Name			NVARCHAR(200),
	@Value			NVARCHAR(MAX),
	@ContentMetaID	BIGINT
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE ContentMetaData
	SET 
		ContentItemID	= @ContentItemID
		,Name			= @Name
		,Value			= @Value
		,LastWriteDate	= GETUTCDATE()
	WHERE ContentMetaID = @ContentMetaID 
	
	SELECT 
		ContentMetaID
		,ContentItemID
		,Name
		,Value
		,[Length]
		,CreationDate
		,LastWriteDate
	FROM ContentMetaData
	WHERE ContentMetaID = @ContentMetaID
END