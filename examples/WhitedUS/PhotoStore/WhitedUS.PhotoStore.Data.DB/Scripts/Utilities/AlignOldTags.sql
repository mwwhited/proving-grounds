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
		[Old].[ImageID] AS [ImageID]
		,[New].[ResourceID]
		,ISNULL([Old].[Folder], [New].[Folder]) AS [Folder]
		,ISNULL([Old].[FileName], [New].[FileName]) AS [FileName]
	FROM [OldImages] AS [Old]
	FULL JOIN [NewImage] AS [New]
		ON [Old].[Folder] = [New].[Folder]
			AND [Old].[FileName] = [New].[FileName]
), [MissingImagesByFolder] AS (
	SELECT 
		[Aligned].[Folder]
		,COUNT(*) AS [Count]
	FROM [AlignedImages] AS [Aligned]
	WHERE
		[Aligned].[ResourceID] IS NULL
	GROUP BY
		[Aligned].[Folder]
), [MissingImages] AS (
	SELECT 
		[Aligned].[ImageID]
		,[Aligned].[ResourceID]
		,[Aligned].[Folder]
		,[Aligned].[FileName]
	FROM [AlignedImages] AS [Aligned]
	WHERE
		[Aligned].[ResourceID] IS NULL
), [MatchedTags] AS (
	SELECT
		[ResourceTags].[ResourceID]
		,[Tags].[TagID]
		,[Tags].[Label] AS [TagName]
	FROM [PhotoStore].[dbo].[ResourceTags]
	JOIN [PhotoStore].[dbo].[Tags]
		ON [Tags].[TagID] = [ResourceTags].[TagID]
), [OldTags] As (
	SELECT 
		[Tags].[ImageID] AS [ImageID]
		,[Tags].[Name] AS [TagName]
	FROM [HOMESERVER].[PhotoTags].[dbo].[Tags]
	WHERE
		[Tags].[Name] NOT IN (
			'Seth'
		)
)
	INSERT INTO [PhotoStore].[dbo].[ResourceTags] (
		[ResourceID]
		,[TagID]
	)
	SELECT 
		[Aligned].[ResourceID]
		,[NewTags].[TagID]
	FROM [OldTags] AS [OldTags]
	INNER JOIN [AlignedImages] AS [Aligned]
		ON [Aligned].[ImageID] = [OldTags].[ImageID]
	INNER JOIN [PhotoStore].[dbo].[Tags] AS [NewTags]
		ON [NewTags].[Label] = [OldTags].[TagName]
	WHERE
		[Aligned].[ResourceID] IS NOT NULL
		AND NOT EXISTS (
			SELECT *
			FROM [PhotoStore].[dbo].[ResourceTags]
			WHERE
				[ResourceTags].[ResourceID] = [Aligned].[ResourceID]
				AND [ResourceTags].[TagID] = [NewTags].[TagID]
		)
