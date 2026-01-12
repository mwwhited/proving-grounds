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
    public partial class channel
    {

        public channel()
        {
            this.language = "en-us";
            this.docs = "http://blogs.law.harvard.edu/tech/rss";
            this.version = "2.0";
        }

        [XmlElementAttribute(Form = XmlSchemaForm.Unqualified)]
        public object title { get; set; }

        [XmlElementAttribute(Form = XmlSchemaForm.Unqualified)]
        public object link { get; set; }

        [XmlElementAttribute(Form = XmlSchemaForm.Unqualified)]
        public object description { get; set; }

        [XmlElementAttribute(Form = XmlSchemaForm.Unqualified)]
        [DefaultValueAttribute("en-us")]
        public string language { get; set; }

        [XmlElementAttribute(Form = XmlSchemaForm.Unqualified)]
        public object copyright { get; set; }

        [XmlElementAttribute(Form = XmlSchemaForm.Unqualified)]
        public object managingEditor { get; set; }

        [XmlElementAttribute(Form = XmlSchemaForm.Unqualified)]
        public object webMaster { get; set; }

        [XmlElementAttribute(Form = XmlSchemaForm.Unqualified)]
        public object pubDate { get; set; }

        [XmlElementAttribute(Form = XmlSchemaForm.Unqualified)]
        public object lastBuildDate { get; set; }

        [XmlElementAttribute(Form = XmlSchemaForm.Unqualified)]
        public object category { get; set; }

        [XmlElementAttribute(Form = XmlSchemaForm.Unqualified)]
        public object generator { get; set; }

        [XmlElementAttribute(Form = XmlSchemaForm.Unqualified)]
        public string docs { get; set; }

        [XmlElementAttribute(Form = XmlSchemaForm.Unqualified)]
        public channelCloud cloud { get; set; }

        [XmlElementAttribute(Form = XmlSchemaForm.Unqualified)]
        public object ttl { get; set; }

        [XmlElementAttribute(Form = XmlSchemaForm.Unqualified)]
        public channelImage image { get; set; }

        [XmlElementAttribute(Form = XmlSchemaForm.Unqualified)]
        public object rating { get; set; }

        [XmlElementAttribute(Form = XmlSchemaForm.Unqualified)]
        public channelTextInput textInput { get; set; }

        [XmlElementAttribute(Form = XmlSchemaForm.Unqualified)]
        public object skipHours { get; set; }

        [XmlElementAttribute(Form = XmlSchemaForm.Unqualified)]
        public object skipDays { get; set; }

        [XmlElementAttribute("item", Form = XmlSchemaForm.Unqualified)]
        public item[] item { get; set; }

        [XmlAttributeAttribute()]
        [DefaultValueAttribute("2.0")]
        public string version { get; set; }
    }
}
