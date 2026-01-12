-- =============================================
-- Author:		Matthew Whited
-- Create date: 11/7/2011
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION IsGuid
(
	@input NVARCHAR(50)
)
RETURNS BIT
AS
BEGIN
	DECLARE @result BIT = 
		CASE
			WHEN @input LIKE ( 
					REPLICATE('[0-9A-F]',8)+'-'+REPLICATE(REPLICATE('[0-9A-F]',4)+'-',3)+REPLICATE('[0-9A-F]',12) 
				) COLLATE Latin1_General_BIN
				THEN 1
			ELSE 0
		END

	RETURN @result

END