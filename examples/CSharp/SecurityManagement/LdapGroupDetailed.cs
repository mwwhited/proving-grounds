using System;
using System.Collections.Generic;
using System.Diagnostics;

namespace Originations.DataProviders.SecurityManagement
{
    [System.Diagnostics.CodeAnalysis.ExcludeFromCodeCoverage]
    [DebuggerDisplay("{FullPath}")]
    internal class LdapGroupDetailed : ILdapGroupDetailed
    {
        public string GroupName { get; internal set; }
        public string Container { get; internal set; }
        public string FullPath { get; internal set; }
        public Guid ObjectGuid { get; internal set; }
        public DateTime LastModified { get; internal set; }
        public DateTime Created { get; internal set; }
        public IEnumerable<ILdapUserSimple> Members { get; internal set; }
    }
}