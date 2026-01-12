using System;
using System.Collections.Generic;

namespace CarMaintenanceLog.Data.Core
{
    public partial class SummaryCostsYearly
    {
        public int CarId { get; set; }
        public int? Year { get; set; }
        public decimal? YearlyCost { get; set; }
        public decimal? TotalMiles { get; set; }
        public decimal? MilesThisYear { get; set; }
        public decimal? CostDifferenceYear { get; set; }
        public decimal? CostPerMile { get; set; }
    }
}
