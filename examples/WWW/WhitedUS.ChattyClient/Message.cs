using System;
using System.Xml.Serialization;

namespace WhitedUS.ChattyClient
{
    [XmlRoot("message")]
    public class Message
    {
        [XmlAttribute("to")]
        public string To { get; set; }
        [XmlAttribute("from")]
        public string From { get; set; }
        [XmlAttribute("id")]
        public int ID { get; set; }
        [XmlAttribute("ts")]
        public DateTime TimeStamp { get; set; }
        [XmlElement("body")]
        public string Body { get; set; }

        public override string ToString()
        {
            return string.Format("{0}: {1}",
                this.From,
                this.Body);
        }
    }
}
