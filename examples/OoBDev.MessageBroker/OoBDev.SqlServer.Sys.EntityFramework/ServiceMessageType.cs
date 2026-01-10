using System.Collections.Generic;

namespace OoBDev.SqlServer.Sys
{
    public class ServiceMessageType
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int PrincipalId { get; set; }
        public int? XmlCollectionId { get; set; }
        public string ValidationDescription { get; set; }
        public XmlSchemaCollection XmlSchemaCollection { get; internal set; }
        internal IEnumerable<ServiceContractToServiceMessageType> ServiceContracts { get; set; }
    }
}