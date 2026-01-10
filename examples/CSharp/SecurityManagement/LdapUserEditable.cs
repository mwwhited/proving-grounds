using System;
using System.Collections.Generic;

namespace Originations.DataProviders.SecurityManagement
{

    [System.Diagnostics.CodeAnalysis.ExcludeFromCodeCoverage]
    public class LdapUserEditable : ILdapUserEditable
    {
        public LdapUserEditable()
        {
        }
        public LdapUserEditable(ILdapUserDetailed wrapped)
        {
            IsEnabled = wrapped.IsEnabled;
            ObjectGuid = wrapped.ObjectGuid;
            FirstName = wrapped.FirstName;
            LastName = wrapped.LastName;
            Email = wrapped.Email;
            Username = wrapped.Username;
            Container = wrapped.Container;
        }

        public bool IsEnabled { get; set; }
        public Guid ObjectGuid { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string Username { get; set; }
        public string Container { get; set; }
        public IEnumerable<ILdapGroupEditable> Groups { get; set; }
    }
}
