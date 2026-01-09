-- Basic Database Schema Export to XML
-- Exports schema, tables, columns with data types
-- Platform: SQL Server
--USE [YourDatabaseName];
--GO

WITH [DbDetails] AS (
	SELECT
		[schemas].[name] AS [@name]
		,LOWER([tables].[name]) AS [table/@name]
		,'[' + [schemas].[name] + '].[' + LOWER([tables].[name]) + ']' AS [table/@long-name]
		,LOWER([columns].[name]) AS [table/column/@name]
		,UPPER(CASE
			WHEN [types].[name] LIKE '%char' OR [types].[name] LIKE '%binary' THEN [types].[name] + '(' +
				CASE [columns].[max_length]
					WHEN -1 THEN 'MAX'
					ELSE  CAST([columns].[max_length] AS VARCHAR(10))
					END  + ')'
			WHEN [types].[name] IN ('decimal', 'numeric') THEN [types].[name] + '(' +
					 CAST([columns].[precision] AS VARCHAR(10)) + ',' +
					 CAST([columns].[scale] AS VARCHAR(10)) + ')'
			ELSE [types].[name]
			END)

			AS [table/column/@type]

		,CASE [columns].[is_nullable] WHEN 1 THEN 'true' ELSE 'false' END AS [table/column/@is-nullable]

		--,[types].[name] AS [TypeName]
		--,[columns].[max_length]
		--,[columns].[precision]
		--,[columns].[scale]
		--,[columns].[is_identity]
		--,[columns].[is_nullable]
		,[columns].[column_id]
	FROM [sys].[schemas]
	INNER JOIN [sys].[tables]
		ON [tables].[schema_id] = [schemas].[schema_id]
	INNER JOIN [sys].[columns]
		ON [columns].[object_id] = [tables].[object_id]
	INNER JOIN [sys].[types]
		ON [types].[system_type_id] = [columns].[system_type_id]
			AND [types].[user_type_id] = [columns].[user_type_id]
)
	SELECT *
	FROM [DbDetails]
	FOR XML PATH('schema'), ROOT('db')
	--ORDER BY
	--	[TableName]
	--	,[column_id]
