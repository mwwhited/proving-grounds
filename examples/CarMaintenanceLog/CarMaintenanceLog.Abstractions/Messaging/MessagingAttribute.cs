using System;

namespace CarMaintenanceLog.Abstractions.Messaging
{
    [AttributeUsage(AttributeTargets.Class | AttributeTargets.Interface, Inherited = true)]
    public class MessagingAttribute : Attribute
    {
        public string ProviderConnection { get; set; }
        public string QueueName { get; set; }
    }
}
