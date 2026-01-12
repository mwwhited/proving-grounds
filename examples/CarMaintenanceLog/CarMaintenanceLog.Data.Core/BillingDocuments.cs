using System;
using System.Collections.Generic;

namespace CarMaintenanceLog.Data.Core
{
    public partial class BillingDocuments
    {
        public int BillingDocument { get; set; }
        public DateTime DownloadedDate { get; set; }
        public byte[] Data { get; set; }
        public string Comment { get; set; }
        public int VendorId { get; set; }
        public decimal? Amount { get; set; }
        public DateTime? PaidDate { get; set; }

        public virtual Vendors Vendor { get; set; }
    }
}
