

-- =============================================
-- Author:		Matthew Whited
-- Create date: 10/30/2011
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[ContentItem_Delete]
	@ContentItemID	INT
AS
BEGIN
	SET NOCOUNT ON;
	
	DELETE
	FROM ContentItems	
	WHERE [ContentItemID] = @ContentItemID
		
END