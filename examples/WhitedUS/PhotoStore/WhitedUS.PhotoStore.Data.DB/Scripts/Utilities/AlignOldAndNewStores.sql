WITH [OldImages] AS (
	SELECT 
		[Images].[ImageID]
		,[Images].[Folder]
		,[Images].[Name] AS [FileName]
	FROM [HOMESERVER].[PhotoTags].[dbo].[Images]
), [NewImage] AS (
	SELECT 
		[Resources].[ResourceID]
		,[Resources].[Folder]
		,[Resources].[Name] + [Resources].[Extension] AS [FileName]
	FROM [PhotoStore].[dbo].[Resources]
), [AlignedImages] As (
	SELECT 
		[Old].[ImageID]
		,[New].[ResourceID]
		,ISNULL([Old].[Folder], [New].[Folder]) AS [Folder]
		,ISNULL([Old].[FileName], [New].[FileName]) AS [FileName]
	FROM [OldImages] AS [Old]
	FULL JOIN [NewImage] AS [New]
		ON [Old].[Folder] = [New].[Folder]
			AND [Old].[FileName] = [New].[FileName]
)
	SELECT 
		[Aligned].[ImageID]
		,[Aligned].[ResourceID]
		,[Aligned].[Folder]
		,[Aligned].[FileName]
	FROM [AlignedImages] AS [Aligned]
	WHERE
		[Aligned].[ResourceID] IS NULL
	ORDER BY
		[Aligned].[Folder]
		,[Aligned].[FileName]
	