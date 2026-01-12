using System;
using System.Collections.Generic;

namespace CarMaintenanceLog.Data.Core
{
    public partial class LineItems
    {
        public int LineItemId { get; set; }
        public string Description { get; set; }
        public double Quantity { get; set; }
        public double UnitPrice { get; set; }
        public double? TaxRate { get; set; }
        public double ExtendedAmount { get; set; }
        public double? TaxAmount { get; set; }
        public double TotalAmount { get; set; }
        public int? ProjectId { get; set; }
        public int? InvoiceId { get; set; }

        public virtual Invoices Invoice { get; set; }
    }
}
