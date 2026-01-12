using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel.Web;
using System.Text;
using System.Xml.Serialization;

namespace restClient
{
    [XmlRoot("invoke")]
    public class InvokeDetails
    {
        [XmlAttribute("uriTemplate")]
        public string UriTemplate { get; set; }
        [XmlAttribute("bodyStyle")]
        public WebMessageBodyStyle BodyStyle { get; set; }
        [XmlAttribute("responseFormat")]
        public WebMessageFormat ResponseFormat { get; set; }
        [XmlAttribute("requestFormat")]
        public WebMessageFormat RequestFormat { get; set; }
        [XmlAttribute("method")]
        public string Method { get; set; }

        public override string ToString()
        {
            return this.UriTemplate ?? base.ToString();
        }
    }
}
