using CarMaintenanceLog.Abstractions.Hubs;
using Microsoft.AspNetCore.SignalR.Client;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;

namespace CarMaintenanceLog.SignalRClients
{
    public sealed class CentralHubClientBuilder : ICentralHubClientBuilder, IDisposable
    {
        private readonly HubConnectionBuilder _builder;
        private readonly IConfiguration _config;
        private readonly IList<IDisposable> _disposables = new List<IDisposable>();

        private bool _disposed = false;

        public CentralHubClientBuilder(
            HubConnectionBuilder builder,
            IConfiguration config
            )
        {
            _builder = builder;
            _config = config;
        }

        public async Task<HubConnection> Build(ICentralHubClient client)
        {
            try
            {
                var connectionString = _config["CarMaintenanceLogCentralHub"];
                var mapped = from cs in connectionString.Split(';')
                             let kvp = cs.Split(new[] { '=' }, 2)
                             select new
                             {
                                 Key = kvp.ElementAtOrDefault(0),
                                 Value = kvp.ElementAtOrDefault(1),
                             };
                var hubName = "CentralHub";
                var url = $"{mapped.FirstOrDefault(k => string.Equals(k.Key, "Endpoint", StringComparison.InvariantCultureIgnoreCase))?.Value}/client/?hub={hubName}";

                // in Component Initialization code
                var connection = _builder // the injected one from above.
                        //.WithUrl(url)
                        //opt =>
                        //{
                        //    opt.LogLevel = SignalRLogLevel.Trace; // Client log level
                        //    opt.Transport = HttpTransportType.WebSockets; // Which transport you want to use for this connection
                        //})
                        .Build(); // Build the HubConnection

                _disposables.Add(connection.On<string>("Received", async message => await (client.OnReceived ?? NotHandled)(message)));

                await connection.StartAsync();
                return connection;
            }
            catch (Exception ex)
            {
                throw;
            }
        }
        /*
          public MessagingClient(
            IHubConnectionBuilder builder,
            IMessageResolver resolver
            )
        {
            var connectionString = resolver.GetHubConnectionString<THub>();

            _connection = builder.WithAutomaticReconnect()
                   .WithUrl(url, options =>
                   {
                       //options.AccessTokenProvider = () => Task.FromResult(config.GenerateAccessToken());
                   }).Build();
            _resolver = resolver;

            _connection.On("SendMessage", (string server, string message) =>
            {
                Console.WriteLine($"[{DateTime.Now.ToString()}] Received message from server {server}: {message}");
            });
        }

        private string GetClientUrl(string endpoint, string hubName)
        {
            return $"{endpoint}/client/?hub={hubName}";
        }
        */

        private Task NotHandled(string message)
        {
            Debug.WriteLine($"{nameof(CentralHubClientBuilder)}::{nameof(NotHandled)} => {message}");
            return Task.FromResult(0);
        }

        ~CentralHubClientBuilder()
        {
            Dispose(false);
        }
        public void Dispose()
        {
            // Dispose of unmanaged resources.
            Dispose(true);
            // Suppress finalization.
            GC.SuppressFinalize(this);
        }
        // Protected implementation of Dispose pattern.
        protected void Dispose(bool disposing)
        {
            if (_disposed)
                return;

            if (disposing)
            {
                foreach (var disposable in _disposables)
                {
                    disposable.Dispose();
                }
            }

            _disposed = true;
        }

        /*

connection.On("Receive", this.Handle); // Subscribe to messages sent from the Hub to the "Receive" method by passing a handle (Func<object, Task>) to process messages.
await connection.StartAsync(); // Start the connection.

await connection.InvokeAsync("ServerMethod", param1, param2, paramX); // Invoke a method on the server called "ServerMethod" and pass parameters to it. 

var result = await connection.InvokeAsync<MyResult>("ServerMethod", param1, param2, paramX); // Invoke a method on the server called "ServerMethod", pass parameters to it and get the result back.
*/
    }
}
