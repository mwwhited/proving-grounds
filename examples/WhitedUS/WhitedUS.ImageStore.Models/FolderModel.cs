using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;

namespace WhitedUS.ImageStore.Models
{
    [DebuggerDisplay("{Name}")]
    [DataContract]
    public class FolderModel
    {
        public FolderModel() //Func<FolderModel, Stream> getStream)
        {
            this.FolderID = -1;
            //this.GetStream = getStream;
        }

        //private Func<FolderModel, Stream> GetStream { get; set; }

        [DataMember]
        public int FolderID { get; set; }
        [DataMember]
        public int? ParentID { get; set; }

        [DataMember]
        public string Name { get; set; }
        [DataMember]
        public DateTime CreationTime { get; set; }
        [DataMember]
        public DateTime LastAccessTime { get; set; }
        [DataMember]
        public DateTime LastWriteTime { get; set; }

        [DataMember]
        public string MappedPath { get; set; }
    }
}
