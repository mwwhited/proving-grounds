using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;
using System.Xml.Serialization;

namespace WhitedUS.GPSTools.GPX
{
    [XmlRoot("gpx", Namespace = GPXGlobals.DefaultNameSpace)]
    public class GPSExchange
    {
        public GPSExchange()
        {
            this.WayPoints = new List<WayPoint>();
        }

        [XmlAttribute("creator", Namespace = GPXGlobals.DefaultNameSpace)]
        public string Creator { get; set; }
        [XmlAttribute("version", Namespace = GPXGlobals.DefaultNameSpace)]
        public string Version { get; set; }

        [XmlElement("metadata", Namespace = GPXGlobals.DefaultNameSpace)]
        public MetaData MetaData { get; set; }

        [XmlElement("wpt", Namespace = GPXGlobals.DefaultNameSpace)]
        public List<WayPoint> WayPoints { get; set; }

        [XmlElement("trk", Namespace = GPXGlobals.DefaultNameSpace)]
        public Track Track { get; set; }
    }
}
