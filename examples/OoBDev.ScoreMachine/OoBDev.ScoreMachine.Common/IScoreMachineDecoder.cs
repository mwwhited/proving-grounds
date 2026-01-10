using System.Collections.Generic;
using System.IO;

namespace OoBDev.ScoreMachine.Common
{
    public interface IScoreMachineDecoder
    {
        IScoreMachineState Decode(StreamReader reader);
        IEnumerable<byte> GetFrame(StreamReader reader);
    }
}
