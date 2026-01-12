using Microsoft.Azure.WebJobs;
using Microsoft.Extensions.Logging;

namespace CarMaintenanceLog.Azure.Functions
{
    public static class OnMessageReceived
    {
        [FunctionName("OnMessageReceived")]
        public static void Run([ServiceBusTrigger("MessageCentral", Connection = "CarMaintenanceLogServiceHub")]string myQueueItem, ILogger log)
        {
            log.LogInformation($"C# ServiceBus queue trigger function processed message: {myQueueItem}");
        }
    }
}
