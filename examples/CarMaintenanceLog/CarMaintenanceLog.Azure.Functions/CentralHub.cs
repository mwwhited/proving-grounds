using Microsoft.AspNetCore.Http;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.Azure.WebJobs.Extensions.SignalRService;
using Microsoft.Extensions.Logging;
using System.Threading.Tasks;

namespace CarMaintenanceLog.Azure.Functions
{
    public class CentralHub
    {
        private readonly ILogger<CentralHub> _log;
        public CentralHub(
            ILogger<CentralHub> log
            )
        {
            _log = log;
        }

        // https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-signalr-service?tabs=csharp
        // https://github.com/Azure/azure-functions-signalrservice-extension

        [FunctionName("negotiate")]
        public SignalRConnectionInfo Negotiate(
            [HttpTrigger(AuthorizationLevel.Anonymous)]HttpRequest req,
            [SignalRConnectionInfo(
                HubName = "CentralHub",
                ConnectionStringSetting = "CarMaintenanceLogCentralHub"
            )]SignalRConnectionInfo connectionInfo)
        {
            _log.LogInformation($"Connected: {connectionInfo.AccessToken} @ {connectionInfo.Url}");
            return connectionInfo;
        }

        [FunctionName("SendMessage")]
        public static Task SendMessage(
            [HttpTrigger(AuthorizationLevel.Anonymous, "post")]object message,
            [SignalR(
                HubName = "CentralHub",
                ConnectionStringSetting = "CarMaintenanceLogCentralHub"
            )]IAsyncCollector<SignalRMessage> signalRMessages
            )
        {
            return signalRMessages.AddAsync(
                new SignalRMessage
                {
                    Target = "Received",
                    Arguments = new[] { $"Response:>{message}" },
                });
        }
    }
}

//Func<string, Task> OnReceived { get; set; }
//Task SendMessageAsync(string message);