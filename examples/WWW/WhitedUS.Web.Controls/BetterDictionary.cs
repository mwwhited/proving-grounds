using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;
using System.IO;
using System.Runtime.Serialization.Formatters.Binary;

namespace WhitedUS.Web.Controls
{
    [Serializable]
    public class BetterDictionary<K, V> : Dictionary<K, V>
    {
        public BetterDictionary()
        {
        }

        protected BetterDictionary(SerializationInfo info, StreamingContext context)
            : base(info, context)
        {
        }

        public new V this[K key]
        {
            get
            {
                V returnValue;
                if (base.TryGetValue(key, out returnValue))
                    return returnValue;
                else
                    return default(V);
            }
            set
            {
                if (this.ContainsKey(key))
                {
                    if (value == null)
                        base.Remove(key);
                    else if (!object.Equals(this[key], value))
                    {
                        base.Remove(key);
                        base.Add(key, value);
                    }
                }
                else
                    base.Add(key, value);
            }
        }

        public Stream Serialize()
        {
            return Serialize(this);
        }

        public void Serialize(Stream stream)
        {
            Serialize(this, stream);
        }

        #region Binary Serializers

        public static Stream Serialize(BetterDictionary<K, V> request)
        {
            if (request == null)
                return null;

            BinaryFormatter serializer = new BinaryFormatter();
            Stream memStream = new MemoryStream();
            serializer.Serialize(memStream, request);
            return memStream;
        }

        public static void Serialize(BetterDictionary<K, V> request, Stream memStream)
        {
            if (request == null || memStream == null || !memStream.CanWrite)
                return;

            BinaryFormatter serializer = new BinaryFormatter();
            serializer.Serialize(memStream, request);
        }

        public static BetterDictionary<K, V> Deserialize(Stream memStream)
        {
            if (memStream == null || !memStream.CanRead)
                return null;

            memStream.Position = 0;
            BinaryFormatter deserializer = new BinaryFormatter();
            object newobj = deserializer.Deserialize(memStream);
            memStream.Close();
            return newobj as BetterDictionary<K, V>;
        }

        #endregion

    }
}
