using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections.Specialized;

namespace WhitedUS.ServiceModel.Linq
{
    /// <summary>
    /// Extension Methods for NameValueCollections
    /// </summary>
    public static class NameValueCollectionLinq
    {
        /// <summary>
        /// Retrive a value from a NameValueCollection
        /// </summary>
        /// <param name="nvc">NameValueCollection to get value from</param>
        /// <param name="field">value to get</param>
        /// <param name="defaultValue">default</param>
        /// <returns>value</returns>
        public static int GetValue(this NameValueCollection nvc, 
                                   string field, 
                                   int defaultValue)
        {
            if (nvc == null || string.IsNullOrEmpty(field))
                return defaultValue;

            int ret = 0;
            if (int.TryParse(nvc[field], out ret))
                return ret;

            return defaultValue;
        }
    }
}
