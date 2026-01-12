using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.Serialization.Formatters.Binary;
using System.Text;

namespace OutOfBand.Cloud.Common.Linq
{
    public static class ObjectTools
    {
        public static T LoadObjectAs<T>(this string fileName)
            where T : class
        {
            using (var fs = File.Open(fileName,
                                     FileMode.Open,
                                     FileAccess.Read,
                                     FileShare.Read))
                return fs.LoadObjectAs<T>();
        }

        public static T LoadObjectAs<T>(this Stream input)
            where T : class
        {
            var xser = new BinaryFormatter();
            var obj = xser.Deserialize(input);
            var ret = obj as T;
            return ret;
        }

        public static void SaveObjectTo<T>(this T input, string fileName)
            where T : class
        {
            using (var fs = File.Open(fileName,
                         FileMode.Create,
                         FileAccess.Write,
                         FileShare.None))
                input.SaveObjectTo<T>(fs);
        }

        public static void SaveObjectTo<T>(this T input, Stream stream)
            where T : class
        {
            var xSer = new BinaryFormatter();
            xSer.Serialize(stream, input);
        }

    }
}
