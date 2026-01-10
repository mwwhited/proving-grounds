using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;

namespace OoBDev.SqlServer.Sys
{
    public class SystemContext : DbContext
    {
        private string ConnectionString { get; }

        public SystemContext(DbContext wrappedContext)
            : this(wrappedContext.Database.GetDbConnection().ConnectionString)
        {
        }

        /// <summary>
        /// </summary>
        /// <param name="keys">key value pair set for connection string</param>
        /// <param name="useOdbcRules">true to use {} to delimit fields; false to use quotation marks.</param>
        public SystemContext(IDictionary<string, object> keys, bool useOdbcRules = false)
            : this(keys?.Aggregate(new DbConnectionStringBuilder(useOdbcRules), (dsb, i) => { dsb.Add(i.Key, i.Value); return dsb; }, dsb => dsb.ToString()))
        {
        }

        public SystemContext(params (string name, object value)[] keys)
            : this(keys?.ToDictionary(i => i.name, i => i.value), false)
        {

        }

        public SystemContext(bool useOdbcRules, params (string name, object value)[] keys)
            : this(keys?.ToDictionary(i => i.name, i => i.value), useOdbcRules)
        {

        }
        public SystemContext(string connectionString = null)
        {
            ConnectionString = connectionString;
        }

        public SystemContext(DbContextOptions<SystemContext> options)
            : base(options)
        {
        }

        public virtual DbSet<ConversationEndpoint> ConversationEndpoints { get; set; }
        public virtual DbSet<Schema> Schemas { get; set; }
        public virtual DbSet<Service> Services { get; set; }
        public virtual DbSet<ServiceContract> ServiceContracts { get; set; }
        public virtual DbSet<ServiceMessageType> ServiceMessageTypes { get; set; }
        public virtual DbSet<ServiceQueue> ServiceQueues { get; set; }
        public virtual DbSet<XmlSchemaCollection> XmlSchemaCollections { get; set; }

        [DbFunction("CONTEXT_INFO", "")]
        public static byte[] ContextInfo()
        {
            throw new NotImplementedException();
        }

        [DbFunction("XML_SCHEMA_NAMESPACE", "")]
        public static string XmlSchemaNamespace(string schema, string collection)
        {
            throw new NotImplementedException();
        }
        [DbFunction("XML_SCHEMA_NAMESPACE", "")]
        public static string XmlSchemaNamespace(string schema, string collection, string @namespace)
        {
            throw new NotImplementedException();
        }

        [DbFunction("SESSION_CONTEXT", "")]
        public static byte[] SessionContextBinary(string key)
        {
            throw new NotImplementedException();
        }

        [DbFunction("SESSION_CONTEXT", "")]
        public static int SessionContextInteger(string key)
        {
            throw new NotImplementedException();
        }

        [DbFunction("SESSION_CONTEXT", "")]
        public static string SessionContextString(string key)
        {
            throw new NotImplementedException();
        }

        [DbFunction("SESSION_CONTEXT", "")]
        public static long SessionContextLong(string key)
        {
            throw new NotImplementedException();
        }

        [DbFunction("SESSION_CONTEXT", "")]
        public static decimal SessionContextDecimal(string key)
        {
            throw new NotImplementedException();
        }

        [DbFunction("SESSION_CONTEXT", "")]
        public static float SessionContextSingle(string key)
        {
            throw new NotImplementedException();
        }

        [DbFunction("SESSION_CONTEXT", "")]
        public static double SessionContextDouble(string key)
        {
            throw new NotImplementedException();
        }

        [DbFunction("SESSION_CONTEXT", "")]
        public static bool SessionContextBit(string key)
        {
            throw new NotImplementedException();
        }



        //public IQueryable<QueueItem> QueryQueue(string queueName, string schemaName = "dbo")
        //{
        //    if (string.IsNullOrWhiteSpace(queueName)) throw new ArgumentNullException(nameof(queueName));
        //    if (queueName.Contains("[") || queueName.Contains("]")) throw new ArgumentOutOfRangeException(nameof(queueName));
        //    if (string.IsNullOrWhiteSpace(schemaName)) throw new ArgumentNullException(nameof(schemaName));
        //    if (schemaName.Contains("[") || schemaName.Contains("]")) throw new ArgumentOutOfRangeException(nameof(schemaName));
        //    string query = $"SELECT * FROM [{schemaName}].[{queueName}]";
        //    return this.Set<QueueItem>().FromSql(query);
        //}

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. See http://go.microsoft.com/fwlink/?LinkId=723263 for guidance on storing connection strings.
                optionsBuilder.UseSqlServer(ConnectionString ?? "Server=.;Database=master;Trusted_Connection=True;");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            var sysBuilder = modelBuilder.HasDefaultSchema("sys");
            {
                var entity = sysBuilder.Entity<Schema>().ToTable("schemas", "sys");
                entity.HasKey(e => e.Id);
                entity.Property(e => e.Id).HasColumnName("schema_id");
                entity.Property(e => e.Name).HasColumnName("name");
                entity.Property(e => e.PrincipalId).HasColumnName("principal_id");
            }
            {
                var entity = sysBuilder.Entity<ServiceQueue>().ToTable("service_queues", "sys");
                entity.HasKey(e => e.Id);
                entity.Property(e => e.Id).HasColumnName("object_id");
                entity.Property(e => e.Name).HasColumnName("name");
                entity.Property(e => e.PrincipalId).HasColumnName("principal_id");
                //entity.Property(e => (int)e.ParentId).HasColumnName("parent_object_id");
                entity.Property(e => e.SchemaId).HasColumnName("schema_id");
                entity.Property(e => e.IsMicrosoftShipped).HasColumnName("is_ms_shipped");
                entity.Property(e => e.IsEnabled).HasColumnName("is_enqueue_enabled");
                entity.Property(e => e.IsActivationEnabled).HasColumnName("is_activation_enabled");
                entity.Property(e => e.ActivationProcedure).HasColumnName("activation_procedure");
                entity.Property(e => e.ExecuteAsPrincipalId).HasColumnName("execute_as_principal_id");
                entity.Property(e => e.MaxReaders).HasColumnName("max_readers");
                entity.Property(e => e.IsPoisonMessageHandlingEnabled).HasColumnName("is_poison_message_handling_enabled");
                //entity.Property(e => (bool)e.IsPublished).HasColumnName("is_published");
                //entity.Property(e => (bool)e.IsSchemaPublished).HasColumnName("is_schema_published");
                entity.Property(e => e.IsReceiveEnabled).HasColumnName("is_receive_enabled");
                entity.Property(e => e.IsRetentionEnabled).HasColumnName("is_retention_enabled");
                entity.HasOne(e => e.Schema).WithMany(e => e.ServiceQueues).HasForeignKey(e => e.SchemaId);
                /*
                  ,[parent_object_id]
              */
            }
            {
                var entity = sysBuilder.Entity<Service>().ToTable("services", "sys");
                entity.HasKey(e => e.Id);
                entity.Property(e => e.Id).HasColumnName("service_id");
                entity.Property(e => e.Name).HasColumnName("name");
                entity.Property(e => e.PrincipalId).HasColumnName("principal_id");
                entity.Property(e => e.ServiceQueueId).HasColumnName("service_queue_id");
                entity.HasOne<ServiceQueue>(e => e.ServiceQueue).WithMany(e => e.Services).HasForeignKey(e => e.ServiceQueueId);
                entity.HasMany(e => e.ConversationEndpoints).WithOne(e => e.Service).HasForeignKey(e => e.ServiceId);
            }
            {
                var entity = sysBuilder.Entity<ServiceContract>().ToTable("service_contracts", "sys");
                entity.HasKey(e => e.Id);
                entity.Property(e => e.Id).HasColumnName("service_contract_id");
                entity.Property(e => e.Name).HasColumnName("name");
                entity.Property(e => e.PrincipalId).HasColumnName("principal_id");
                entity.HasMany(e => e.ConversationEndpoints).WithOne(e => e.ServiceContract).HasForeignKey(e => e.ServiceContractId);
            }
            {
                var entity = sysBuilder.Entity<ServiceToServiceContract>().ToTable("service_contract_usages", "sys");
                entity.HasKey(e => new { e.ServiceId, e.ServiceContractId });
                entity.Property(e => e.ServiceId).HasColumnName("service_id");
                entity.Property(e => e.ServiceContractId).HasColumnName("service_contract_id");
                entity.HasOne(e => e.Service).WithMany(e => e.ServiceContracts).HasForeignKey(e => e.ServiceId);
                entity.HasOne(e => e.ServiceContract).WithMany(e => e.Services).HasForeignKey(e => e.ServiceContractId);
            }
            {
                var entity = sysBuilder.Entity<ServiceMessageType>().ToTable("service_message_types", "sys");
                entity.HasKey(e => e.Id);
                entity.Property(e => e.Id).HasColumnName("message_type_id");
                entity.Property(e => e.Name).HasColumnName("name");
                entity.Property(e => e.PrincipalId).HasColumnName("principal_id");
                entity.Property(e => e.XmlCollectionId).HasColumnName("xml_collection_id");
                entity.Property(e => e.ValidationDescription).HasColumnName("validation_desc");
                entity.HasOne(e => e.XmlSchemaCollection).WithMany(e => e.ServiceMessageTypes).HasForeignKey(e => e.XmlCollectionId);
            }
            {
                var entity = sysBuilder.Entity<ServiceContractToServiceMessageType>().ToTable("service_contract_message_usages", "sys");
                entity.HasKey(e => new { e.ServiceContractId, e.MessageTypeId });
                entity.Property(e => e.ServiceContractId).HasColumnName("service_contract_id");
                entity.Property(e => e.MessageTypeId).HasColumnName("message_type_id");
                entity.Property(e => e.IsSentByInitiator).HasColumnName("is_sent_by_initiator");
                entity.Property(e => e.IsSentByTarget).HasColumnName("is_sent_by_target");
                entity.HasOne(e => e.ServiceContract).WithMany(e => e.MessageTypes).HasForeignKey(e => e.ServiceContractId);
                entity.HasOne(e => e.ServiceMessageType).WithMany(e => e.ServiceContracts).HasForeignKey(e => e.MessageTypeId);
            }
            {
                var entity = sysBuilder.Entity<XmlSchemaCollection>().ToTable("xml_schema_collections", "sys");
                entity.HasKey(e => e.Id);
                entity.Property(e => e.Id).HasColumnName("xml_collection_id");
                entity.Property(e => e.Name).HasColumnName("name");
                entity.Property(e => e.PrincipalId).HasColumnName("principal_id");
                entity.Property(e => e.SchemaId).HasColumnName("schema_id");
                entity.HasOne(e => e.Schema).WithMany(e => e.XmlSchemaCollections).HasForeignKey(e => e.SchemaId);
            }
            {
                var entity = sysBuilder.Entity<ConversationEndpoint>().ToTable("conversation_endpoints", "sys");
                entity.HasKey(e => e.Handle);
                entity.Property(e => e.Handle).HasColumnName("conversation_handle");
                entity.Property(e => e.ConversationId).HasColumnName("conversation_id");
                entity.Property(e => e.ConversationGroupId).HasColumnName("conversation_group_id");
                entity.Property(e => e.IsInitiator).HasColumnName("is_initiator");
                entity.Property(e => e.IsSystem).HasColumnName("is_system");
                entity.Property(e => e.ServiceContractId).HasColumnName("service_contract_id");
                entity.Property(e => e.ServiceId).HasColumnName("service_id");
                entity.Property(e => e.PrincipalId).HasColumnName("principal_id");
                entity.Property(e => e.FarService).HasColumnName("far_service");
                entity.Property(e => e.FarBrokerInstance).HasColumnName("far_broker_instance");
                /*
      ,[lifetime]
      ,[far_principal_id]
      ,[outbound_session_key_identifier]
      ,[inbound_session_key_identifier]
      ,[security_timestamp]
      ,[dialog_timer]
      ,[send_sequence]
      ,[last_send_tran_id]
      ,[end_dialog_sequence]
      ,[receive_sequence]
      ,[receive_sequence_frag]
      ,[system_sequence]
      ,[first_out_of_order_sequence]
      ,[last_out_of_order_sequence]
      ,[last_out_of_order_frag]
      ,[priority]*/
            }
            {
                var entity = sysBuilder.Entity<ConversationGroup>().ToTable("conversation_groups", "sys");
                entity.HasKey(e => e.Id);
                entity.Property(e => e.Id).HasColumnName("conversation_group_id");
                entity.Property(e => e.ServiceId).HasColumnName("service_id");
                entity.Property(e => e.IsSystem).HasColumnName("is_system");
                entity.HasMany(e => e.ConversationEndpoints).WithOne(e => e.ConversationGroup).HasForeignKey(e => e.ConversationGroupId);
                entity.HasOne(e => e.Service).WithMany(e => e.ConversationGroups).HasForeignKey(e => e.ServiceId);
            }
            {
                var entity = sysBuilder.Entity<TransmissionQueue>().ToTable("transmission_queue", "sys");
                entity.HasKey(e => e.Id);
                entity.Property(e => e.Id).HasColumnName("conversation_handle");
                //entity.Property(e => e.ServiceId).HasColumnName("service_id");
                //entity.Property(e => e.IsSystem).HasColumnName("is_system");
                //entity.HasMany(e => e.ConversationEndpoints).WithOne(e => e.ConversationGroup).HasForeignKey(e => e.ConversationGroupId);
                //entity.HasOne(e => e.Service).WithMany(e => e.ConversationGroups).HasForeignKey(e => e.ServiceId);
            }

            /*
            select 
	            conversation_handle	
	            ,to_service_name	
	            ,to_broker_instance	
	            ,from_service_name	
	            ,service_contract_name	
	            ,enqueue_time	
	            ,message_sequence_number	
	            ,message_type_name	
	            ,is_conversation_error	
	            ,is_end_of_dialog	
	            ,message_body	
	            ,transmission_status	
	            ,priority
            from [sys].[transmission_queue]
            */

            /*
            sys.dm_exec_requests
            sys.dm_exec_sessions
            sys.sysprocesses
            */
        }
    }
}
