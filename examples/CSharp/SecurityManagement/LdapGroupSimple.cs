using System.Diagnostics;

namespace Originations.DataProviders.SecurityManagement
{
    [System.Diagnostics.CodeAnalysis.ExcludeFromCodeCoverage]
    [DebuggerDisplay("{FullPath}")]
    internal class LdapGroupSimple : ILdapGroupSimple
    {
        public string GroupName { get; internal set; }
        public string Container { get; internal set; }
        public string FullPath { get; internal set; }
    }
}
