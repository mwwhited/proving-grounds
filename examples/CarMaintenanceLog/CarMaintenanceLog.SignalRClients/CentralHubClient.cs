using CarMaintenanceLog.Abstractions.Hubs;
using Microsoft.AspNetCore.SignalR.Client;
using System;
using System.Threading;
using System.Threading.Tasks;

namespace CarMaintenanceLog.SignalRClients
{
    public class CentralHubClient : ICentralHubClient
    {
        private readonly ICentralHubClientBuilder _builder;
        private readonly Lazy<HubConnection> _connection;
        private HubConnection Connection { get => _connection.Value; }

        public CentralHubClient(
            ICentralHubClientBuilder builder
            )
        {
            _builder = builder; //.Build(this).Result;
            _connection = new Lazy<HubConnection>(CreateConnection, LazyThreadSafetyMode.PublicationOnly);
        }

        private HubConnection CreateConnection()
        {
            var factory = _builder.Build(this);
            var connection = factory.Result;
            return connection;
        }

        /*
            JavaScript interop calls cannot be issued at this time. This is because the component is being statically rendererd.
            When prerendering is enabled, JavaScript interop calls can only be performed during the OnAfterRenderAsync lifecycle method.

                  SignalRConnectionInfo signalRConnectionInfo;
            signalRConnectionInfo = await functionsClient.GetDataAsync<SignalRConnectionInfo>(FunctionsClientConstants.SignalR);

            hubConnection = new HubConnectionBuilder()
            .WithUrl(signalRConnectionInfo.Url, options =>
            {
              options.AccessTokenProvider = () => Task.FromResult(signalRConnectionInfo.AccessToken);
            })
            .Build();
        */

        public Func<string, Task> OnReceived { get; set; }

        public async Task SendMessageAsync(string message)
        {
            await Connection.InvokeAsync("SendMessage", message);
        }
    }
}
