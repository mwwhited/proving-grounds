using CarMaintenanceLog.Abstractions;
using CarMaintenanceLog.Abstractions.Eventing;
using CarMaintenanceLog.Abstractions.Messaging;
using Microsoft.Azure.ServiceBus;
using System;
using System.Threading.Tasks;

namespace CarMaintenanceLog.Messaging
{
    internal class ServiceHubSendMessages : ISendMessages
    {
        private readonly ISendEvents _events;
        private readonly IObjectSerializer _serializer;
        private readonly IQueueProvider _provider;

        public ServiceHubSendMessages(
            ISendEvents @events,
            IObjectSerializer serializer,
            IQueueProvider provider
            )
        {
            _events = @events;
            _serializer = serializer;
            _provider = provider;
        }

        public async Task<string> SendAsync<TMessage>(TMessage message)
        {
            var messageId = Guid.NewGuid().ToString();
            try
            {
                await _events.SendAsync(new { Message = "Sending Message", Id = messageId, Type = typeof(TMessage) });

                var payload = await _serializer.SerializeAsync(message);
                var queue = _provider.GetQueue<TMessage>();
                await queue.SendAsync(new Message(payload.data)
                {
                    CorrelationId = messageId,
                    ContentType = payload.contentType,
                });

                await _events.SendAsync(new { Message = "Sent Message", Id = messageId, Type = typeof(TMessage) });

                return messageId;
            }
            catch (Exception ex)
            {
                await _events.SendAsync(new { Message = "Error Message", Id = messageId, Type = typeof(TMessage), Error = ex.Message, });
                throw;
            }
        }
    }
}