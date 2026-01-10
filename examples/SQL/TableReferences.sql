SELECT 
	'[' + schemas.name + '].[' + tables.name + ']' AS [ParentTable]
	,'(' + LTRIM((SELECT STRING_AGG(' [' + columns.name + ']', ',') WITHIN GROUP (ORDER BY foreign_key_columns.constraint_column_id)
		FROM sys.foreign_key_columns
		INNER JOIN sys.columns
			ON columns.object_id = foreign_key_columns.parent_object_id
				AND columns.column_id = foreign_key_columns.parent_column_id
		WHERE foreign_key_columns.constraint_object_id = foreign_keys.object_id)) + ')' AS [ParentColumns]

	,'[' + foreign_keys.name + ']' AS [ForeignKeyName]

	,'[' + [referenceSchema].name + '].[' + [referennceTable].name + ']' AS [ReferenceTable]
	,'(' + LTRIM((SELECT STRING_AGG(' [' + columns.name + ']', ',') WITHIN GROUP (ORDER BY foreign_key_columns.constraint_column_id)
		FROM sys.foreign_key_columns
		INNER JOIN sys.columns
			ON columns.object_id = foreign_key_columns.referenced_object_id
				AND columns.column_id = foreign_key_columns.referenced_column_id
		WHERE foreign_key_columns.constraint_object_id = foreign_keys.object_id)) + ')' AS [ReferenceColumns]
FROM sys.foreign_keys	
--INNER JOIN sys.foreign_key_columns
--	ON foreign_key_columns.constraint_object_id = foreign_keys.object_id
INNER JOIN sys.tables
	ON tables.object_id = foreign_keys.parent_object_id
INNER JOIN sys.schemas
	ON schemas.schema_id = tables.schema_id
INNER JOIN sys.tables AS [referennceTable]
	ON [referennceTable].object_id = foreign_keys.referenced_object_id
INNER JOIN sys.schemas AS [referenceSchema]
	ON [referenceSchema].schema_id = [referennceTable].schema_id
ORDER BY
	schemas.name
	,tables.name
	,foreign_keys.name