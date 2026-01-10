
 --=============================================
 --Author:		Matthew Whited
 --Create date: 06/18/2025
 --Description:	This function will calculate the factorial of an input value
 --=============================================
 CREATE FUNCTION [dbo].[Factorial]
(
	@value INT
)
RETURNS BIGINT
WITH SCHEMABINDING
AS
BEGIN
	RETURN (ISNULL((
		SELECT ROUND(EXP(SUM([Number])),0)
		FROM (
			SELECT
				LOG(ROW_NUMBER() OVER (ORDER BY (SELECT NULL))) AS [Number]
			FROM STRING_SPLIT(REPLICATE(',', @value-1),',')
		) AS [Numbers]
	),1));
END
GO

 --=============================================
 --Author:		Matthew Whited
 --Create date: 11/12/2024
 --Description:	This function will compare to strings and return the longest matching prefix
 --=============================================
CREATE FUNCTION [dbo].[LongestCommonPrefix]
(
	 @word1 NVARCHAR(MAX)
	,@word2 NVARCHAR(MAX)
)
RETURNS NVARCHAR(MAX)
WITH SCHEMABINDING
AS
BEGIN
    RETURN (
		SELECT 
			 SUBSTRING(@word1, 1, MAX(LEN(SUBSTRING(@word1, 1, [$Numbers].[Number]))))
		FROM (	
			SELECT
				ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS [Number]
			FROM STRING_SPLIT(REPLICATE(',', LEN(@word1)),',')
		) AS [$Numbers]
		WHERE 
				[$Numbers].[Number] <= LEN(@word1)
			AND SUBSTRING(@word1, 1, [$Numbers].[Number]) = SUBSTRING(@word2, 1, [$Numbers].[Number])
    );
END;
GO

 --=============================================
 --Author:		Matthew Whited
 --Create date: 06/18/2025
 --Description:	This function will generate a list of numbers up to the provided value
 --=============================================
CREATE FUNCTION [dbo].[Sequence](
	@length INT
)
RETURNS TABLE
WITH SCHEMABINDING
AS
	RETURN(
		SELECT
			ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS [Number]
		FROM STRING_SPLIT(REPLICATE(',', @length-1),',')	
	);

GO