using CarMaintenanceLog.Abstractions.Hubs;
using Microsoft.AspNetCore.SignalR.Client;
using System.Threading.Tasks;

namespace CarMaintenanceLog.SignalRClients
{
    public interface ICentralHubClientBuilder
    {
        Task<HubConnection> Build(ICentralHubClient client);
    }
}
