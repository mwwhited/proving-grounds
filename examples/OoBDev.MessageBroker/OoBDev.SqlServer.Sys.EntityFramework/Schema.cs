using System.Collections.Generic;

namespace OoBDev.SqlServer.Sys
{
    public class Schema
    {
        public string Name { get; set; }
        public int Id { get; set; }
        public int PrincipalId { get; set; }
        public IEnumerable<ServiceQueue> ServiceQueues { get; set; }
        public IEnumerable<XmlSchemaCollection> XmlSchemaCollections { get; internal set; }
    }
}