using CarMaintenanceLog.Abstractions;
using CarMaintenanceLog.Abstractions.Eventing;
using Microsoft.Extensions.DependencyInjection;

namespace CarMaintenanceLog.Eventing
{
    public class EventingRegistrar : IRegistrar
    {
        public IServiceCollection AddServices(IServiceCollection services)
        {
            services.AddScoped<ISendEvents, EventHubSendEvents>();
            services.AddScoped<IEventProvider, EventHubProvider>();
            return services;
        }
    }
}
