using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net.Sockets;
using System.Threading;

namespace WhitedUS.Services.IRC
{
    public class IrcService
    {
        public static void ServerStart()
        {
            var listener = new TcpListener(6667);
            listener.Start();

            while (true)
            {
                Console.WriteLine("Waiting on \"{0}\"",
                                  listener.LocalEndpoint);
                //listener.
            }
        }
    }
}
