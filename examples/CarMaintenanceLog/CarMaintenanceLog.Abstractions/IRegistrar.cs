using Microsoft.Extensions.DependencyInjection;

namespace CarMaintenanceLog.Abstractions
{
    public interface IRegistrar
    {
        IServiceCollection AddServices(IServiceCollection services);
    }
}
