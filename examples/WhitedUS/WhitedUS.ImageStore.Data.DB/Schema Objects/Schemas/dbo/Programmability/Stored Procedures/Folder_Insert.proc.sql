-- =============================================
-- Author:		Matthew Whited
-- Create date: 10/19/2011
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[Folder_Insert]
	@Name NVARCHAR(200),
	@MappedPath NVARCHAR(MAX),
	@CreationTime DATETIME,
	@LastAccessTime DATETIME,
	@LastWriteTime DATETIME,
	@ParentFolderID INT 
	/* ,@FolderID INT OUTPUT */
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @ParentHID HIERARCHYID,
			@ChildBefore HIERARCHYID,
			@ChildAfter HIERARCHYID,
			@StructureID HIERARCHYID
	
	SELECT TOP 1 @ParentHID = [StructureID]
	FROM [Folders]
	WHERE FolderID = @ParentFolderID	
	IF @ParentHID IS NULL
		SET @ParentHID = HIERARCHYID::GetRoot()	
	PRINT '@ParentHID: ' + ISNULL(@ParentHID.ToString(), '--NULL--')
	
	SELECT TOP 1 @ChildBefore = MAX([StructureID])
	FROM [Folders]
	WHERE [StructureID].GetAncestor(1) = @ParentHID
		AND Name <= @Name
	PRINT '@ChildBefore: ' + ISNULL(@ChildBefore.ToString(), '--NULL--')
		
	SELECT TOP 1 @ChildAfter = MIN([StructureID])
	FROM [Folders]
	WHERE [StructureID].GetAncestor(1) = @ParentHID
		AND Name > @Name
	PRINT '@ChildAfter: ' + ISNULL(@ChildAfter.ToString(), '--NULL--')

	SET @StructureID = @ParentHID.GetDescendant(@ChildBefore, @ChildAfter)
	PRINT '@StructureID: ' + ISNULL(@StructureID.ToString(), '--NULL--')
	
	INSERT INTO [Folders] (
		[StructureID]
		,[Name]
		,[MappedPath]
		,[CreationTime]
		,[LastAccessTime]
		,[LastWriteTime]
	) VALUES (
		@StructureID,
		@Name,
		@MappedPath,
		@CreationTime,
		@LastAccessTime,
		@LastWriteTime 
	)
	
	DECLARE @insertedID INT = @@IDENTITY	
	SELECT @insertedID FolderID

END