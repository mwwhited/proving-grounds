using System;
using System.Xml.Serialization;
using System.Xml.Schema;
using System.Xml;
using System.IO;
using OutOfBand.Cloud.Common.Linq;

namespace OutOfBand.Cloud.Configuration
{
    [Serializable]
    public class Package : IXmlSerializable
    {
        private ServiceConfig _config;
        public ServiceConfig Config
        {
            get { return _config; }
            set { _config = value; }
        }

        private object _state;
        public object State
        {
            get { return _state; }
            set { _state = value; }
        }

        #region IXmlSerializable Members

        public XmlSchema GetSchema()
        {
            throw new NotImplementedException();
        }

        public void ReadXml(XmlReader reader)
        {
            //TODO: might consider having this use the xml seralizer instead of this cludge
            var encoded = reader.ReadInnerXml();
            var buffer = Convert.FromBase64String(encoded);
            using (var ms = new MemoryStream(buffer))
            {
                ms.Seek(0, SeekOrigin.Begin);
                var package = ms.LoadObjectAs<Package>();
                this.Config = package.Config;
                this.State = package.State;
            }
        }

        public void WriteXml(XmlWriter writer)
        {
            //TODO: might consider having this use the xml seralizer instead of this cludge
            using (var ms = new MemoryStream())
            {
                this.SaveObjectTo(ms);
                ms.Seek(0, SeekOrigin.Begin);
                var buffer = ms.ToArray();
                var base64 = Convert.ToBase64String(buffer);
                writer.WriteValue(base64);
            }
        }

        #endregion
    }
}
