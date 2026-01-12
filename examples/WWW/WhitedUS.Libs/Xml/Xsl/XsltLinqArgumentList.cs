using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Xml.Linq;
using System.Xml.XPath;
using System.Xml.Xsl;
using WhitedUS.Libs.Xml.Linq;

namespace WhitedUS.Libs.Xml.Xsl
{
    public class XsltLinqArgumentList
    {
        public XsltLinqArgumentList()
        {
            this.ExtensionObjects = new List<object>();
            this.Parameters = new Dictionary<string, object>();
            this.XmlParameters = new List<XElement>();
        }

        public List<object> ExtensionObjects { get; private set; }
        public Dictionary<string, object> Parameters { get; private set; }
        public List<XElement> XmlParameters { get; private set; }

        public XsltArgumentList CreateArgumentList()
        {
            var xsltArgumentList = new XsltArgumentList();
            AddExtensionObjects(xsltArgumentList);
            AddParameters(xsltArgumentList);
            AddXmlParameters(xsltArgumentList);
            return xsltArgumentList;
        }

        private void AddExtensionObjects(XsltArgumentList xsltArgumentList)
        {
            if (ExtensionObjects != null)
                foreach (var item in ExtensionObjects)
                {
                    var ns = item.ResolveNamespace();
                    Debug.WriteLine(ns);
                    xsltArgumentList.AddExtensionObject(ns, item);
                }
        }
        private void AddParameters(XsltArgumentList xsltArgumentList)
        {
            if (Parameters != null)
                foreach (var item in Parameters)
                {
                    var ns = item.Value.ResolveNamespace();
                    Debug.WriteLine(ns);
                    xsltArgumentList.AddParam(item.Key, ns, item.Value);
                }
        }
        private void AddXmlParameters(XsltArgumentList xsltArgumentList)
        {
            if (XmlParameters != null)
                foreach (var item in XmlParameters)
                {
                    Debug.WriteLine(item.Name.NamespaceName);
                    xsltArgumentList.AddParam(item.Name.LocalName,
                                              item.Name.NamespaceName,
                                              item.CreateNavigator());
                }
        }
    }
}
