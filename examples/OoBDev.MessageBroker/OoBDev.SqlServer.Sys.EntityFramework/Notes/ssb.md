using Microsoft.EntityFrameworkCore;
using Playground.Core;
using Playground.SSB.Core;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace Playground.SSB.Client
{
    public static class ServiceBrokerEntitesExtension
    {
        public static IServiceBroker GetBroker<TDBContext>(this TDBContext context) where TDBContext : DbContext
        {
            return new ServiceBrokerEntitesExtension<TDBContext>(context);
        }
    }
    internal class ServiceBrokerEntitesExtension<TDBContext> : IServiceBroker where TDBContext : DbContext
    {
        public TDBContext Context { get; private set; }

        public ServiceBrokerEntitesExtension(TDBContext context)
        {
            this.Context = context;
        }

        public IEnumerable<IServiceBrokerQueue> Queues()
        {
            var command = @"SELECT 
	[service_queues].[name] AS [Name]
	,[schemas].[name] AS [Schema]
	,[service_queues].[is_enqueue_enabled] AS [IsEnabled]
FROM [sys].[service_queues]
INNER JOIN [sys].[schemas]
	ON [service_queues].[schema_id] = [schemas].[schema_id]
WHERE
	[service_queues].[is_ms_shipped] = 0
	AND [service_queues].[is_activation_enabled] = 0";
            return this.Context.Query<ServiceBrokerQueue>().FromSql(command) ?? Enumerable.Empty<ServiceBrokerQueue>();
        }
        public IEnumerable<IServiceBrokerService> Services(IServiceBrokerQueue queue = null)
        {
            var command = @"SELECT 
	[Services].[name] AS [Name]
FROM [sys].[services] AS [Services]
INNER JOIN (
	SELECT 
		[service_queues].*
		,[schemas].[name] AS [SchemaName]
	FROM [sys].[service_queues]
	INNER JOIN [sys].[schemas]
		ON [service_queues].[schema_id] = [schemas].[schema_id]" +
(queue == null ? "" : @"    WHERE
        [service_queues].[name] = @queueName
        AND [schemas].[name] = @schemaName
") +
@") AS [Queues] 
	ON [Services].[service_queue_id] = [Queues].[object_id]
WHERE
	[Queues].[is_ms_shipped] = 0";

            return this.Context.Query<ServiceBrokerService>().FromSql(command,
                new SqlParameter("@queueName", queue == null ? "" : queue.Name),
                new SqlParameter("@schemaName", queue == null ? "" : queue.Schema)
                ) ?? Enumerable.Empty<ServiceBrokerService>();
        }
        public IEnumerable<IServiceBrokerContract> Contracts(IServiceBrokerService service = null)
        {
            var command = @"SELECT 
	[service_contracts].[name] AS [Name]
FROM [sys].[service_contracts]
INNER JOIN [sys].[service_contract_usages]
	ON [service_contracts].[service_contract_id] = [service_contract_usages].[service_contract_id]
INNER JOIN [sys].[services]
	ON [services].[service_id] = [service_contract_usages].[service_id]" +
(service == null ? "" : @"    AND
        [services].[name] = @serviceName
") +
@"
		--AND [services].[name] = @serviceName
INNER JOIN [sys].[service_queues]
	ON [service_queues].[object_id] = [services].[service_queue_id]
WHERE
	[service_queues].[is_ms_shipped] = 0";

            return this.Context.Query<ServiceBrokerContract>().FromSql(command,
                new SqlParameter("@serviceName", service == null ? "" : service.Name)
                ) ?? Enumerable.Empty<ServiceBrokerContract>();
        }
        public IEnumerable<IServiceBrokerMessageType> MessageTypes(Guid conversationHandle)
        {
            //TODO: Extend this with XSD
            var command = @"SELECT 
	[service_message_types].[name] AS [Name]
	,[service_message_types].[validation] AS [ValidationType]
	,[service_message_types].[validation_desc] AS [ValidationTypeDescription]

	,[service_contract_message_usages].[is_sent_by_initiator] AS [ByInitiator]
	,[service_contract_message_usages].[is_sent_by_target] AS [ByTarget]

	,CASE
		WHEN [service_contract_message_usages].[is_sent_by_initiator] = 0
			AND [service_contract_message_usages].[is_sent_by_target] = 0 THEN 0
		WHEN [service_contract_message_usages].[is_sent_by_initiator] = 1
			AND [service_contract_message_usages].[is_sent_by_target] = 0 THEN 1
		WHEN [service_contract_message_usages].[is_sent_by_initiator] = 0
			AND [service_contract_message_usages].[is_sent_by_target] = 1 THEN 2
		WHEN [service_contract_message_usages].[is_sent_by_initiator] = 1
			AND [service_contract_message_usages].[is_sent_by_target] = 1 THEN 3
		END AS [SentBy]
FROM [sys].[conversation_endpoints]
INNER JOIN [sys].[service_contract_message_usages]
	ON [service_contract_message_usages].[service_contract_id] = [conversation_endpoints].[service_contract_id]
		AND (
			([conversation_endpoints].[is_initiator] = 1 AND [service_contract_message_usages].[is_sent_by_initiator] = 1)
			OR ([conversation_endpoints].[is_initiator] = 0 AND [service_contract_message_usages].[is_sent_by_target] = 1)
		)
INNER JOIN [sys].[service_message_types]
	ON [service_message_types].[message_type_id] = [service_contract_message_usages].[message_type_id]
WHERE
	[conversation_endpoints].[is_system] = 0
	AND [conversation_endpoints].[conversation_handle] = @conversationHandle;
";

            return this.Context.Query<ServiceBrokerMessageType>().FromSql(command,
                new SqlParameter("@conversationHandle", conversationHandle)
                ) ?? Enumerable.Empty<ServiceBrokerMessageType>();
        }
        public IEnumerable<IServiceBrokerMessageType> MessageTypes(IServiceBrokerContract contract = null)
        {
            //TODO: Extend this with XSD
            var command = @"SELECT 
	[service_message_types].[name] AS [Name]
	,[service_message_types].[validation] AS [ValidationType]
	,[service_message_types].[validation_desc] AS [ValidationTypeDescription]

	,[service_contract_message_usages].[is_sent_by_initiator] AS [ByInitiator]
	,[service_contract_message_usages].[is_sent_by_target] AS [ByTarget]

	,CASE
		WHEN [service_contract_message_usages].[is_sent_by_initiator] = 0
			AND [service_contract_message_usages].[is_sent_by_target] = 0 THEN 0
		WHEN [service_contract_message_usages].[is_sent_by_initiator] = 1
			AND [service_contract_message_usages].[is_sent_by_target] = 0 THEN 1
		WHEN [service_contract_message_usages].[is_sent_by_initiator] = 0
			AND [service_contract_message_usages].[is_sent_by_target] = 1 THEN 2
		WHEN [service_contract_message_usages].[is_sent_by_initiator] = 1
			AND [service_contract_message_usages].[is_sent_by_target] = 1 THEN 3
		END AS [SentBy]

FROM [sys].[service_message_types]
INNER JOIN [sys].[service_contract_message_usages]
	ON [service_contract_message_usages].[message_type_id] = [service_message_types].[message_type_id]
INNER JOIN [sys].[service_contracts]
	ON [service_contracts].[service_contract_id] = [service_contract_message_usages].[service_contract_id]" +
(contract == null ? "" : @"    AND [service_contracts].[name] = @contractName");

            return this.Context.Query<ServiceBrokerMessageType>().FromSql(command,
                new SqlParameter("@contractName", contract == null ? "" : contract.Name)
                ) ?? Enumerable.Empty<ServiceBrokerMessageType>();
        }

        /// <summary>
        /// Begin Dialog on SQL Service Broker
        /// </summary>
        /// <param name="from">Source Service for the Dialog</param>
        /// <param name="to">Receiving Service for the Dialog</param>
        /// <param name="contract">Contract to use for the Dialog (Default = No Contract)</param>
        /// <param name="encrypted">Encrypt Dialog (Default = No)</param>
        /// <param name="relatedConversationID">ConversationID for Related Dialog (Default = No ID)</param>
        /// <param name="relatedGroupID">GroupID for related Dialogs (Default = No ID)</param>
        /// <param name="brokerID">ServiceBrokerID for Dialog (Default = No Dialog)  Send Guid.Empty to force 'CURRENT DATABASE'</param>
        /// <returns></returns>
        public async Task<Guid> BeginDialog(IServiceBrokerService from, IServiceBrokerService to, IServiceBrokerContract contract = null,
                                            bool encrypted = false,
                                            Guid? relatedConversationID = null,
                                            Guid? relatedGroupID = null,
                                            Guid? brokerID = null)
        {
            var commandFormatter = @"BEGIN DIALOG @ch " +
                                   @"   FROM SERVICE [{0}] " +
                                   @"   TO SERVICE '{1}'" +
                                   (brokerID.HasValue ? @", '{4}'" : "") +
                                   (contract == null ? "" : @"   ON CONTRACT [{2}]") +
                                   @"   WITH" +
                                   (relatedConversationID.HasValue ? @"   RELATED_CONVERSATION = @relatedConversationID" : "") +
                                   (relatedGroupID.HasValue ? @"   RELATED_CONVERSATION_GROUP = @relatedGroupID" : "") +
                                   @"       ENCRYPTION = {3};";
            var command = string.Format(commandFormatter,
                                        from.Name,
                                        to.Name.Replace("'", "''"),
                                        contract.Name,
                                        encrypted ? "ON" : "OFF",
                                        brokerID.HasValue ? (brokerID.Value == Guid.Empty ? "CURRENT DATABASE" : brokerID.Value.ToString()) : ""
                                        );

            var conversationHandle = new SqlParameter("@ch", SqlDbType.UniqueIdentifier)
            {
                Direction = ParameterDirection.Output,
            };


            var rowcount = await this.Context.Database.ExecuteSqlCommandAsync(command,
                conversationHandle,
                new SqlParameter("@relatedConversationID", relatedConversationID ?? Guid.Empty) { Direction = ParameterDirection.Output, },
                new SqlParameter("@relatedGroupID", relatedGroupID ?? Guid.Empty) { Direction = ParameterDirection.Output, }
                );

            return (Guid)conversationHandle.Value;
        }

        public async Task SendOnConversation(Guid dialogHandle, object payload)
        {
            var xml = await payload.AsXml();
            await this.SendOnConversation(dialogHandle, xml.Name.NamespaceName, xml);
        }
        public async Task SendOnConversation(Guid dialoghandle, string messageTypeName, XElement message)
        {
            await this.SendOnConversation(dialoghandle, new ServiceBrokerMessageType { Name = messageTypeName }, message);
        }
        public async Task SendOnConversation(Guid dialoghandle, IServiceBrokerMessageType messageType, XElement message)
        {
            var payload = message == null ? (string)null : message.ToString();
            await this.SendOnConversation(dialoghandle, messageType, payload);
        }
        public async Task SendOnConversation(Guid dialoghandle, string messageTypeName, string message = null)
        {
            await this.SendOnConversation(dialoghandle, new ServiceBrokerMessageType { Name = messageTypeName }, message);
        }
        public async Task SendOnConversation(Guid dialoghandle, IServiceBrokerMessageType messageType, string message = null)
        {
            var validationOption = await this.MessageTypeValidation(messageType);

            if (validationOption == null || validationOption.ValidationType.StartsWith("N")) // None
            {
                await this.SendOnConversation_Simple(dialoghandle, messageType, message);
            }
            else if (validationOption.ValidationType.StartsWith("E")) //Empty
            {
                if (string.IsNullOrWhiteSpace(message))
                {
                    await this.SendOnConversation_Simple(dialoghandle, messageType, message);
                }
                else
                {
                    throw new InvalidOperationException("MessageType does not Allow Content");
                }
            }
            else if (validationOption.ValidationType.StartsWith("X")) // Xml
            {
                if (validationOption.IsXmlSchema) //Xml with Schema
                {
                    await this.SendOnConversation_Schema(dialoghandle, messageType, message, validationOption.XmlCollectionSchema, validationOption.XmlCollectionName);
                }
                else //Xml
                {
                    await this.SendOnConversation_Xml(dialoghandle, messageType, message);
                }
            }
            else
            {
                throw new NotSupportedException();
            }

        }
        private async Task SendOnConversation_Xml(Guid dialoghandle, IServiceBrokerMessageType messageType, string message)
        {
            var commandFormatter = @"DECLARE @messageContent XML = @message;" +
                                   @"SEND ON CONVERSATION @ch " +
                                   @"   MESSAGE TYPE [{0}] " +
                                   @"   (@messageContent);";

            var command = string.Format(commandFormatter, messageType.Name);

            var rowcount = await this.Context.Database.ExecuteSqlCommandAsync(command,
                new SqlParameter("@ch", dialoghandle) { Direction = ParameterDirection.Input, },
                new SqlParameter("@message", SqlDbType.Xml) { Direction = ParameterDirection.Input, Value = message, }
                );
        }
        private async Task SendOnConversation_Schema(Guid dialoghandle, IServiceBrokerMessageType messageType, string message, string catalogName, string collectionName)
        {
            var commandFormatter = @"DECLARE @messageContent XML([{1}].[{2}]) = @message;" +
                                   @"SEND ON CONVERSATION @ch " +
                                   @"   MESSAGE TYPE [{0}] " +
                                   @"   (@messageContent);";

            var command = string.Format(commandFormatter, messageType.Name, catalogName, collectionName);

            var rowcount = await this.Context.Database.ExecuteSqlCommandAsync(command,
                new SqlParameter("@ch", dialoghandle) { Direction = ParameterDirection.Input, },
                new SqlParameter("@message", SqlDbType.Xml) { Direction = ParameterDirection.Input, Value = message, }
                );
        }
        private async Task SendOnConversation_Simple(Guid dialoghandle, IServiceBrokerMessageType messageType, string message = null)
        {
            var commandFormatter = @"SEND ON CONVERSATION @ch " +
                                   @"   MESSAGE TYPE [{0}] " +
                                   (string.IsNullOrWhiteSpace(message) ? "" : @"   (@message);");

            var command = string.Format(commandFormatter, messageType.Name);

            var rowcount = await this.Context.Database.ExecuteSqlCommandAsync(command,
                new SqlParameter("@ch", dialoghandle) { Direction = ParameterDirection.Input, },
                new SqlParameter("@message", SqlDbType.NVarChar, int.MaxValue) { Direction = ParameterDirection.Input, Value = message ?? "", }
                );
        }
        public async Task SendOnConversation(Guid dialoghandle, string messageTypeName, byte[] message)
        {
            await this.SendOnConversation(dialoghandle, new ServiceBrokerMessageType { Name = messageTypeName }, message);
        }
        public async Task SendOnConversation(Guid dialoghandle, IServiceBrokerMessageType messageType, byte[] message)
        {
            var commandFormatter = @"SEND ON CONVERSATION @ch " +
                                   @"   MESSAGE TYPE [{0}] " +
                                   ((message == null || message.Length == 0) ? "" : @"   (@message);");

            var command = string.Format(commandFormatter,
                                        messageType.Name,
                                        message);

            var conversationHandle = new SqlParameter("@ch", dialoghandle)
            {
                Direction = ParameterDirection.Input,
            };

            var rowcount = await this.Context.Database.ExecuteSqlCommandAsync(command, conversationHandle,
                new SqlParameter("@message", message ?? new byte[0]) { Direction = ParameterDirection.Input, });
        }
        public async Task EndConversation(Guid conversationHandle, IServiceBrokerError withError = null)
        {
            var commandFormatter = @"END CONVERSATION @conversationHandle" +
                (withError == null ? "" : " WITH ERROR=@error_id DESCRIPTION='@error_desc'") +
                ";";
            var command = string.Format(commandFormatter);

            var rowcount = await this.Context.Database.ExecuteSqlCommandAsync(command,
                new SqlParameter("@conversationHandle", conversationHandle) { Direction = ParameterDirection.Input, },
                new SqlParameter("@error_id", withError == null ? 0 : withError.Code) { Direction = ParameterDirection.Input, },
                new SqlParameter("@error_desc", withError == null ? "" : withError.Description) { Direction = ParameterDirection.Input, }
                );
        }

        public async Task EndConversation(Guid conversationHandle, Exception exception)
        {
            await this.EndConversation(conversationHandle, new ServiceBrokerError
            {
                Code = int.MaxValue,
                Description = exception.ToString(),
            });
        }

        public async Task EnableQueue(IServiceBrokerQueue queue)
        {
            var commandFormatter = @"ALTER QUEUE [{0}].[{1}] WITH STATUS = ON";
            var command = string.Format(commandFormatter, queue.Schema, queue.Name);

            var rowcount = await this.Context.Database.ExecuteSqlCommandAsync(command);
        }
        public async Task DisableQueue(IServiceBrokerQueue queue)
        {
            var commandFormatter = @"ALTER QUEUE [{0}].[{1}] WITH STATUS = OFF";
            var command = string.Format(commandFormatter, queue.Schema, queue.Name);

            var rowcount = await this.Context.Database.ExecuteSqlCommandAsync(command);
        }

        public async Task<Guid?> GetConversationGroup(IServiceBrokerQueue queue, int timeout = ServiceBrokerGlobals.DefaultTimeOut)
        {
            var commandFormatter = @"WAITFOR (" +
                                   @"   GET CONVERSATION GROUP @conversation_group_id" +
                                   @"   FROM [{0}].[{1}]" +
                                   @"), TIMEOUT {2}";
            var command = string.Format(commandFormatter, queue.Schema, queue.Name, timeout);

            var parameter = new SqlParameter("@conversation_group_id", SqlDbType.UniqueIdentifier) { Direction = ParameterDirection.Output, };

            var rowcount = await this.Context.Database.ExecuteSqlCommandAsync(command, parameter);

            if (parameter.Value == DBNull.Value)
            {
                return null;
            }

            return (Guid)parameter.Value;
        }
        public async Task<IServiceBrokerMessage> Receive(IServiceBrokerQueue queue, int timeout = ServiceBrokerGlobals.DefaultTimeOut)
        {
            var commandFormatter = @"WAITFOR (" +
                                   @"   RECEIVE TOP(1) " +
                                   @"       @conversation_group_id = [conversation_group_id]," +
                                   @"       @conversation_handle = [conversation_handle]," +
                                   @"       @validation = [validation]," +
                                   @"       @service_contract_name = [service_contract_name]," +
                                   @"       @message_type_name = [message_type_name]," +
                                   @"       @message_body = [message_body]," +
                                   @"       @message_text = CAST([message_body] AS NVARCHAR(MAX))" +
                                   @"   FROM [{0}].[{1}]" +
                                   @"), TIMEOUT {2}";
            var command = string.Format(commandFormatter, queue.Schema, queue.Name, timeout);

            var parameters = new[] {
                new SqlParameter("@conversation_group_id", SqlDbType.UniqueIdentifier)  {  Direction = ParameterDirection.Output, },
                new SqlParameter("@conversation_handle", SqlDbType.UniqueIdentifier)  {  Direction = ParameterDirection.Output, },

                new SqlParameter("@validation", SqlDbType.NVarChar, 2)  {  Direction = ParameterDirection.Output,  },
                new SqlParameter("@service_contract_name", SqlDbType.NVarChar, 256)  {  Direction = ParameterDirection.Output, },
                new SqlParameter("@message_type_name", SqlDbType.NVarChar, 256)  {  Direction = ParameterDirection.Output, },

                new SqlParameter("@message_body", SqlDbType.VarBinary, int.MaxValue)  {  Direction = ParameterDirection.Output, },
                new SqlParameter("@message_text", SqlDbType.NVarChar, int.MaxValue)  {  Direction = ParameterDirection.Output, },
            };

            var rowcount = await this.Context.Database.ExecuteSqlCommandAsync(command, parameters);

            if (parameters[0].Value == DBNull.Value)
            {
                return null;
            }

            var data = parameters.ToDictionary(p => p.ParameterName);
            var result = new ServiceBrokerMessage
            {
                ConversationGroupId = (Guid)data["@conversation_group_id"].Value,
                ConversationHandle = (Guid)data["@conversation_handle"].Value,

                Validation = (string)data["@validation"].Value,
                ServiceContractName = (string)data["@service_contract_name"].Value,
                MessageTypeName = (string)data["@message_type_name"].Value,

                MessageBody = (data["@message_body"].Value != DBNull.Value ? (byte[])data["@message_body"].Value : null),
                MessageText = (data["@message_text"].Value != DBNull.Value ? data["@message_text"].Value.ToString() : null),
                //MessageText = (data["@message_text"].Value != DBNull.Value ? ((string)data["@message_text"].Value).Substring(1) : null),

                QueueName = queue.Name,
                QueueSchema = queue.Schema,
            };
            return result;
        }
        public async Task<IServiceBrokerMessage> Receive(IServiceBrokerQueue queue, Guid conversationGroup, int timeout = ServiceBrokerGlobals.DefaultTimeOut)
        {
            var commandFormatter = @"WAITFOR (" + Environment.NewLine +
                                   @"   RECEIVE TOP(1) " + Environment.NewLine +
                                   @"       @conversation_group_id = [conversation_group_id]," + Environment.NewLine +
                                   @"       @conversation_handle = [conversation_handle]," + Environment.NewLine +
                                   @"       @validation = [validation]," + Environment.NewLine +
                                   @"       @service_contract_name = [service_contract_name]," + Environment.NewLine +
                                   @"       @message_type_name = [message_type_name]," + Environment.NewLine +
                                   @"       @message_body = [message_body]," + Environment.NewLine +
                                   @"       @message_text = CAST([message_body] AS NVARCHAR(MAX))," + Environment.NewLine +
                                   @"       @message_xml = CASE [validation] WHEN 'X' THEN CAST([message_body] AS XML) END" + Environment.NewLine +
                                   @"   FROM [{0}].[{1}]" + Environment.NewLine +
                                   @"   WHERE conversation_group_id = @group_id" + Environment.NewLine +
                                   @"), TIMEOUT {2}";
            var command = string.Format(commandFormatter, queue.Schema, queue.Name, timeout);

            var parameters = new[] {
                new SqlParameter("@conversation_group_id", SqlDbType.UniqueIdentifier)  {  Direction = ParameterDirection.Output, },
                new SqlParameter("@conversation_handle", SqlDbType.UniqueIdentifier)  {  Direction = ParameterDirection.Output, },

                new SqlParameter("@validation", SqlDbType.NVarChar, 2)  {  Direction = ParameterDirection.Output,  },
                new SqlParameter("@service_contract_name", SqlDbType.NVarChar, 256)  {  Direction = ParameterDirection.Output, },
                new SqlParameter("@message_type_name", SqlDbType.NVarChar, 256)  {  Direction = ParameterDirection.Output, },

                new SqlParameter("@message_body", SqlDbType.VarBinary, int.MaxValue)  {  Direction = ParameterDirection.Output, },
                new SqlParameter("@message_text", SqlDbType.NVarChar, int.MaxValue)  {  Direction = ParameterDirection.Output, },
                new SqlParameter("@message_xml", SqlDbType.Xml)  {  Direction = ParameterDirection.Output, },

                new SqlParameter("@group_id", conversationGroup)  {  Direction = ParameterDirection.Input, },
            };

            var rowcount = await this.Context.Database.ExecuteSqlCommandAsync(command, parameters);

            if (parameters[0].Value == DBNull.Value)
            {
                return null;
            }

            var data = parameters.ToDictionary(p => p.ParameterName);
            var result = new ServiceBrokerMessage
            {
                ConversationGroupId = (Guid)data["@conversation_group_id"].Value,
                ConversationHandle = (Guid)data["@conversation_handle"].Value,

                Validation = (string)data["@validation"].Value,
                ServiceContractName = (string)data["@service_contract_name"].Value,
                MessageTypeName = (string)data["@message_type_name"].Value,

                MessageBody = (data["@message_body"].Value != DBNull.Value ? (byte[])data["@message_body"].Value : null),
                MessageText = (data["@message_text"].Value != DBNull.Value ? (string)data["@message_text"].Value : null),

                QueueName = queue.Name,
                QueueSchema = queue.Schema,
            };
            return result;
        }

        public async Task BeginConversationTimer(Guid conversationHandle, int timeoutSeconds)
        {
            var command = "BEGIN CONVERSATION TIMER (@conversation_handle) TIMEOUT = @timeout;";

            var parameters = new[] {
                new SqlParameter("@conversation_handle", conversationHandle)  {  Direction = ParameterDirection.Input, },
                new SqlParameter("@timeout", timeoutSeconds)  {  Direction = ParameterDirection.Input, },
            };

            var rowcount = await this.Context.Database.ExecuteSqlCommandAsync(command, parameters);
        }

        public async Task<IServiceBrokerValidation> MessageTypeValidation(IServiceBrokerMessageType messageType)
        {
            var command = @"SELECT 
	[service_message_types].[name] AS [Name]
	,[service_message_types].[validation] AS [ValidationType]
	,[service_message_types].[validation_desc] AS [ValidationTypeDescription]

	,CAST((CASE [service_message_types].[validation]
		WHEN 'X' THEN 1
		ELSE 0
		END) AS BIT) AS [IsXml]
	,CAST((CASE
		WHEN [service_message_types].[xml_collection_id] IS NOT NULL THEN 1
		ELSE 0
		END) AS BIT) AS [IsXmlSchema]
	
	,[schemas_forxml].[name] AS [XmlCollectionSchema]
	,[xml_schema_collections].[name] AS [XmlCollectionName]
	,CASE
		WHEN [service_message_types].[xml_collection_id] IS NOT NULL
			THEN XML_SCHEMA_NAMESPACE([schemas_forxml].[name],[xml_schema_collections].[name])
		END AS [XmlSchemaCollectionContent]
FROM [sys].[service_message_types]
LEFT OUTER JOIN [sys].[xml_schema_collections]
	ON [xml_schema_collections].[xml_collection_id] = [service_message_types].[xml_collection_id]
LEFT OUTER JOIN [sys].[schemas] AS [schemas_forxml]
	ON [schemas_forxml].[schema_id] = [xml_schema_collections].[schema_id]
WHERE
	[service_message_types].[name] = @messageType";

            var parameters = new[] {
                new SqlParameter("@messageType", messageType != null ?  messageType.Name : null)  {  Direction = ParameterDirection.Input, },
            };

            var results = this.Context.Query<ServiceBrokerValidation>().FromSql(command, parameters);
            var result = await results.FirstOrDefaultAsync();
            return result;
        }
    }
}
