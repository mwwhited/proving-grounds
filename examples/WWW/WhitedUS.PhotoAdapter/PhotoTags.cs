using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Serialization;

namespace WhitedUS.PhotoAdapter
{
    [XmlRoot("tags")]
    public class PhotoTags
    {
        public PhotoTags()
        {
            this.Tags = new List<PhotoTag>();
            this.Images = new List<PhotoImage>();
        }

        [XmlAttribute("name")]
        public string Name { get; set; }
        [XmlAttribute("path")]
        public string Path { get; set; }
        [XmlAttribute("hash")]
        public string Hash { get; set; }

        [XmlElement("tag")]
        public List<PhotoTag> Tags { get; set; }
        [XmlElement("image")]
        public List<PhotoImage> Images { get; set; }
    }
}