
DECLARE @bitlength INT = 5;

WITH [$masks] AS (
	SELECT 
		 POWER(2,@bitlength)-1 AS [FullMask]

		 --,POWER(2,@bitlength)-1 - 

		 ,((POWER(2, [Bits].[Bit] + ([Distances].[Distance] - 1))
			+ ([Distances].[Distance] - 1)
			) * POWER(2,[Shifts].[Shift])) AS [Mask]

		--,[Distances].[Distance] 
		,*
	FROM (
		SELECT
			ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) - 1 AS [Distance]
		FROM STRING_SPLIT(REPLICATE(',', @bitlength-1),',')	
	) AS [Distances] 
	CROSS APPLY (
		SELECT
			ROW_NUMBER() OVER (ORDER BY (SELECT NULL))-1 AS [Bit]
		FROM STRING_SPLIT(REPLICATE(',', @bitlength-1),',')	
	) AS [Bits] 
	CROSS APPLY (
		SELECT
			ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) - 1 AS [Shift]
		FROM STRING_SPLIT(REPLICATE(',', @bitlength-1),',')	
	) AS [Shifts] 
)
	SELECT *
	FROM [$masks]
	WHERE 
		[Mask] BETWEEN 0 AND 31
		AND [Distance] = 1
		--AND [Mask] > 0
	--AND [Pattern].[Z] < 31

