using System;
using System.Collections.Generic;

namespace CarMaintenanceLog.Data.Core
{
    public partial class Customers
    {
        public Customers()
        {
            Invoices = new HashSet<Invoices>();
            Projects = new HashSet<Projects>();
            Transactions = new HashSet<Transactions>();
        }

        public int CustomerId { get; set; }
        public string CompanyName { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Address1 { get; set; }
        public string Address2 { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string PostalCode { get; set; }
        public string Country { get; set; }
        public string AccountingEmail { get; set; }
        public string ContractEmail { get; set; }
        public string Phone { get; set; }
        public string Notes { get; set; }

        public virtual ICollection<Invoices> Invoices { get; set; }
        public virtual ICollection<Projects> Projects { get; set; }
        public virtual ICollection<Transactions> Transactions { get; set; }
    }
}
