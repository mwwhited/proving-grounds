using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Serialization;

namespace restClient
{
    [XmlRoot("services")]
    public class RestServiceSet
    {
        public RestServiceSet()
        {
            this.Services = new List<RestService>();
        }
        [XmlElement("service")]
        public List<RestService> Services { get; set; }
    }
}
