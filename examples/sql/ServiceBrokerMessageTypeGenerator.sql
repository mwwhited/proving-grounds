-- SQL Server Service Broker Message Type Generator
-- Generates CREATE MESSAGE TYPE statements from XML schema collections
-- Platform: SQL Server

--CREATE MESSAGE TYPE <message-type-name, sysname, test_msg>
--AUTHORIZATION <owner-name ,database-user  ,dbo>
--VALIDATION = VALID_XML WITH SCHEMA COLLECTION

;WITH MessageTypes AS (
	SELECT
		'[' + s.name + '].[' + c.name + ']'		AS [Validation]
		,'[dbo]'								AS [Authorization]
		,'[' + n.name + ']'						AS [MessageType]
	FROM sys.schemas s
	JOIN sys.xml_schema_collections c
		ON s.[schema_id] = c.[schema_id]
	JOIN sys.xml_schema_namespaces n
		ON c.xml_collection_id = n.xml_collection_id
			AND n.xml_namespace_id = (
				SELECT MAX(i.xml_namespace_id)
				FROM sys.xml_schema_namespaces i
				WHERE
					c.xml_collection_id = i.xml_collection_id
			)
	WHERE
		c.xml_collection_id != 1
)
SELECT
N'CREATE MESSAGE TYPE ' + CAST(m.[MessageType] AS NVARCHAR(MAX))
,N' AUTHORIZATION ' + CAST(m.[Authorization] AS NVARCHAR(MAX))
,N' VALIDATION = VALID_XML WITH SCHEMA COLLECTION ' + CAST(m.[Validation] AS NVARCHAR(MAX))
FROM MessageTypes m
