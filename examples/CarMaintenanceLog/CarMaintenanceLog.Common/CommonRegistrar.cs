using CarMaintenanceLog.Abstractions;
using CarMaintenanceLog.Common.Converters;
using Microsoft.Extensions.DependencyInjection;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;

namespace CarMaintenanceLog.Common
{
    public class CommonRegistrar : IRegistrar
    {
        public IServiceCollection AddServices(IServiceCollection services)
        {
            services.AddScoped<IObjectSerializer, JsonObjectSerializer>();
            services.AddScoped(svc =>
            new JsonConverter[]
            {
                new JsonEnumValueConverter(),
                new StringEnumConverter(),
            });
            return services;
        }
    }
}
