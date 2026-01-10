using OoBDev.ScoreMachine.Web.Core.Providers.IO;
using System;
using System.IO;
using System.IO.Ports;
using System.Linq;
using System.Runtime.InteropServices;
using System.Threading;
using System.Threading.Tasks;

namespace OoBDev.ScoreMachine.Web.Core.Providers.Serial
{
    public abstract class SerialPortProviderBase : IProvider
    {
        public string PortName { get; }
        public int BaudRate { get; }
        public int DataBits { get; }
        public Parity Parity { get; }
        public StopBits StopBits { get; }
        public int PollingPeriod { get; }

        public bool StopReading { get; protected set; }

        public SerialPortProviderBase(
            string portName,
            int baudRate,
            int dataBits = 8,
            Parity parity = Parity.None,
            StopBits stopBits = StopBits.One,
            int pollingPeriod = 100)
        {
            this.PortName = portName;
            this.BaudRate = baudRate;
            this.DataBits = dataBits;
            this.Parity = parity;
            this.StopBits = stopBits;
            this.PollingPeriod = pollingPeriod;
        }

        public async Task Start(CancellationTokenSource cts)
        {
            while (!cts.IsCancellationRequested)
            {
                try
                {
                    var realName = GetRealPortName();
                    if (!string.IsNullOrWhiteSpace(realName))
                    {
                        await OpenWindowsSerialPort(realName, cts);
                    }
                    else
                    {
                        await Console.Error.WriteLineAsync($"Device \"{PortName}\" not found");
                    }
                }
                catch (Exception ex)
                {
                    await Console.Error.WriteLineAsync($"{PortName}: {ex}");
                }
                await TaskEx.Delay(5000, cts);
            }
        }

        private string GetRealPortName()
        {
            if (RuntimeInformation.IsOSPlatform(OSPlatform.Windows))
            {
                return SerialPort.GetPortNames().FirstOrDefault(i => i.Equals(this.PortName, StringComparison.InvariantCultureIgnoreCase));
            }
            else
            {
                return this.PortName;
            }
        }

        private async Task OpenWindowsSerialPort(string serialPort, CancellationTokenSource cts)
        {
            using (var sp = new SerialPort(serialPort, BaudRate, Parity, DataBits, StopBits))
                if (!sp.IsOpen)
                {
                    sp.Open();
                    var stream = sp.BaseStream;
                    await WorkOnStream(stream, cts, () => sp.BytesToRead > 0, () => sp.BytesToRead);
                }
                else
                {
                    await Console.Error.WriteLineAsync($"Device \"{PortName}\" could not open");
                }
        }

        private async Task WorkOnStream(Stream stream, CancellationTokenSource cts, Func<bool> hasBytes, Func<int> bytesToRead)
        {
            await Task.WhenAll(
                Task.Run(async () =>
                {
                    while (!cts.IsCancellationRequested)
                    {
                        while (!cts.IsCancellationRequested && !StopReading && hasBytes())
                        {
                            var buffer = new byte[128];
                            var len = await stream.ReadAsync(buffer, 0, buffer.Length);
                            var readBuffer = new byte[len];
                            Array.Copy(buffer, readBuffer, len);
                            await this.Received(readBuffer, stream, cts);
                        }
                        await TaskEx.Delay(10, cts);
                    }
                }, cts.Token),
                Task.Run(async () =>
                {
                    while (!cts.IsCancellationRequested)
                    {
                        await this.Poll(stream, cts, bytesToRead);
                        await TaskEx.Delay(this.PollingPeriod, cts);
                    }
                }, cts.Token)
            );
        }

        protected abstract Task Poll(Stream stream, CancellationTokenSource cts, Func<int> bytesToRead);
        protected abstract Task Received(byte[] readBuffer, Stream stream, CancellationTokenSource cts);
    }
}
