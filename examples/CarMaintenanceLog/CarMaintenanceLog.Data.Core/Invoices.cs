using System;
using System.Collections.Generic;

namespace CarMaintenanceLog.Data.Core
{
    public partial class Invoices
    {
        public Invoices()
        {
            LineItems = new HashSet<LineItems>();
        }

        public int InvoiceId { get; set; }
        public int CustomerId { get; set; }
        public string Notes { get; set; }
        public DateTime? InvoiceDate { get; set; }
        public DateTime? DueDate { get; set; }
        public int TermsId { get; set; }
        public string TermsAndConditions { get; set; }
        public string InvoiceStatusCode { get; set; }
        public string RenderedInvoiceMime { get; set; }
        public byte[] RenderedInvoice { get; set; }
        public int? InvoiceNumber { get; set; }
        public DateTime? PaidDate { get; set; }
        public string Comment { get; set; }
        public int HasRenderedInvoice { get; set; }

        public virtual Customers Customer { get; set; }
        public virtual Terms Terms { get; set; }
        public virtual ICollection<LineItems> LineItems { get; set; }
    }
}
