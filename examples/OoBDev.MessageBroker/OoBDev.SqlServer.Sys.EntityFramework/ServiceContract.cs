using System.Collections.Generic;

namespace OoBDev.SqlServer.Sys
{
    public class ServiceContract
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int PrincipalId { get; set; }
        public IEnumerable<ServiceToServiceContract> Services { get; set; }
        public IEnumerable<ServiceContractToServiceMessageType> MessageTypes { get; set; }
        public IEnumerable<ConversationEndpoint> ConversationEndpoints { get; internal set; }
    }
}