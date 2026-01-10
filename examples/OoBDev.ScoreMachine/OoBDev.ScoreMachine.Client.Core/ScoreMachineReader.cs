using OoBDev.ScoreMachine.Common;
using System;
using System.Threading;
using System.Threading.Tasks;

namespace OoBDev.ScoreMachine.Client.Core
{
    public class ScoreMachineReader
    {
        protected IScoreMachineDecoder Decoder { get; }
        protected IScoreMachinePublisher Publisher { get; }

        public ScoreMachineReader(
            IScoreMachineDecoder decoder,
            IScoreMachinePublisher publisher
            )
        {
            this.Decoder = decoder;
            this.Publisher = publisher;
        }

        protected virtual Task<byte[]> GetData()
        {
            return Task.FromResult(new byte[0]);
        }

        public virtual async Task Start(CancellationToken token)
        {
            throw new NotImplementedException();
            //IScoreMachineState last = null;
            //while (!token.IsCancellationRequested)
            //{
            //    var data = await GetData();
            //    var next = Decoder.Decode(data);
            //    if (!(next?.Equals(last) ?? true))
            //    {
            //        await Publisher.Publish(next);
            //    }
            //    last = next;
            //}
        }
    }
}
