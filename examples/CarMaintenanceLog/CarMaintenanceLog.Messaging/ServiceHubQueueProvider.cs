using Microsoft.Azure.ServiceBus;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections;
using System.Collections.Generic;

namespace CarMaintenanceLog.Messaging
{
    internal class ServiceHubQueueProvider : IQueueProvider
    {
        private readonly IDictionary<Type, QueueClient> _clients = new Dictionary<Type, QueueClient>();
        private readonly IServiceHubResolver _resolver;
        private readonly IConfiguration _config;

        public ServiceHubQueueProvider(
            IServiceHubResolver resolver,
            IConfiguration config
            )
        {
            _resolver = resolver;
            _config = config;
        }

        public QueueClient GetQueue<TMessage>()
        {
            if (_clients.TryGetValue(typeof(TMessage), out var client))
            {
                return client;
            }

            client = new QueueClient(
                connectionString: _config[_resolver.GetConnectionString()],
                entityPath: _resolver.GetEntityPath()
                );

            return _clients.TryAdd(typeof(TMessage), client) ? client : _clients[typeof(TMessage)];
        }
    }
}