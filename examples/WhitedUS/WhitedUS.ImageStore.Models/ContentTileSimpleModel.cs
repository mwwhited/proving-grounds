using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;

namespace WhitedUS.ImageStore.Models
{
    [DataContract]
    public class ContentTileSimpleModel
    {
        public ContentTileSimpleModel()
        {
            this.ContentTileID = -1;
        }

        [DataMember]
        public long ContentTileID { get; set; }

        [DataMember]
        public int ContentFrameID { get; set; }
        [DataMember]
        public int X { get; set; }
        [DataMember]
        public int Y { get; set; }
        [DataMember]
        public int Level { get; set; }
        [DataMember]
        public int ContentTypeID { get; set; }
        [DataMember]
        public DateTime LastWriteTime { get; set; }

        [DataMember]
        public long Length { get; set; }
    }
}
