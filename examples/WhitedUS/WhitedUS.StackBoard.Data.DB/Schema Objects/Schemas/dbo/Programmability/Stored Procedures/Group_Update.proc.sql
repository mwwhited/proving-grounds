
-- =============================================
-- Author:		Matthew Whited
-- Create date: 10/22/2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Group_Update]
	@groupId		INT,
	@name			NVARCHAR(200),
	@description	NVARCHAR(MAX),
	@parentId		INT
AS
BEGIN
	SET NOCOUNT ON;
	
	BEGIN TRY
		BEGIN TRAN Group_Update_Tran

			DECLARE @parentHId HIERARCHYID,
					@hid HIERARCHYID
			
			SELECT TOP 1 @parentHId = HId
			FROM Groups
			WHERE GroupID = @parentId
				
			IF @parentHId IS NULL
				SET @ParentHID = HIERARCHYID::GetRoot()	
			PRINT '@@parentHId: ' + ISNULL(@parentHId.ToString(), '--NULL--')
			
			SELECT TOP 1 @hid = HId
			FROM Groups
			WHERE GroupID = @groupId	
			PRINT '@hid: ' + ISNULL(@hid.ToString(), '--NULL--')
			
			IF (@ParentHID != ISNULL(@hid.GetAncestor(1), HIERARCHYID::GetRoot()))
			BEGIN
				PRINT 'Relocate Folder'
				DECLARE	@max		HIERARCHYID,
						@currentID	HIERARCHYID = @hid

				SELECT TOP 1 @max = MAX(HId)
				FROM Groups
				WHERE HId.GetAncestor(1) = @parentHId				
				PRINT '@max: ' + ISNULL(@max.ToString(), '--NULL--')

				SET @hid = @parentHId.GetDescendant(@max, NULL)
				PRINT '@hid: ' + ISNULL(@hid.ToString(), '--NULL--')

				----Reparent branch
				UPDATE Groups			
				SET HId = HId.GetReparentedValue(@CurrentID, @hid)
				WHERE HId.IsDescendantOf(@currentID) = 1
				
			END
			
			UPDATE Groups
			SET
				--[StructureID] = @StructureID, --Updated Above... no need to do it again here
				[Name] = @name,
				[Description] = @description
			WHERE HId = @hid

			IF (XACT_STATE()) = 1
				COMMIT TRANSACTION Group_Update_Tran;
				
			SELECT 
				 [GroupID]
				,[HId]
				,[Name]
				,[Description]
				,[ParentID]
			FROM Groups
			WHERE GroupID = @groupId
			
	END TRY
	BEGIN CATCH
	 
		DECLARE @ErrorMessage	NVARCHAR(4000), 
				@ErrorSeverity	INT,
				@ErrorState		INT
	 
		SELECT @ErrorMessage = ERROR_MESSAGE(), 
			   @ErrorSeverity = ERROR_SEVERITY(), 
			   @ErrorState = ERROR_STATE(); 
	 
		IF (XACT_STATE()) = 1
			ROLLBACK TRANSACTION Group_Update_Tran;
	 
		-- Use RAISERROR inside the CATCH block to return  
		-- error information about the original error that  
		-- caused execution to jump to the CATCH block. 
		RAISERROR (@ErrorMessage, -- Message text. 
				   @ErrorSeverity, -- Severity. 
				   @ErrorState -- State. 
				   ); 
	END CATCH 	
END