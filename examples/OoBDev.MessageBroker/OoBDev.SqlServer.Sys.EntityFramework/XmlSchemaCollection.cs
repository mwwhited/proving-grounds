using System.Collections.Generic;

namespace OoBDev.SqlServer.Sys
{
    public class XmlSchemaCollection
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int PrincipalId { get; set; }
        public int SchemaId { get; set; }
        public Schema Schema { get; internal set; }
        public IEnumerable<ServiceMessageType> ServiceMessageTypes { get; internal set; }
    }
}