


-- =============================================
-- Author:		Matthew Whited
-- Create date: 10/30/2011
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[ContentFrame_Insert]
	@Data			VARBINARY(MAX),
	@ContentTypeID	INT,
	@ContentItemID	INT,
	@Index			INT,
	@Width			INT,
	@Height			INT
AS
BEGIN
	SET NOCOUNT ON;
	
	INSERT INTO [ContentFrames] (
		[Data]
		,[ContentTypeID]
		,[ContentItemID]
		,[Index]
		,Width
		,Height
     ) VALUES (
		@Data,
		@ContentTypeID,
		@ContentItemID,
		@Index,
		@Width,
		@Height
	)
	
	DECLARE @insertedID INT = @@IDENTITY	
	SELECT 
		[ContentFrameID]
		,[RowID]
		,[LastWriteTime]
		--,[Data]
		,[ContentTypeID]
		,[ContentItemID]
		,[Index]
		,Width
		,Height
		,[Length]
	FROM [ContentFrames]
	WHERE [ContentFrameID] = @insertedID

END