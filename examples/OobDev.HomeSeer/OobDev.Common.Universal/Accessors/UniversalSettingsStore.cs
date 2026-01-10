using OobDev.Common.Accessors;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;
using Windows.Storage;
using OobDev.Common.SimpleSerializers;
using System.Diagnostics.Contracts;
using System.IO.Compression;
using System.IO;

namespace OobDev.Common.Accessors
{
    public class UniversalSettingsStore : ISettingsStore
    {
        private ApplicationDataContainer DataContainer
        {
            get { return ApplicationData.Current.LocalSettings;  }
        }

        private bool HasValue(string key)
        {
            return this.DataContainer.Values.ContainsKey(key);
        }
        private object GetValue(string key)
        {
            if (!this.DataContainer.Values.ContainsKey(key))
            {
                return null;
            }

            var value = this.DataContainer.Values[key];
            if (!(value is byte[]))
                return value;

            using (var compressed = new MemoryStream(value as byte[]))
            using (var deflate = new DeflateStream(compressed, CompressionMode.Decompress))
            using (var decompressed = new MemoryStream())
            {
                deflate.CopyTo(decompressed);

                var buffer = decompressed.ToArray();
                var ret = Encoding.UTF8.GetString(buffer, 0, buffer.Length);

                return ret;
            }
        }
        private void SaveValue(string key, object value)
        {
            this.RemoveValue(key);
            if (value == null)
                return;

            if (!(value is string))
                this.DataContainer.Values.Add(key, value);

            var buffer = Encoding.UTF8.GetBytes(value as string);
            using (var decompressed = new MemoryStream(buffer))
            using (var compressed = new MemoryStream())
            {
                using (var deflate = new DeflateStream(compressed, CompressionLevel.Optimal))
                {
                    decompressed.CopyTo(deflate);
                }

                var compressedBuffer = compressed.ToArray();
                this.DataContainer.Values.Add(key, compressedBuffer);
            }
        }
        private void RemoveValue(string key)
        {
            if (this.DataContainer.Values.ContainsKey(key))
                this.DataContainer.Values.Remove(key);
        }

        public T Get<T>(string key)
        {
            if (this.HasValue(key))
            {
                if (typeof(T) == typeof(XElement))
                {
                    var obj = this.GetValue(key);
                    var xml = XElement.Parse((string)obj);
                    return (T)(object)xml;
                }
                else if (typeof(T) == typeof(IEnumerable<KeyValuePair<string, string>>))
                {
                    var obj = this.GetValue(key);
                    var xml = XElement.Parse((string)obj);
                    var q = xml.ToKeyValuePair();
                    return (T)(object)q;
                }
                else
                {
                    return (T)this.GetValue(key);
                }
            }
            return default(T);
        }

        public T Add<T>(string key, T value)
        {
            object input = value;
            if (value is XElement)
            {
                input = value.ToString();
            }
            else if (value is IEnumerable<KeyValuePair<string, string>>)
            {
                var q = ((IEnumerable<KeyValuePair<string, string>>)value).ToSimpleXml();
                input = q.ToString();
            }

            this.SaveValue(key, input);

            return value;
        }

        public void Remove(string key)
        {
            this.RemoveValue(key);
        }
    }
}
