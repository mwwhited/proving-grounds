using System;
using System.Collections.Generic;

namespace CarMaintenanceLog.Data.Core
{
    public partial class Tires
    {
        public int TireId { get; set; }
        public int CarId { get; set; }
        public DateTime Date { get; set; }
        public decimal Miles { get; set; }
        public string Make { get; set; }
        public string Model { get; set; }
        public decimal Cost { get; set; }
        public int Quantity { get; set; }
        public decimal TaxRate { get; set; }
        public int WarrantyMonths { get; set; }
        public decimal WarrantyMiles { get; set; }
        public string Note { get; set; }
        public DateTime? ExpireDate { get; set; }
        public decimal? ExpireMiles { get; set; }
        public decimal? ExtendedCost { get; set; }

        public virtual Cars Car { get; set; }
    }
}
