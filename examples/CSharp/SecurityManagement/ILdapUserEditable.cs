using System;
using System.Collections.Generic;

namespace Originations.DataProviders.SecurityManagement
{
    public interface ILdapUserEditable
    {
        string Container { get; set; }
        string Email { get; set; }
        string FirstName { get; set; }
        bool IsEnabled { get; set; }
        string LastName { get; set; }
        Guid ObjectGuid { get; set; }
        string Username { get; set; }

        IEnumerable<ILdapGroupEditable> Groups { get; set; }
    }
}