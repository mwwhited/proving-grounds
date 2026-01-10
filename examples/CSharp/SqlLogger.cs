using System;
using System.Data.Entity.Core.Objects;
using System.Data.Entity.Infrastructure;
using System.Diagnostics;
using System.Linq;
using System.Reflection;
using System.Text;

namespace Originations.DataProviders.Diagnostics
{
    public static class SqlLogger
    {
        public static string ToScript<T>(this IQueryable<T> query)
        {
            var dbQuery = (DbQuery<T>)query;
            // get the IInternalQuery internal variable from the DbQuery object
            var iqProp = dbQuery.GetType().GetProperty("InternalQuery", BindingFlags.Instance | BindingFlags.NonPublic | BindingFlags.Public);
            if (iqProp == null) return null;
            var iq = iqProp.GetValue(dbQuery, null);
            // get the ObjectQuery internal variable from the IInternalQuery object
            var oqProp = iq.GetType().GetProperty("ObjectQuery", BindingFlags.Instance | BindingFlags.NonPublic | BindingFlags.Public);
            if (oqProp == null) return null;
            var objectQuery = (ObjectQuery<T>)oqProp.GetValue(iq, null);

            return (
                from pi in objectQuery.Parameters.Select((p, i) => new { Parameter = p, Index = i })
                let opv = pi.Parameter.Value
                let value = opv is bool ? (((bool)opv) ? 1 : 0) : opv
                select new
                {
                    pi.Parameter.Name,
                    Type = TranslateType(pi.Parameter.ParameterType),
                    First = pi.Index == 1,
                }).Aggregate(
                new StringBuilder(),
                (sb, p) => sb.Append(p.First ? "DECLARE " : "       ,").AppendFormat("@{0} = {1}", p.Name, p.Type).AppendLine()
            ).AppendLine(query.ToString()).ToString();
        }

        [Conditional("DEBUG")]
        public static void WriteDebug<T>(this IQueryable<T> query)
        {
            var queryString = query.ToScript();
            if (!string.IsNullOrWhiteSpace(queryString))
            {
                Debug.WriteLine("--SQL--START--------------------------");
                Debug.WriteLine(queryString);
                Debug.WriteLine("--SQL--END----------------------------");
            }
        }

        private static string TranslateType(Type type)
        {
            if (type == typeof(int) || type == typeof(int?)) return "INT";
            if (type == typeof(bool) || type == typeof(bool?)) return "BIT";

            //Note: this may need expanded for other SQL types.

            return type.Name;
        }
    }
}
