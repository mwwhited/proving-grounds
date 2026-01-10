using System;
using System.Net;
using System.Runtime.InteropServices;

namespace OoBDev.ScoreMachine.Web.Core.Providers.ConfigurationManagement
{
    public class ConfigurationFactory
    {
        public ConfigurationModel Load()
        {
            return new ConfigurationModel
            {
                WebHost = "SM_WEBHOST".FromEnvironment("http://0.0.0.0:5000"),
                //WebCors = "SM_WEBCORS".FromEnvironment("*"),
                WebDisabled = "SM_WEBHOST".FromEnvironment().Is("Disabled"),

                HubUrl = "SM_HUB".FromEnvironment("http://localhost:5000"),

                NeTvHost = "SM_NETVHOST".FromEnvironment("http://10.0.88.1"),
                NeTvHub = "SM_NETVHUB".FromEnvironment("http://10.0.88.4:5000"),
                NeTvDelay = "SM_NETVDELAY".FromEnvironment().As(5000),
                NeTvDisabled = "SM_NETVHOST".FromEnvironment().Is("Disabled"),

                E810DtuAddress = "SM_E810HOST".FromEnvironment().As(IPAddress.Any),
                E810DtuPort = "SM_E810PORT".FromEnvironment().As(8886),
                E810DtuDisabled = "SM_E810HOST".FromEnvironment().Is("Disabled"),

                BusyLightDisabled = "SM_BUSYLIGHT".FromEnvironment().Is("Disabled"),

                //Bus 001 Device 013: ID 067b:2303 Prolific Technology, Inc. PL2303 Serial Port
                // 2400 8n1
                H4nPort = "SM_H4NPORT".FromEnvironment().OrByOsPlatform(new[]
                {
                    (OSPlatform.Windows, "COM20"),
                    (OSPlatform.Linux, "/dev/ttyUSB0"),
                }),
                H4nDisabled = "SM_H4NPORT".FromEnvironment().Is("Disabled"),

                // Bus 001 Device 016: ID 1a86:7523 QinHeng Electronics HL-340 USB-Serial adapter
                // 9600 8n1
                HdmiPort = "SM_HDMIPORT".FromEnvironment().OrByOsPlatform(new[]
                {
                    (OSPlatform.Windows, "COM19"),
                    (OSPlatform.Linux, "/dev/ttyUSB1"),
                }),
                HdmiOnRecord = "SM_HDMIRECORD".FromEnvironment("HDMI1"),
                HdmiOnStopped = "SM_HDMISTOPPED".FromEnvironment("HDMI2"),
                HdmiDisabled = "SM_HDMIPORT".FromEnvironment().Is("Disabled"),
            };
        }
    }
}
