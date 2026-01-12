using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Serialization;
using System.ComponentModel;
using System.Diagnostics;

namespace WhitedUS.Data.RSS
{
    [SerializableAttribute()]
    [DebuggerStepThroughAttribute()]
    [DesignerCategoryAttribute("code")]
    [XmlTypeAttribute(AnonymousType = true, Namespace = "http://blogs.law.harvard.edu/RSS20.xsd")]
    public partial class channelCloud
    {

        [XmlAttributeAttribute()]
        public string domain { get; set; }

        [XmlAttributeAttribute()]
        public string port { get; set; }

        [XmlAttributeAttribute()]
        public string path { get; set; }

        [XmlAttributeAttribute()]
        public string registerProcedure { get; set; }

        [XmlAttributeAttribute()]
        public channelCloudProtocol protocol { get; set; }

        [XmlIgnoreAttribute()]
        public bool protocolSpecified { get; set; }
    }
}
