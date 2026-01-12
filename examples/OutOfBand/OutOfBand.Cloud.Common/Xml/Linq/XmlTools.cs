using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Xml.Serialization;

namespace OutOfBand.Cloud.Common.Xml.Linq
{
    public static class XmlTools
    {
        public static T LoadXmlAs<T>(this string fileName)
            where T : class 
        {
            using (var fs = File.Open(fileName,
                                     FileMode.Open,
                                     FileAccess.Read,
                                     FileShare.Read))
                 return fs.LoadXmlAs<T>();
        }

        public static T LoadXmlAs<T>(this Stream input)
            where T : class
        {
            var xser = new XmlSerializer(typeof(T));
            var obj = xser.Deserialize(input);
            var ret = obj as T;
            return ret;
        }

        public static void SaveXmlTo<T>(this T input, string fileName)
            where T : class 
        {
            using (var fs = File.Open(fileName,
                         FileMode.Create,
                         FileAccess.Write,
                         FileShare.None))
                input.SaveXmlTo<T>(fs);
        }

        public static void SaveXmlTo<T>(this T input, Stream stream)
            where T : class
        {
            var xSer = new XmlSerializer(typeof(T));
            xSer.Serialize(stream, input);
        }
    }
}
