


-- =============================================
-- Author:		Matthew Whited
-- Create date: 10/30/2011
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[ContentType_Insert]
	@Name			NVARCHAR(200),
	@Description	NVARCHAR(MAX),
	@Extension		NVARCHAR(10),
	@MimeType		NVARCHAR(1024),
	@IsSingleFrame	BIT
AS
BEGIN
	SET NOCOUNT ON;
	
	INSERT INTO ContentTypes (
		Name
		,[Description]
		,[Extension]
		,[MimeType]	
		,[IsSingleFrame]
     ) VALUES (
		@Name
		,@Description
		,@Extension
		,@MimeType
		,@IsSingleFrame
	)
	
	DECLARE @insertedID INT = @@IDENTITY	
	SELECT 
		[ContentTypeID]
		,[Name]
		,[Description]
		,[Extension]
		,[MimeType]
		,[IsSingleFrame]
	FROM ContentTypes
	WHERE [ContentTypeID] = @insertedID

END