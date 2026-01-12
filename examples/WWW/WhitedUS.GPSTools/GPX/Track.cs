using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;
using System.Xml.Serialization;

namespace WhitedUS.GPSTools.GPX
{
    [XmlRoot("trk", Namespace = GPXGlobals.DefaultNameSpace)]
    public class Track
    {
        [XmlElement("name", Namespace = GPXGlobals.DefaultNameSpace)]
        public string Name { get; set; }

        [XmlElement("extensions", Namespace = GPXGlobals.DefaultNameSpace)]
        public XmlElement Extensions { get; set; }

        [XmlElement("trkseg", Namespace = GPXGlobals.DefaultNameSpace)]
        public TrackSegment TrackSegment { get; set; }
    }
}
