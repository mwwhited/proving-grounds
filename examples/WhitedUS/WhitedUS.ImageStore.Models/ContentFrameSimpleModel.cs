using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;

namespace WhitedUS.ImageStore.Models
{
    [DataContract]
    public class ContentFrameSimpleModel
    {
        public ContentFrameSimpleModel()
        {
            this.ContentFrameID = -1;
        }

        [DataMember]
        public int ContentFrameID { get; set; }
        [DataMember]
        public DateTime LastWriteTime { get; set; }
        [DataMember]
        public int ContentTypeID { get; set; }
        [DataMember]
        public int ContentItemID { get; set; }

        [DataMember]
        public int Index { get; set; }
        [DataMember]
        public int Width { get; set; }
        [DataMember]
        public int Height { get; set; }
        [DataMember]
        public long Length { get; set; }
    }
}
