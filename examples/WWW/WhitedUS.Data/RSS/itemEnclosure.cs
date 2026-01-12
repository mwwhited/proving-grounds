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
    public partial class itemEnclosure
    {

        [XmlAttributeAttribute()]
        public string url { get; set; }

        [XmlAttributeAttribute()]
        public string length { get; set; }

        [XmlAttributeAttribute()]
        public string type { get; set; }
    }
}
