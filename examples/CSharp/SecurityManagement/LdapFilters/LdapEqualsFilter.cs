using System;

namespace Originations.DataProviders.SecurityManagement.LdapFilters
{
    public class LdapEqualsFilter : LdapSimpleFilter
    {
        public LdapEqualsFilter(string attributeName, object value)
            : base(attributeName, LdapFilterTypes.Equals, value)
        {
        }
    }
}
