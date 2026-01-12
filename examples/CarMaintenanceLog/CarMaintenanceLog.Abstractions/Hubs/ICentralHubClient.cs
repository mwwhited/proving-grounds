using System;
using System.Threading.Tasks;

namespace CarMaintenanceLog.Abstractions.Hubs
{
    public interface ICentralHubClient
    {
        Func<string, Task> OnReceived { get; set; }
        Task SendMessageAsync(string message);
    }
}
