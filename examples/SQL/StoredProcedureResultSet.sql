use cash;
go

DECLARE @procName NVARCHAR(2000) = '[dbo].[YourProc]';
WITH [SystemTypes] AS (
	SELECT
		'In' AS [Direction]
		,parameters.[parameter_id] AS [Ordinal]
		,parameters.[name]
		,types.[name] AS [system_type_name]
		,parameters.[is_nullable]
		,parameters.[max_length]
		,parameters.[precision]
		,parameters.[scale]
	FROM sys.parameters 
	INNER JOIN sys.procedures 
		ON parameters.OBJECT_ID = procedures.OBJECT_ID 
	INNER JOIN sys.types 
		ON parameters.system_type_id = types.system_type_id 
			AND parameters.user_type_id = types.user_type_id
	WHERE parameters.OBJECT_ID = OBJECT_ID(@procName)
	UNION ALL
	SELECT 
		'Out' AS [Direction]
		,[column_ordinal] AS [Ordinal]
		,[name]
		,[system_type_name]
		,[is_nullable]
		,[max_length]
		,[precision]
		,[scale]
	FROM sys.dm_exec_describe_first_result_set_for_object(OBJECT_ID(@procName), NULL)
), [WithSimpleSqlTypes] AS (
	SELECT 
		[Direction]
		,[Ordinal]
		,[name]
		,[system_type_name]
		,[is_nullable]
		,[max_length]
		,[precision]
		,[scale]
		,CASE CHARINDEX('(', system_type_name) 
			WHEN 0 THEN system_type_name
			ELSE SUBSTRING(system_type_name,1, CHARINDEX('(', system_type_name) -1)
			END AS [sql_simple_type]
	FROM [SystemTypes]
), [CSharpNames] AS (
	SELECT 
		[Direction]
		,[Ordinal]
		,ROW_NUMBER() OVER (
			PARTITION BY [Ordinal]
			ORDER BY [name]
			) AS [SubOrdinal]
		,CASE 
			WHEN [Direction] = 'In' AND ROW_NUMBER() OVER (PARTITION BY [Ordinal] ORDER BY [name])  = 1 THEN [parts].[value]
			ELSE UPPER(LEFT([parts].[value],1)) + LOWER(RIGHT([parts].[value], LEN([parts].[value]) - 1))
			END AS [value]
	FROM [WithSimpleSqlTypes]
	CROSS APPLY STRING_SPLIT(LTRIM(RTRIM(REPLACE([name],'@', ''))),'_') AS [parts]
	WHERE [Direction] = 'In'
), [WithSimpleSqlTypesAndCSharpTypes] AS (
	SELECT 
		[Direction]
		,[Ordinal]
		,[name]
		,[system_type_name]
		,[is_nullable]
		,[max_length]
		,[precision]
		,[scale]
		,[sql_simple_type]
		,CASE 
			WHEN [sql_simple_type] LIKE '%char' THEN 'string'
			WHEN [sql_simple_type] LIKE '%datetime' THEN 'DateTime'
			ELSE CASE [sql_simple_type]
				WHEN 'money' THEN 'decimal'
				WHEN 'tinyint' THEN 'byte'
				WHEN 'smallint' THEN 'short'
				WHEN 'bit' THEN 'bool'
				ELSE [sql_simple_type]
			END 
		END + 
		CASE [is_nullable]
			WHEN 1 THEN CASE 
				WHEN [sql_simple_type] LIKE '%char' THEN ''
				ELSE '?'
				END 
		ELSE '' END AS [CSharpType]
		,(
			SELECT 
				[CSharpNames].[value] + ''
			FROM [CSharpNames]
			WHERE 
				[CSharpNames].[Direction] = [WithSimpleSqlTypes].[Direction]
				AND [CSharpNames].[Ordinal] = [WithSimpleSqlTypes].[Ordinal]
			ORDER BY [CSharpNames].[SubOrdinal] 
			FOR XML PATH('')
		) AS [CSharpName]
	FROM [WithSimpleSqlTypes]
)
	SELECT
		[Direction]
		,[Ordinal]
		,[name]
		,[system_type_name]
		,[CSharpType]
		,[CSharpName]
		,CASE [Direction] WHEN 'Out' THEN 'public ' + [CSharpType] + ' ' + [name] + ' { get; set; }' END AS [CSharpProperty]
		,CASE [Direction] WHEN 'In' THEN 'new SqlParameter("' + [name] + '", ' + [CSharpName] + ')' + 
			CASE WHEN MAX([Ordinal]) OVER (PARTITION BY [Direction]) = [Ordinal] THEN '' ELSE ',' END 
			END AS [CSharpSqlParameter]
		,CASE [Direction] WHEN 'In' THEN [CSharpType] + ' ' + [CSharpName] + 
			CASE WHEN MAX([Ordinal]) OVER (PARTITION BY [Direction]) = [Ordinal] THEN '' ELSE ',' END
			END AS [CSharpParameter]		
	FROM [WithSimpleSqlTypesAndCSharpTypes]
