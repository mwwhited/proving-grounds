using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Linq.Expressions;

namespace ConsoleApplication30
{
    class Program
    {
        static void Main(string[] args)
        {
    //using (var db = new SampleEntities())
    //    db.Invoices.WriteAsCSVTo("invoices.csv");

    //var t = new { x = 1, y = 2, z = 3 }.AsKVP();

    //Enumerable.Range(0, 100)
    //          .Select(i => new { i, x = i % 2 })
    //          .AsCSV()
    //          .WriteLinesTo("outfile.csv")
    //          ;


    Enumerable.Range(0, 100)
                .Select(i => new { i, x = i % 2 })
                .WriteAsCSVTo("outfile.csv")
                ;
        }

    }

    public static class ToolsEx
    {
        public static IEnumerable<KeyValuePair<string, object>> AsKVP(this object input)
        {
            var type = input.GetType();
            return type.GetProperties().Select(p => new KeyValuePair<string, object>(p.Name, p.GetGetMethod().Invoke(input, null)));
        }
        public static IEnumerable<IEnumerable<KeyValuePair<string, object>>> AsKVPSet<TSource>(this IEnumerable<TSource> source, params Expression<Func<TSource, object>>[] selectors)
        {
            var selectorsSet = (from selector in selectors
                                let name = ((selector.Body as UnaryExpression).Operand as MemberExpression).Member.Name
                                select new
                                {
                                    name,
                                    func = selector.Compile()
                                }).ToList();

            var results = source.Select(i => selectorsSet.Select(s => new KeyValuePair<string, object>(s.name, s.func(i))));
            return results;
        }
        public static IEnumerable<string> AsCSV<T>(this IEnumerable<T> items, bool includeHeaders = true, string delimiter = ",", string fieldFormatter = @"""{0}""")
        {
            if (typeof(T) == typeof(KeyValuePair<string, object>))
            {
                return items.Cast<KeyValuePair<string, object>>().AsCSV(includeHeaders, delimiter, fieldFormatter);
            }
            else if (typeof(T) == typeof(KeyValuePair<string, string>))
            {
                return items.Cast<KeyValuePair<string, object>>().AsCSV(includeHeaders, delimiter, fieldFormatter);
            }
            else
            {
                return items.Select(i => i.AsKVP()).AsCSV(includeHeaders, delimiter, fieldFormatter);
            }
        }
        public static IEnumerable<string> AsCSV(this IEnumerable<IEnumerable<KeyValuePair<string, object>>> items, bool includeHeaders = true, string delimiter = ",", string fieldFormatter = @"""{0}""")
        {
            var e = items.GetEnumerator();

            if (!e.MoveNext())
                yield break;

            if (includeHeaders)
            {
                yield return string.Join(delimiter, e.Current.Select(k => string.Format(fieldFormatter, k.Key)));
            }

            do
            {
                yield return string.Join(delimiter, e.Current.Select(k => string.Format(fieldFormatter, k.Value)));
            } while (e.MoveNext());
        }
        public static void WriteLinesTo(this IEnumerable<string> lines, string filename)
        {
            using (var writer = new StreamWriter(filename))
                foreach (var line in lines)
                    writer.WriteLine(line);
        }
        public static void WriteAsCSVTo(this IEnumerable<object> items, string filename, bool includeHeaders = true, string delimiter = ",", string fieldFormatter = @"""{0}""")
        {
            items.AsCSV(includeHeaders, delimiter, fieldFormatter);
        }
    }
}
