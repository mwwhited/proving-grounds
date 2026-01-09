-- Comprehensive Database Schema Export with Relationships
-- Exports complete database schema including tables, columns, indexes, and foreign keys
-- Platform: SQL Server
--USE [YourDatabaseName];
--GO


SELECT
	[schemas].[name] AS [@name]
	,[schemas].[schema_id] AS [@id]
	,(
		SELECT
			LOWER([tables].[name]) AS [@name]
			,'[' + [schemas].[name] + '].[' + LOWER([tables].[name]) + ']' AS [@full-name]
			,[tables].[object_id] AS [@id]
			,(
				SELECT
					[columns].[name] AS [@name]
					,[columns].[column_id] AS [@id]
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
						END) AS [@type]
					,[columns].[is_nullable] AS [@is-nullable]

				FROM [sys].[columns]
				INNER JOIN [sys].[types]
					ON [types].[system_type_id] = [columns].[system_type_id]
						AND [types].[user_type_id] = [columns].[user_type_id]
				WHERE
					[columns].[object_id] = [tables].[object_id]
				FOR XML PATH('column'), TYPE
			)
			,(
				SELECT
					[indexes].[name] AS [@name]
					,[indexes].[index_id] AS [@id]
					,[indexes].[is_unique] AS [@is-unique]
					,[indexes].[is_primary_key] AS [@is-primary-key]
					,[indexes].[type_desc] AS [@type]
					,(
						SELECT
							[index_columns].[column_id] AS [@ref-id]
							,[columns].[name] AS [@ref-name]
						FROM [sys].[index_columns]
						INNER JOIN [sys].[columns]
							ON [columns].[object_id] = [tables].[object_id]
								AND [columns].[column_id] = [index_columns].[column_id]
						WHERE
							[index_columns].[object_id] = [tables].[object_id]
							AND [index_columns].[index_id] = [indexes].[index_id]
						FOR XML PATH('column-ref'), TYPE
					)
				FROM [sys].[indexes]
				WHERE
					[indexes].[object_id] = [tables].[object_id]
					AND [indexes].[index_id] != 0
				FOR XML PATH('index'), TYPE
			)
			,(
				SELECT
					[foreign_keys].[name] AS [@name]
					,[foreign_keys].[object_id] AS [@id]
					,[foreign_keys].[schema_id] AS [@schema-id]
					,[foreign_keys].[referenced_object_id] AS [@related-id]
					,[referenced_tables].[name] AS [@related-name]
					,[referenced_schemas].[name] AS [@related-schema]
					,(
						SELECT
							[foreign_key_columns].[constraint_column_id] AS [@id]
							,[foreign_key_columns].[parent_column_id] AS [@ref-id]
							,[parent_column].[name] AS [@ref-name]
							,[foreign_key_columns].[referenced_column_id] AS [@related-id]
							,[referenced_column].[name] AS [@related-name]
						FROM [sys].[foreign_key_columns]
						INNER JOIN [sys].[columns] AS [parent_column]
							ON [parent_column].[object_id] = [foreign_key_columns].[parent_object_id]
								AND [parent_column].[column_id] = [foreign_key_columns].[parent_column_id]
						INNER JOIN [sys].[columns] AS [referenced_column]
							ON [referenced_column].[object_id] = [foreign_key_columns].[referenced_object_id]
								AND [referenced_column].[column_id] = [foreign_key_columns].[referenced_column_id]
						WHERE
							[foreign_key_columns].[constraint_object_id] = [foreign_keys].[object_id]
						FOR XML PATH('column-ref'), TYPE
					)
				FROM [sys].[foreign_keys]
				INNER JOIN [sys].[tables] AS [referenced_tables]
					ON [foreign_keys].[referenced_object_id] = [referenced_tables].[object_id]
				INNER JOIN [sys].[schemas] AS [referenced_schemas]
					ON [referenced_tables].[schema_id] = [referenced_schemas].[schema_id]
				WHERE
					[foreign_keys].[parent_object_id] = [tables].[object_id]
				FOR XML PATH('foreign-key'), TYPE
			)
		FROM [sys].[tables]
		WHERE
			[tables].[schema_id] = [schemas].[schema_id]
			AND [tables].[name] != 'sysdiagrams'
		FOR XML PATH('table'), TYPE
	)
FROM [sys].[schemas]
WHERE
	[schemas].[schema_id] IN (
		SELECT [tables].[schema_id]
		FROM [sys].[tables]
		WHERE
			[tables].[name] != 'sysdiagrams'
	)
FOR XML PATH('schema'), ROOT('db')

