using System.Xml.Serialization;

namespace WhitedUS.ChattyClient
{
    [XmlRoot("ack")]
    public class Ack
    {
        [XmlAttribute("result")]
        public bool Result { get; set; }
        [XmlAttribute("id")]
        public int ID { get; set; }

        [XmlElement("exception")]
        public string Exception { get; set; }
    }
}
