using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Configuration;
using System.Linq;
using System.Net.Sockets;
using System.Text;
using Monitor.Service.Callbacks;
using System.Xml;
using System.Threading;
using System.Net;

namespace Monitor.Client
{
    class Program
    {
        private static IDictionary<string, TcpListener> _listeners = new Dictionary<string, TcpListener>();
        private static IDictionary<string, ConnectionStateObject> _connections = new Dictionary<string, ConnectionStateObject>();
        private static IDictionary<string, Thread> _threads = new Dictionary<string, Thread>();
        private static IList<string> _configs = null; //new List<string>();

        static void Main(string[] args)
        {
            string tdnfRelayConfig = ConfigurationManager.AppSettings["tdnfRelay"];

            _configs = tdnfRelayConfig.Split(new char[] { ';' }).ToList();

            foreach (var _config in _configs)
            {
                Thread _newThread = new Thread(new ParameterizedThreadStart(
                    delegate
                    {
                        StartListener(_config);
                    }));
                _threads.Add(_config, _newThread);
                _newThread.Start();
                Thread.Sleep(100);
            }
        }

        static void StartListener(string configListener)
        {
            string[] _configParts = configListener.Split(new char[] { ':' });
            string _localAddress = _configParts[0];
            int _localPort = Convert.ToInt32(_configParts[1]);
            string _remoteAddress = _configParts[2];
            int _remotePort = Convert.ToInt32(_configParts[3]);

            TcpListener _listener = null;

            if (string.IsNullOrEmpty(_localAddress))
                _listener = new TcpListener(_localPort);
            else
                _listener = new TcpListener(Dns.GetHostAddresses(_localAddress).FirstOrDefault(), _localPort);

            _listeners.Add(configListener, _listener);
            _listener.Start();

            Console.WriteLine("Waiting for connection on: " + _localAddress + ":" + _localPort.ToString() + " for " + _remoteAddress + ":" + _remotePort);

            while (true)
            {
                Socket _newConnect = _listener.AcceptSocket();

                Console.WriteLine("Hello " + _newConnect.RemoteEndPoint.ToString());
                ConnectionStateObject _client = new ConnectionStateObject(_newConnect, _remoteAddress, _remotePort);
                _client.ConnectionLost += new ConnectionClientEventHandler(_client_ConnectionLost);
                _connections.Add(_newConnect.RemoteEndPoint.ToString(), _client);
            }

        }

        static void _client_ConnectionLost(object sender, ConnectionClientEventArgs e)
        {
            Console.WriteLine("Connection Lost for: " + e.OriginSocketName);

            if (_connections.ContainsKey(e.OriginSocketName))
            {
                _connections[e.OriginSocketName] = null;
                _connections.Remove(e.OriginSocketName);
            }
        }
    }
}
