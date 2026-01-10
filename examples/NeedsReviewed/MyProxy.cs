using System;
using System.Collections.Generic;
using System.Text;
using System.Net.Sockets;
using System.Net;
using System.IO;
using System.Threading;

namespace StreamReader
{
    class MyProxy
    {
        static void Main(string[] args)
        {
            TcpListener listener = new TcpListener(IPAddress.Parse("127.0.0.1"), 8082);
            listener.Start();
            while (true)
            {
                Console.WriteLine(string.Format("Connection Count: {0}", tunnels.Count));
                HouseCall(listener.AcceptSocket());
            }
        }
        static List<Tunnel> tunnels = new List<Tunnel>();
        static void HouseCall(Socket listener)
        {
            Console.WriteLine(string.Format("Welcome \"{0}\"", listener.RemoteEndPoint.ToString()));
            Tunnel connected = new Tunnel(listener, new TcpClient("localhost", 8080).GetStream());
            connected.Hangup += new Tunnel.HangupHandler(connected_Hangup);

            tunnels.Add(connected);
        }

        static void connected_Hangup(TunnelEventArgs e)
        {
            tunnels.Remove(e.Tunnel);
        }
    }

    public class TunnelEventArgs : EventArgs
    {
        public TunnelEventArgs(Tunnel tunnel)
        {
            _tunnel = tunnel;
        }

        private Tunnel _tunnel;
        public Tunnel Tunnel { get { return _tunnel; } }
    }

    public class Tunnel
    {
        public delegate void HangupHandler(TunnelEventArgs e);
        public event HangupHandler Hangup;

        public Tunnel(Socket inbound, NetworkStream outBound)
        {
            inStream = new NetworkStream(inbound);
            outStream = outBound;

            string endPointName = inbound.RemoteEndPoint.ToString().Replace(".", "-").Replace(":", "_");
            inOut = File.Open(string.Format(".\\inOut({0}).dump", endPointName), FileMode.Append);
            outIn = File.Open(string.Format(".\\outIn({0}).dump", endPointName), FileMode.Append);

            ioThread = new Thread(new ThreadStart(in2out));
            ioThread.Name = string.Format("In to Out: {0}", endPointName);
            oiThread = new Thread(new ThreadStart(out2in));
            oiThread.Name = string.Format("Out to In: {0}", endPointName);

            ioThread.Start();
            oiThread.Start();

            hup = new Thread(new ThreadStart(HungUp));
            hup.Start();
        }

        private volatile bool isClosed = false;
        private Stream inOut = null;
        private Stream outIn = null;
        private NetworkStream inStream = null;
        private NetworkStream outStream = null;

        private Thread ioThread;
        private Thread oiThread;
        private Thread hup;

        private void HungUp()
        {
            ioThread.Join();
            oiThread.Join();
            if (Hangup != null)
                Hangup(new TunnelEventArgs(this));
        }

        private void in2out()
        {
            BufferLoop(inStream, outStream, inOut);
            isClosed = true;
            inOut.Close();
            inStream.Close();
            outStream.Close();
            Console.WriteLine(Thread.CurrentThread.Name);
        }

        private void out2in()
        {
            BufferLoop(outStream, inStream, outIn);
            isClosed = true;
            outIn.Close();
            outStream.Close();
            inStream.Close();
            Console.WriteLine(Thread.CurrentThread.Name);
        }

        private void BufferLoop(Stream iStream, Stream oStream, Stream copy)
        {
            byte[] buffer = new byte[1024];
            int bufferLength;
            try
            {
                while (iStream.CanRead && oStream.CanWrite && !isClosed)
                {
                    bufferLength = iStream.Read(buffer, 0, buffer.Length);
                    if (bufferLength > 0)
                    {
                        copy.Write(buffer, 0, bufferLength);
                        copy.Flush();
                        if (oStream.CanWrite)
                            oStream.Write(buffer, 0, bufferLength);
                    }
                    else if (bufferLength <= 0)
                        break;
                }
            }
            catch { }
        }
    }
}
