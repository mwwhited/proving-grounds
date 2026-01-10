using OoBDev.ScoreMachine.Web.Core.Providers.SaintGeorge;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reactive;
using System.Reactive.Linq;

namespace PlayGround
{

    class Program
    {
        static void Main(string[] args)
        {
            var scores = Observer.Create<SgState>(
                s => Console.WriteLine(s),
                () => Console.WriteLine("Completed Scores")
                );

            var state = SgState.Empty;
            var messages = Observer.Create<byte[]>(
                p => scores.OnNext(state = (p.Length <= 2 ? state : SgState.Create(state, new ArraySegment<byte>(p, 1, p.Length - 2).ToArray()))),
                () => Console.WriteLine("Completed Messages")
                );

            var buffer = new List<byte>();
            var packets = File.OpenRead("outfile.bin")
                               .ToObservable()
                               .Subscribe(i =>
                               {
                                   buffer.Add(i);
                                   if (i == 0x04)
                                   {
                                       messages.OnNext(buffer.ToArray());
                                       buffer.Clear();
                                   }
                               }, () => Console.WriteLine("Completed File"));

            Console.WriteLine("Poof!");
            Console.Read();
        }

    }
}
