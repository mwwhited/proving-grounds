using System;
using System.Collections.Generic;

namespace CarMaintenanceLog.Data.Core
{
    public partial class CarCostsRolledUp
    {
        public int? CarId { get; set; }
        public int? Year { get; set; }
        public int? Month { get; set; }
        public decimal? Amount { get; set; }
    }
}
