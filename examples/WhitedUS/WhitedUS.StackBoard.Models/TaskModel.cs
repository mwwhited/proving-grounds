using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Xml.Linq;
using System.Xml;
using System.IO;

namespace WhitedUS.StackBoard.Models
{
    [DebuggerDisplay("{Subject} ({TaskID/ParentID})")]
    [DataContract]
    public class TaskModel
    {
        public TaskModel()
        {
            this.TaskID = -1;
        }

        [DataMember]
        public int TaskID { get; set; }
        [DataMember]
        public int? ParentID { get; set; }
        [DataMember]
        public string Subject { get; set; }
        [DataMember]
        public string Description { get; set; }
        [DataMember]
        public DateTime? DueDate { get; set; }
        [DataMember]
        public DateTime CreatedDate { get; set; }
        [DataMember]
        public DateTime ModifiedDate { get; set; }
        [DataMember]
        public string MetaData { get; set; }

        public XDocument MetaDataXml
        {
            get
            {
                if (string.IsNullOrWhiteSpace(this.MetaData))
                    return null;

                var xdocument = XDocument.Parse(this.MetaData);
                return xdocument;
            }
            set
            {
                if (value == null)
                {
                    this.MetaData = null;
                }
                else
                {
                    var settings = new XmlWriterSettings
                    {
                        Encoding = Encoding.Unicode,
                    };
                    using (var ms = new MemoryStream())
                    {
                        using (var xmlWriter = XmlWriter.Create(ms, settings))
                            value.Save(xmlWriter);
                        ms.Position = 0;
                        using (var reader = new StreamReader(ms, Encoding.Unicode))
                        {
                            var result = reader.ReadToEnd();
                            this.MetaData = result;
                        }
                    }
                }
            }
        }

        [DataMember]
        public int GroupID { get; set; }
        [DataMember]
        public int TaskTypeID { get; set; }
        [DataMember]
        public int StateID { get; set; }
        [DataMember]
        public int PriorityID { get; set; }
    }
}
