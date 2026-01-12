using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Monitor.Service.Callbacks.ConnectionRelayServer;

namespace Monitor.Service.Callbacks
{
    public interface IStateObject
    {
        void SendData(Monitor.Service.Callbacks.ConnectionRelayServer.DataMessage request);
        CallbackSystemEventResponse CallbackSystemEvent(Monitor.Service.Callbacks.ConnectionRelayServer.EventMessage request);
        void ReturnLoopBack(ReturnLoopBack request);
    }
}
