using System;
using System.Diagnostics;
using System.IO;
using System.Xml;
using System.Xml.Linq;
using System.Xml.XPath;
using System.Xml.Serialization;

namespace WhitedUS.Libs.Xml.Xsl
{
    public class ExtensionObjectToolSet : INamespaceResolvable
    {
        public string Name { get; set; }

        //XPathNodeIterator
        public bool WriteXml(XPathNodeIterator input, string filename)
        {
            try
            {
                using (var writer = new StreamWriter(filename))
                using (var xmlWriter = XmlWriter.Create(writer))
                    if (input.MoveNext())
                        input.Current.WriteSubtree(xmlWriter);
                    else
                        return false;

                return true;
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex);
                return false;
            }
        }

        public Func<XElement, bool> OnProcessElement { get; set; }
        public bool ProcessElement(XPathNodeIterator input)
        {
            if (OnProcessElement == null)
                return false;

            try
            {
                var node = input.Clone();
                using (var memory = new MemoryStream())
                    if (node.MoveNext())
                    {
                        using (var xmlWriter = XmlWriter.Create(memory,
                                                                new XmlWriterSettings()
                                                                {
                                                                    CloseOutput = false
                                                                }))
                            node.Current.WriteSubtree(xmlWriter);

                        memory.Position = 0;

                        using (var xmlReader = XmlReader.Create(memory,
                                                                new XmlReaderSettings()
                                                                {
                                                                    CloseInput = false
                                                                }))
                        {
                            var xml = XElement.Load(xmlReader);
                            return OnProcessElement(xml);
                        }
                    }
                    else
                        return false;
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex);
                return false;
            }
        }

        public Func<XPathNodeIterator, bool> OnProcessXPathNode { get; set; }
        public bool ProcessXPathNode(XPathNodeIterator input)
        {
            if (OnProcessXPathNode == null)
                return false;

            try
            {
                return OnProcessXPathNode(input.Clone());
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex);
                return false;
            }
        }

        #region INamespaceResolvable Members

        public string ResolveNamespace()
        {
            const string ns = "http://www.whited.us/2010/XSL/ExtensionObjectToolSet";

            if (string.IsNullOrEmpty(Name))
                return ns;

            return ns + '/' + Name;
        }

        #endregion
    }
}
