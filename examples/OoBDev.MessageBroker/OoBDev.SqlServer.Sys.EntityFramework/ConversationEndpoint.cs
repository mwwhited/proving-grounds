using System;

namespace OoBDev.SqlServer.Sys
{
    public class ConversationEndpoint
    {
        public Guid Handle { get; set; }
        public Guid ConversationId { get; set; }
        public bool IsInitiator { get; set; }
        public bool IsSystem { get; set; }
        public int ServiceContractId { get; set; }
        public int ServiceId { get; set; }
        public string StateDescription { get; set; }
        public int PrincipalId { get; set; }
        public string FarService { get; set; }
        public Guid FarBrokerInstance { get; set; }
        public Guid ConversationGroupId { get; set; }
        public ServiceContract ServiceContract { get; set; }
        public Service Service { get; internal set; }
        public ConversationGroup ConversationGroup { get; set; }
    }
}