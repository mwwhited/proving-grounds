using OoBDev.ScoreMachine.Web.Core.Providers.ScoreMachine;

namespace OoBDev.ScoreMachine.Web.Core.Providers.SaintGeorge
{
    public class SgDecoder : IScoreMachineDecoder
    {
        public SgState Current { get; private set; }

        public IScoreMachineState Decode(byte[] packet, int offset)
        {
            return this.Current = SgState.Create(this.Current, packet);
        }
    }
}
