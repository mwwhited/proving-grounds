using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Serialization;

namespace WhitedUS.GPSTools.GPX
{
    [XmlRoot("link", Namespace = GPXGlobals.DefaultNameSpace)]
    public class Link
    {
        [XmlAttribute("href", Namespace = GPXGlobals.DefaultNameSpace)]
        public string HyperReference { get; set; }
        [XmlElement("text", Namespace = GPXGlobals.DefaultNameSpace)]
        public string Text { get; set; }

        public override string ToString()
        {
            return string.Format("{0} ({1})",
                                 this.Text,
                                 this.HyperReference).Trim();
        }
    }
}
