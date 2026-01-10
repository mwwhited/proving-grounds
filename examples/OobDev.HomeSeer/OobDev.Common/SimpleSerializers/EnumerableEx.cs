using System;
using System.Collections.Generic;
using System.Diagnostics.Contracts;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace OobDev.Common.SimpleSerializers
{
    public static class EnumerableEx
    {
        public static XNamespace NS { get; } = "http://schemas.outofbanddevelopment.com/SimpleSerializers/Enumerable/2015/06/v1";

        public static XElement ToSimpleXml(this IEnumerable<KeyValuePair<string, int>> items)
        {
            return new XElement(NS + "kvp",
                new XAttribute("t","int"),
                from item in items ?? Enumerable.Empty<KeyValuePair<string, int>>()
                select new XElement(NS + "r",
                    new XAttribute("k", item.Key ?? ""),
                    new XAttribute("v", item.Value)
                    )
                );
        }
        public static XElement ToSimpleXml(this IEnumerable<KeyValuePair<string, string>> items)
        {
            return new XElement(NS + "kvp",
                new XAttribute("t", "string"),
                from item in items ?? Enumerable.Empty<KeyValuePair<string, string>>()
                select new XElement(NS + "r",
                    new XAttribute("k", item.Key ?? ""),
                    new XAttribute("v", item.Value ?? "")
                    )
                );
        }

        public static IEnumerable<KeyValuePair<string, string>> ToKeyValuePair(this string simpleXmlString)
        {
            if (string.IsNullOrWhiteSpace(simpleXmlString))
                return Enumerable.Empty<KeyValuePair<string, string>>();

            var xml = XElement.Parse(simpleXmlString);
            return xml.ToKeyValuePair();
        }

        public static IEnumerable<KeyValuePair<string, string>> ToKeyValuePair(this XElement simpleXml)
        {
            if (simpleXml == null)
                return Enumerable.Empty<KeyValuePair<string, string>>();

            if (simpleXml.Name.Namespace != NS ||
                simpleXml.Name.LocalName != "kvp")
                throw new InvalidOperationException("Input must be KeyValuePair<string,string> set from SimpleSerializer");

            var query = from x in simpleXml.Elements(NS + "r")
                        select new KeyValuePair<string, string>((string)x.Attribute("k"), (string)x.Attribute("v"));

            return query.ToArray();
        }
    }
}
