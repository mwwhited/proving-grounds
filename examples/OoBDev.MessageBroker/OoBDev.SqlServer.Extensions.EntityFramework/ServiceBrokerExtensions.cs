using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore.Query.Expressions;
using Microsoft.EntityFrameworkCore.Query.Internal;
using Microsoft.EntityFrameworkCore.Query.Sql;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics.Contracts;
using System.Linq;
using System.Linq.Expressions;
using System.Reflection;
using System.Xml.Linq;

namespace OoBDev.SqlServer.Extensions.EntityFramework
{
    public static class ServiceBrokerExtensions
    {
        // https://www.shadesofazure.com/sql-generation-ef-core/ 
        internal static readonly MethodInfo ReceiveMethodInfo
          = typeof(ServiceBrokerExtensions).GetTypeInfo().GetDeclaredMethod(nameof(Receive));

        internal static readonly MethodInfo GetConversationGroupMethodInfo
          = typeof(ServiceBrokerExtensions).GetTypeInfo().GetDeclaredMethod(nameof(GetConversationGroupId));

        internal static readonly MethodInfo EnableQueueMethodInfo
          = typeof(ServiceBrokerExtensions).GetTypeInfo().GetDeclaredMethod(nameof(EnableQueueInternal));

        public static IQueryable<TEntity> Receive<TEntity>(this IQueryable<TEntity> source) where TEntity : class
        {
            return source.Provider is EntityQueryProvider
                ? source.Provider.CreateQuery<TEntity>(
                    Expression.Call(
                        instance: null,
                        method: ReceiveMethodInfo.MakeGenericMethod(typeof(TEntity)),
                        arguments: source.Expression))
                : source;
        }

        private static IQueryable<Guid?> GetConversationGroupId(this IQueryable<Guid?> source)
        {
            return source.Provider is EntityQueryProvider
                    ? source.Provider.CreateQuery<Guid?>(
                      Expression.Call(
                        instance: null,
                        method: GetConversationGroupMethodInfo,
                        arguments: source.Expression))
                    : null;
        }
        public static Guid GetConversationGroup<TQueue>(this IQueryable<TQueue> source) where TQueue : QueueItem
        {
            var subQuery = source.Select(i => (Guid?)i.ConversationGroupId);
            var ids = subQuery.GetConversationGroupId();
            var id = ids?.FirstOrDefault();
            return id ?? Guid.Empty;
        }

        private static IQueryable<TQueue> EnableQueueInternal<TQueue>(this IQueryable<TQueue> source) where TQueue : QueueItem
        {
            return source.Provider is EntityQueryProvider
                    ? source.Provider.CreateQuery<TQueue>(
                      Expression.Call(
                        instance: null,
                        method: EnableQueueMethodInfo.MakeGenericMethod(typeof(TQueue)),
                        arguments: source.Expression))
                    : null;
        }
        public static void EnableQueue<TQueue>(this IQueryable<TQueue> source) where TQueue : QueueItem
        {
            source.EnableQueueInternal().FirstOrDefault();
        }

        public static Guid BeginDialogConversation(this DbContext dbContext, IService from, string to, IServiceContract on = null, bool encrypted = false)
        {
            Contract.Requires(dbContext != null);
            Contract.Requires(from != null);
            Contract.Requires(!string.IsNullOrEmpty(from.Name));
            Contract.Requires(!string.IsNullOrWhiteSpace(from.Name));
            Contract.Requires(!from.Name.Contains("["));
            Contract.Requires(!from.Name.Contains("]"));
            Contract.Requires(!string.IsNullOrEmpty(to));
            Contract.Requires(!string.IsNullOrWhiteSpace(to));
            Contract.Requires(!to.Contains("["));
            Contract.Requires(!to.Contains("]"));
            Contract.Requires(on == null || !string.IsNullOrEmpty(on.Name));
            Contract.Requires(on == null || !string.IsNullOrWhiteSpace(on.Name));
            Contract.Requires(on == null || !on.Name.Contains("["));
            Contract.Requires(on == null || !on.Name.Contains("]"));

            var cmd = $"BEGIN DIALOG CONVERSATION @ch " +
                      $"   FROM SERVICE [{from.Name}]" +
                      $"   TO SERVICE '{to.Replace("'", "''")}' " +
                      (on == null ? "" : $"   ON CONTRACT [{on?.Name}] ") +
                      $"   WITH ENCRYPTION = {(encrypted ? "ON" : "OFF")}; ";

            var handle = new SqlParameter("ch", SqlDbType.UniqueIdentifier)
            {
                Direction = ParameterDirection.Output,
            };
            dbContext.Database.ExecuteSqlCommand(new RawSqlString(cmd), handle);
            var handleId = (Guid)handle.Value;
            return handleId;
        }
        public static Guid BeginDialogConversation(this DbContext dbContext, IService from, IService to, IServiceContract on = null, bool encrypted = false)
        {
            Contract.Requires(dbContext != null);
            Contract.Requires(from != null);
            Contract.Requires(!string.IsNullOrEmpty(from.Name));
            Contract.Requires(!string.IsNullOrWhiteSpace(from.Name));
            Contract.Requires(!from.Name.Contains("["));
            Contract.Requires(!from.Name.Contains("]"));
            Contract.Requires(to != null);
            Contract.Requires(!string.IsNullOrEmpty(to.Name));
            Contract.Requires(!string.IsNullOrWhiteSpace(to.Name));
            Contract.Requires(!to.Name.Contains("["));
            Contract.Requires(!to.Name.Contains("]"));
            Contract.Requires(on == null || !string.IsNullOrEmpty(on.Name));
            Contract.Requires(on == null || !string.IsNullOrWhiteSpace(on.Name));
            Contract.Requires(on == null || !on.Name.Contains("["));
            Contract.Requires(on == null || !on.Name.Contains("]"));
            return dbContext.BeginDialogConversation(from, to.Name, on, encrypted);
        }

        public static void SendOnConversation(this DbContext dbContext, Guid conversationHandle, IMessageType messageType, byte[] message)
        {
            dbContext.SendOnConversationInternal(conversationHandle, messageType, message);
        }
        public static void SendOnConversation(this DbContext dbContext, Guid conversationHandle, IMessageType messageType, XElement message)
        {
            dbContext.SendOnConversationInternal(conversationHandle, messageType, message.ToString());
        }
        public static void SendOnConversation(this DbContext dbContext, Guid conversationHandle, IMessageType messageType, string message)
        {
            dbContext.SendOnConversationInternal(conversationHandle, messageType, message);
        }
        public static void SendOnConversation(this DbContext dbContext, Guid conversationHandle, IMessageType messageType)
        {
            dbContext.SendOnConversationInternal(conversationHandle, messageType, null);
        }
        internal static void SendOnConversationInternal(this DbContext dbContext, Guid conversationHandle, IMessageType messageType, object message)
        {
            var cmd = $"SEND ON CONVERSATION @ch " +
                      $"    MESSAGE TYPE [{messageType.Name}] " +
                      (message == null ? "" : "(@msg)") +
                      ";";

            var parameters = new[]
            {
                new SqlParameter("ch", conversationHandle),
                (message == null ? null : new SqlParameter("msg", message)),
            }.Where(p => p != null);

            dbContext.Database.ExecuteSqlCommand(new RawSqlString(cmd), parameters);
        }
       
        //TODO: WaitFor Receive
        //TODO: WaitFor GetConversationGroup 
        //TODO: EndConversation
        //TODO: SendOnConversation
        //TODO: BeginDialogConversaion (from service reference, to service name)

        //TODO: CreateQueue
        //TODO: CreateMesageType https://docs.microsoft.com/en-us/sql/t-sql/statements/create-message-type-transact-sql?view=sql-server-2017
        //TODO: CreateContract (uses message type)
        //TODO: CreateService (uses queues, contracts)

        //TODO: MoveConversation

        //public static Guid? WaitForConversationGroup()
        //{
        //    //thr n
        //}

        //public static IQueryable<TEntity> WaitFor<TEntity>(this IQueryable<TEntity> source) where TEntity : class
        //{
        //    return
        //      source.Provider is EntityQueryProvider
        //        ? source.Provider.CreateQuery<TEntity>(
        //          Expression.Call(
        //            instance: null,
        //            method: ReceiveMethodInfo.MakeGenericMethod(typeof(TEntity)),
        //            arguments: source.Expression))
        //        : source;
        //}

        //public static void MoveConversation(this DbContext context, Guid conversationHandle, Guid conversationGroupId)
        //{
        //    var exe = context.Database.CreateExecutionStrategy();
        //   // exe.Execute()
        //    //context.Database.ExecuteSqlCommand($"MOVE CONVERSATION {conversationHandle} TO {conversationGroupId};");
        //}

        public static EntityTypeBuilder<TQueueType> MapQueue<TQueueType>(this ModelBuilder modelBuilder, string queueName, string schemaName = "dbo")
            where TQueueType : QueueItem
        {
            var entity = modelBuilder.Entity<TQueueType>().ToTable(queueName, schemaName);
            entity.HasKey(e => new { e.ConversationGroupId, e.ConversationHandle, e.MessageSequenceNumber });
            entity.Property(e => e.Status).HasColumnName("status");
            entity.Property(e => e.Priority).HasColumnName("priority");
            entity.Property(e => e.QueuingOrder).HasColumnName("queuing_order");
            entity.Property(e => e.ConversationGroupId).HasColumnName("conversation_group_id");
            entity.Property(e => e.ConversationHandle).HasColumnName("conversation_handle");
            entity.Property(e => e.MessageSequenceNumber).HasColumnName("message_sequence_number");
            entity.Property(e => e.ServiceName).HasColumnName("service_name");
            entity.Property(e => e.ServiceId).HasColumnName("service_id");
            entity.Property(e => e.ServiceContractName).HasColumnName("service_contract_name");
            entity.Property(e => e.ServiceContractId).HasColumnName("service_contract_id");
            entity.Property(e => e.MessageTypeName).HasColumnName("message_type_name");
            entity.Property(e => e.MessageTypeId).HasColumnName("message_type_id");
            entity.Property(e => e.Validation).HasColumnName("validation");
            entity.Property(e => e.MessageBody).HasColumnName("message_body");
            entity.Property(e => e.MessageEnqueueTime).HasColumnName("message_enqueue_time");
            entity.HasOne(e => e.ConversationGroup).WithMany().HasForeignKey(e => e.ConversationGroupId);
            entity.HasOne(e => e.ConversationEndpoint).WithMany().HasForeignKey(e => e.ConversationHandle);
            entity.HasOne(e => e.Service).WithMany().HasForeignKey(e => e.ServiceId);
            entity.HasOne(e => e.ServiceContract).WithMany().HasForeignKey(e => e.ServiceContractId);
            entity.HasOne(e => e.MessageType).WithMany().HasForeignKey(e => e.MessageTypeId);
            return entity;
        }

        public static IMessageType MapMessageType(this ModelBuilder modelBuilder, string messageTypeName, MessageValidationType validationType = MessageValidationType.None)
        {
            return new MessageType
            {
                Name = messageTypeName,
                ValidationType = validationType,
            };
        }

        public static IServiceContract MapServiceContract(this ModelBuilder modelBuilder, string contractName,
            params (IMessageType MessageType, SentBy SendType)[] messageTypes)
        {
            return new SsbContract
            {
                Name = contractName,
                MessageTypes = messageTypes,
            };
            /*
                CREATE CONTRACT contract_name  
                   [ AUTHORIZATION owner_name ]  
                      (  {   { message_type_name | [ DEFAULT ] }  
                          SENT BY { INITIATOR | TARGET | ANY }   
                       } [ ,...n] )  
            */
        }

        public static IService MapService<TQueueItem>(this ModelBuilder modelBuilder, string serviceName, DbSet<TQueueItem> queue, params IServiceContract[] contracts)
            where TQueueItem : QueueItem
        {
            return new SsbService
            {
                Name = serviceName,
                //Queue = queue, //TODO: make a reference
                Contracts = contracts,
            };
            /*
                CREATE SERVICE service_name  
                   [ AUTHORIZATION owner_name ]  
                   ON QUEUE [ schema_name. ]queue_name  
                   [ ( contract_name | [DEFAULT][ ,...n ] ) ] 
            */
        }

        public static DbContextOptionsBuilder AddServiceBroker(this DbContextOptionsBuilder optionsBuilder)
        {
            //TODO: is it possible to wrap this around the exisiting providers?
            return optionsBuilder.ReplaceService<INodeTypeProviderFactory, ServiceBrokerMethodInfoBasedNodeTypeRegistryFactory>()
                                 .ReplaceService<ISelectExpressionFactory, ServiceBrokerSelectExpressionFactory>()
                                 .ReplaceService<IQuerySqlGeneratorFactory, ServiceBrokerSqlServerQuerySqlGeneratorFactory>()
                                 ;
        }
    }
}
