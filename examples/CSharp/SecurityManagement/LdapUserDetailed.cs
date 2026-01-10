using System;
using System.Collections.Generic;
using System.Diagnostics;

namespace Originations.DataProviders.SecurityManagement
{
    [System.Diagnostics.CodeAnalysis.ExcludeFromCodeCoverage]
    [DebuggerDisplay("{FullPath} ({IsEnabled})")]
    internal class LdapUserDetailed : ILdapUserDetailed
    {
        public string Username { get; internal set; }
        public string Container { get; internal set; }
        public string FullPath { get; internal set; }
        public bool IsEnabled { get; internal set; }
        public Guid ObjectGuid { get; internal set; }

        public string FirstName { get; internal set; }
        public string LastName { get; internal set; }
        public string Email { get; internal set; }

        public DateTime LastLogin { get; internal set; }
        public DateTime LastPasswordChanged { get; internal set; }
        public DateTime LastModified { get; internal set; }
        public DateTime Created { get; internal set; }

        public bool IsLockedOut { get; internal set; }
        public DateTime? LockoutTime { get; internal set; }
        public bool IsPasswordExpired { get; internal set; }
        
        public IEnumerable<ILdapGroupSimple> Groups { get; set; }       
    }
}