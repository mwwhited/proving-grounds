--SELECT 
--    [Feature] AS [@feature]
--    ,[CompatibleSchemaVersion] AS [@version]
--    ,[IsCurrentVersion] AS [@isCurrent]
--FROM [dbo].[aspnet_SchemaVersions]
--FOR XML PATH ('aspnet_SchemaVersion'), ROOT('aspnet_SchemaVersions')

DECLARE @aspnet_SchemaVersions XML = N'
<aspnet_SchemaVersions>
  <aspnet_SchemaVersion feature="common" version="1" isCurrent="1" />
  <aspnet_SchemaVersion feature="health monitoring" version="1" isCurrent="1" />
  <aspnet_SchemaVersion feature="membership" version="1" isCurrent="1" />
  <aspnet_SchemaVersion feature="profile" version="1" isCurrent="1" />
  <aspnet_SchemaVersion feature="role manager" version="1" isCurrent="1" />
</aspnet_SchemaVersions>
';

WITH [SchemaVersions] AS (
      SELECT 
            s.a.value('./@feature', 'NVARCHAR(128)') AS [Feature]
            ,s.a.value('./@version', 'NVARCHAR(128)') AS [CompatibleSchemaVersion]
            ,s.a.value('./@isCurrent', 'BIT') AS [IsCurrentVersion]
      FROM @aspnet_SchemaVersions.nodes('aspnet_SchemaVersions/aspnet_SchemaVersion') s(a)
)
      INSERT INTO [dbo].[aspnet_SchemaVersions] (
            [Feature]
            ,[CompatibleSchemaVersion]
            ,[IsCurrentVersion]
      )
      SELECT *
      FROM [SchemaVersions]
      WHERE
            NOT EXISTS (
                  SELECT *
                  FROM [dbo].[aspnet_SchemaVersions]
                  WHERE [aspnet_SchemaVersions].[Feature] = [SchemaVersions].[Feature] 
            )
