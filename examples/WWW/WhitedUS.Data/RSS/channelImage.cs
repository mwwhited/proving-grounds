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
    public partial class channelImage
    {

        public channelImage()
        {
            this.width = ((decimal)(88m));
            this.height = ((decimal)(31m));
        }

        [XmlElementAttribute(Form = XmlSchemaForm.Unqualified)]
        public object url { get; set; }

        [XmlElementAttribute(Form = XmlSchemaForm.Unqualified)]
        public object title { get; set; }

        [XmlElementAttribute(Form = XmlSchemaForm.Unqualified)]
        public object link { get; set; }

        [XmlElementAttribute(Form = XmlSchemaForm.Unqualified)]
        public decimal width { get; set; }

        [XmlElementAttribute(Form = XmlSchemaForm.Unqualified)]
        public decimal height { get; set; }

        [XmlElementAttribute(Form = XmlSchemaForm.Unqualified)]
        public object description { get; set; }
    }
}
