-- Database Object Catalog
-- Comprehensive scan of all database objects including tables, views, stored procedures, and functions
-- Platform: SQL Server
--USE [YourDatabaseName];
--GO

SELECT
	[databases].[database_id]
	,[schemas].[schema_id]
	,CASE [objects].[parent_object_id]
		WHEN 0 THEN [objects].[object_id]
		ELSE [objects].[parent_object_id]
		END [object_id]
	--,[objects].[object_id]
	--,[objects].[parent_object_id]
	,CASE [objects].[parent_object_id]
		WHEN 0 THEN [columns].[column_id]
		ELSE [objects].[object_id]
		END [column_id]
	--,[columns].[column_id]

	,[databases].[name] AS [Database Name]
	,[schemas].[name] AS [Schema Name]

	,CASE [objects].[parent_object_id]
		WHEN 0 THEN [objects].[name]
		ELSE [Parent].[name]
		END [Object Name]
	--,[objects].[name] AS [Object Name]

	,CASE [objects].[parent_object_id]
		WHEN 0 THEN [columns].[name]
		ELSE [objects].[name]
		END [Item Name]
	--,[columns].[name] AS [Column Name]

	,[objects].[type]
	,REPLACE([objects].[type_desc], '_', ' ') AS [Object Type]

	,[types].[name] AS [Column Type]
	,[types].[max_length]
	,[types].[precision]
	,[types].[scale]
	,ISNULL([types].[collation_name], [databases].[collation_name]) As [collation_name]
FROM [sys].[objects]
CROSS JOIN [sys].[databases]
INNER JOIN [sys].[schemas]
	ON [objects].[schema_id] = [schemas].[schema_id]
LEFT OUTER JOIN [sys].[objects] AS [Parent]
	ON [objects].[parent_object_id] = [Parent].[object_id]
LEFT OUTER JOIN [sys].[columns]
	ON [objects].[object_id] = [columns].[object_id]
LEFT OUTER JOIN [sys].[types]
	ON [types].[user_type_id] = [columns].[user_type_id]
WHERE
	[databases].[database_id] = DB_ID()
	AND [objects].[is_ms_shipped] = 0
ORDER BY
	[databases].[database_id]
	,[schemas].[schema_id]
	,CASE [objects].[parent_object_id]
		WHEN 0 THEN [objects].[object_id]
		ELSE [objects].[parent_object_id]
		END
	,[objects].[type]
	,[objects].[object_id]
	,[columns].[column_id]

