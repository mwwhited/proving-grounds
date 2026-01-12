


-- =============================================
-- Author:		Matthew Whited
-- Create date: 10/30/2011
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[ContentItem_Touch]
	@ContentItemID	INT
AS
BEGIN
	SET NOCOUNT ON;
	
	UPDATE ContentItems
	SET LastAccessTime = GETUTCDATE()
	WHERE ContentItemID = @ContentItemID	

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