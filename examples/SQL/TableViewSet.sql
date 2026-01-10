USE bmwdss
GO

DECLARE @procName NVARCHAR(2000) = '[dbo].[YourView]';

WITH [SystemTypes] AS (
	SELECT
		columns.[column_id] AS [Ordinal]
		,columns.[name]
		,types.[name] AS [system_type_name]
		,columns.[is_nullable]
		,columns.[max_length]
		,columns.[precision]
		,columns.[scale]
	FROM sys.columns
	INNER JOIN sys.types 
		ON columns.system_type_id = types.system_type_id 
			AND columns.user_type_id = types.user_type_id
	WHERE [columns].[object_id] = OBJECT_ID(@procName)
), [WithSimpleSqlTypes] AS (
	SELECT 
		[Ordinal]
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
), [WithSimpleSqlTypesAndCSharpTypes] AS (
	SELECT 
		[Ordinal]
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
				WHEN 'bigint' THEN 'long'
				WHEN 'bit' THEN 'bool'
				WHEN 'uniqueidentifier' THEN 'Guid'
				ELSE [sql_simple_type]
			END 
		END + 
		CASE [is_nullable]
			WHEN 1 THEN CASE 
				WHEN [sql_simple_type] LIKE '%char' THEN ''
				ELSE '?'
				END 
		ELSE '' END AS [CSharpType]
	FROM [WithSimpleSqlTypes]
)
	SELECT
		[Ordinal]
		,[name]
		,[system_type_name]
		,[is_nullable]
		,[max_length]
		,[precision]
		,[scale]
		,[sql_simple_type]
		,[CSharpType]
		,'public ' + [CSharpType] + ' ' + [name] + ' { get; set; }' AS [CSharpProperty]
		--,'[Column(Order = ' + CAST([Ordinal] AS NVARCHAR(10)) + ')]' + CHAR(13) + CHAR(10) + 'public ' + [CSharpType] + ' ' + [name] + ' { get; set; }' AS [CSharpProperty]
	FROM [WithSimpleSqlTypesAndCSharpTypes]
