using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ServiceModel;

namespace WhitedUS.Services.NetworkRelay
{
    public class ConnectionHost
    {
        private static ServiceHost _localHost = null;
        public static ServiceHost HostService { get { return _localHost; } }

        static ConnectionHost()
        {
            _localHost = new ServiceHost(typeof(ConnectionService));
        }

        public static void StartService()
        {
            _localHost.Open();
        }

        public static void StopService()
        {
            if (_localHost.State != CommunicationState.Closed)
                _localHost.Close();
        }
    }
}
