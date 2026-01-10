using Microsoft.AspNetCore.SignalR.Client;
using Newtonsoft.Json.Linq;
using System;
using System.Threading.Tasks;

namespace OoBDev.ScoreMachine.Web.Core.Providers.ScoreMachine
{
    public class ScoreMachinePublisher : IScoreMachinePublisher
    {
        private readonly string _hubUrl;
        private HubConnection _connection;
        private HubConnection Connection
        {
            get
            {
                if (_connection == null || _connection.State != HubConnectionState.Connected)
                {
                    var connection = new HubConnectionBuilder()
                        .WithUrl($"{_hubUrl.TrimEnd('/')}/ScoreMachineHub")
                        .Build();
                    connection.StartAsync().Wait();
                    _connection = connection;
                }
                return _connection;
            }
        }

        public ScoreMachinePublisher(string hubUrl)
        {
            _hubUrl = hubUrl;
        }

        public async Task Publish(IScoreMachineState state)
        {
            var json = Translate(state);
            Console.WriteLine($"Score Machine: {state}");
            try
            {
                await SendData(json);
            }
            catch (Exception ex)
            {
                await Console.Error.WriteLineAsync($"ScoreMachinePublisher::Publish::{ex.Message}");
            }
        }

        private async Task SendData(object data)
        {
            await Connection.InvokeAsync("SendData", data);
        }

        public JObject Translate(IScoreMachineState score)
        {
            var data = new
            {
                messageType = "ScoreMachine",

                clock = score.Clock.ToString(@"mm\:ss"),

                playerRightScore = score.Red.Score.ToString(),
                playerRightCard = score.Red.Cards.MapColor(),
                playerRightLight = score.Red.Lights.MapColor("red"),
                playerRightPriority = score.Red.Priority.ToString(),

                playerLeftScore = score.Green.Score.ToString(),
                playerLeftCard = score.Green.Cards.MapColor(),
                playerLeftLight = score.Green.Lights.MapColor("green"),
                playerLeftPriority = score.Green.Priority.ToString(),
            };
            //TODO: add logging frameworks Console.WriteLine($"Score Machine: {score}");
            return JObject.FromObject(data);
        }
    }
}