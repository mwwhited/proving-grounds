namespace CarMaintenanceLog.Messaging
{
    public interface IServiceHubResolver
    {
        string GetConnectionString();
        string GetEntityPath();
    }
}