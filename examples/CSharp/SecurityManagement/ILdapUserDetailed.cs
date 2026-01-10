using System;
using System.Collections.Generic;

namespace Originations.DataProviders.SecurityManagement
{
    public interface ILdapUserDetailed : ILdapUserSimple
    {
        /// <summary>
        /// IsActive
        /// </summary>
        /// <remarks>ldap: attribute = !msDS-UserAccountDisabled</remarks>
        bool IsEnabled { get; }

        /// <summary>
        /// objectGUID
        /// </summary>
        /// <remarks>ldap: attribute = objectGUID</remarks>
        Guid ObjectGuid { get; }


        /// <remarks>ldap: attribute = givenName</remarks>
        string FirstName { get; }
        /// <remarks>ldap: attribute = sn</remarks>
        string LastName { get; }
        /// <remarks>ldap: attribute = mail</remarks>
        string Email { get; }


        /// <remarks>ldap: attribute = lastLogonTimestamp</remarks>
        DateTime LastLogin { get; }
        /// <remarks>ldap: attribute = pwdLastSet</remarks>
        DateTime LastPasswordChanged { get; }
        /// <remarks>ldap: attribute = whenChanged</remarks>
        DateTime LastModified { get; }
        /// <remarks>ldap: attribute = whenCreated</remarks>
        DateTime Created { get; }

        /// <remarks>ldap: attribute = msDS-UserPasswordExpired</remarks>
        bool IsPasswordExpired { get; }

        /// <remarks>ldap: attribute = lockoutTime</remarks>
        DateTime? LockoutTime { get; }

        /// <remarks>ldap: attribute = msDS-User-Account-Control-Computed &amp; 0x0010</remarks>
        bool IsLockedOut { get; }
                     
        /// <remarks>ldap: attribute = memberOf</remarks>
        IEnumerable<ILdapGroupSimple> Groups { get; set; }
    }
}