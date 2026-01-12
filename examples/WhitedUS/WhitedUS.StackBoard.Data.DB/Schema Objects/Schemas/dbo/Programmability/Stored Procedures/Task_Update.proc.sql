


-- =============================================
-- Author:		Matthew Whited
-- Create date: 10/22/2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Task_Update]
	@taskId			INT,
	@subject		NVARCHAR(200),
	@description	NVARCHAR(MAX),
	@taskTypeId		INT,
	@groupId		INT,
	@stateId		INT,
	@priorityId		INT,
	@parentId		INT,
	@dueDate		DATETIME,
	@metaData		XML
AS
BEGIN
	SET NOCOUNT ON;
	
	BEGIN TRY
		BEGIN TRAN Task_Update_Tran
	
			DECLARE	@createdDate	DATETIME,
					@modifiedDate	DATETIME = GETUTCDATE()
			
			SELECT TOP 1 @createdDate = CreatedDate
			FROM Tasks
			WHERE TaskID = @taskId
			
			DECLARE @parentHId HIERARCHYID,
					@hid HIERARCHYID
			
			SELECT TOP 1 @parentHId = HId
			FROM Tasks
			WHERE TaskID = @parentId
				
			IF @parentHId IS NULL
				SET @ParentHID = HIERARCHYID::GetRoot()	
			PRINT '@@parentHId: ' + ISNULL(@parentHId.ToString(), '--NULL--')
			
			SELECT TOP 1 @hid = HId
			FROM Tasks
			WHERE TaskID = @groupId	
			PRINT '@hid: ' + ISNULL(@hid.ToString(), '--NULL--')
			
			IF (@ParentHID != ISNULL(@hid.GetAncestor(1), HIERARCHYID::GetRoot()))
			BEGIN
				PRINT 'Relocate Folder'
				DECLARE	@max		HIERARCHYID,
						@currentID	HIERARCHYID = @hid

				SELECT TOP 1 @max = MAX(HId)
				FROM Tasks
				WHERE HId.GetAncestor(1) = @parentHId				
				PRINT '@max: ' + ISNULL(@max.ToString(), '--NULL--')

				SET @hid = @parentHId.GetDescendant(@max, NULL)
				PRINT '@hid: ' + ISNULL(@hid.ToString(), '--NULL--')

				----Reparent branch
				UPDATE Tasks			
				SET HId = HId.GetReparentedValue(@CurrentID, @hid)
				WHERE HId.IsDescendantOf(@currentID) = 1
				
			END
			
			UPDATE [Tasks]
			   SET [HId]			= @hid
				  ,[TaskTypeID]		= @taskTypeId
				  ,[GroupID]		= @groupId
				  ,[Subject]		= @subject
				  ,[Description]	= @description
				  ,[StateID]		= @stateId
				  ,[PriorityID]		= @priorityId
				  ,[DueDate]		= @dueDate
				  ,[MetaData]		= @metaData
				  ,[ModifiedDate]	= @modifiedDate
			 WHERE TaskID			= @taskId 			

			IF (XACT_STATE()) = 1
				COMMIT TRANSACTION Task_Update_Tran;			

			SELECT
				@taskId				AS TaskID,
				@hid				AS HId,
				@taskTypeId			AS TaskTypeID,
				@groupId			AS GroupID,
				@subject			AS [Subject],
				@description		AS [Description],
				@stateId			AS [StateID],
				@priorityId			AS [PriorityID],
				@dueDate			AS [DueDate],
				@metaData			AS [MetaData],
				@createdDate		AS [CreatedDate],
				@modifiedDate		AS [ModifiedDate]
			
	END TRY
	BEGIN CATCH
	 
		DECLARE @ErrorMessage	NVARCHAR(4000), 
				@ErrorSeverity	INT,
				@ErrorState		INT
	 
		SELECT @ErrorMessage = ERROR_MESSAGE(), 
			   @ErrorSeverity = ERROR_SEVERITY(), 
			   @ErrorState = ERROR_STATE(); 
	 
		IF (XACT_STATE()) = 1
			ROLLBACK TRANSACTION Task_Update_Tran;
	 
		-- Use RAISERROR inside the CATCH block to return  
		-- error information about the original error that  
		-- caused execution to jump to the CATCH block. 
		RAISERROR (@ErrorMessage, -- Message text. 
				   @ErrorSeverity, -- Severity. 
				   @ErrorState -- State. 
				   ); 
	END CATCH 	
END