using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel;
using System.Xml.Serialization;
using System.Diagnostics;

namespace WhitedUS.Data.RSS
{
    [SerializableAttribute()]
    [DebuggerStepThroughAttribute()]
    [DesignerCategoryAttribute("code")]
    [XmlTypeAttribute(AnonymousType = true, Namespace = "http://blogs.law.harvard.edu/RSS20.xsd")]
    public partial class itemSource
    {

        [XmlAttributeAttribute()]
        public string url { get; set; }
    }
}
