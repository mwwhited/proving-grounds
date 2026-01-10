using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace Ssb.Modeling.Models.Tools
{
    public static class EnumEx
    {
        public static TEnum GetOrDefault<TEnum>(this XAttribute attribute, bool ignoreCase = false) where TEnum : struct
        {
            var value = (string)attribute;
            var result = default(TEnum);
            if (Enum.TryParse(value, ignoreCase, out result)) { }
            return result;
        }

    }
}
