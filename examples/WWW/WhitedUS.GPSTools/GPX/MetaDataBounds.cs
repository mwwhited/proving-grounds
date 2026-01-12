using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Serialization;

namespace WhitedUS.GPSTools.GPX
{
    [XmlRoot("bounds", Namespace = GPXGlobals.DefaultNameSpace)]
    public class MetaDataBounds
    {
        [XmlAttribute("maxlat", Namespace = GPXGlobals.DefaultNameSpace)]
        public float MaximumLatitude { get; set; }
        [XmlAttribute("maxlon", Namespace = GPXGlobals.DefaultNameSpace)]
        public float MaximumLongitude { get; set; }
        [XmlAttribute("minlat", Namespace = GPXGlobals.DefaultNameSpace)]
        public float MinimumLatitude { get; set; }
        [XmlAttribute("minlon", Namespace = GPXGlobals.DefaultNameSpace)]
        public float MinimumLongitude { get; set; }
    }
}
