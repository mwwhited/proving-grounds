using System.Collections.Specialized;
using System.IO;
using System.Linq;
using System.ServiceModel.Web;
using System.Web;
using WhitedUS.Common.Linq;

namespace WhitedUS.ServiceModel.Linq
{
    public static class WebTools
    {
        public static string AsString(this Stream input)
        {
            using (var reader = new StreamReader(input))
                return reader.ReadToEnd();
        }

        public static NameValueCollection ParseQueryString(this string input)
        {
            return HttpUtility.ParseQueryString(input);
        }

        public static NameValueCollection ParseQueryString(this Stream input)
        {
            return input.AsString().ParseQueryString();
        }

        public static T ParseQueryString<T>(this NameValueCollection input)
            where T : class, new()
        {
            var ret = new T();

            var parsedValues = input;
            var type = typeof(T);

            var properties = type.GetProperties();
            var keys = parsedValues.AllKeys;

            var values = from i in keys
                         let v = parsedValues[i]
                         where !string.IsNullOrEmpty(v)
                         let leftId = i.ToUpperInvariant()
                         join p in properties on leftId equals p.Name.ToUpperInvariant()
                         select new { Value = v, Property = p };

            values.ForEach(kvp => kvp.Property.SetValue(ret, kvp.Value, null));

            return ret;
        }

        public static T ParseQueryString<T>(this string input)
            where T : class, new()
        {
            return input.ParseQueryString()
                        .ParseQueryString<T>();
        }

        public static T ParseQueryString<T>(this Stream input)
            where T : class, new()
        {
            return input.ParseQueryString()
                        .ParseQueryString<T>();
        }

        public static T ParseQueryString<T>(this WebOperationContext input)
            where T : class, new()
        {
            return input.IncomingRequest
                        .UriTemplateMatch
                        .QueryParameters
                        .ParseQueryString<T>();
        }
    }
}
