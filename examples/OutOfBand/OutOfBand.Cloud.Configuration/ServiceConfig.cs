using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Serialization;
using OutOfBand.Cloud.Definitions;

namespace OutOfBand.Cloud.Configuration
{
    [XmlRoot("service")]
    [Serializable]
    public class ServiceConfig
    {
        //TODO: this should really be changed to only allow IApplication classes to be bound
        private string _typeName;
        [XmlAttribute("type")]
        public string TypeName
        {
            get
            {
                if (string.IsNullOrEmpty(_typeName) && _type != null)
                    _typeName = _type.AssemblyQualifiedName;
                return _typeName;
            }
            set
            {
                _typeName = value;
                _type = null;
            }
        }

        [NonSerialized]
        private Type _type;
        [XmlIgnore]
        public Type Type
        {
            get
            {
                if (_type == null && !string.IsNullOrEmpty(_typeName))
                    _type = Type.GetType(_typeName);
                return _type;
            }
            set
            {
                _type = value;
                _typeName = value.AssemblyQualifiedName;
            }
        }

        public IApplication CreateInstance()
        {
            var ci = this.Type.GetConstructor(Type.EmptyTypes);
            var obj = ci.Invoke(null);
            var ret = obj as IApplication;
            return ret;
        }

        public IApplication CreateInstance(params object[] args)
        {
            var parms = args.Select(o => o.GetType()).ToArray();
            var ci = this.Type.GetConstructor(parms);
            var obj = ci.Invoke(args);
            var ret = obj as IApplication;
            return ret;
        }
    }
}
