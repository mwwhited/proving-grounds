using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;

namespace WhitedUS.ImageStore.Models
{
    [DataContract]
    public class ContentItemModel
    {
        public ContentItemModel()
        {
            this.ContentItemID = -1;
        }

        [DataMember]
        public int ContentItemID { get; set; }
        [DataMember]
        public int FolderID { get; set; }
        
        [DataMember]
        public string Name { get; set; }
        [DataMember]
        public string Description { get; set; }
        [DataMember]
        public DateTime CreationTime { get; set; }
        [DataMember]
        public DateTime LastAccessTime { get; set; }
        [DataMember]
        public DateTime LastWriteTime { get; set; }
        [DataMember]
        public byte[] Data { get; set; }
        [DataMember]
        public int ContentTypeID { get; set; }

        [DataMember]
        public long Length { get; set; }
    }
}
