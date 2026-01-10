using System.Collections.Generic;

namespace Originations.DataProviders.SecurityManagement.LdapFilters
{
    public abstract class LdapFilterSetBase : ILdapFilter
    {
        public LdapFilterSetBase(LdapFilterSetOperations operation, IEnumerable<ILdapFilter> filterSet)
        {
            this.Operation = operation;
            this.FilterSet = filterSet;
        }

        public LdapFilterSetOperations Operation { get; private set; }
        public IEnumerable<ILdapFilter> FilterSet { get; private set; }
    }
}
