using System.Diagnostics;

namespace Originations.DataProviders.SecurityManagement
{
    [System.Diagnostics.CodeAnalysis.ExcludeFromCodeCoverage]
    [DebuggerDisplay("cn={GroupName},ou={Container}")]
    public class LdapGroupEditable : ILdapGroupEditable
    {
        public string GroupName { get; set; }
        public string Container { get; set; }
        public int OperationType { get; set; }
    }
}
