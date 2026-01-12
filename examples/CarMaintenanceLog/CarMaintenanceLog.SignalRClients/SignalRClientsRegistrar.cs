using CarMaintenanceLog.Abstractions;
using CarMaintenanceLog.Abstractions.Hubs;
using Microsoft.AspNetCore.SignalR.Client;
using Microsoft.Extensions.DependencyInjection;

namespace CarMaintenanceLog.SignalRClients
{
    public class SignalRClientsRegistrar : IRegistrar
    {
        public IServiceCollection AddServices(IServiceCollection services)
        {
            return services
                .AddTransient<HubConnectionBuilder>()
                .AddTransient<ICentralHubClient, CentralHubClient>()
                .AddTransient<ICentralHubClientBuilder, CentralHubClientBuilder>()
               ;
        }
    }
}
