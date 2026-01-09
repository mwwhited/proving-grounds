-- XML Export Statement Generator
-- Generates SELECT...FOR XML AUTO statements for all tables in the database
-- Useful for creating complete database XML dump scripts
-- Platform: SQL Server

SELECT
	',(SELECT * FROM [' + [schemas].[name] + '].[' + [tables].[name] + '] FOR XML AUTO, TYPE)'
FROM [sys].[tables]
INNER JOIN [sys].[schemas]
	ON [tables].[schema_id] = [schemas].[schema_id]
ORDER BY
	[schemas].[name]
	,[tables].[name]
