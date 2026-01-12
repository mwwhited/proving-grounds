CREATE Function SplitPath(@Input NVARCHAR(MAX)) 
RETURNS TABLE (
	[Level] INT, 
	[Name] NVARCHAR(200)
) EXTERNAL NAME [WhitedUS.Shared.Data.SqlClr].UserDefinedFunctions.SplitPath
