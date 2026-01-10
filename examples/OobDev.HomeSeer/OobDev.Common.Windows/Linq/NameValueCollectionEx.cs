using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Diagnostics.Contracts;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OobDev.Common.Linq
{
    public static class NameValueCollectionEx
    {
        public static IEnumerable<KeyValuePair<string, string>> AsKeyValuePair(this NameValueCollection collection)
        {
            Contract.Requires(collection != null);
            Contract.Ensures(Contract.Result<IEnumerable<KeyValuePair<string, string>>>() != null);
            return from key in collection.OfType<string>()
                   let value = collection[key]
                   select new KeyValuePair<string, string>(key, value);
        }
    }
}
