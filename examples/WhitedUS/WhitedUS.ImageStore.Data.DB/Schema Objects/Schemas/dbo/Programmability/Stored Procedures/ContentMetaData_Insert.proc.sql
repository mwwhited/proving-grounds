

-- =============================================
-- Author:		Matthew Whited
-- Create date: 11/6/2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ContentMetaData_Insert]
	@ContentItemID	INT,
	@Name			NVARCHAR(200),
	@Value			NVARCHAR(MAX)
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO ContentMetaData (
		ContentItemID
		,Name
		,Value
     ) VALUES (
		@ContentItemID,
		@Name,
		@Value
	)
	
	DECLARE @insertedID INT = @@IDENTITY	
	SELECT 
		ContentMetaID
		,ContentItemID
		,Name
		,Value
		,[Length]
		,CreationDate
		,LastWriteDate
	FROM ContentMetaData
	WHERE ContentMetaID = @insertedID
END