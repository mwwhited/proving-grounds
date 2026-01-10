using OoBDev.ScoreMachine.Web.Core.Hubs;
using OoBDev.ScoreMachine.Web.Core.Providers.Serial;
using System;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace OoBDev.ScoreMachine.Web.Core.Providers.HdmiSwitch
{
    public class HdmiSwitchProvider : SerialPortProviderBase
    {
        public HdmiSwitchProvider(string portName, string onRecord, string onStopped)
            : base(portName, 9600)
        {
            this.OnRecord = onRecord;
            this.OnStopped = onStopped;
        }

        public string OnRecord { get; }
        public string OnStopped { get; }

        protected override async Task Poll(Stream stream, CancellationTokenSource cts, Func<int> bytesToRead)
        {
            var target = ScoreMachineHub.Recording ? OnRecord : ScoreMachineHub.OtherVideo ?? OnStopped;
            if (!target.Is(Current))
            {
                var buffer = Encoding.ASCII.GetBytes(target);
                stream.Write(buffer, 0, buffer.Length);
            }
            await Task.FromResult(0);
        }

        public string Current { get; private set; }

        protected override async Task Received(byte[] readBuffer, Stream stream, CancellationTokenSource cts)
        {
            var received = Encoding.ASCII.GetString(readBuffer).Trim('\r', '\n').Split(';').FirstOrDefault(i => i.StartsWith("HDMI"));
            if (received != null && Current != received)
            {
                Console.WriteLine($"HDMI Switch: {Encoding.ASCII.GetString(readBuffer)}");
                Current = received;
            }
            await Task.FromResult(0);
        }
    }
}
