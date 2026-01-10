using System;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace OoBDev.ScoreMachine.NetTv.Core
{
    class Program
    {
        static void Main(string[] args)
        {
            var netv = args.Where(a => a.StartsWith("-n") || a.StartsWith("--netv"))
                           .Select(a => a.Split(new char[] { '=' }, 2).Skip(1).FirstOrDefault())
                           .FirstOrDefault();
            Console.WriteLine($"NeTV: {netv}");

            var hub = args.Where(a => a.StartsWith("-h") || a.StartsWith("--hub"))
                           .Select(a => a.Split(new char[] { '=' }, 2).Skip(1).FirstOrDefault())
                           .FirstOrDefault();
            Console.WriteLine($"Hub: {hub}");

            var isDebug = args.Where(a => a.StartsWith("-d") || a.StartsWith("--debug")).Any();
            Console.WriteLine($"IsDebug: {isDebug}");

            var netvProvider = new NeTvProvider();
            Console.WriteLine("NeTV Starting");

            var ts = new CancellationTokenSource();
            Console.WriteLine($"Client Connecting");
            netvProvider.ConnectClient(netv, "root", "", ts.Token, async t =>
            {
                Console.WriteLine($"NeTvProvider.Initializing");
                var result = await netvProvider.Initialize(netv, hub);
                Console.WriteLine($"NeTvProvider.Initialize::{result}");
            }, isDebug).Wait();
            Console.WriteLine($"Client Connected");

            if (isDebug)
            {
                Console.WriteLine("waiting to end");
                Console.ReadLine();
            }
        }
    }
}
