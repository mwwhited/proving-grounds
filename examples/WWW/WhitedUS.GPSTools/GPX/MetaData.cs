using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Serialization;

namespace WhitedUS.GPSTools.GPX
{
    [XmlRoot("metadata", Namespace = GPXGlobals.DefaultNameSpace)]
    public class MetaData
    {
        [XmlElement("link", Namespace = GPXGlobals.DefaultNameSpace)]
        public Link Link { get; set; }
        [XmlElement("time", Namespace = GPXGlobals.DefaultNameSpace)]
        public string Time { get; set; }
        [XmlElement("bounds", Namespace = GPXGlobals.DefaultNameSpace)]
        public MetaDataBounds Bounds { get; set; }
    }
}
