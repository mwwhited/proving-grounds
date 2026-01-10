using System.Collections.Generic;
using System.Linq;

namespace Originations.DataProviders.SecurityManagement.LdapFilters
{
    public class LdapAndFilter : LdapFilterSetBase
    {
        public LdapAndFilter(ILdapFilter filter, params ILdapFilter[] filterSet)
            : this(new[] { filter }.Concat(filterSet))
        {
        }
        public LdapAndFilter(IEnumerable<ILdapFilter> filterSet)
            : base(LdapFilterSetOperations.And, filterSet)
        {
        }
    }
}
