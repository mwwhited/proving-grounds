CREATE VIEW [dbo].[TagSummaryData]
WITH SCHEMABINDING  
AS --
	WITH [TagSummary] AS (
		SELECT 
			[Tags].[TagID]
			,[Tags].[Label]
			,COUNT(*) AS [Count]
			,(SELECT COUNT(DISTINCT [ResourceTags].[ResourceID])
				FROM [dbo].[ResourceTags]
				) AS [Total]
		FROM [dbo].[Tags]
		INNER JOIN [dbo].[ResourceTags]
			ON [Tags].[TagID] = [ResourceTags].[TagID]
		GROUP BY
			[Tags].[TagID]
			,[Tags].[Label]
	), [TagSummaryWithPercent] AS (
		SELECT 
			[Summary].[TagID]
			,[Summary].[Label]
			,[Summary].[Count]
			,[Summary].[Total]
			,CAST(10000 * [Summary].[Count] / [Summary].[Total] AS FLOAT) / 100 AS [Percent]
		FROM [TagSummary] AS [Summary]
	), [TagSummaryTiered] AS (
		SELECT
			[Summary].[TagID]
			,[Summary].[Label]
			,[Summary].[Count]
			,[Summary].[Total]
			,[Summary].[Percent]
			,CAST(ROUND([Summary].[Percent] * 2,-1)/2 AS INT) AS [Tier]
		FROM [TagSummaryWithPercent] AS [Summary]
	)
		SELECT
			[Summary].[TagID]
			,[Summary].[Label]
			,[Summary].[Count]
			,[Summary].[Total]
			,[Summary].[Percent]
			,[Summary].[Tier]
		FROM [TagSummaryTiered] AS [Summary]