using System;
using System.Xml.Serialization;

namespace WhitedUS.ChattyClient
{
    [XmlRoot("client")]
    public class ChattyClient
    {
        public ChattyClient()
        {
            this.Port = 80;
            this.Host = "www.whited.us";
            this.BasePath = "AlphaSite/Services/ChattyRest.svc";
        }

        [XmlAttribute("host")]
        public string Host { get; set; }
        [XmlAttribute("port")]
        public int Port { get; set; }
        [XmlAttribute("basePath")]
        public string BasePath { get; set; }

        [XmlIgnore]
        public string Url
        {
            get
            {
                return string.Format("http://{0}:{1}/{2}",
                                     this.Host,
                                     this.Port,
                                     this.BasePath);
            }
        }

        #region IChattyClient Members

        public Ack SendTo(string to, string from, string message)
        {
            using (var proxy = new ChattyProxy(this.Url))
                return proxy.SendTo(to, from, message);
        }

        public Messages GetFor(string username)
        {
            return GetFor(username, null);
        }
        public Messages GetFor(string username, DateTime? sync)
        {
            return GetFor(username, sync ?? DateTime.MinValue);
        }
        public Messages GetFor(string username, DateTime sync)
        {
            using (var proxy = new ChattyProxy(this.Url))
                return proxy.GetFor(username, sync);
        }

        public Ack DeleteFor(string username)
        {
            return DeleteFor(username, null);
        }
        public Ack DeleteFor(string username, DateTime? sync)
        {
            return DeleteFor(username, sync ?? DateTime.MinValue);
        }
        public Ack DeleteFor(string username, DateTime sync)
        {
            using (var proxy = new ChattyProxy(this.Url))
                return proxy.DeleteFor(username, sync);
        }

        #endregion
    }
}
