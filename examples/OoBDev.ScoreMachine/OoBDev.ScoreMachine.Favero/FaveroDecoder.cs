using OoBDev.ScoreMachine.Common;
using System;
using System.Collections.Generic;
using System.IO;

namespace OoBDev.ScoreMachine.Favero
{
    public class FaveroDecoder : IScoreMachineDecoder
    {
        public IScoreMachineState Current { get; private set; }

        public IScoreMachineState Decode(StreamReader reader)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<byte> GetFrame(StreamReader reader)
        {
            throw new NotImplementedException();
        }
    }
}
