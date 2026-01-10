using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;

namespace OoBDev.ScoreMachine.Tcp.Cli
{
    class Program
    {
        static void Main(string[] args)
        {
            using (var client = new TcpClient())
            {
                client.Connect(IPAddress.Loopback, 5002);

                using (var stream = client.GetStream())
                {
                    while (true)
                    {
                        var input = Console.ReadLine();
    
                        var buffer = Encoding.UTF8.GetBytes(input);
                        stream.Write(buffer, 0, buffer.Length);

                        if (input == "done")
                        {
                            break;
                        }
                    }
                }
            }
        }
    }
}
