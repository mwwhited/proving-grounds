using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace OoBDev.ScoreMachine.Web.Core.Models
{
    public class PlayerModel
    {
        public string Name { get; set; }
        public string Club { get; set; }
        public string Hand { get; set; }

        public string Division { get; set; }
        public string Region { get; set; }
        public string State { get; set; }
        public string Nation { get; set; }
    }
}
