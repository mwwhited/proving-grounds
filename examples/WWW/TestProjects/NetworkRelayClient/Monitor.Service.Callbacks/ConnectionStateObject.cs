using System;
using System.Net.Sockets;
using System.ServiceModel;
using System.Threading;
using Monitor.Service.Callbacks.ConnectionRelayServer;
using WhitedUS.Services.NetworkRelay;

namespace Monitor.Service.Callbacks
{
    public class ConnectionStateObject: IStateObject
    {
        private Socket _originSocket = null;
        private NetworkStream _listenerStream = null;
        private NetworkRelayClient _proxyServer = null;
        private NetworkRelayCallback _proxyCallback = null;
        private Thread _proxyClientThread = null;
        private int _sequenceNumber = 0;
        private string _originSocketName = null;

        public event ConnectionClientEventHandler ConnectionLost;

        public ConnectionStateObject(Socket listener, string serverName, int port)
        {
            _originSocket = listener;
            _listenerStream = new NetworkStream(_originSocket);

            _proxyCallback = new ConnectionServiceClient<ConnectionStateObject>(this);
            _proxyServer = new NetworkRelayClient(new InstanceContext(_proxyCallback));
            _proxyServer.Open();

            Console.WriteLine("Proxy State:" + _proxyServer.State.ToString());

            _originSocketName = _originSocket.RemoteEndPoint.ToString();

            _proxyServer.Connect(serverName, port, _originSocketName);
            string reply = _proxyServer.Loopback("Hello");

            Console.WriteLine("Loopback: " + reply);
            _proxyServer.LoopbackWithCallBack("Hi There");

            _proxyClientThread = new Thread(new ParameterizedThreadStart(delegate { this.MonitorBuffer(); }));
            _proxyClientThread.Start();

            //_proxyServer.Disconnect();
        }

        private void MonitorBuffer()
        {
            byte[] _errorMessage;
            try
            {
                bool _started = false;
                while (!_started)
                {
                    if (_listenerStream.CanRead && _listenerStream.DataAvailable)
                    {
                        _started = true;
                        int _byteBuffer = -1;
                        byte[] _buffer = new byte[ConnectionService.BUFFER_SIZE];

                        while (_byteBuffer != 0)
                        {
                            _byteBuffer = _listenerStream.Read(_buffer, 0, ConnectionService.BUFFER_SIZE);

                            _proxyServer.SendData(_byteBuffer, _sequenceNumber++, _buffer);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
            }

            _proxyServer.SendSystemEvent(Monitor.Service.Callbacks.ConnectionRelayServer.EventType.SocketHangup, new byte[0]);
        }

        #region IStateObject Members

        public void SendData(Monitor.Service.Callbacks.ConnectionRelayServer.DataMessage request)
        {
            _listenerStream.Write(request.DataPacket, 0, request.DataPacketSize);
            _listenerStream.Flush();
        }

        public CallbackSystemEventResponse CallbackSystemEvent(Monitor.Service.Callbacks.ConnectionRelayServer.EventMessage request)
        {
            switch (request.EventType)
            {
                case Monitor.Service.Callbacks.ConnectionRelayServer.EventType.SocketHangup:
                    _originSocket.Disconnect(false);
                    _proxyServer.Disconnect();
                    
                    if (this.ConnectionLost != null)
                        this.ConnectionLost(this, new ConnectionClientEventArgs(_originSocketName));

                    break;
                case Monitor.Service.Callbacks.ConnectionRelayServer.EventType.ResendRequest:
                    break;
                default:
                    break;
            }

            return null;
        }

        public void ReturnLoopBack(ReturnLoopBack request)
        {
            Console.WriteLine();
            Console.WriteLine("ReturnLoopBack");
            Console.WriteLine("Origin Socket Name: " + request.originSocketName);
            Console.WriteLine("Reply Message: " + request.OutboundData);
        }

        #endregion
    }
}
