using OoBDev.SqlServer.Sys;
using System;

namespace OoBDev.SqlServer.Extensions.EntityFramework
{
    public abstract class QueueItem
    {
        public byte Status { get; internal set; }
        public byte Priority { get; internal set; }
        public long QueuingOrder { get; internal set; }
        public Guid ConversationGroupId { get; internal set; }
        public Guid ConversationHandle { get; internal set; }
        public long MessageSequenceNumber { get; internal set; }
        public string ServiceName { get; internal set; }
        public int ServiceId { get; internal set; }
        public string ServiceContractName { get; internal set; }
        public int ServiceContractId { get; internal set; }
        public string MessageTypeName { get; internal set; }
        public int MessageTypeId { get; internal set; }
        public string Validation { get; internal set; }
        public DateTime MessageEnqueueTime { get; internal set; }
        public byte[] MessageBody { get; internal set; }
        public ConversationGroup ConversationGroup { get; internal set; }
        public ConversationEndpoint ConversationEndpoint { get; internal set; }
        public Service Service { get; internal set; }
        public ServiceContract ServiceContract { get; internal set; }
        public ServiceMessageType MessageType { get; internal set; }
    }
}