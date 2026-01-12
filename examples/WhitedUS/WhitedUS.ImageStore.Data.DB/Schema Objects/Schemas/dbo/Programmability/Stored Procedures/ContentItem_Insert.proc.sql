

-- =============================================
-- Author:		Matthew Whited
-- Create date: 10/30/2011
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[ContentItem_Insert]
	@Name			NVARCHAR(200),
	@Description	NVARCHAR(MAX),
	@Data			VARBINARY(MAX),
	@ContentTypeID	INT,
	@FolderID		INT
AS
BEGIN
	SET NOCOUNT ON;
	
	INSERT INTO [ContentItems] (
		[Name],
		[Description],
		[Data],
		[ContentTypeID],
		[FolderID]
     ) VALUES (
		@Name,
		@Description,
		@Data,
		@ContentTypeID,
		@FolderID
	)
	
	DECLARE @insertedID INT = @@IDENTITY	
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
	WHERE [ContentItemID] = @insertedID

END