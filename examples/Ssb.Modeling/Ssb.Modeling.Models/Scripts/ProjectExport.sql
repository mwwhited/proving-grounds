WITH XMLNAMESPACES (DEFAULT 'mwtm://ServiceBroker/Project/v1',
					'http://www.w3.org/2001/XMLSchema' AS xsd
), [Project] As (
	SELECT 
		[databases].[name] AS [@Name]
		,[databases].[database_id] As [@sql-id]
	FROM [sys].[databases]
	WHERE 
		[databases].[database_id] = DB_ID()
), [Xml-Schema-Collections] AS (
	SELECT 
		[xml_schema_collections__schemas].[name] AS [@Schema]
		,[xml_schema_collections].[name] AS [@Name]
		,[xml_schema_collections].[xml_collection_id] AS [@sql-id]
		,CAST(XML_SCHEMA_NAMESPACE([xml_schema_collections__schemas].[name], [xml_schema_collections].[name]) AS XML) AS [Xml]
	FROM [sys].[xml_schema_collections]
	INNER JOIN [sys].[schemas] AS [xml_schema_collections__schemas]
		ON [xml_schema_collections].[schema_id] = [xml_schema_collections__schemas].[schema_id]
	WHERE
		[xml_schema_collections__schemas].[name] != 'sys'
), [Message-Types] AS (
	SELECT 
		[service_message_types].[name] AS [@Name]
		,CASE [service_message_types].[validation]
			WHEN 'E' THEN 'Empty'
			WHEN 'N' THEN 'None'
			WHEN 'X' THEN CASE
				WHEN [service_message_types].[xml_collection_id] IS NULL THEN 'WellFormedXml'
				ELSE 'ValidXmlWithSchemaCollection'
				END 
			END AS [@Validation]
		,[service_message_types].[message_type_id] AS [@sql-id]
		,CAST((
			SELECT 
				[xml_schema_collections__schemas].[name] AS [@Schema]
				,[xml_schema_collections].[name] AS [@Name]
				,[xml_schema_collections].[xml_collection_id] AS [@sql-id]
			FROM [sys].[xml_schema_collections]
			INNER JOIN [sys].[schemas] AS [xml_schema_collections__schemas]
				ON [xml_schema_collections].[schema_id] = [xml_schema_collections__schemas].[schema_id]
			WHERE
				[xml_schema_collections].[xml_collection_id] = [service_message_types].[xml_collection_id]
			FOR XML PATH('Xml-Schema.Ref')
		) AS XML) AS [Xml-Schema.Ref]
	FROM [sys].[service_message_types]
	WHERE
		[service_message_types].[message_type_id] > 1000
), [Contracts] AS (
	SELECT
		[service_contracts].[name] AS [@Name]
		,[service_contracts].[service_contract_id] AS [@sql-id]
		,CAST((
			SELECT 
				[service_message_types].[name] AS [@Name]
				,CASE
					 WHEN [service_contract_message_usages].[is_sent_by_initiator] = 1 
						AND [service_contract_message_usages].[is_sent_by_target] = 1 THEN 'Any'
					 WHEN [service_contract_message_usages].[is_sent_by_initiator] = 1 THEN 'Initiator'
					 WHEN [service_contract_message_usages].[is_sent_by_target] = 1 THEN 'Target'
					 END AS [@Sent-By]
				,[service_message_types].[message_type_id] AS [@sql-id]
			FROM [sys].[service_contract_message_usages]
			INNER JOIN [sys].[service_message_types]
				ON [service_message_types].[message_type_id] = [service_contract_message_usages].[message_type_id]
			WHERE
				[service_contract_message_usages].[service_contract_id] = [service_contracts].[service_contract_id]
				AND [service_message_types].[message_type_id] > 1000
			FOR XML PATH('Message-Type.Ref')
		) AS XML) AS [Message-Type.Ref]
	FROM [sys].[service_contracts]
	WHERE
		[service_contracts].[service_contract_id] > 1000
), [Queues] AS (
	SELECT 
		[service_queues_schemas].[name] AS [@Schema]
		,[service_queues].[name] AS [@Name]
		,[service_queues].[object_id] AS [@sql-id]
		,CASE [service_queues].[is_enqueue_enabled] WHEN 1 THEN 'true' ELSE 'false' END AS [@Status]
		,CASE [service_queues].[is_retention_enabled] WHEN 1 THEN 'true' ELSE 'false' END AS [@Retention]
		,CASE [service_queues].[is_poison_message_handling_enabled] WHEN 1 THEN 'true' ELSE 'false' END AS [@Poison-Message-Handling]

		,CAST((SELECT
					[procedures_schemas].[name] AS [@Schema]
					,[procedures].[name] AS [@Name]
					,[service_queues].[is_activation_enabled] AS [@Status]
					,[service_queues].[max_readers] AS [@Max-Queue-Readers]
					,[procedures].[object_id] AS [@sql-id]
				FROM [sys].[procedures]
				INNER JOIN [sys].[schemas] AS [procedures_schemas]
					ON [procedures_schemas].[schema_id] = [procedures].[schema_id]
				WHERE
					[procedures].[object_id] = OBJECT_ID([service_queues].[activation_procedure])
				FOR XML PATH('Activator')
				) AS XML) AS [Activator]
	FROM [sys].[service_queues]
	INNER JOIN [sys].[schemas] AS [service_queues_schemas]
		ON [service_queues_schemas].[schema_id] = [service_queues].[schema_id]
	WHERE
		[service_queues].[is_ms_shipped] = 0
), [Services] AS (
	SELECT 
		[services].[name] AS [@Name]
		,[services].[service_id] AS [@sql-id]
		,CAST((
			SELECT
				[service_queues_schemas].[name] AS [@Schema]
				,[service_queues].[name] AS [@Name]
				,[service_queues].[object_id] AS [@sql-id]
			FROM [sys].[service_queues]
			INNER JOIN [sys].[schemas] AS [service_queues_schemas]
				ON [service_queues_schemas].[schema_id] = [service_queues].[schema_id]
			WHERE
				[service_queues].[object_id] = [services].[service_queue_id]
			FOR XML PATH('Queue.Ref')
		) AS XML) AS [Queue.Ref]
		,CAST((
			SELECT 
				[service_contracts].[name] AS [@Name]
				,[service_contracts].[service_contract_id] AS [@sql-id]
			FROM [sys].[service_contract_usages]
			INNER JOIN [sys].[service_contracts]
					ON [service_contracts].[service_contract_id] = [service_contract_usages].[service_contract_id]
			WHERE
				[service_contract_usages].[service_id] = [services].[service_id]
			FOR XML PATH('Contract.Ref')
		) AS XML) AS [Contracts.Ref]
	FROM [sys].[services]
	WHERE
		[services].[service_id] > 1000
)
	SELECT 
		[Project].[@Name]
		,[Project].[@sql-id]
		,CAST((
			SELECT 
				[Xml-Schema-Collections].[@Schema]
				,[Xml-Schema-Collections].[@Name]
				,[Xml-Schema-Collections].[@sql-id]
				,CAST((SELECT 
					CAST(x.s.query('.') AS NVARCHAR(MAX))
					FROM [Xml-Schema-Collections].[Xml].nodes('xsd:schema') AS x(s)
					FOR XML PATH('XmlSchema')
					) AS XML)
			FROM [Xml-Schema-Collections]
			FOR XML PATH('Xml-Schema-Collection')
		 )AS XML)
		 ,CAST((
			SELECT
				[Message-Types].[@Name]
				,[Message-Types].[@Validation]
				,[Message-Types].[@sql-id]
				,CAST([Message-Types].[Xml-Schema.Ref] AS XML)
			FROM [Message-Types]
			FOR XML PATH('Message-Type')
		 ) AS XML)
		 ,CAST((
			SELECT
				[Contracts].[@Name]
				,[Contracts].[@sql-id]
				,CAST([Contracts].[Message-Type.Ref] AS XML)
			FROM [Contracts]
			FOR XML PATH('Contract')
		 ) AS XML)
		 ,CAST((
			SELECT
				[Queues].[@Schema]
				,[Queues].[@Name]
				,[Queues].[@Status]
				,[Queues].[@Retention]
				,[Queues].[@Poison-Message-Handling]
				,[Queues].[@sql-id]
				,CAST([Queues].[Activator] AS XML)
			FROM [Queues]
			FOR XML PATH('Queue')
		 ) AS XML)
		 ,CAST((
			SELECT
				[Services].[@Name]
				,[Services].[@sql-id]
				,CAST([Services].[Queue.Ref] AS XML)
				,CAST([Services].[Contracts.Ref] AS XML)
			FROM [Services]
			FOR XML PATH('Service')
		 ) AS XML)
	FROM [Project]
	FOR XML PATH('Project');
