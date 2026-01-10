using OoBDev.ScoreMachine.Client.Core;
using System;
using System.Linq;
using System.Threading;

namespace OoBDev.ScoreMachine.Emulator.Core
{
    class Program
    {
        static void Main(string[] args)
        {
            var hub = args.Where(a => a.StartsWith("-h") || a.StartsWith("--hub"))
                           .Select(a => a.Split(new char[] { '=' }, 2).Skip(1).FirstOrDefault())
                           .FirstOrDefault();
            Console.WriteLine($"Hub: {hub}");

            var scoreMachine = new ScoreMachineReader(new EmulatorDecoder(), new ScoreMachinePublisher(hub));
            var cts = new CancellationTokenSource();
            scoreMachine.Start(cts.Token).Wait();
        }
    }
}
