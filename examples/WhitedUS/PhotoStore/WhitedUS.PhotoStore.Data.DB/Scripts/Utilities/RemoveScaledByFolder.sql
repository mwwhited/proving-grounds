DELETE
FROM [PhotoStore].[dbo].[Scalings] 
WHERE
	[Scalings].[ResourceID] IN (
	SELECT 
		[Resources].[ResourceID]
	FROM [PhotoStore].[dbo].[Resources]
	WHERE
		[Resources].[Folder] = '2007/Smipsonize/Matt'
)