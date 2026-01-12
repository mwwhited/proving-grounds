using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Serialization;

namespace WhitedUS.GPSTools.GPX
{
    [XmlRoot("trkpt", Namespace = GPXGlobals.DefaultNameSpace)]
    public class TrackPoint
    {
        [XmlAttribute("lat", Namespace = GPXGlobals.DefaultNameSpace)]
        public float Latitude { get; set; }
        [XmlAttribute("lon", Namespace = GPXGlobals.DefaultNameSpace)]
        public float Longitude { get; set; }

        [XmlElement("ele", Namespace = GPXGlobals.DefaultNameSpace)]
        public float Elevation { get; set; }
        [XmlElement("time", Namespace = GPXGlobals.DefaultNameSpace)]
        public DateTime Time { get; set; }

        public override string ToString()
        {
            return string.Format("{0}, {1}, {2}", 
                                 this.Latitude, 
                                 this.Longitude, 
                                 this.Elevation);
        }
    }
}
