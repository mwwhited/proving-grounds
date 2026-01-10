namespace Originations.DataProviders.SecurityManagement.LdapFilters
{
    public class LdapNotFilter : ILdapFilter
    {
        public LdapNotFilter(ILdapFilter wrapped)
        {
            this.Wrapped = wrapped;
        }

        public ILdapFilter Wrapped { get; private set; }

        public override bool Equals(object obj)
        {
            var inner = obj as LdapNotFilter;
            if (inner == null)
            {
                return false;
            }
            return this.Wrapped.Equals(inner.Wrapped);
        }

        public override int GetHashCode()
        {
            return new
            {
                this.Wrapped,
            }.GetHashCode();
        }
    }
}
