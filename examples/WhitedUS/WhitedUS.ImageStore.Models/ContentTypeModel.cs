using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;

namespace WhitedUS.ImageStore.Models
{
    [DataContract]
    public class ContentTypeModel
    {
        public ContentTypeModel()
        {
            this.ContentTypeID = -1;
        }

        [DataMember]
        public int ContentTypeID { get; set; }
        [DataMember]
        public string Name { get; set; }
        [DataMember]
        public string Description { get; set; }
        [DataMember]
        public string Extension { get; set; }
        [DataMember]
        public string MimeType { get; set; }
        [DataMember]
        public bool IsSingleFrame { get; set; }
    }
}
