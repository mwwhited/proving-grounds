using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net.Sockets;
using System.Net;
using System.Threading;
using System.Diagnostics;

namespace WhitedUS.Services.SNTP
{
    public class SNTPService
    {
        public const int NTP_PORT = 123;
        private static Thread other;
        static ManualResetEvent mre = new ManualResetEvent(false);
        static UdpClient listener;

        public static void Kill()
        {
            try
            {
                Console.WriteLine("SNTPService :: Kill()");
                mre.Set();
                Console.WriteLine("SNTP Service - Abort Thread");
                other.Abort();
                Console.WriteLine("SNTP Service - Close Listener");
                listener.Close();
                Console.WriteLine("SNTP Service - Join Thread");
                other.Join(10000);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }

        public static void ServerStart()
        {
            other = new Thread(new ThreadStart(delegate()
            {
                try
                {
                    listener = new UdpClient(NTP_PORT);
                    var groupEP = new IPEndPoint(IPAddress.Any, NTP_PORT);

                    var time = DateTime.Now.ToBinary();

                    Console.WriteLine("Waiting for Request");
                    mre.Set();
                    while (true)
                    {
                        byte[] bytes = listener.Receive(ref groupEP);

                        var recv = DateTime.UtcNow;
                        var inPacket = NTPPacket.Create(bytes);
                        inPacket.VersionNumber = 3;
                        inPacket.LeapIndicator = LeapIndicatorTypes.NoWarning;
                        inPacket.Mode = NTPModeTypes.Server;
                        inPacket.Stratum = 16;
                        inPacket.ReferenceClockIdentifier = 
                                            new byte[] { 127, 0, 0, 1 };
                        inPacket.OriginateTimestamp = inPacket.TransmitTimestamp;
                        inPacket.ReceiveTimestamp = recv;
                        inPacket.TransmitTimestamp = DateTime.UtcNow;
                        listener.Send(inPacket.ToBinary(), 48, groupEP);

                        Debug.WriteLine(string.Format(
                            "Request from \"{0}\" sent at " +
                                "\"{1}\" replyed at \"{2}\"",
                            groupEP.ToString(),
                            inPacket.OriginateTimestamp,
                            inPacket.TransmitTimestamp));
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine();
                    Console.WriteLine("SNTP Server - Exception");
                    Console.WriteLine(ex.Message);
                }
            }));
            other.Name = "SNTP Server";
            other.Start();
            mre.WaitOne();
        }
    }
}
