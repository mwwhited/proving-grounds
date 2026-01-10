using OoBDev.ScoreMachine.Web.Core.Providers.IO;
using System;
using System.Net.Http;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace OoBDev.ScoreMachine.Web.Core.Providers.NeTv
{

    public class NeTvProvider : IProvider
    {
        public NeTvProvider(string netv, string hub, int delay)
        {
            this.NeTv = netv;
            this.Hub = hub;
            this.Delay = delay;
        }

        public string NeTv { get; }
        public string Hub { get; }
        public int Delay { get; }

        public async Task<NeTvResult> Start(CancellationTokenSource cts)
        {
            Console.WriteLine($"NeTV Waiting: {this.Delay}");
            await TaskEx.Delay(this.Delay, cts);
            Console.WriteLine($"NeTV Loading:");

            var commands = new[]
            {
                $"{NeTv}/bridge?cmd=enablessh",
                $"{NeTv}/bridge?cmd=keepalive&value=off",
                $"{NeTv}/bridge?cmd=seturl&value={Uri.EscapeDataString(Hub)}",
            };
            var results = new StringBuilder();
            while (!cts.IsCancellationRequested)
            {
                try
                {

                    var client = new HttpClient();
                    var ret = await client.GetAsync(NeTv);
                    Console.WriteLine($"NeTV>: {NeTv}");
                    results.AppendLine($">{NeTv}");
                    if (ret.IsSuccessStatusCode)
                    {
                        foreach (var cmd in commands)
                        {
                            Console.WriteLine($"NeTV>: {cmd}");
                            results.AppendLine($">{cmd}");
                            var res = await client.GetAsync(cmd);
                            var mesg = await res.Content.ReadAsStringAsync();
                            Console.WriteLine($"NeTV<: {mesg}");
                            results.AppendLine($"<{mesg}");
                            await Task.Delay(1000);
                        }
                        return new NeTvResult
                        {
                            Success = true,
                            Message = results.ToString(),
                        };
                    }
                }
                catch (Exception ex)
                {
                    await Console.Error.WriteLineAsync($"NeTvProvider::Start: ERROR: {ex.Message}");
                    results.AppendLine($"NeTV: ERROR:{ex.Message}");
                    await TaskEx.Delay(500, cts);
                }
            }
            return new NeTvResult
            {
                Success = false,
                Message = results.ToString(),
            };
        }

        Task IProvider.Start(CancellationTokenSource cts)
        {
            return this.Start(cts);
        }
    }
}
