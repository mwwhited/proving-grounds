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
    [XmlRootAttribute(Namespace = "http://blogs.law.harvard.edu/RSS20.xsd", IsNullable = false)]
    public partial class rss
    {

        [XmlElementAttribute(Form = XmlSchemaForm.Unqualified)]
        public channel channel { get; set; }
    }

}
