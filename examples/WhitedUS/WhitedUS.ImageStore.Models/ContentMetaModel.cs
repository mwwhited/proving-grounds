using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;

namespace WhitedUS.ImageStore.Models
{
    [DataContract]
    public class ContentMetaModel
    {
        public ContentMetaModel()
        {
            this.ContentMetaID = -1;
        }

        [DataMember]
        public long ContentMetaID { get; set; }
        [DataMember]
        public int ContentItemID { get; set; }
        [DataMember]
        public string Name { get; set; }
        [DataMember]
        public string Value { get; set; }
        [DataMember]
        public DateTime CreationDate { get; set; }
        [DataMember]
        public DateTime LastWriteDate { get; set; }
    }
}
