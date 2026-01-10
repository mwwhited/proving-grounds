using OoBDev.ScoreMachine.Common;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace OoBDev.ScoreMachine.SG
{
    [UseSerial]
    public class SgDecoder : IScoreMachineDecoder
    {
        public SgState Current { get; private set; }

        public IScoreMachineState Decode(StreamReader reader)
        {
            var frame = this.GetFrame(reader).ToArray();
            var state = this.Current = SgState.Create(this.Current, frame);
            return state;
        }

        public IEnumerable<byte> GetFrame(StreamReader reader)
        {
            while (reader.Read() != 0x1) ; ///fast forward to next frame
            int dataPoint;
            while ((dataPoint = reader.Read()) >= 0)
            {
                if (dataPoint == 0x4) yield break;
                yield return (byte)dataPoint;
            }
        }
    }
}
