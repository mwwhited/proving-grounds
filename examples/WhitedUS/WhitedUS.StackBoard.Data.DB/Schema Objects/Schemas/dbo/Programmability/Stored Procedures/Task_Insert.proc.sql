


-- =============================================
-- Author:		Matthew Whited
-- Create date: 10/22/2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Task_Insert]
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
	
	DECLARE @parentHID		HIERARCHYID,
			@hid			HIERARCHYID
	
	SELECT TOP 1 @parentHID = HId
	FROM Tasks
	WHERE TaskID = @parentId	
	IF @parentHID IS NULL
		SET @parentHID = HIERARCHYID::GetRoot()	
	PRINT '@ParentHID: ' + ISNULL(@parentHID.ToString(), '--NULL--')

	SET @hid = @parentHID.GetDescendant((
		SELECT TOP 1 MAX(HId)
		FROM Tasks
		WHERE HId.GetAncestor(1) = @ParentHID
		), NULL)
	PRINT '@hid: ' + ISNULL(@hid.ToString(), '--NULL--')

	DECLARE @createdDate DATETIME = GETUTCDATE()

	INSERT INTO Tasks (
		[HId],
		[TaskTypeID],
		[GroupID],
		[Subject],
		[Description],
		[StateID],
		[PriorityID],
		[DueDate],
		[MetaData],
		[CreatedDate],
		[ModifiedDate]
	) VALUES (
		@hid,
		@taskTypeId,
		@groupId,
		@subject,
		@description,
		@stateId,
		@priorityId,
		@dueDate,
		@metaData,
		@createdDate,
		@createdDate
	)	
	
	DECLARE @insertedId INT = @@IDENTITY
	SELECT
		@insertedId			AS TaskID,
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
		@createdDate		AS [ModifiedDate]
END