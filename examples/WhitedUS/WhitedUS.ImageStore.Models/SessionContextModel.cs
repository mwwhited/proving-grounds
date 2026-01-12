using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace WhitedUS.ImageStore.Models
{
    public class SessionContextModel
    {
        public SessionContextModel()
        {
            this.SessionContextID = -1;
            this.Context = null;
            this.ContextID = Guid.Empty;
        }

        public long SessionContextID { get; set; }
        public byte[] Context { get; set; }
        public Guid ContextID { get; set; }

        public Guid? AspNetID { get; set; }
        public string Application { get; set; }
        public string ExecutingAssembly { get; set; }
    }
}
