

-- =============================================
-- Author:		Matthew Whited
-- Create date: 10/30/2011
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[ContentItem_Update]
	@Name			NVARCHAR(200),
	@Description	NVARCHAR(MAX),
	@Data			VARBINARY(MAX),
	@ContentTypeID	INT,
	@FolderID		INT,
	@ContentItemID	INT
AS
BEGIN
	SET NOCOUNT ON;
	
	UPDATE ContentItems
	SET
		[Name]			= @Name,
		[Description]	= @Description,
		[Data]			= @Data,
		[ContentTypeID]	= @ContentTypeID,
		[FolderID]		= @FolderID,
		[LastAccessTime]= GETUTCDATE(),
		[LastWriteTime]	= GETUTCDATE()		
	WHERE [ContentItemID] = @ContentItemID
		
	SELECT 
		[ContentItemID]
		,[RowID]
		,[Name]
		,[Description]
		,[CreationTime]
		,[LastAccessTime]
		,[LastWriteTime]
		--,[Data]
		,[ContentTypeID]
		,[FolderID]
	FROM [ContentItems]
	WHERE [ContentItemID] = @ContentItemID

END