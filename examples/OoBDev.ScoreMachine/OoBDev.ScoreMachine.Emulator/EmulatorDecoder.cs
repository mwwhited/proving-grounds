using OoBDev.ScoreMachine.Common;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace OoBDev.ScoreMachine.Emulator
{
    public class EmulatorDecoder : IScoreMachineDecoder
    {

        private readonly Random rand = new Random();
        public IScoreMachineState Decode(StreamReader reader)
        {
            Task.Delay(500).Wait();
            return new EmulatorState
            {
                Clock = DateTime.Now.TimeOfDay,
                Red = new Fencer((byte)rand.Next(16), (Cards)rand.Next(16), (Lights)rand.Next(4), rand.Next(10) > 5),
                Green = new Fencer((byte)rand.Next(16), (Cards)rand.Next(16), (Lights)rand.Next(4), rand.Next(10) > 5),
            };
        }

        public IEnumerable<byte> GetFrame(StreamReader reader)
        {
            return Enumerable.Empty<byte>();
        }
    }
}
