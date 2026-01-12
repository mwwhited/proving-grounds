using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Serialization;

namespace WhitedUS.PhotoAdapter
{
    [XmlRoot("photo")]
    public class Photo
    {
        [XmlAttribute("name")]
        public string Name { get; set; }
        [XmlAttribute("path")]
        public string Path { get; set; }
        [XmlAttribute("hash")]
        public Guid Hash { get; set; }
    }
}
