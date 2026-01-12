using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Serialization;

namespace WhitedUS.Data.RSS
{
    [SerializableAttribute()]
    [XmlTypeAttribute(AnonymousType = true, Namespace = "http://blogs.law.harvard.edu/RSS20.xsd")]
    public enum channelCloudProtocol
    {

        [XmlEnumAttribute("xml-rpc")]
        xmlrpc,
        soap,
    }
}
