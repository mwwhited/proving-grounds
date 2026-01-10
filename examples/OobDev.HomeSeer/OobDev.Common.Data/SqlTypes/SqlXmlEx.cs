using OobDev.Common.Xml.Linq;
using System.Data.SqlTypes;

namespace OobDev.Common.Data.SqlTypes
{
    public static class SqlXmlEx
    {
        public static XFragment ToXFragment(this SqlXml sqlxml)
        {
            using (var xmlReader = sqlxml.CreateReader())
            {
                return XFragment.Parse(xmlReader);
            }
        }

        public static SqlXml ToSqlXml(this XFragment xFragment)
        {
            return new SqlXml(xFragment.CreateReader());
        }
    }
}
