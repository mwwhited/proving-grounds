using System;
using System.Linq;
using System.Text;

namespace Originations.DataProviders.SecurityManagement.LdapFilters
{
    public class LdapValue
    {
        public LdapValue(object value)
            : this(value, null)
        {
        }
        internal LdapValue(object value, string unescapedFormatter)
        {
            this.Value = value;
            this.Formatter = unescapedFormatter;
        }

        public override string ToString()
        {
            return (string)this;
        }

        public override bool Equals(object obj)
        {
            //if not wrapped use value
            var inner = obj is LdapValue ? ((LdapValue)obj).Value : obj;

            if (this.Value == null)
            {
                //if both null than true
                return inner == null;
            }
            else if (inner is string)
            {
                return string.Equals(this, inner as string, StringComparison.InvariantCultureIgnoreCase);
            }

            // compare instances
            return this.Value.Equals(inner);
        }

        public override int GetHashCode()
        {
            if (this.Value == null)
            {
                return 0;
            }

            return this.Value.GetHashCode();
        }

        private object Value { get; set; }
        private string Formatter { get; set; }

        public static implicit operator LdapValue(string input)
        {
            return new LdapValue(input);
        }

        public static implicit operator string(LdapValue input)
        {
            if (input == null)
            {
                return "";
            }

            var value = EscapeStringOrDefault(input.Value as string)
                     ?? ConvertByteArrayOrDefault(input.Value as byte[])
                     ?? ConvertGuidOrDefault(input.Value as Guid?)
                     ?? ConvertDateTimeOrDefault(input.Value as DateTime?)
                     ?? ConvertOther(input.Value); // as object

            if (!string.IsNullOrWhiteSpace(input.Formatter))
            {
                return string.Format(input.Formatter, value);
            }

            return value ?? "";
        }

        internal static string ConvertOther(object value)
        {
            if (value == null)
            {
                return null;
            }

            return value.ToString();
        }
        internal static string ConvertGuidOrDefault(Guid? value)
        {
            if (!value.HasValue)
            {
                return null;
            }

            return ConvertByteArrayOrDefault(value.Value.ToByteArray());
        }

        internal static string ConvertDateTimeOrDefault(DateTime? value)
        {
            if (!value.HasValue)
            {
                return null;
            }

            return value.Value.ToFileTimeUtc().ToString();
        }
        internal static string ConvertByteArrayOrDefault(byte[] value)
        {
            if (value == null)
            {
                return null;
            }

            return value.Aggregate(new StringBuilder(),
                                   (sb, v) => sb.AppendFormat("\\{0:X}", v),
                                   sb => sb.ToString());
        }
        internal static string EscapeStringOrDefault(string value)
        {
            if (value == null)
            {
                return null;
            }

            /*
               \               0x5c
               *               0x2a
               (               0x28
               )               0x29
               NUL             0x00
           */
            return value.Replace(@"\", @"\5c")
                        .Replace("*", @"\2a")
                        .Replace("(", @"\28")
                        .Replace(")", @"\29")
                        .Replace("\0", @"\00");
        }
    }
}
