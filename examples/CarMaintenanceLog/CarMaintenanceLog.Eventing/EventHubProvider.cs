using Microsoft.Azure.EventHubs;
using System;

namespace CarMaintenanceLog.Eventing
{
    public class EventHubProvider : IEventProvider
    {
        //TODO: this needs mapped
        public EventHubClient GetClient<TEvent>()
        {
            return null;
        }

        public string GetPartition<TEvent>()
        {
            return null;
        }
    }
}