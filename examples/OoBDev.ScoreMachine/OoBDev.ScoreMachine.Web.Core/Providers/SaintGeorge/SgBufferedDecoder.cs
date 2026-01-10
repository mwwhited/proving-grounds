using System;
using System.Threading.Tasks;

namespace OoBDev.ScoreMachine.Web.Core.Providers.SaintGeorge
{
    public class SgBufferedDecoder
    {
        private readonly Func<byte[], Task> _onFrame;

        public SgBufferedDecoder(Func<byte[], Task> onFrame)
        {
            this._onFrame = onFrame;
        }

        public async Task AppendMessage(byte[] message, int offset)
        {
            var segment = new ArraySegment<byte>(message, 2, message.Length - 2);
            await _onFrame(segment.ToArray());
        }
    }
}
