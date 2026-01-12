using CarMaintenanceLog.Abstractions;
using CarMaintenanceLog.Abstractions.Eventing;
using Microsoft.Azure.EventHubs;
using Microsoft.Extensions.Logging;
using Microsoft.Net.Http.Headers;
using System;
using System.Runtime.CompilerServices;
using System.Threading.Tasks;

namespace CarMaintenanceLog.Eventing
{
    internal class EventHubSendEvents : ISendEvents
    {
        private readonly IObjectSerializer _serializer;
        private readonly ILogger<EventHubSendEvents> _log;
        private readonly IEventProvider _provider;

        public EventHubSendEvents(
            IObjectSerializer serializer,
            ILogger<EventHubSendEvents> log,
            IEventProvider provider
            )
        {
            _serializer = serializer;
            _log = log;
            _provider = provider;
        }

        public async Task SendAsync<TEvent>(
            TEvent evnt,
            [CallerMemberName] string caller = null,
            [CallerLineNumber] int lineNumber = 0,
            [CallerFilePath] string callerPath = null
            )
        {
            //TODO: restore this

            //var (contentType, data) = await _serializer.SerializeAsync(evnt);
            //var client = _provider.GetClient<TEvent>();
            //var partitionKey = _provider.GetPartition<TEvent>();
            //var eventData = new EventData(data);
            //eventData.Properties.Add(HeaderNames.ContentType, contentType);
            //eventData.Properties.Add(HeaderNames.ContentLength, data.Length);
            //eventData.Properties.Add("X-CallerMemberName", caller);
            //eventData.Properties.Add("X-CallerLineNumber", lineNumber);
            //eventData.Properties.Add("X-CallerFilePath", callerPath);
            //eventData.Properties.Add("X-UserName", Environment.UserName);
            //if (string.IsNullOrWhiteSpace(partitionKey))
            //{
            //    await client.SendAsync(eventData);
            //}
            //else
            //{
            //    await client.SendAsync(eventData, partitionKey);
            //}
            _log.LogDebug($"Sent event for {caller}:{lineNumber}");
            await Task.FromResult(0);
        }
    }
}