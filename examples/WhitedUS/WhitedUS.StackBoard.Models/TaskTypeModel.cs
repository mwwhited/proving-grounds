using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Xml;

namespace WhitedUS.StackBoard.Models
{
    [DebuggerDisplay("{Name} ({TaskTypeID})")]
    [DataContract]
    public class TaskTypeModel
    {
        [DebuggerBrowsable(DebuggerBrowsableState.Never)]
        private string _handlerType;
        [DebuggerBrowsable(DebuggerBrowsableState.Never)]
        private string _configuration;
        [DebuggerBrowsable(DebuggerBrowsableState.Never)]
        private ITaskTypeHandler _handler;

        public TaskTypeModel()
        {
            this.TaskTypeID = -1;
        }
        [DataMember]
        public int TaskTypeID { get; set; }
        [DataMember]
        public string Name { get; set; }
        [DataMember]
        public string Description { get; set; }

        [DataMember]
        public string HandlerType
        {
            get
            {
                if (this._handler == null)
                    return this._handlerType;

                return _handler.GetType().AssemblyQualifiedName;
            }
            set
            {
                if (this._handler != null)
                    this._handler = null;
                this._handlerType = value;
            }
        }
        [DataMember]
        public string Configuration
        {
            get
            {
                return this.Serialize();
            }
            set
            {
                if (this._handler != null)
                    this._handler = null;
                this._configuration = value;
            }
        }

        public ITaskTypeHandler Handler
        {
            get
            {
                if (this._handler == null && !string.IsNullOrWhiteSpace(this._handlerType))
                {
                    this._handler = TaskTypeModel.Deserialize(this._handlerType, this._configuration);
                }
                return this._handler;
            }
            set { this._handler = value; }
        }

        public string Serialize()
        {
            if (this._handler == null)
                return this._configuration;

            using (var ms = new MemoryStream())
            {
                var settings = new XmlWriterSettings
                {
                    Encoding = Encoding.Unicode,
                };

                using (var xmlWriter = XmlWriter.Create(ms, settings))
                {
                    var dcs = new DataContractSerializer(this._handler.GetType());
                    dcs.WriteObject(xmlWriter, this._handler);
                }
                ms.Position = 0;

                using (var reader = new StreamReader(ms, Encoding.Unicode))
                {
                    var result = reader.ReadToEnd();
                    return result;
                }
            }
        }

        public static ITaskTypeHandler Deserialize(string handlerType, string configuration)
        {
            if (string.IsNullOrWhiteSpace(configuration))
            {
                if (string.IsNullOrWhiteSpace(handlerType))
                    return null;

                var type = Type.GetType(handlerType);
                var obj = Activator.CreateInstance(type);
                var result = (ITaskTypeHandler)obj;
                return result;
            }

            var buffer = Encoding.UTF8.GetBytes(configuration);
            using (var ms = new MemoryStream(buffer))
            {
                var type = Type.GetType(handlerType);
                var dcs = new DataContractSerializer(type);
                var obj = dcs.ReadObject(ms);
                var result = (ITaskTypeHandler)obj;
                return result;
            }
        }
    }
}