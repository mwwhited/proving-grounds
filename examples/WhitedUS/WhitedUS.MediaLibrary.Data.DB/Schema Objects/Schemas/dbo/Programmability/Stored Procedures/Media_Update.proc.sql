-- =============================================
-- Author:		Matthew Whited
-- Create date: 09/11/2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE Media_Update
	@LocalID		INT,
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
	
	UPDATE Media
	SET
		Title = @Title,
		[Rating] = @Rating,
		[Year] = @Year,
		[Code] = @Code,
		[Format] = @Format,
		[Length] = @Length,
		[MediaTypeID] = @MediaTypeID,
		[Have] = @Have,
		[Notes] = @Notes,
		[BoxTitle] = @BoxTitle,
		[DiskNumber] = @DiskNumber
	WHERE Media.LocalID = @LocalID
	
	SELECT @LocalID LocalID
	
END