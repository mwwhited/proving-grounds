using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Serialization;

namespace WhitedUS.GPSTools.GPX
{
    [XmlRoot("trkseg", Namespace = GPXGlobals.DefaultNameSpace)]
    public class TrackSegment
    {
        public TrackSegment()
        {
            this.Points = new List<TrackPoint>();
        }

        [XmlElement("trkpt", Namespace = GPXGlobals.DefaultNameSpace)]
        public List<TrackPoint> Points { get; set; }
    }
}
