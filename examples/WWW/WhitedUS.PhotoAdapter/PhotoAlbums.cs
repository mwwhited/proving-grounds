using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Serialization;

namespace WhitedUS.PhotoAdapter
{
    [XmlRoot("photoAlbums")]
    public class PhotoAlbums
    {
        public PhotoAlbums()
        {
            this.Albums = new List<PhotoAlbum>();
            this.Tags = new List<PhotoTag>();
            this.Photos = new List<Photo>();
        }

        [XmlAttribute("parent")]
        public string Parent { get; set; }
        [XmlAttribute("skip")]
        public int Skip { get; set; }
        [XmlAttribute("take")]
        public int Take { get; set; }
        [XmlAttribute("total")]
        public int Total { get; set; }
        [XmlAttribute("method")]
        public string Method { get; set; }

        [XmlElement("photoAlbum")]
        public List<PhotoAlbum> Albums { get; set; }
        [XmlElement("photoTag")]
        public List<PhotoTag> Tags { get; set; }
        [XmlElement("photo")]
        public List<Photo> Photos { get; set; }
    }
}
