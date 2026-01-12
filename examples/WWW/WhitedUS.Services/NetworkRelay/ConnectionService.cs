using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.ServiceModel;
using System.Threading;

//WhitedUS.Services.NetworkRelay.ConnectionService,WhitedUS.Services
namespace WhitedUS.Services.NetworkRelay
{
    public class ConnectionService : IConnectionContract
    {
        public const int BUFFER_SIZE = 512;

        private NetworkStream _clientStream = null;
        private Socket _clientSocket = null;
        private TcpClient _clientTcp = null;
        private IPEndPoint _clientEndPoint = null;
        private IPAddress _clientAddress = null;

        private IConnectionCallbackContract _callbackClientChannel = null;
        private IConnectionCallbackContract CallbackChannel
        {
            get
            {
                if (_callbackClientChannel == null)
                {
                    if (OperationContext.Current != null)
                        _callbackClientChannel = OperationContext.Current
                            .GetCallbackChannel<IConnectionCallbackContract>();
                }

                return _callbackClientChannel;
            }
        }

        private bool _connected = false;
        private int _sequenceNumber = 0;

        private string _originSocketName = null;

        private Thread _clientThread = null;

        private void MonitorBuffer()
        {
            bool _started = false;
            while (!_started)
            {
                if (_clientStream.CanRead && _clientStream.DataAvailable)
                {
                    _started = true;
                    int _byteBuffer = -1;
                    byte[] _buffer = new byte[BUFFER_SIZE];

                    while (_byteBuffer != 0)
                    {
                        _byteBuffer = _clientStream.Read(_buffer, 
                                                         0, 
                                                         BUFFER_SIZE);

                        this.CallbackChannel.SendData(new DataMessage()
                        {
                            SequenceNumber = _sequenceNumber++,
                            DataPacket = _buffer,
                            DataPacketSize = _byteBuffer
                        });
                    }
                }
            }

            this.CallbackChannel.CallbackSystemEvent(new EventMessage() { 
                                        EventType = EventType.SocketHangup, 
                                        Payload = new byte[0]});
        }
        
        #region IConnectionContract Members

        public void Connect(string server, int port, string orgSocket)
        {
            Console.WriteLine("Incomming Call: {0} for {1}:{2}", 
                              orgSocket, 
                              server, 
                              port);
            if (
                string.IsNullOrEmpty(server) ||
                string.IsNullOrEmpty(orgSocket) ||
                port < 0 ||
                port > 65535
                )
                throw new ArgumentOutOfRangeException(
                    "Please check Connect Parameters");

            try
            {
                if (_clientEndPoint == null && !_connected)
                {
                    _connected = true;

                    _originSocketName = orgSocket;
                    _clientAddress = Dns.GetHostAddresses(server)
                                        .FirstOrDefault();

                    if (_clientAddress == null)
                        throw new InvalidOperationException(
                            "Host name or IP Address could not be resolved");

                    _clientEndPoint = new IPEndPoint(_clientAddress, port);

                    _clientTcp = new TcpClient();
                    _clientTcp.Connect(_clientEndPoint);

                    _clientSocket = _clientTcp.Client;

                    _clientStream = new NetworkStream(_clientSocket);

                    _clientThread = new Thread(
                            new ThreadStart (()=> { this.MonitorBuffer(); })
                        );
                    _clientThread.Start();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }

        public void SendData(DataMessage inboundData)
        {
            if (!_connected)
                return;

            if (_clientStream == null)
                return;

            _clientStream.Write(inboundData.DataPacket, 
                                0, 
                                inboundData.DataPacketSize);
            _clientStream.Flush();
        }

        public void SendSystemEvent(EventMessage eventMessage)
        {
            Console.WriteLine("System Event: {0}", eventMessage.EventType);
            switch (eventMessage.EventType)
            {
                case EventType.SocketHangup:
                    _clientSocket.Disconnect(false);
                    break;
                case EventType.ResendRequest:
                    break;
                default:
                    break;
            }
        }

        public void ReturnSystemEvent(EventMessage eventMessage)
        {
            throw new NotImplementedException();
        }

        public void LoopbackWithCallBack(string inboundMessage)
        {
            this.CallbackChannel.ReturnLoopBack(_originSocketName, 
                                                inboundMessage);
        }

        public string Loopback(string inboundMessage)
        {
            return inboundMessage;
        }

        public void Disconnect()
        {
            if (_clientSocket != null && _connected)
            {
                _connected = false;

                _clientSocket.Disconnect(false);
                _clientSocket = null;

                if (_clientEndPoint != null)
                    _clientEndPoint = null;

                _originSocketName = null;

                if (_clientStream != null)
                    _clientStream.Dispose();

                if (_clientTcp != null)
                    _clientTcp = null;

                if (_clientAddress != null)
                    _clientAddress = null;

                if (_clientThread != null)
                {
                    if (_clientThread.ThreadState != ThreadState.Stopped)
                    {
                        try
                        {
                            _clientThread.Abort();
                        }
                        catch (Exception ex)
                        {
                            Console.WriteLine("Abort Failed: " + ex.Message);
                        }
                    }
                    _clientThread = null;
                }
            }

        }

        #endregion

    }
}
