using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;
using System.Xml.Serialization;

namespace WhitedUS.GPSTools.GPX
{
    [XmlRoot("wpt", Namespace = GPXGlobals.DefaultNameSpace)]
    public class WayPoint
    {
        [XmlAttribute("lat", Namespace = GPXGlobals.DefaultNameSpace)]
        public float Latitude { get; set; }
        [XmlAttribute("lon", Namespace = GPXGlobals.DefaultNameSpace)]
        public float Longitude { get; set; }
        [XmlElement("ele", Namespace = GPXGlobals.DefaultNameSpace)]
        public float Elevation { get; set; }
        [XmlElement("time", Namespace = GPXGlobals.DefaultNameSpace)]
        public DateTime Time { get; set; }
        [XmlElement("name", Namespace = GPXGlobals.DefaultNameSpace)]
        public string Name { get; set; }
        [XmlElement("cmt", Namespace = GPXGlobals.DefaultNameSpace)]
        public string Comment { get; set; }
        [XmlElement("desc", Namespace = GPXGlobals.DefaultNameSpace)]
        public string Description { get; set; }
        [XmlElement("sym", Namespace = GPXGlobals.DefaultNameSpace)]
        public string Symbol { get; set; }

        [XmlElement("extensions", Namespace = GPXGlobals.DefaultNameSpace)]
        public XmlElement Extensions { get; set; }

        public override string ToString()
        {
            return this.Name;
        }
    }
}
