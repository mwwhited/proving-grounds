using System.Net;

namespace OoBDev.ScoreMachine.Web.Core.Providers.ConfigurationManagement
{
    public class ConfigurationModel
    {
        public string WebHost { get; internal set; }
        public bool WebDisabled { get; internal set; }
        public string NeTvHost { get; internal set; }
        public string NeTvHub { get; internal set; }
        public int NeTvDelay { get; internal set; }
        public bool NeTvDisabled { get; internal set; }
        public IPAddress E810DtuAddress { get; internal set; }
        public int E810DtuPort { get; internal set; }
        public bool E810DtuDisabled { get; internal set; }
        public bool BusyLightDisabled { get; internal set; }
        public string H4nPort { get; internal set; }
        public bool H4nDisabled { get; internal set; }
        public string HdmiPort { get; internal set; }
        public bool HdmiDisabled { get; internal set; }
        public string HdmiOnRecord { get; internal set; }
        public string HdmiOnStopped { get; internal set; }
        public string HubUrl { get; internal set; }

        public override string ToString()
        {
            return this.As();
        }
    }
}
