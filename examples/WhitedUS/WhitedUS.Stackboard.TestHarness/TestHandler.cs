using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using WhitedUS.StackBoard.Models;
using System.Runtime.Serialization;

namespace WhitedUS.StackBoard.TestHarness
{
    [DataContract]
    public class TestHandler : ITaskTypeHandler
    {
        [DataMember]
        public string Value { get; set; }
    }
}
