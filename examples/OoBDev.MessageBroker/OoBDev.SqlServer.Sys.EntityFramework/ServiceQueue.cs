using System.Collections.Generic;

namespace OoBDev.SqlServer.Sys
{
    public class ServiceQueue
    {
        public string Name { get; set; }
        public int Id { get; set; }
        public int? PrincipalId { get; set; }
        public int SchemaId { get; set; }
        public Schema Schema { get; set; }
        public bool IsMicrosoftShipped { get; set; }
        public bool IsEnabled { get; set; }
        public bool IsActivationEnabled { get; set; }
        public IEnumerable<Service> Services { get; set; }
        public string ActivationProcedure { get; internal set; }
        public bool? ExecuteAsPrincipalId { get; internal set; }
        public int? MaxReaders { get; internal set; }
        public bool IsPoisonMessageHandlingEnabled { get; internal set; }
        public bool IsRetentionEnabled { get; internal set; }
        public bool IsReceiveEnabled { get; internal set; }
    }
}