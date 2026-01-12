using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;

namespace WhitedUS.StackBoard.Models
{
    [DebuggerDisplay("{Name} ({PriorityID}-{Weight})")]
    [DataContract]
    public class PriorityModel
    {
        public PriorityModel()
        {
            this.PriorityID = -1;
        }

        [DataMember]
        public int PriorityID { get; set; }
        [DataMember]
        public string Name { get; set; }
        [DataMember]
        public string Description { get; set; }
        [DataMember]
        public int Weight { get; set; }
    }
}
