using OoBDev.ScoreMachine.Manager.Extensions;
using OoBDev.ScoreMachine.Manager.Providers;
using System;
using System.Threading;
using System.Threading.Tasks;

namespace OoBDev.ScoreMachine.Manager
{
    public static class Launch
    {
        public static Task PressEscape(CancellationTokenSource cts)
        {
            try
            {
                var token = cts.Token;
                token.ThrowIfCancellationRequested();
                do
                {
                    Console.WriteLine("Press Escape to Exit");
                }
                while (Console.ReadKey().Key != ConsoleKey.Escape);
            }
            catch (Exception ex)
            {
                Console.Error.WriteLine(ex);
            }
            finally
            {
                cts.Cancel();
            }
            return Task.FromResult(0);
        }
        
        public static async Task ScoreMachine(CancellationTokenSource cts)
        {
            var sm = new ScoreMachineReader();
            await sm.Start(cts, score =>
            {
                var data = new
                {
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
                //await DataHub.Send(data);
            });
        }

        public static async Task Notice(CancellationTokenSource cts)
        {
            while (!cts.Token.IsCancellationRequested)
            {
                Console.WriteLine($"Still Running: {DateTime.Now}");
                await Task.Delay(10 * 1000);
            }
        }
    }
}
