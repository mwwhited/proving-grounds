using System.Collections.Generic;

namespace OoBDev.SqlServer.Sys
{
    public class Service
    {
        public int Id { get; set; }
        public int PrincipalId { get; set; }
        public int ServiceQueueId { get; set; }
        public string Name { get;  set; }
        public ServiceQueue ServiceQueue { get; internal set; }
        public IEnumerable<ServiceToServiceContract> ServiceContracts { get; internal set; }
        public IEnumerable<ConversationEndpoint> ConversationEndpoints { get; internal set; }
        internal IEnumerable<ConversationGroup> ConversationGroups { get; set; }
    }
}