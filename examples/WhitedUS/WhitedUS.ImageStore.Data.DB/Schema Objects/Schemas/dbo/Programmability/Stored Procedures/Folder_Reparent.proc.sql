
-- =============================================
-- Author:		Matthew Whited
-- Create date: 10/30/2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Folder_Reparent]
	@folderID		INT,
	@parentFolderID	INT
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRAN Folder_Reparent_Tran

		DECLARE 
			@newParent	HIERARCHYID,
			@oldParent	HIERARCHYID

		SELECT TOP 1
			@oldParent = StructureID 
		FROM Folders 
		WHERE FolderID = @folderID
		
		SELECT TOP 1
			@newParent = StructureID
		FROM Folders 
		WHERE FolderID = @parentFolderID

		DECLARE
			@childHID	HIERARCHYID,
			@childID	INT,
			@name		NVARCHAR(200)
		DECLARE
			@temp		TABLE (
				FolderID	INT,
				StructureID	HIERARCHYID,
				Name		NVARCHAR(200)
			)
			
		INSERT INTO @temp
		SELECT FolderID, StructureID, Name
		FROM Folders 
		WHERE StructureID.GetAncestor(1) = @oldParent
		
		DECLARE children_cursor CURSOR FOR
			SELECT FolderID, StructureID, Name
			FROM @temp

		OPEN children_cursor
		FETCH NEXT FROM children_cursor INTO @childID, @childHID, @name;
		WHILE @@FETCH_STATUS = 0
		BEGIN
		START:
		
			DECLARE 
				@newHId	HIERARCHYID,
				@minHId	HIERARCHYID,
				@maxHId	HIERARCHYID
				
			SELECT @minHId = MAX(StructureID)
			FROM Folders 
			WHERE StructureID.GetAncestor(1) = @NewParent
				AND Name < @name
			SELECT @maxHId = MAX(StructureID)
			FROM Folders 
			WHERE StructureID.GetAncestor(1) = @NewParent
				AND Name > @name

			SET	@newHId = @NewParent.GetDescendant(@minHId, @maxHId)
			
			UPDATE Folders
			SET StructureID = StructureID.GetReparentedValue(@childHID, @newHId)
			WHERE StructureID.IsDescendantOf(@childHID) = 1;	
		
			IF @@error <> 0 
				GOTO START -- On error, retry
			FETCH NEXT FROM children_cursor INTO @childID, @childHID, @name;
		END
		CLOSE children_cursor;
		DEALLOCATE children_cursor;

	COMMIT TRAN Folder_Reparent_Tran

END