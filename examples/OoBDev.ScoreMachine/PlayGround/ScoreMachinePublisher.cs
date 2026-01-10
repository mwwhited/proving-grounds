//using Microsoft.AspNetCore.SignalR.Client;
//using Newtonsoft.Json.Linq;
//using System;
//using System.Threading.Tasks;

//namespace OoBDev.ScoreMachine.Web.Core.Providers.ScoreMachine
//{
//    public class ScoreMachinePublisher : IScoreMachinePublisher
//    {
//        private readonly string _hubUrl;
//        private HubConnection _connection;
//        private HubConnection Connection
//        {
//            get
//            {
//                if (_connection == null ||_connection.State != HubConnectionState.Connected)
//                {
//                    var connection = new HubConnectionBuilder()
//                        .WithUrl($"{_hubUrl.TrimEnd('/')}/ScoreMachineHub")
//                        .Build();
//                    connection.StartAsync().Wait();
//                    _connection = connection;
//                }
//                return _connection;
//            }
//        }

//        public ScoreMachinePublisher(string hubUrl)
//        {
//            _hubUrl = hubUrl;
//        }
                                  
//        public async Task Publish(IScoreMachineState state)
//        {
//            var json = Translate(state);
//            Console.WriteLine($"Score Machine: {state}");
//            await SendData(json);
//        }

//        private async Task SendData(object data)
//        {
//            await Connection.InvokeAsync("SendData", data);
//        }

//        public JObject Translate(IScoreMachineState score)
//        {
//            var data = new
//            {
//                messageType = "ScoreMachine",

//                clock = score.Clock.ToString(@"mm\:ss"),

//                player1Score = score.Red.Score.ToString(),
//                player1Card = score.Red.Cards.MapColor(),
//                player1Light = score.Red.Lights.MapColor("red"),
//                player1Priority = score.Red.Priority.ToString(),

//                player2Score = score.Green.Score.ToString(),
//                player2Card = score.Green.Cards.MapColor(),
//                player2Light = score.Green.Lights.MapColor("green"),
//                player2Priority = score.Green.Priority.ToString(),
//            };
//            Console.WriteLine($"Score Machine: {score}");
//            return JObject.FromObject(data);
//        }
//    }
//}