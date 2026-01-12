


-- =============================================
-- Author:		Matthew Whited
-- Create date: 10/30/2011
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[ContentType_Update]
	@Name			NVARCHAR(200),
	@Description	NVARCHAR(MAX),
	@Extension		NVARCHAR(10),
	@MimeType		NVARCHAR(1024),
	@IsSingleFrame	BIT,
	@ContentTypeID	INT
AS
BEGIN
	SET NOCOUNT ON;
	
	UPDATE ContentTypes
	SET 
		[Name]			= @Name
		,[Description]	= @Description
		,[Extension]	= @Extension
		,[MimeType]		= @MimeType
		,[IsSingleFrame]= @IsSingleFrame
	WHERE ContentTypeID = @ContentTypeID		
	
	SELECT 
		[ContentTypeID]
		,[Name]
		,[Description]
		,[Extension]
		,[MimeType]
		,[IsSingleFrame]
	FROM ContentTypes
	WHERE [ContentTypeID] = @ContentTypeID
END