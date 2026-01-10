using Microsoft.Extensions.DependencyInjection;
using OoBDev.ScoreMachine.Web.Core.Providers.Busylight;
using OoBDev.ScoreMachine.Web.Core.Providers.ConfigurationManagement;
using OoBDev.ScoreMachine.Web.Core.Providers.EbyteE810Dtu;
using OoBDev.ScoreMachine.Web.Core.Providers.HdmiSwitch;
using OoBDev.ScoreMachine.Web.Core.Providers.Hosting;
using OoBDev.ScoreMachine.Web.Core.Providers.NeTv;
using OoBDev.ScoreMachine.Web.Core.Providers.ZoomH4N;
using System;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace OoBDev.ScoreMachine.Web.Core
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var configFactory = new ConfigurationFactory();
            Console.WriteLine("Configuration Loading");
            var config = configFactory.Load();
            Console.WriteLine("Configuration Loaded");
            Console.WriteLine(config);

            var hosting = new HostingProvider(config.WebHost, args);
            var e810Dtu = new EbyteE810DtuProvider(config.E810DtuAddress, config.E810DtuPort, config.HubUrl);
            var neTv = new NeTvProvider(config.NeTvHost, config.NeTvHub, config.NeTvDelay);
            var busyLight = new BusylightProvider();
            var h4n = new H4nProvider(config.H4nPort);
            var hdmi = new HdmiSwitchProvider(config.HdmiPort, config.HdmiOnRecord, config.HdmiOnStopped);

            using (var cts = new CancellationTokenSource())
            {
                var providers = new[] {
                    config.WebDisabled ? null : hosting.Start(cts),
                    config.NeTvDisabled ? null : neTv.Start(cts),
                    config.E810DtuDisabled ? null : e810Dtu.Start(cts),
                    config.BusyLightDisabled ? null : busyLight.Start(cts),
                    config.H4nDisabled ? null : h4n.Start(cts),
                    config.HdmiDisabled ? null : hdmi.Start(cts),
                }.Where(i => i != null).ToArray();
                Task.WaitAll(providers);
            }
        }
    }
}
