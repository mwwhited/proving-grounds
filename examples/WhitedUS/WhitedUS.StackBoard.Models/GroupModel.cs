using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.Serialization;
using System.Diagnostics;

namespace WhitedUS.StackBoard.Models
{
    [DebuggerDisplay("{Name} ({GroupID}/{ParentID})")]
    [DataContract]
    public class GroupModel
    {
        public GroupModel()
        {
            this.GroupID = -1;
        }

        [DataMember]
        public int GroupID { get; set; }
        [DataMember]
        public int? ParentID { get; set; }

        [DataMember]
        public string Name { get; set; }
        [DataMember]
        public string Description { get; set; }
    }
}
