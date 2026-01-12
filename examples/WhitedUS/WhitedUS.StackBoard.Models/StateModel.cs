using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;

namespace WhitedUS.StackBoard.Models
{
    [DebuggerDisplay("{Name} ({StateID})")]
    [DataContract]
    public class StateModel
    {
        public StateModel()
        {
            this.StateID = -1;
        }

        [DataMember]
        public int StateID { get; set; }
        [DataMember]
        public string Name { get; set; }
        [DataMember]
        public string Description { get; set; }
        [DataMember]
        public int TaskTypeID { get; set; }
    }
}
