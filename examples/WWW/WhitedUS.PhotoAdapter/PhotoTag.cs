using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Serialization;

namespace WhitedUS.PhotoAdapter
{
    [XmlRoot("photoTag")]
    public class PhotoTag
    {
        [XmlAttribute("name")]
        public string Name { get; set; }
        [XmlAttribute("count")]
        public int Count { get; set; }
    }
}
