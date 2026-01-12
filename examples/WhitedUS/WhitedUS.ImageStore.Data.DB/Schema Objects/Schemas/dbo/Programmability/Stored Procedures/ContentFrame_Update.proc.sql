


-- =============================================
-- Author:		Matthew Whited
-- Create date: 10/30/2011
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[ContentFrame_Update]
	@Data			VARBINARY(MAX),
	@ContentTypeID	INT,
	@ContentItemID	INT,
	@Index			INT,
	@Width			INT,
	@Height			INT,
	@ContentFrameID INT
AS
BEGIN
	SET NOCOUNT ON;
	
	UPDATE ContentFrames
	SET Data			= @Data,
		ContentItemID	= @ContentItemID,
		ContentTypeID	= @ContentTypeID,
		[Index]			= @Index,
		Width			= @Width,
		Height			= @Height
	WHERE ContentFrameID = @ContentFrameID		
	
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
	WHERE [ContentFrameID] = @ContentFrameID

END