using OoBDev.ScoreMachine.Web.Core.Providers.Hosting;
using OoBDev.ScoreMachine.Web.Core.Providers.Tools;
using System;
using System.Collections.Generic;
using System.Net;
using System.Net.NetworkInformation;
using System.Net.Sockets;
using System.Threading;
using System.Threading.Tasks;

namespace OoBDev.ScoreMachine.Web.Core.Providers.EbyteE810Dtu
{
    //TODO: this should be a handler used by the TCP Listener Provider
    //TODO: this should take other providers based on the prefix
    public class EbyteE810DtuProvider
    {
        private readonly IPAddress _serverAddress;
        private readonly int _port;
        private readonly string _hubUrl;

        public EbyteE810DtuProvider(IPAddress serverAddress, int port, string hubUrl)
        {
            this._serverAddress = serverAddress;
            this._port = port;
            this._hubUrl = hubUrl;
        }

        public async Task Start(CancellationTokenSource cts)
        {
            var clientTasks = new List<Task>();
            while (!cts.IsCancellationRequested)
            {
                Console.WriteLine("EbyteE810Dtu: Start Listener");
                var tcpListener = new TcpListener(_serverAddress, _port);
                tcpListener.Start();
                try
                {
                    using (var clientTokenSource = new CancellationTokenSource())
                    {
                        var realToken = CancellationTokenSource.CreateLinkedTokenSource(cts.Token, clientTokenSource.Token);
                        while (!cts.IsCancellationRequested)
                        {
                            Console.WriteLine("EbyteE810Dtu: Waiting for Listener");
                            var tcpClient = await tcpListener.AcceptTcpClientAsync().ConfigureAwait(false);
                            clientTasks.Add(ClientRunner(tcpClient, realToken));
                            Console.WriteLine("EbyteE810Dtu: Client forked");
                        }
                        Console.WriteLine("EbyteE810Dtu: Stopping Listener");
                        clientTokenSource.Cancel();
                        Console.WriteLine("EbyteE810Dtu: Stopped Listener");
                    }
                }
                catch (Exception ex)
                {
                    await Console.Error.WriteLineAsync($"EbyteE810DtuProvider::Start ERROR::{ex}");
                }
                finally
                {
                    tcpListener.Stop();
                    Task.WaitAll(clientTasks.ToArray());
                }
                await TaskEx.Delay(1000, cts);
            }
        }

        private async Task ClientRunner(TcpClient client, CancellationTokenSource cts)
        {
            var endPoint = client.Client.RemoteEndPoint;
            try
            {
                Console.WriteLine($"EbyteE810Dtu: Connected:{endPoint}");
                using (var stream = client.GetStream())
                {
                    var processor = new ClientProcessor(stream, _hubUrl);
                    await Task.WhenAll(
                        Task.Run(() => processor.Start(cts)),
                        Task.Run(async () =>
                        {
                            while (!cts.IsCancellationRequested)
                                try
                                {
                                    while (client.Connected && !cts.IsCancellationRequested && client.GetState() == TcpState.Established)
                                    {
                                        var buffer = new byte[1024];
                                        var len = await stream.ReadAsync(buffer, 0, buffer.Length);
                                        if (len > 2)
                                        {
                                            var message = new byte[len];
                                            Array.Copy(buffer, message, len);
                                            await processor.MessageReceived(message);
                                        }
                                    }
                                }
                                catch (Exception exi)
                                {
                                    await Console.Error.WriteLineAsync($"EbyteE810DtuProvider::ClientRunner: exi::{exi}");
                                }
                        })
                    );
                    client.Close();
                    Console.WriteLine($"EbyteE810Dtu: Closed:{endPoint}/{processor.Type}");
                }
            }
            catch (Exception ex)
            {
                await Console.Error.WriteLineAsync($"EbyteE810DtuProvider::ClientRunner: ERROR::{ex}");
            }
        }
    }
}
