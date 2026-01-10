namespace Originations.DataProviders.SecurityManagement.LdapFilters
{
    public class LdapSimpleFilter : ILdapFilter
    {
        public LdapSimpleFilter(string attributeName, LdapFilterTypes operation, object value)
        {
            this.AttributeName = attributeName;
            this.Operation = operation;
            this.Value = new LdapValue(value);
        }

        public string AttributeName { get; private set; }
        public LdapFilterTypes Operation { get; private set; }
        public LdapValue Value { get; private set; }
        public override bool Equals(object obj)
        {
            var inner = obj as LdapSimpleFilter;
            if (inner == null)
            {
                return false;
            }

            return new
            {
                AttributeName = this.AttributeName.ToUpperInvariant(),
                this.Operation,
                Value = ((string)this.Value).ToUpperInvariant(),
            }.Equals(new
            {
                AttributeName = inner.AttributeName.ToUpperInvariant(),
                inner.Operation,
                Value = ((string)inner.Value).ToUpperInvariant(),
            });
        }

        public override int GetHashCode()
        {
            return new
            {
                this.AttributeName,
                this.Operation,
                Value = (string)this.Value,
            }.GetHashCode();
        }
    }
}
