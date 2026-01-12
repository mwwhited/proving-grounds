using System;
using System.Collections.Generic;

namespace CarMaintenanceLog.Data.Core
{
    public partial class OilChanges
    {
        public int OilChangeId { get; set; }
        public int CarId { get; set; }
        public DateTime Date { get; set; }
        public decimal ChangeMiles { get; set; }
        public string OilBrand { get; set; }
        public string FilterBrand { get; set; }
        public decimal? Quarts { get; set; }
        public decimal? OilCost { get; set; }
        public decimal? FilterCost { get; set; }
        public decimal? LaborCost { get; set; }
        public decimal? TaxRate { get; set; }
        public decimal? OtherCost { get; set; }
        public string Location { get; set; }
        public string Notes { get; set; }
        public decimal? ExtendedCost { get; set; }

        public virtual Cars Car { get; set; }
    }
}
