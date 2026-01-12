using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net;

namespace WhitedUS.Services.NetworkRelay
{
    internal static class Constants
    {
        static Constants()
        {
            MessageServerEndPoint = new IPEndPoint(MessageServer, MessagePort);
        }

        public static readonly int MessagePort = 1234;
        public static readonly IPAddress MessageServer = 
                                                IPAddress.Parse("127.0.0.1");
        public static readonly IPEndPoint MessageServerEndPoint;

        public static readonly int SleepLength = 500;
        public static readonly int ConnectionTimeOut = 60;

        public static readonly int LineDelay = 500;

        public const string ServiceContractNamespace = 
                                "http://www.whited.us/2008/01/RelayService";
        public const string ServiceContractName = "NetworkRelay";

    }
}