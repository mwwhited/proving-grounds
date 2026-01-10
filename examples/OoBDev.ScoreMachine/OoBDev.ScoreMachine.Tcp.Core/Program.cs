using System;
using System.Collections.Generic;
using System.Net;
using System.Linq;
using System.Net.Sockets;
using System.Threading;
using System.Threading.Tasks;
using System.Text;
using System.Net.NetworkInformation;

namespace OoBDev.ScoreMachine.Tcp.Core
{
    class Program
    {
        static void Main(string[] args)
        {
            var clientToken = new CancellationTokenSource();
            Server(clientToken.Token).Wait();
        }

        class ClientHandle
        {
            public ClientHandle(TcpClient client, Func<TcpClient, CancellationToken, Task> task, CancellationToken token)
            {
                this.Client = client;
                this.Task = Task.Run(() => task(client, token));
            }

            public TcpClient Client { get; }
            public Task Task { get; }
        }
        private static List<ClientHandle> _clients = new List<ClientHandle>();

        private static Task Server(CancellationToken token)
        {
            return Task.Run(async () =>
            {
                Console.WriteLine("Start Listener");
                var tcpListener = new TcpListener(IPAddress.Any, 8886);
                tcpListener.Start();
                var clientToken = new CancellationTokenSource();
                while (!token.IsCancellationRequested)
                {
                    Console.WriteLine("Waiting for Listener");
                    var tcpClient = await tcpListener.AcceptTcpClientAsync().ConfigureAwait(false);
                    var client = new ClientHandle(tcpClient, ClientRunner, clientToken.Token);
                    _clients.Add(client);
                    Console.WriteLine("Client forked");
                }
                Console.WriteLine("Stopping Listener");
                clientToken.Cancel();
                var tasks = _clients.Select(t => t.Task)
                                    //.Where(t => t.Status == TaskStatus.Running)
                                    .ToArray();
                Task.WaitAll(tasks, 2000);
                tcpListener.Stop();
                Console.WriteLine("Stopped Listener");
            });
        }

        private static async Task ClientRunner(TcpClient client, CancellationToken token)
        {
            Console.WriteLine($"Connected:{client.Client.RemoteEndPoint}");
            using (var stream = client.GetStream())
            {
                while (client.Connected && !token.IsCancellationRequested && GetState(client) == TcpState.Established)
                {
                    var buffer = new byte[1024];
                    var len = await stream.ReadAsync(buffer, 0, buffer.Length);
                    Console.WriteLine($"{client.Client.RemoteEndPoint}:> {Encoding.UTF8.GetString(buffer, 0, len)}");
                }
                client.Close();
                Console.WriteLine($"Closed:{client.Client.RemoteEndPoint}");
            }
        }


        // https://stackoverflow.com/questions/1387459/how-to-check-if-tcpclient-connection-is-closed
        public static TcpState GetState(TcpClient tcpClient)
        {
            var foo = IPGlobalProperties.GetIPGlobalProperties()
              .GetActiveTcpConnections()
              .SingleOrDefault(x => x.RemoteEndPoint.Equals(tcpClient.Client.RemoteEndPoint));
            return foo != null ? foo.State : TcpState.Unknown;
        }
    }
}
