-- =============================================
-- Author:		Matthew Whited
-- Create date: 09/11/2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE Media_Insert
	@Title			NVARCHAR(255),
	@Rating			NVARCHAR(50),
	@Year			NVARCHAR(50),
	@Code			NVARCHAR(50),
	@Format			NVARCHAR(50),
	@Length			NVARCHAR(50),
	@MediaTypeID	INT,
	@Have			BIT,
	@Notes			NVARCHAR(255),
	@BoxTitle		NVARCHAR(255),
	@DiskNumber		NVARCHAR(255)
AS
BEGIN
	SET NOCOUNT ON;
	
	INSERT INTO [Media] (
		[Title]
		,[Rating]
		,[Year]
		,[Code]
		,[Format]
		,[Length]
		,[MediaTypeID]
		,[Have]
		,[Notes]
		,[BoxTitle]
		,[DiskNumber]
	) VALUES (
		@title
		,@rating
		,@year
		,@code
		,@format
		,@length
		,@mediaTypeID
		,@have
		,@notes
		,@boxTitle
		,@diskNumber
	)
	
	DECLARE @insertedID INT = @@IDENTITY
	
	SELECT @insertedID LocalID
	
END