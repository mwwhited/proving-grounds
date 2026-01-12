using System;
using System.Collections.Generic;

namespace CarMaintenanceLog.Data.Core
{
    public partial class Payments
    {
        public int PaymentId { get; set; }
        public int CarId { get; set; }
        public DateTime Date { get; set; }
        public decimal Amount { get; set; }
        public string PaidTo { get; set; }
        public string Notes { get; set; }

        public virtual Cars Car { get; set; }
    }
}
