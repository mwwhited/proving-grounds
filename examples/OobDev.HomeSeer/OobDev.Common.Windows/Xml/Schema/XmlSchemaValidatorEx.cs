using System;
using System.Collections.Generic;
using System.Diagnostics.Contracts;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using System.Xml.Linq;
using System.Xml.Schema;
using System.Xml.XPath;

namespace OobDev.Common.Xml.Schema
{
    public class XmlSchemaValidatorEx
    {
        public XmlSchemaSet XmlSchemaSet { get; private set; }

        public XmlSchemaValidatorEx()
        {
            this.XmlSchemaSet = new XmlSchemaSet();
        }

        public XmlSchemaValidatorEx(string targetNamespace, string xsdUri)
            : this()
        {
            Contract.Requires(!string.IsNullOrEmpty(xsdUri));
            this.XmlSchemaSet.Add(targetNamespace ?? "", xsdUri);
        }
        public XmlSchemaValidatorEx(string targetNamespace, XmlReader xmlreader)
            : this()
        {
            Contract.Requires(xmlreader != null);
            this.XmlSchemaSet.Add(targetNamespace ?? "", xmlreader);
        }
        public XmlSchemaValidatorEx(string targetNamespace, XNode xsd)
            : this(targetNamespace ?? "", xsd.CreateReader())
        {
            Contract.Requires(xsd != null);
        }
        public XmlSchemaValidatorEx(IEnumerable<KeyValuePair<string, string>> xsdUris)
            : this()
        {
            Contract.Requires(xsdUris != null);

            foreach (var xsdUri in xsdUris.Where(v => v.Value != null))
            {
                this.XmlSchemaSet.Add(xsdUri.Key ?? "", xsdUri.Value);
            }
        }
        public XmlSchemaValidatorEx(IEnumerable<KeyValuePair<string, XmlReader>> xsdReaders)
            : this()
        {
            Contract.Requires(xsdReaders != null);

            foreach (var xsdUri in xsdReaders.Where(v => v.Value != null))
            {
                this.XmlSchemaSet.Add(xsdUri.Key ?? "", xsdUri.Value);
            }
        }
        public XmlSchemaValidatorEx(IEnumerable<KeyValuePair<string, XNode>> xsds)
            : this()
        {
            Contract.Requires(xsds != null);

            foreach (var xsdUri in xsds.Where(v => v.Value != null))
            {
                this.XmlSchemaSet.Add(xsdUri.Key ?? "", xsdUri.Value.CreateReader());
            }
        }

        public XmlSchemaValidatorEx(IEnumerable<string> xsdUris)
            : this()
        {
            Contract.Requires(xsdUris != null);

            foreach (var xsdUri in xsdUris)
            {
                var xDocument = XDocument.Load(xsdUri);
                var xsdNs = (XNamespace)"http://www.w3.org/2001/XMLSchema";

                var targetNamespace = (string)(xDocument.Element(xsdNs + "schema").Attribute("targetNamespace"));

                this.XmlSchemaSet.Add(targetNamespace, xsdUri);
            }
        }
        public XmlSchemaValidatorEx(IEnumerable<XContainer> xsdContainers)
            : this()
        {
            Contract.Requires(xsdContainers != null);

            foreach (var xsdContainer in xsdContainers)
            {
                var xsdNs = (XNamespace)"http://www.w3.org/2001/XMLSchema";

                var targetNamespace = (string)(xsdContainer.Element(xsdNs + "schema").Attribute("targetNamespace"));

                this.XmlSchemaSet.Add(targetNamespace, xsdContainer.CreateReader());
            }
        }

        public bool IsValid(XDocument xDocument)
        {
            var result = true;
            Contract.Requires(xDocument != null);
            xDocument.Validate(this.XmlSchemaSet, (sender, e) =>
            {
                if (e.Severity == XmlSeverityType.Error)
                    result = false;
            }, false);

            return result;
        }

        public IEnumerable<string> GetErrors(XDocument xDocument)
        {
            var result = new List<string>();
            Contract.Requires(xDocument != null);
            xDocument.Validate(this.XmlSchemaSet, (sender, e) =>
            {
                if (e.Severity == XmlSeverityType.Error)
                    result.Add(e.Message);
            }, false);

            return result.AsEnumerable();
        }
        public IEnumerable<string> GetWarnings(XDocument xDocument)
        {
            var result = new List<string>();
            Contract.Requires(xDocument != null);
            xDocument.Validate(this.XmlSchemaSet, (sender, e) =>
            {
                if (e.Severity == XmlSeverityType.Warning)
                    result.Add(e.Message);
            }, false);

            return result.AsEnumerable();
        }
        public IEnumerable<XmlValidationResult> GetResults(XDocument xDocument)
        {
            var result = new List<XmlValidationResult>();
            Contract.Requires(xDocument != null);
            xDocument.Validate(this.XmlSchemaSet, (sender, e) =>
            {
                result.Add(new XmlValidationResult
                {
                    Exception = e.Exception,
                    Message = e.Message,
                    Severity = e.Severity,
                });
            }, false);

            return result.AsEnumerable();
        }
    }
}
