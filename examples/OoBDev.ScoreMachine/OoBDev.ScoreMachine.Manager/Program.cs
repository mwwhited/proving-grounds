using OoBDev.ScoreMachine.Manager.Extensions;
using System;
using System.Threading;

namespace OoBDev.ScoreMachine.Manager
{
    class Program
    {
        private static readonly string AppID = "E648DFA6-FBFC-4A55-B3D2-06BBFBB9A69E";

        static void Main(string[] args)
        {
            using (var mutex = new Mutex(false, $"Global\\{AppID}"))
                if (!mutex.WaitOne(0, false))
                {
                    Console.Error.WriteLine("App Already Running");
                }
                else
                {
                    new CancellationTokenSource()
                        .StartAll(
                        Launch.PressEscape,
                        Launch.Notice,
                        Launch.ScoreMachine
                        ).WaitAll();
                }
        }
    }
}
