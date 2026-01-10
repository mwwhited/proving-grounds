using OoBDev.ScoreMachine.Common;
using OoBDev.ScoreMachine.Emulator;
using OoBDev.ScoreMachine.Favero;
using OoBDev.ScoreMachine.SG;
using System;
using System.Configuration;
using System.IO;
using System.IO.Ports;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace OoBDev.ScoreMachine.Manager.Providers
{
    public class ScoreMachineReader
    {
        public async Task Start(CancellationTokenSource cts, Action<IScoreMachineState> onChange)
        {
            var token = cts.Token;

            var decoder = GetDecoder();
            await Start(decoder, cts.Token, s =>
            {
                // Tracing.ScoreMachine.TraceInformation($"{s}");
                onChange(s);
            });
        }

        private IScoreMachineDecoder GetDecoder()
        {
            var model = ConfigurationManager.AppSettings["ScoreMachine.Model"];
            switch (model)
            {
                case "None":
                    return null;
                case "SG":
                    return new SgDecoder();
                case "Emulator":
                    return new EmulatorDecoder();
                case "Favero":
                // return new FaveroDecoder();
                default:
                    throw new NotSupportedException($"{model} is not supported");
            }
        }

        private bool UseSerial(IScoreMachineDecoder decoder)
        {
            var type = decoder.GetType();
            var useSerial = type.GetCustomAttributes(false).OfType<UseSerialAttribute>().FirstOrDefault() != null;
            return useSerial;
        }

        private Task Start(IScoreMachineDecoder decoder, CancellationToken token, Action<IScoreMachineState> onChange)
        {
            try
            {
                var serial = UseSerial(decoder);
                var portName = serial ? ConfigurationManager.AppSettings["ScoreMachine.Serial.PortName"] : null;
                var baudRate = serial ? int.Parse(ConfigurationManager.AppSettings["ScoreMachine.Serial.BaudRate"] ?? "9600") : 9600;
                var port = serial ? new SerialPort(portName, baudRate, Parity.None, 8, StopBits.One) : null;
                if (!port?.IsOpen ?? false)
                    port?.Open();
                var reader = serial && (port?.IsOpen ?? false) ? new StreamReader(port.BaseStream) : null;
                try
                {
                    IScoreMachineState last = null;
                    while (!token.IsCancellationRequested)
                    {
                        var next = decoder.Decode(reader);
                        if (!(next?.Equals(last) ?? true))
                        {
                            // post score data and send to signalr client
                            onChange(next);
                        }
                        last = next;
                    }
                }
                finally
                {
                    port?.Dispose();
                    reader?.Dispose();
                }
            }
            catch (Exception ex)
            {
                Console.Error.WriteLine(ex);
            }
            return Task.FromResult(0);
        }
    }
}
