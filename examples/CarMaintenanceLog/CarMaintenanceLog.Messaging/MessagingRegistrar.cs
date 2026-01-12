using CarMaintenanceLog.Abstractions;
using CarMaintenanceLog.Abstractions.Messaging;
using Microsoft.Extensions.DependencyInjection;

namespace CarMaintenanceLog.Messaging
{
    public class MessagingRegistrar : IRegistrar
    {
        public IServiceCollection AddServices(IServiceCollection services)
        {
            return services
                .AddScoped<ISendMessages, ServiceHubSendMessages>()
                .AddScoped<IQueueProvider, ServiceHubQueueProvider>()
                .AddScoped<IServiceHubResolver, ServiceHubResolver>()
                ;
        }
    }
}
