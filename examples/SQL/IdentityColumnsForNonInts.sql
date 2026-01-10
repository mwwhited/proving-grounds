/*
	Detect Tables that need integer based identity columns
		Ignore tables that already have integer based columns
		Add script should also ignore cases that have the field but it is not yet PK

*/

WITH [$ComposedColumns] AS (
	SELECT 
		schemas.name AS SchemaName
		,schemas.schema_id
		,tables.name AS TableName
		,tables.object_id
		,identityColumn.name AS IdentityName
		,CASE
			WHEN tables.name LIKE '%ses' THEN SUBSTRING(tables.name,1,LEN(tables.name)-2)
			WHEN tables.name LIKE '%xes' THEN SUBSTRING(tables.name,1,LEN(tables.name)-2)
			WHEN tables.name LIKE '%ies' THEN SUBSTRING(tables.name,1,LEN(tables.name)-3) + 'y'
			WHEN tables.name LIKE '%s' THEN  SUBSTRING(tables.name,1,LEN(tables.name)-1)
			ELSE tables.name END 
				+ 'Identity' 
				AS BuiltIdentityName
		,(
			SELECT 
				LTRIM(STRING_AGG(' [' + columns.name + ']', ','))
			FROM sys.indexes
			INNER JOIN sys.index_columns
				ON index_columns.index_id = indexes.index_id
					AND index_columns.object_id = tables.object_id
					AND index_columns.is_included_column = 0
			INNER JOIN sys.columns
				ON columns.object_id = index_columns.object_id 
					AND columns.column_id = index_columns.column_id
			INNER JOIN sys.types
				ON types.system_type_id = columns.system_type_id
			WHERE indexes.is_primary_key = 1
					AND indexes.object_id = tables.object_id
			--FOR XML PATH(''), TYPE
		) AS [PrimaryKey]
		,(
			SELECT MIN(types.name)
			FROM sys.indexes
			INNER JOIN sys.index_columns
				ON index_columns.index_id = indexes.index_id
					AND index_columns.object_id = tables.object_id
					AND index_columns.is_included_column = 0
			INNER JOIN sys.columns
				ON columns.object_id = index_columns.object_id 
					AND columns.column_id = index_columns.column_id
			INNER JOIN sys.types
				ON types.system_type_id = columns.system_type_id
			WHERE indexes.is_primary_key = 1
					AND indexes.object_id = tables.object_id
			HAVING COUNT(*) = 1
		) AS [AlreadyIntPk]
	FROM sys.tables
	INNER JOIN sys.schemas
		ON schemas.schema_id = tables.schema_id
	LEFT OUTER JOIN sys.columns AS identityColumn
		ON identityColumn.object_id = tables.object_id
			AND identityColumn.is_identity = 1
)
	SELECT 
		*

		,ROW_NUMBER() OVER (ORDER BY [SchemaName], [TableName])  AS [Ordinal]

		,'ALTER TABLE [' + [SchemaName] + '].['+ [TableName] + '] ADD [' + [BuiltIdentityName] + '] INT IDENTITY(1,1) NOT NULL;' AS [AddColumn]

		--DROP FORIGN KEY

		--,CASE WHEN [BuiltIdentityName] != [IdentityName] 
		--	THEN 'ALTER TABLE [' + [SchemaName] + '].['+ [TableName] + '] DROP COLUMN [' + [IdentityName] + '];'
		--	END AS [DropThisColumn]
		
		,CASE WHEN [BuiltIdentityName] != [IdentityName] 
			THEN 'ALTER TABLE [' + [SchemaName] + '].['+ [TableName] + '] DROP PRIMARY KEY;'
			END AS [DropPrimaryKey]

		,'CREATE UNIQUE INDEX [UX_' + [SchemaName] + '_'+ [TableName] + '] ON [' + [SchemaName] + '].['+ [TableName] + '] (Name);  '

		--Add FORIGIN KEY

		,'EXEC sp_addextendedproperty '+
			'@name = N''__lw_n_identity'''+
			',@value = N''Testing entry for Extended Property'''+
			',@level0type = N''Schema'', @level0name = ''' + [SchemaName] + ''''+
			',@level1type = N''Table'',  @level1name = '''+ [TableName] + ''''+ 
			',@level2type = N''Column'', @level2name = ''' + [BuiltIdentityName] + '''' AS [ExtendedProperty\]
			
	FROM [$ComposedColumns]
	--WHERE IdentityName IS NULL
	WHERE 
		[$ComposedColumns].[SchemaName] NOT in ('SIS')
		AND [$ComposedColumns].[TableName] NOT in ('__EFMigrationsHistory')
		AND ([$ComposedColumns].[AlreadyIntPk] IS NULL OR [$ComposedColumns].[AlreadyIntPk] NOT IN ('INT', 'BIGINT'))
		AND NOT EXISTS (
			SELECT *
			FROM sys.columns
			WHERE
				columns.object_id = [$ComposedColumns].object_id
				AND columns.name = [$ComposedColumns].[BuiltIdentityName]
		)
	ORDER BY
		CASE WHEN BuiltIdentityName != IdentityName THEN 1 END DESC
		,SchemaName
		,TableName


SELECT
	indexes.object_id
	,indexes.index_id
	--,columns.column_id
	,'[' + indexes.name +']' AS [IndexName]
	--,'[' + columns.name +']' AS [ColumnName]
	,'[' + columns.name +']' +
	CASE index_columns.is_descending_key WHEN 1 THEN 'DESC' ELSE '' END
		AS [ColumnName]
FROM sys.indexes
INNER JOIN sys.index_columns
	ON index_columns.object_id = indexes.object_id
		AND index_columns.index_id = indexes.index_id
INNER JOIN sys.columns
	ON columns.object_id = indexes.object_id
		AND columns.column_id = index_columns.column_id
WHERE 
	indexes.is_primary_key = 1

SELECT 
	'ALTER TABLE [' + schemas.name + '].[' + tables.name + '] DROP CONSTRAINT [' + foreign_keys.name + '];'
FROM sys.foreign_keys
INNER JOIN sys.tables	
	ON tables.object_id = foreign_keys.parent_object_id
INNER JOIN sys.schemas
	ON tables.schema_id = schemas.schema_id


		