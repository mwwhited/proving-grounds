using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;

namespace WhitedUS.Services.NetworkRelay
{
    [MessageContract]
    public class EventMessage
    {
        [MessageHeader]
        public EventType EventType { get; set; }

        [MessageBodyMember]
        public byte[] Payload { get; set; }
    }
}
