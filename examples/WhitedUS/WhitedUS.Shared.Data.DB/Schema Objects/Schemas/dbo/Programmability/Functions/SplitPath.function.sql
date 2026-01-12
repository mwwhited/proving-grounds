CREATE FUNCTION [dbo].[SplitPath]
(@Input NVARCHAR (MAX))
RETURNS 
     TABLE (
        [Level] INT            NULL,
        [Name]  NVARCHAR (200) NULL)
AS
 EXTERNAL NAME [WhitedUS.Shared.Data.SqlClr].[UserDefinedFunctions].[SplitPath]

