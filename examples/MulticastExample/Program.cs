using System;
using System.Net;
using System.Net.Sockets;
using System.Threading.Tasks;

namespace ConsoleApplication18
{
    class Program
    {
        static void Main(string[] args)
        {
            using (var client = new UdpClient())
            {
                var multicastaddress = IPAddress.Parse("224.0.0.21");
                IPEndPoint localep = new IPEndPoint(IPAddress.Any, 3956);
                client.Client.SetSocketOption(SocketOptionLevel.Socket, SocketOptionName.ReuseAddress, true);
                client.Client.Bind(localep);
                client.JoinMulticastGroup(multicastaddress);

                IPEndPoint remoteep = new IPEndPoint(IPAddress.Any, 0);

                Console.WriteLine("start");

                volatile bool running = true;
                var task = Task.Run(() =>
                  {
                      try
                      {
                          while (running)
                          {
                              var received = client.Receive(ref remoteep);
                              Console.WriteLine("Received: {0}) {1}", remoteep, Convert.ToBase64String(received));
                          }
                      }
                      catch (SocketException ex)
                      {
                          Console.WriteLine("Socket error: {0}", ex.Message);
                      }
                      finally
                      {
                          Console.WriteLine("fin!");
                          client.DropMulticastGroup(multicastaddress);
                      }
                  });

                Console.WriteLine("waiting");
                Console.Read();
                Console.WriteLine("done");
                running = false;

                task.Wait();
            }
        }
    }
}
