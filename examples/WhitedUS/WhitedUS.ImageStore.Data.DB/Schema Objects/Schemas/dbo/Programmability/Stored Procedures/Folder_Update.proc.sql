

-- =============================================
-- Author:		Matthew Whited
-- Create date: 10/22/2011
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[Folder_Update]
	@Name NVARCHAR(200),
	@MappedPath NVARCHAR(MAX),
	@CreationTime DATETIME,
	@LastAccessTime DATETIME,
	@LastWriteTime DATETIME,
	@ParentFolderID INT,
	@FolderID INT
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		BEGIN TRAN Folder_Update_Tran
			
			IF (@ParentFolderID != (SELECT TOP 1 ParentFolderID
									FROM Folders 
									WHERE FolderID = @FolderID
									))
				EXEC Folder_Reparent 
					@folderID = @FolderID, 
					@parentFolderID = @ParentFolderID
					;
			
			UPDATE [Folders]
			SET
				[Name] = @Name,
				[MappedPath] = @MappedPath,
				[CreationTime] = @CreationTime,
				[LastAccessTime] = @LastAccessTime,
				[LastWriteTime] = @LastWriteTime
			WHERE [Folders].FolderID = @FolderID

			IF (XACT_STATE()) = 1
				COMMIT TRANSACTION Folder_Update_Tran;
				
			SELECT 
				@FolderID		FolderID,
				@Name			Name,
				@MappedPath		MappedPath,
				@CreationTime	CreationTime,
				@LastAccessTime	LastAccessTime,
				@LastWriteTime	LastWriteTime,
				@ParentFolderID ParentFolderID,
				@FolderID		FolderID
			
	END TRY
	BEGIN CATCH

		IF (XACT_STATE()) = 1
			ROLLBACK TRANSACTION;
					 
		DECLARE @ErrorMessage NVARCHAR(4000),
				@ErrorSeverity INT,
				@ErrorState INT; 
	 
		SELECT @ErrorMessage = ERROR_MESSAGE(), 
			   @ErrorSeverity = ERROR_SEVERITY(), 
			   @ErrorState = ERROR_STATE(); 
	 
		-- Use RAISERROR inside the CATCH block to return  
		-- error information about the original error that  
		-- caused execution to jump to the CATCH block. 
		RAISERROR (@ErrorMessage, -- Message text. 
				   @ErrorSeverity, -- Severity. 
				   @ErrorState -- State. 
				   ); 


	END CATCH 	
END