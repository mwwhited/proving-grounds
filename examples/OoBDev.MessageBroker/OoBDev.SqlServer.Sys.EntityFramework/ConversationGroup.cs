using System;
using System.Collections.Generic;

namespace OoBDev.SqlServer.Sys
{
    public class ConversationGroup
    {
        public Guid Id { get; internal set; }
        public int ServiceId { get; internal set; }
        public bool IsSystem { get; internal set; }
        public IEnumerable<ConversationEndpoint> ConversationEndpoints { get; set; }
        public Service Service { get; internal set; }
    }
}