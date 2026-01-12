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
    [XmlTypeAttribute(Namespace = "http://blogs.law.harvard.edu/RSS20.xsd")]
    public partial class item
    {

        [XmlElementAttribute(Form = XmlSchemaForm.Unqualified)]
        public string title { get; set; }

        [XmlElementAttribute(Form = XmlSchemaForm.Unqualified)]
        public string link { get; set; }

        [XmlElementAttribute(Form = XmlSchemaForm.Unqualified)]
        public string description { get; set; }

        [XmlElementAttribute(Form = XmlSchemaForm.Unqualified)]
        public string author { get; set; }

        [XmlElementAttribute("category", Form = XmlSchemaForm.Unqualified)]
        public itemCategory[] category { get; set; }

        [XmlElementAttribute(Form = XmlSchemaForm.Unqualified)]
        public string comments { get; set; }

        [XmlElementAttribute(Form = XmlSchemaForm.Unqualified)]
        public itemEnclosure enclosure { get; set; }

        [XmlElementAttribute(Form = XmlSchemaForm.Unqualified)]
        public string guid { get; set; }

        [XmlElementAttribute(Form = XmlSchemaForm.Unqualified)]
        public string pubDate { get; set; }

        [XmlElementAttribute(Form = XmlSchemaForm.Unqualified)]
        public itemSource source { get; set; }
    }
}
