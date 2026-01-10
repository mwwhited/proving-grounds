using Microsoft.AspNetCore;
using Microsoft.AspNetCore.Hosting;
using OoBDev.ScoreMachine.Web.Core.Providers.IO;
using System.Threading;
using System.Threading.Tasks;

namespace OoBDev.ScoreMachine.Web.Core.Providers.Hosting
{
    public class HostingProvider : IProvider
    {
        public string Url { get; }
        public string[] Arguments { get; }

        private IWebHost _host;
        public IWebHost Host
        {
            get { return _host ?? (_host = BuildWebHost(Arguments, Url)); }
        }

        public HostingProvider(string url, params string[] arguments)
        {
            this.Url = url;
            this.Arguments = arguments;
        }

        public Task Start(CancellationTokenSource cts)
        {
            return StartWeb(Arguments, Url, cts);
        }

        public T GetService<T>()
        {
            return (T)this.Host.Services.GetService(typeof(T));
        }

        private Task StartWeb(string[] args, string url, CancellationTokenSource cts) =>
            Task.Run(async () =>
            {
                await Host.RunAsync();
                cts.Cancel(false);
            });
        private IWebHost BuildWebHost(string[] args, params string[] urls) =>
            WebHost.CreateDefaultBuilder()                
                .UseStartup<Startup>()
                .UseKestrel()
                .UseUrls(urls)
                .Build();
    }
}
