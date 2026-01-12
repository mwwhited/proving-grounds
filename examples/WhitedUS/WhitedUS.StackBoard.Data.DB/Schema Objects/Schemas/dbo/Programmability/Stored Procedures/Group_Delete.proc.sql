



-- =============================================
-- Author:		Matthew Whited
-- Create date: 10/22/2011
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[Group_Delete]
	@groupId INT
AS
BEGIN
	SET NOCOUNT ON;
	
	BEGIN TRY
		BEGIN TRAN Group_Delete_Tran
		
			DECLARE @hid HIERARCHYID
			
			SELECT TOP 1 @hid = HId
			FROM Groups
			WHERE GroupID = @groupId

			IF EXISTS (SELECT *
						FROM Groups
						WHERE HId.IsDescendantOf(@hid) = 1)
			BEGIN
				PRINT 'Unable to delete group if it has children'
				RAISERROR ('Unable to delete group if it has children', -- Message text. 
						   16, -- Severity. 
						   1 -- State. 
						   );
			END

			DELETE 
			FROM Groups
			WHERE GroupID = @groupId	

			IF (XACT_STATE()) = 1
				COMMIT TRANSACTION Group_Delete_Tran;
	
			SELECT @groupId GroupID
			
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