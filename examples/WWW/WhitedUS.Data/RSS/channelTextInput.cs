using System;
using System.CodeDom.Compiler;
using System.ComponentModel;
using System.Diagnostics;
using System.Xml.Serialization;
using System.Xml.Schema;

namespace WhitedUS.Data.RSS
{
    [SerializableAttribute()]
    [DebuggerStepThroughAttribute()]
    [DesignerCategoryAttribute("code")]
    [XmlTypeAttribute(AnonymousType = true, Namespace = "http://blogs.law.harvard.edu/RSS20.xsd")]
    public partial class channelTextInput
    {

        [XmlElementAttribute(Form = XmlSchemaForm.Unqualified)]
        public object title { get; set; }

        [XmlElementAttribute(Form = XmlSchemaForm.Unqualified)]
        public object description { get; set; }

        [XmlElementAttribute(Form = XmlSchemaForm.Unqualified)]
        public object name { get; set; }

        [XmlElementAttribute(Form = XmlSchemaForm.Unqualified)]
        public object link { get; set; }
    }
}
