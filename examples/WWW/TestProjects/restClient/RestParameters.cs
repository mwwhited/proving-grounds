using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Serialization;

namespace restClient
{
    [XmlRoot("parameter")]
    public class RestParameters
    {
        [XmlAttribute("name")]
        public string Name { get; set; }
        [XmlAttribute("type")]
        public string TypeName { get; set; }
        [XmlAttribute("position")]
        public int Position { get; set; }
        public override string ToString()
        {
            return this.Name ?? base.ToString();
        }
    }
}
