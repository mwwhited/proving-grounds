using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;

namespace WhitedUS.Services.NetworkRelay
{
    [MessageContract]
    public class DataMessage
    {
        [MessageHeader]
        public int SequenceNumber { get; set; }

        [MessageHeader]
        public int DataPacketSize { get; set; }

        [MessageBodyMember]
        public byte[] DataPacket { get; set; }

    }
}
