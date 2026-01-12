using System;
using System.Collections.Generic;

namespace CarMaintenanceLog.Data.Core
{
    public partial class SlidingBalance
    {
        public int TransactionId { get; set; }
        public int CustomerId { get; set; }
        public decimal? Credit { get; set; }
        public decimal? Debit { get; set; }
        public string Note { get; set; }
        public DateTime DateTime { get; set; }
        public string Currency { get; set; }
        public decimal? Balance { get; set; }
    }
}
