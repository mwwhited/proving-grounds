using Microsoft.AspNetCore.SignalR.Client;
using OoBDev.ScoreMachine.Common;
using OoBDev.ScoreMachine.Common.Extensions;
using System;
using System.Threading.Tasks;

namespace OoBDev.ScoreMachine.Client.Core
{
    public class ScoreMachinePublisher : IScoreMachinePublisher
    {
        private HubConnection Connection { get; }

        public ScoreMachinePublisher(string hub)
        {
            Connection = new HubConnectionBuilder()
                .WithUrl($"{hub.TrimEnd('/')}/ScoreMachineHub")
                .Build();
            Connection.On<object>("ReceiveData", data =>
            {
                Console.WriteLine($"ReceiveData:{data}");
            });
            Connection.StartAsync().Wait();
        }

        public async Task Publish(IScoreMachineState score)
        {
            var data = new
            {
                messageType = "ScoreMachine",

                clock = score.Clock.ToString(@"mm\:ss"),

                player1Score = score.Red.Score.ToString(),
                player1Card = score.Red.Cards.MapColor(),
                player1Light = score.Red.Lights.MapColor("red"),
                player1Priority = score.Red.Priority.ToString(),

                player2Score = score.Green.Score.ToString(),
                player2Card = score.Green.Cards.MapColor(),
                player2Light = score.Green.Lights.MapColor("green"),
                player2Priority = score.Green.Priority.ToString(),
            };
            Console.WriteLine($"Score Machine: {score}");
            await SendData(data);
        }

        private async Task SendData(object data)
        {
            await Connection.InvokeAsync("SendData", data);
        }
    }
}