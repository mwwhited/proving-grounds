using System;
using System.Collections.Generic;
using System.Diagnostics.Contracts;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace OobDev.Common.Xml.Linq
{
    public static class XAttributeEx
    {
        public static TEnum AsEnum<TEnum>(this XAttribute xAttribute)
            where TEnum : struct
        {
            TEnum value;
            if (xAttribute != null && Enum.TryParse<TEnum>((string)xAttribute, out value))
                return value;
            return default(TEnum);
        }
    }
}
