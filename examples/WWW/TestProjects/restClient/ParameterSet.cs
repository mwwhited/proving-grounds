using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Serialization;

namespace restClient
{
    [XmlRoot("Parameters")]
    public class ParameterSet
    {
        public ParameterSet()
        {
            this.Parameters = new List<RestParameters>();
        }
        [XmlElement("parameter")]
        public List<RestParameters> Parameters { get; set; }
    }
}
