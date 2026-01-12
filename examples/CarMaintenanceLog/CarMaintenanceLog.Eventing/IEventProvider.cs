using Microsoft.Azure.EventHubs;

namespace CarMaintenanceLog.Eventing
{
    public interface IEventProvider
    {
        string GetPartition<TEvent>();
        EventHubClient GetClient<TEvent>();
    }
}