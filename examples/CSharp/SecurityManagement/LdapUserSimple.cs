using System;
using System.Collections.Generic;
using System.Diagnostics;

namespace Originations.DataProviders.SecurityManagement
{
    [System.Diagnostics.CodeAnalysis.ExcludeFromCodeCoverage]
    [DebuggerDisplay("{FullPath}")]
    internal class LdapUserSimple : ILdapUserSimple
    {
        public string Username { get; internal set; }
        public string Container { get; internal set; }
        public string FullPath { get; internal set; }
    }
}