namespace Originations.DataProviders.SecurityManagement.LdapFilters
{
    public class LdapStartsWith : LdapSimpleFilter
    {
        public LdapStartsWith(string attributeName, object value)
            : base(attributeName, LdapFilterTypes.Equals, new LdapValue(value, "{0}*"))
        {
        }
    }
}
