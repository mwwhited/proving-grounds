using Microsoft.EntityFrameworkCore;
using OoBDev.SqlServer.Extensions.EntityFramework;
using OoBDev.SqlServer.Sys;
using System.Collections.Generic;

namespace OoBDev.MessageBroker.Cli
{
    public class PlaygroundContext : SystemContext
    {
        public PlaygroundContext(DbContext wrappedContext) : base(wrappedContext)
        {
        }
        public PlaygroundContext(IDictionary<string, object> keys, bool useOdbcRules = false) : base(keys, useOdbcRules)
        {
        }
        public PlaygroundContext(params (string name, object value)[] keys) : base(keys)
        {
        }
        public PlaygroundContext(bool useOdbcRules, params (string name, object value)[] keys) : base(useOdbcRules, keys)
        {
        }
        public PlaygroundContext(string connectionString = null) : base(connectionString)
        {
        }
        public PlaygroundContext(DbContextOptions<SystemContext> options) : base(options)
        {
        }

        public virtual DbSet<ProcessMessageQueueItem> ProcessMessageQueue { get; private set; }
        public virtual DbSet<ProcessResponseQueueItem> ProcessResponseQueue { get; private set; }
        public IMessageType ResponseMessageType { get; private set; }
        public IMessageType RequestMessageType { get; private set; }
        public IServiceContract ProcessMessageContract { get; private set; }
        public IServiceContract ProcessResponseContract { get; private set; }
        public IService ProcessMessageService { get; private set; }
        public IService ProcessResponseService { get; private set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.MapQueue<ProcessMessageQueueItem>("ProcessMessageQueue");
            modelBuilder.MapQueue<ProcessResponseQueueItem>("ProcessResponseQueue");

            this.ResponseMessageType = modelBuilder.MapMessageType("oobdev://ProcessMessage/Response");
            this.RequestMessageType = modelBuilder.MapMessageType("oobdev://ProcessMessage/Request");

            this.ProcessMessageContract = modelBuilder.MapServiceContract("oobdev://ProcessMessage/Contract",
                (this.RequestMessageType, SentBy.Initiator),
                (this.ResponseMessageType, SentBy.Target)
                );
            this.ProcessResponseContract = modelBuilder.MapServiceContract("oobdev://ProcessMessage/Contract",
                (this.RequestMessageType, SentBy.Target),
                (this.ResponseMessageType, SentBy.Initiator)
                );

            this.ProcessMessageService = modelBuilder.MapService("ProcessMessageService", this.ProcessMessageQueue, this.ProcessMessageContract);
            this.ProcessResponseService = modelBuilder.MapService("ProcessResponseService", this.ProcessResponseQueue, this.ProcessMessageContract);


            //        ProcessMessageService
            //ProcessResponseService

            base.OnModelCreating(modelBuilder);
        }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            base.OnConfiguring(optionsBuilder);
            optionsBuilder.AddServiceBroker();

            // optionsBuilder.UseLoggerFactory(new ConsoleLoggerFactory(new ConsoleLogger()));
        }
    }
}
