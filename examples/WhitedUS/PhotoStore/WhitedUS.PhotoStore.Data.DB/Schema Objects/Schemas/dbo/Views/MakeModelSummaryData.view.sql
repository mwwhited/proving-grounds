CREATE VIEW [dbo].[MakeModelSummaryData]
WITH SCHEMABINDING
AS --
	SELECT
		ISNULL(
			CASE [Data].[Make]
				WHEN 'NIKON' THEN 'NIKON CORPORATION'
				ELSE [Data].[Make]
				END
			,CASE GROUPING(
					CASE [Data].[Make]
						WHEN 'NIKON' THEN 'NIKON CORPORATION'
						ELSE [Data].[Make]
						END)
					WHEN 1 THEN 'All'
					WHEN 0 THEN 'Unknown'
					END	
				) AS [Make]
		,ISNULL(
			[Data].[Model] 
			,CASE GROUPING([Data].[Model])
					WHEN 1 THEN 'All'
					WHEN 0 THEN 'Unknown'
					END	
				) AS [Model]
		,COUNT(*) AS [Count]
	FROM (
		SELECT 
			[Resources].[ResourceID]
			,CAST([Make].[Value] AS NVARCHAR(128)) AS [Make]
			,CAST([Model].[Value] AS NVARCHAR(128)) AS [Model]
		FROM [dbo].[Resources] WITH (NOLOCK)
		LEFT OUTER JOIN [dbo].[ResourceAttributes] AS [Make] WITH (NOLOCK)
			ON [Resources].[ResourceID] = [Make].[ResourceID]
				AND [Make].[ResourceAttributeTypeID] = (
					SELECT [ResourceAttributeTypes].[ResourceAttributeTypeID]
					FROM [dbo].[ResourceAttributeTypes]
					WHERE 
						[ResourceAttributeTypes].[AttributeGroup] = 'Image.EXIF'
						AND [ResourceAttributeTypes].[AttributeName] = 'Make'
				)
		LEFT OUTER JOIN [dbo].[ResourceAttributes] AS [Model] WITH (NOLOCK)
			ON [Resources].[ResourceID] = [Model].[ResourceID]
				AND [Model].[ResourceAttributeTypeID] = (
					SELECT [ResourceAttributeTypes].[ResourceAttributeTypeID]
					FROM [dbo].[ResourceAttributeTypes]
					WHERE 
						[ResourceAttributeTypes].[AttributeGroup] = 'Image.EXIF'
						AND [ResourceAttributeTypes].[AttributeName] = 'Model'
				)
		) AS [Data]
	GROUP BY
		CASE [Data].[Make]
			WHEN 'NIKON' THEN 'NIKON CORPORATION'
			ELSE [Data].[Make]
			END
		,[Data].[Model]
		WITH ROLLUP