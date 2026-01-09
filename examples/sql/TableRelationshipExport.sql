-- Table Relationship Mapping Export
-- Exports primary keys and foreign key relationships in XML format
-- Platform: SQL Server
--USE [YourDatabaseName];
--GO

SELECT
	[table_schema].[name] --AS [TableSchemaName]
	,[table].[name] --AS [TableName]

	,[pk].[key_name]
	,[pk].[column_name]
	,[pk].[ordinal]

	,[table_references].[name] --AS [ReferenceName]

	,[other_table_schema].[name] --AS [OtherTableSchemaName]
	,[other_table].[name] --AS [OtherTableName]

	,[table].[object_id] --AS [TableID]
	,[other_table].[object_id] --AS [OtherTableID]

	,[links].[left]
	,[links].[right]

FROM [sys].[tables] As [table]
LEFT JOIN (
	SELECT
		[table_PK].[object_id]
		,[table_PK].[name] AS [key_name]
		,[PK_column].[name] AS [column_name]
		,DENSE_RANK() OVER (ORDER BY [PK_column_ref].[index_column_id]) AS [ordinal]
	FROM [sys].[indexes] AS [table_PK]
	INNER JOIN [sys].[index_columns] AS [PK_column_ref] --[column_id]
		ON [table_PK].[object_id] = [PK_column_ref].[object_id]
	INNER JOIN [sys].[columns] AS [PK_column]
		ON [table_PK].[object_id] = [PK_column].[object_id]
			AND [PK_column_ref].[column_id] = [PK_column].[column_id]
	WHERE
		[table_PK].[is_primary_key] = 1
	) AS [pk]
		ON [table].[object_id] = [pk].[object_id]

LEFT OUTER JOIN [sys].[schemas] AS [table_schema]
	ON [table].[schema_id] = [table_schema].[schema_id]
LEFT OUTER JOIN [sys].[foreign_keys] AS [table_references]
	ON [table].[object_id] = [table_references].[parent_object_id]

LEFT OUTER JOIN [sys].[tables] AS [other_table]
	ON [other_table].[object_id] = [table_references].[referenced_object_id]
LEFT OUTER JOIN [sys].[schemas] AS [other_table_schema]
	ON [other_table].[schema_id] = [other_table_schema].[schema_id]

LEFT OUTER JOIN (
	SELECT
		[foreign_key_columns].[parent_object_id]
		,[foreign_key_columns].[referenced_object_id]
		,[table_column].[name] AS [left]
		,[other_table_column].[name] AS [right]
	FROM [sys].[foreign_key_columns]
	INNER JOIN [sys].[columns] AS [table_column]
		ON [foreign_key_columns].[parent_object_id] = [table_column].[object_id]
			AND [foreign_key_columns].[parent_column_id] = [table_column].[column_id]
	INNER JOIN [sys].[columns] AS [other_table_column]
		ON [foreign_key_columns].[referenced_object_id] = [other_table_column].[object_id]
			AND [foreign_key_columns].[referenced_column_id] = [other_table_column].[column_id]

	) AS [links]
	ON [table].[object_id] = [links].[parent_object_id]
		AND [other_table].[object_id] = [links].[referenced_object_id]

ORDER BY
	[table_schema].[name]
	,[table].[name]
FOR XML AUTO, ROOT('tables')
