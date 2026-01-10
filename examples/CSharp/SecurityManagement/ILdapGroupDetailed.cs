using System;
using System.Collections.Generic;

namespace Originations.DataProviders.SecurityManagement
{
    public interface ILdapGroupDetailed : ILdapGroupSimple
    {
        /// <remarks>ldap: attribute = whenChanged</remarks>
        DateTime LastModified { get; }

        /// <remarks>ldap: attribute = whenCreated</remarks>
        DateTime Created { get; }


        /// <remarks>ldap: attribute = member</remarks>
        IEnumerable<ILdapUserSimple> Members { get; }
    }
}