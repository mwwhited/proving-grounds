using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Sockets;
using System.ServiceModel;
using System.Text;
using Monitor.Service.Callbacks.ConnectionRelayServer;

namespace Monitor.Service.Callbacks
{
    public class ConnectionServiceClient<ParentType> : NetworkRelayCallback
        where ParentType : class, IStateObject
    {
        private ParentType _parent = default(ParentType);

        public ConnectionServiceClient(ParentType parent)
        {
            _parent = parent;
        }

        #region RelayServiceCallback Members

        public void SendData(Monitor.Service.Callbacks.ConnectionRelayServer.DataMessage request)
        {
            _parent.SendData(request);
        }

        public CallbackSystemEventResponse CallbackSystemEvent(Monitor.Service.Callbacks.ConnectionRelayServer.EventMessage request)
        {
            return _parent.CallbackSystemEvent(request);
        }

        public void ReturnLoopBack(ReturnLoopBack request)
        {
            _parent.ReturnLoopBack(request);
        }

        #endregion
    }
}
