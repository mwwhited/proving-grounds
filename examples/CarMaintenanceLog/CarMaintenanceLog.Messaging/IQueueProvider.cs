using Microsoft.Azure.ServiceBus;

namespace CarMaintenanceLog.Messaging
{
    public interface IQueueProvider
    {
        QueueClient GetQueue<TMessage>();
    }
}