namespace Originations.DataProviders.SecurityManagement.LdapFilters
{
    public class LdapPresentFilter : LdapSimpleFilter
    {
        public LdapPresentFilter(string attributeName)
            : base(attributeName, LdapFilterTypes.Equals, new LdapValue(null, "*"))
        {
        }
    }
}
