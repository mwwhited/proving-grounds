using System;
using System.Collections.Generic;

namespace CarMaintenanceLog.Data.Core
{
    public partial class Terms
    {
        public Terms()
        {
            Invoices = new HashSet<Invoices>();
            Projects = new HashSet<Projects>();
        }

        public int TermId { get; set; }
        public string Name { get; set; }
        public string Details { get; set; }
        public string Rules { get; set; }

        public virtual ICollection<Invoices> Invoices { get; set; }
        public virtual ICollection<Projects> Projects { get; set; }
    }
}
