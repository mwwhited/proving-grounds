using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Linq;
using System.IO;
using System.Xml.Serialization;

namespace restClient.Linq
{
    public static class XElementTools
    {
        public static T DeserializeTo<T>(this XElement xml)
            where T : class, new()
        {
            var stream = new MemoryStream(Encoding.UTF8.GetBytes(xml.ToString()));
            var xser = new XmlSerializer(typeof(T));
            var obj = xser.Deserialize(stream);
            var res = obj as T;
            return res;
        }
    }
}
