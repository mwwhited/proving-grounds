using System;
using System.Collections.Generic;

namespace CarMaintenanceLog.Data.Core
{
    public partial class Vendors
    {
        public Vendors()
        {
            BillingDocuments = new HashSet<BillingDocuments>();
        }

        public int VendorId { get; set; }
        public string Name { get; set; }
        public string WebSite { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public string Note { get; set; }

        public virtual ICollection<BillingDocuments> BillingDocuments { get; set; }
    }
}
