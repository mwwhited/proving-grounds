using System;
using System.Collections.Generic;

namespace CarMaintenanceLog.Data.Core
{
    public partial class Vehicles
    {
        public int CarId { get; set; }
        public int? Year { get; set; }
        public decimal? Cost { get; set; }
        public double? LoggedMiles { get; set; }
        public decimal? TotalMiles { get; set; }
        public string PercentBusiness { get; set; }
        public double? Expense { get; set; }
    }
}
