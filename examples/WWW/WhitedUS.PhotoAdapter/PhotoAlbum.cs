using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Serialization;

namespace WhitedUS.PhotoAdapter
{
    [XmlRoot("photoAlbum")]
    public class PhotoAlbum
    {
        [XmlAttribute("name")]
        public string Name { get; set; }
        [XmlAttribute("path")]
        public string Path { get; set; }
    }
}
