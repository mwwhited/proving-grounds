



-- =============================================
-- Author:		Matthew Whited
-- Create date: 10/30/2011
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[Folder_Touch]
	@FolderID	INT
AS
BEGIN
	SET NOCOUNT ON;
	
	UPDATE Folders
	SET LastAccessTime = GETUTCDATE()
	WHERE FolderID = @FolderID	

	SELECT 
		[FolderID]
		,[RowID]
		,[StructureID]
		,[Name]
		,[MappedPath]
		,[CreationTime]
		,[LastAccessTime]
		,[LastWriteTime]
		,[ParentStructureID]
		,[ParentFolderID]
		,[StructureIDString]
		,[StructureIDLevel]
	FROM [Folders]
	WHERE FolderID = @FolderID	
		
END