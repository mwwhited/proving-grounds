


-- =============================================
-- Author:		Matthew Whited
-- Create date: 10/22/2011
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[Folder_Delete]
	@FolderID INT
AS
BEGIN
	SET NOCOUNT ON;
	
	BEGIN TRY
		BEGIN TRAN Folder_Delete_Tran
		
			DECLARE @structureID HIERARCHYID
			
			SELECT TOP 1 @structureID = StructureID
			FROM Folders
			WHERE FolderID = @FolderID

			IF EXISTS (SELECT *
						FROM Folders
						WHERE StructureID.IsDescendantOf(@structureID) = 1)
			BEGIN
				PRINT 'Unable to delete folder if it has children'
				RAISERROR ('Unable to delete folder if it has children', -- Message text. 
						   16, -- Severity. 
						   1 -- State. 
						   );
			END	
	
			DELETE 
			FROM [Folders]
			WHERE FolderID = @FolderID

			IF (XACT_STATE()) = 1
				COMMIT TRANSACTION Folder_Delete_Tran;
			
			SELECT @FolderID FolderID
			
	END TRY
	BEGIN CATCH
		
		DECLARE @ErrorMessage	NVARCHAR(4000), 
				@ErrorSeverity	INT,
				@ErrorState		INT
		PRINT 'Error: ' + @ErrorMessage
	 
		SELECT @ErrorMessage = ERROR_MESSAGE(), 
			   @ErrorSeverity = ERROR_SEVERITY(), 
			   @ErrorState = ERROR_STATE(); 
	 
		IF (XACT_STATE()) = 1
			ROLLBACK TRANSACTION;
	 
		-- Use RAISERROR inside the CATCH block to return  
		-- error information about the original error that  
		-- caused execution to jump to the CATCH block. 
		RAISERROR (@ErrorMessage, -- Message text. 
				   @ErrorSeverity, -- Severity. 
				   @ErrorState -- State. 
				   ); 
	END CATCH 	
			
END