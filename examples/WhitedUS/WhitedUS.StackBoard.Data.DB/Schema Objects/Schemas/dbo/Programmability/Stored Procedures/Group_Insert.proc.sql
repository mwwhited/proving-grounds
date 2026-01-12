
-- =============================================
-- Author:		Matthew Whited
-- Create date: 10/22/2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Group_Insert]
	@name			NVARCHAR(200),
	@description	NVARCHAR(MAX),
	@parentId		INT
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @parentHID		HIERARCHYID,
			@childBefore	HIERARCHYID,
			@hid			HIERARCHYID
	
	SELECT TOP 1 @parentHID = HId
	FROM Groups
	WHERE GroupID = @parentId	
	IF @parentHID IS NULL
		SET @parentHID = HIERARCHYID::GetRoot()	
	PRINT '@ParentHID: ' + ISNULL(@parentHID.ToString(), '--NULL--')
	
	
	PRINT '@ChildBefore: ' + ISNULL(@ChildBefore.ToString(), '--NULL--')

	SET @hid = @parentHID.GetDescendant((
		SELECT TOP 1 MAX(HId)
		FROM Groups
		WHERE HId.GetAncestor(1) = @ParentHID
		), NULL)
	PRINT '@hid: ' + ISNULL(@hid.ToString(), '--NULL--')
	
	INSERT INTO Groups (
		HId
		,[Name]
		,[Description]
	) VALUES (
		@hid,
		@name,
		@description 
	)
	
	DECLARE @insertedID INT = @@IDENTITY	
	SELECT 
		 @insertedID	AS [GroupID]
		,@hid			AS [HId]
		,@name			AS [Name]
		,@description	AS [Description]
		,@parentId		AS [ParentID]
	
END