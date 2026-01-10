using Renci.SshNet;
using System;
using System.Net.Http;
using System.Text.RegularExpressions;
using System.Threading;
using System.Threading.Tasks;

namespace OoBDev.ScoreMachine.NetTv.Core
{
    public class NeTvProvider
    {
        public async Task<bool> Initialize(string netv, string hub)
        {
            var baseHttp = $"{netv}";
            var commands = new[]
            {
                $"{baseHttp}/bridge?cmd=enablessh",
                $"{baseHttp}/bridge?cmd=keepalive&value=off",
                $"{baseHttp}/bridge?cmd=seturl&value={Uri.EscapeDataString(hub)}",
            };
            var client = new HttpClient();
            var ret = await client.GetAsync(baseHttp);
            if (ret.IsSuccessStatusCode)
            {
                foreach (var cmd in commands)
                {
                    Console.WriteLine(cmd);
                    var res = await client.GetAsync(cmd);
                    var mesg = await res.Content.ReadAsStringAsync();
                    Console.WriteLine(mesg);
                    await Task.Delay(500);
                }
                return true;
            }
            return false;
        }

        class Handler
        {
            public Handler(SshClient client, ShellStream shell)
            {
                this.Client = client;
                this.Shell = shell;
            }
            public SshClient Client { get; }
            public ShellStream Shell { get; }
        }

        public async Task ConnectClient(string host, string user, string password, CancellationToken token, Func<CancellationToken, Task> onStarted, bool isDebug)
        {
            if (isDebug)
            {
                var cmds = new[]
                {
                    "/etc/init.d/chumby-netvbrowser stop",
                    "NeTVBrowser -qws -nomouse",
                };
                var client = new SshClient(host, user, password);
                client.Connect();
                var shell = client.CreateShellStream("NeTvCore", 160, 25, 800, 600, 1024);
                shell.DataReceived += (sender, e) =>
                {
                    Console.Write(System.Text.Encoding.UTF8.GetString(e.Data));
                };
                shell.ErrorOccurred += (sender, e) =>
                {
                    Console.Error.Write(e.Exception.Message);
                };
                var result = shell.Expect(new Regex(@":.*>#"), new TimeSpan(0, 0, 3));
                foreach (var cmd in cmds)
                {
                    Console.WriteLine($"SendCmd:{cmd}");
                    shell.WriteLine(cmd);
                    var cmdResult = shell.Expect(new Regex(@":.*>#"), new TimeSpan(0, 0, 3));
                    await Task.Delay(500);
                }
                var rToken = token.Register(r =>
                {
                    var h = r as Handler;
                    h.Shell.Dispose();
                    h.Client.Disconnect();
                    h.Client.Dispose();
                }, new Handler(client, shell));

                token = CancellationTokenSource.CreateLinkedTokenSource(token, rToken.Token).Token;
            }
            await onStarted(token);
        }
    }
}