namespace OoBDev.SqlServer.Sys
{
    public class ServiceContractToServiceMessageType
    {
        public int ServiceContractId { get; set; }
        public int MessageTypeId { get; set; }
        public bool IsSentByInitiator { get; set; }
        public bool IsSentByTarget { get; set; }
        public ServiceContract ServiceContract { get; set; }
        public ServiceMessageType ServiceMessageType { get; set; }
    }
}