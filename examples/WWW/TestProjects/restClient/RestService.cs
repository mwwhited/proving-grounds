using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Serialization;

namespace restClient
{
    [XmlRoot("service")]
    public class RestService
    {
        [XmlAttribute("name")]
        public string Name { get; set; }
        [XmlAttribute("returnType")]
        public string ReturnTypeName { get; set; }
        [XmlAttribute("contentType")]
        public string ContentTypeName { get; set; }
        [XmlAttribute("description")]
        public string Description { get; set; }
        [XmlElement("invoke")]
        public InvokeDetails Details { get; set; }
        [XmlElement("Parameters")]
        public ParameterSet Parameters { get; set; }

        public override string ToString()
        {
            return this.Name ?? base.ToString();
        }
    }
}
