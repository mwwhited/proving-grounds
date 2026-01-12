USE [PhotoStore];

WITH [Favorites] AS (
	SELECT 
		[Resources].[ResourceID]
		,[Others].[ResourceID] AS [Other_ResourceID]
		,[Others].[Folder] AS [Other_Folder]
		,[Resources].[Name]
		
		,COUNT([Others].[ResourceID]) OVER (
			PARTITION BY 
				[Resources].[ResourceID]
			) AS [Count]
		,ROW_NUMBER() OVER (
			PARTITION BY 
				[Resources].[ResourceID]
			ORDER BY
				[Others].[Folder]
				,[Resources].[Name]
			) AS [Number]
		,(SELECT COUNT(*)
			FROM [dbo].[ResourceTags]
			WHERE
				[ResourceTags].[TagID] = 15
				AND [ResourceTags].[ResourceID] = [Others].[ResourceID]
			) AS [TagCount_15]
		,(SELECT COUNT(*)
			FROM [dbo].[ResourceTags]
			WHERE
				[ResourceTags].[TagID] = 33
				AND [ResourceTags].[ResourceID] = [Others].[ResourceID]
			) AS [TagCount_33]
		,(SELECT COUNT(*)
			FROM [dbo].[ResourceTags]
			WHERE
				[ResourceTags].[TagID] = 33
				AND [ResourceTags].[ResourceID] = [Resources].[ResourceID]
			) AS [TagCount_33r]
	FROM [dbo].[Resources]
	LEFT JOIN [dbo].[Resources] AS [Others]
		ON [Resources].[Name] = [Others].[Name]
	WHERE
		[Resources].[Folder] = 'Favorites'
		AND NOT [Others].[Folder] = 'Favorites'
), [Assigned] AS (
	SELECT 
		[Favorites].*
		,MAX([Favorites].[TagCount_15]) OVER (
			PARTITION BY
				[Favorites].[ResourceID]
		) AS [Assigned_15]
	FROM [Favorites]
)
	INSERT INTO [dbo].[ResourceTags] (
		[ResourceID]
		,[TagID]
	)
	SELECT 
		[Assigned].[Other_ResourceID]
		,15
	FROM [Assigned]
	INNER JOIN [dbo].[ResourceMetaData] AS [MetaR]
		ON [Assigned].[ResourceID] = [MetaR].[ResourceID]
	INNER JOIN [dbo].[ResourceMetaData] AS [MetaO]
		ON [Assigned].[Other_ResourceID] = [MetaO].[ResourceID]
	WHERE
		[Assigned].[Assigned_15] = 0
		AND [MetaR].[ImageEXIF_DateTimeDigitized] = [MetaO].[ImageEXIF_DateTimeDigitized]
	ORDER BY
		[Assigned].[ResourceID] 