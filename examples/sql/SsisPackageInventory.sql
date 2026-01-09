-- SSIS Package Inventory
-- Retrieves latest version of each SSIS package from msdb
-- Platform: SQL Server (requires access to msdb database)

WITH [LatestVersions] AS (
	SELECT
		 [sysdtspackages].[id]
		,MAX([sysdtspackages].[createdate]) AS [createdate_MAX]
	FROM [msdb].[dbo].[sysdtspackages]
	GROUP BY
		 [sysdtspackages].[id]
)
	SELECT
		 [sysdtspackages].[name]
		,[sysdtspackages].[id]
		,[sysdtspackages].[versionid]
		,[sysdtspackages].[description]
		,[sysdtspackages].[categoryid]
		,[sysdtspackages].[createdate]
		,[sysdtspackages].[owner]
		--,[sysdtspackages].[packagedata]
		--,[sysdtspackages].[owner_sid]
		,[sysdtspackages].[packagetype]
	FROM [msdb].[dbo].[sysdtspackages]
	INNER JOIN [LatestVersions]
		ON [sysdtspackages].[id] = [LatestVersions].[id]
			AND [sysdtspackages].[createdate] = [LatestVersions].[createdate_MAX]
