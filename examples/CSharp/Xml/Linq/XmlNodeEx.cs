using System.Linq;
using System.Xml;
using System.Xml.Linq;

namespace Originations.DataProviders.Xml.Linq
{
    public static class XmlNodeEx
    {
        public static XElement ToXElement(this XmlNode node)
        {
            var xDoc = new XDocument();
            using (var xmlWriter = xDoc.CreateWriter())
                node.WriteTo(xmlWriter);
            return xDoc.Root;
        }
    }
}
