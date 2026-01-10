namespace Originations.DataProviders.SecurityManagement.LdapFilters
{
    public enum LdapFilterTypes
    {
        /// <remarks>=</remarks>
        Equals,

        /// <remarks>~=</remarks>
        Approximate,
        /// <remarks>&gt;=</remarks>
        GreaterThanOrEqualTo,
        /// <remarks>&lt;=</remarks>
        LessThanOrEqualTo,
    }
}
