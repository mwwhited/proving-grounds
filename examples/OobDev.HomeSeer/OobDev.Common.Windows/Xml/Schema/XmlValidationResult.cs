using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Schema;

namespace OobDev.Common.Xml.Schema
{
    public class XmlValidationResult
    {
        public XmlSchemaException Exception { get; set; }
        public string Message { get; set; }
        public XmlSeverityType Severity { get; set; }
    }
}
