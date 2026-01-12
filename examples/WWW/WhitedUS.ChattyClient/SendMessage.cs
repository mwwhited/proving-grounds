using System.Xml.Serialization;

namespace WhitedUS.ChattyClient
{
    [XmlRoot("SentTo")]
    public class SendMessage
    {
        public string From { get; set; }
        public string Message { get; set; }
    }
}
