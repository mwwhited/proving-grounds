using System.Collections.Generic;
using System.Xml;
using System.Xml.Serialization;

namespace WhitedUS.ChattyClient
{
    [XmlRoot("messages")]
    public class Messages
    {
        public Messages()
        {
            this.Items = new List<Message>();
        }

        [XmlElement("message")]
        public List<Message> Items { get; set; }

        [XmlAttribute("result")]
        public bool Result { get; set; }
        [XmlElement("exception")]
        public string Exception { get; set; }
    }
}
