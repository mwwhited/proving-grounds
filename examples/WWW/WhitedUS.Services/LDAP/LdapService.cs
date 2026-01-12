using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Security;
using System.Net.Sockets;
using System.Threading;
using System.Diagnostics;

namespace WhitedUS.Services.LDAP
{
    public class LdapService
    {
        public static void ServerStart()
        {
            if (Membership.Provider == null)
                throw new InvalidOperationException(
                    "Please configure a default membership provider");
            
            TcpListener listener = new TcpListener(3890);
            listener.Start();

            while (true)
            {
                Console.WriteLine("Waiting on \"{0}\"", 
                                  listener.LocalEndpoint);
                Fork(listener.AcceptSocket());                
            }
        }

        public static void Fork(Socket incomming)
        {
            new Thread(new ThreadStart(delegate
            {
                Console.WriteLine(incomming.RemoteEndPoint);
                Run(incomming);
                Thread.CurrentThread.Join();
            })).Start();
        }

        private static void Run(Socket socket)
        {
            try
            {
                NetworkStream _netStream = new NetworkStream(socket);
                bool _connected = false;
                List<byte> _buffer = new List<byte>();

                while (!_connected)
                {
                    if (_netStream.CanRead && _netStream.DataAvailable)
                    {
                        _connected = true;
                        int _byteBuffer = 0;

                        while (_byteBuffer != -1)
                        {
                            _byteBuffer = _netStream.ReadByte();

                            if (_byteBuffer != -1)
                                _buffer.Add((byte)_byteBuffer);

                            if (!_netStream.DataAvailable)
                                _byteBuffer = -1;
                        }
                    }
                }

                //Incomming packet stuff
                byte[] _header = new byte[] { _buffer[0], _buffer[1], 
                                             _buffer[2], _buffer[3] };
                byte _messageId = _buffer[4];

                byte[] _bindRequest = new byte[] { _buffer[5], _buffer[6] };

                byte[] _bindRequest2 = new byte[] { _buffer[7], _buffer[8] };
                byte _version = _buffer[9];

                byte[] _dnBinder = new byte[] { _buffer[10], _buffer[11] };
                byte _dnLength = _buffer[11];

                byte[] _byteDn = new byte[_dnLength];
                for (int i = 0; i < _dnLength; i++)
                    _byteDn[i] = _buffer[12 + i];
                string _dn = Encoding.ASCII.GetString(_byteDn);

                int _passwordOffset = 12 + _dnLength;
                byte[] _passwordHeader = new byte[] { 
                                                _buffer[_passwordOffset], 
                                                _buffer[_passwordOffset + 1] 
                                            };
                int _passwordLength = _buffer[_passwordOffset + 1];
                byte[] _passwordBuffer = new byte[_passwordLength];
                for (int i = 0; i < _passwordLength; i++)
                    _passwordBuffer[i] = _buffer[_passwordOffset + 2 + i];
                string _password = Encoding.ASCII.GetString(_passwordBuffer);

                //Sucess bind packet
                byte[] _outData = new byte[]
                {
                    0x30, 0x84,
                    0x00, 0x00, 0x00,
                    0x10, 0x02, 0x01,
                    0x01,
                    0x61, 0x84,
                    0x00, 0x00, 0x00, 0x07,
                    0x0a, 0x01,
                    0x00, //0x31 for failed
                    0x04, 0x00,
                    0x04, 0x00
                };

                bool loggedIn = false;

                if (!string.IsNullOrEmpty(_dn) && 
                    !string.IsNullOrEmpty(_password))
                {
                    //TODO: consider something useful here... like allowing you
                    // to change context for membership providers 
                    // (that would be sweet)
                    string userName = _dn.Split(',').FirstOrDefault();
                    if (!string.IsNullOrEmpty(userName))
                    {
                        if (userName.Contains('='))
                            userName = _dn.Split('=').LastOrDefault();

                        if (!string.IsNullOrEmpty(userName))
                            loggedIn = Membership.Provider.ValidateUser(
                                                                userName, 
                                                                _password);
                    }
                }

                Console.WriteLine(loggedIn ? "Passed!" : "Failed!");

                if (!loggedIn)
                    _outData[17] = 0x31;

                _netStream.Write(_outData, 0, _outData.Length);
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
            }
            socket.Disconnect(true);
        }
    }
}
