using System;

namespace CarMaintenanceLog.Messaging
{
    public class ServiceHubResolver : IServiceHubResolver
    {
        //TODO: resolve the attributes
        public string GetConnectionString()
        {
            return "CarMaintenanceLogServiceHub";
        }

        public string GetEntityPath()
        {
            return "messagecentral";
        }
    }
}