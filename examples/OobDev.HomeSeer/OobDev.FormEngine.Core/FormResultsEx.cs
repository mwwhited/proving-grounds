using OobDev.Common.Linq;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Diagnostics.Contracts;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace OobDev.FormEngine
{
    public static class FormResultsEx
    {

        public static XElement AsSurveyData(this NameValueCollection collection)
        {
            Contract.Requires(collection != null);
            Contract.Ensures(Contract.Result<XElement>() != null);
            return collection.AsKeyValuePair().AsSurveyData();
        }
        public static XElement AsSurveyData(this KeyValuePair<string, string> kvp, params KeyValuePair<string, string>[] collection)
        {
            Contract.Requires(collection != null);
            Contract.Ensures(Contract.Result<XElement>() != null);
            return new[] { kvp }.Concat(collection).AsSurveyData();
        }
        public static XElement AsSurveyData(this IEnumerable<KeyValuePair<string, string>> collection)
        {
            Contract.Requires(collection != null);
            Contract.Ensures(Contract.Result<XElement>() != null);
            var ns = Namespaces.FormResults;
            var submittedData = new XElement(ns + "form-data",
                                    from item in collection
                                    select new XElement(ns + "data",
                                        new XAttribute("key", item.Key ?? ""),
                                        new XAttribute("value", item.Value ?? "")
                                        )
                                    );
            return submittedData;
        }
    }
}
