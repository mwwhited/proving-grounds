using OoBDev.ScoreMachine.Web.Core.Hubs;
using OoBDev.ScoreMachine.Web.Core.Providers.SaintGeorge;
using OoBDev.ScoreMachine.Web.Core.Providers.ScoreMachine;
using OoBDev.ScoreMachine.Web.Core.Providers.Threading;
using System;
using System.Linq;
using System.Collections.Generic;
using System.Net.Sockets;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace OoBDev.ScoreMachine.Web.Core.Providers.EbyteE810Dtu
{
    public class ClientProcessor
    {
        private readonly NetworkStream _networkStream;
        private readonly string _hubUrl;
        private readonly IScoreMachinePublisher _scorePublisher;
        private readonly SgBufferedDecoder _bufferedScore;

        public ClientProcessor(NetworkStream networkStream, string hubUrl)
        {
            this._networkStream = networkStream;
            this._hubUrl = hubUrl;

            this._scorePublisher = new ScoreMachinePublisher(hubUrl);
            _bufferedScore = new SgBufferedDecoder(OnFrame);
        }

        private ulong _errorFrameCount = 0;
        private ulong _totalFrameCount = 0;
        private readonly object _smLock = new object();
        private readonly AsyncLock _lock = new AsyncLock();

        private async Task OnFrame(byte[] frames)
        {
            using (await _lock.LockAsync())
                foreach (var item in frames.Chunk(0x04, false).Select((i, v) => new { i, v }))
                {
                    var temp = item.i;
                    var segment = new ArraySegment<byte>(temp, 1, temp.Length - 2);
                    var frame = segment.ToArray();
                    _totalFrameCount++;
                    try
                    {
                        if (_totalFrameCount % 100 == 0) Console.WriteLine($"ClientProcessor::OnFrame:Frames Processed: {_totalFrameCount}-{_errorFrameCount}");
                        var decoded = _sgDecode.Decode(frame, 0);
                        if (decoded != null && !decoded.Equals(_lastScore))
                        {
                            await _scorePublisher.Publish(decoded);
                            _lastScore = decoded;
                        }
                    }
                    catch (Exception exi)
                    {
                        _errorFrameCount++;
                        var lossRate = ((double)_errorFrameCount / _totalFrameCount) * 100;
                        Console.Error.WriteLine($"ClientProcessor::OnFrame:Error::({lossRate}) \"{exi.Message}\" - [{Convert.ToBase64String(frame)}]");
                        Console.Error.WriteLine($"ClientProcessor::OnFrame:Detail:: {string.Join("~", frame.Select(b => b < (byte)' ' ? ((ControlCharacters)b).ToString() : b.ToString("x2")))}");
                        Console.Error.WriteLine($"ClientProcessor::OnFrame:{item.v}:: {string.Join("~", frames.Select(b => b < (byte)' ' ? ((ControlCharacters)b).ToString() : b.ToString("x2")))}");
                    }
                }
        }
        private IEnumerable<byte[]> SplitFrames(byte[] frame)
        {
            var buffer = new List<byte>();
            foreach (var b in frame)
            {
                if (b == 0x13)
                {
                    var capture = buffer.ToArray();
                    buffer.Clear();
                    if (capture.Length > 0)
                    {
                        yield return capture;
                    }
                }
                buffer.Add(b);
            }

            if (buffer.Count > 0)
            {
                yield return buffer.ToArray();
            }
        }

        private IScoreMachineState _lastScore;
        private bool _lastRecording;
        private bool _polling;
        public DeviceTypes Type { get; private set; }

        public enum DeviceTypes
        {
            Unknown,
            ScoreMachine,
            Lanc,
        }

        public async Task Start(CancellationTokenSource cts)
        {
            while (!cts.IsCancellationRequested)
            {
                try
                {
                    while (_networkStream.CanWrite && Type == DeviceTypes.Lanc && _polling && !cts.IsCancellationRequested)
                    {
                        for (var i = 0; i < 10 && !cts.IsCancellationRequested; i++)
                        {
                            var command = (byte)(_lastRecording ? 0x52 : 0x53);
                            _networkStream.WriteByte(command);
                            await _networkStream.FlushAsync();
                            await TaskEx.Delay(10, cts);
                        }
                        await TaskEx.Delay(100, cts);
                    }
                    if (Type == DeviceTypes.ScoreMachine)
                    {
                        break;
                    }
                    await TaskEx.Delay(100, cts);
                }
                catch (Exception ex)
                {
                    await Console.Error.WriteLineAsync($"ClientProcessor:ERROR:{ex}");
                }
            }
        }

        public async Task MessageReceived(byte[] message)
        {
            try
            {
                if (message[0] == 0x56) //prefix == "V1" /*Recorder*/ || prefix == "V2" /*Camera*/)
                {
                    Type = DeviceTypes.Lanc;

                    var decoded = Encoding.UTF8.GetString(message, 0, message.Length).Trim('\r', '\n');

                    var recording = ScoreMachineHub.Recording;
                    var status = Encoding.UTF8.GetString(message, 2, message.Length - 2).Trim('\r', '\n');

                    if (recording && message[2] != 0x52) // !status.StartsWith("RECORDING"))
                    {
                        _polling = true;
                    }
                    else if (!recording && message[2] == 0x52) // status.StartsWith("RECORDING"))
                    {
                        _polling = true;
                    }
                    else
                    {
                        _polling = false;
                    }
                    _lastRecording = recording;
                }
                else if (message[0] == 0x53 && message[1] == 0x4d) /*SM*/
                {
                    await _bufferedScore.AppendMessage(message, 2);
                }

                await Task.FromResult(0);
            }
            catch (Exception ex)
            {
                Console.Error.WriteLine($"ClientProcessor::MessageReceived:{ex.Message}:: \"{Convert.ToBase64String(message)}\"");
                throw;
            }
        }

        private SgDecoder _sgDecode = new SgDecoder();
    }
}