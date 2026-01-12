using System;
using System.Collections.Generic;

namespace CarMaintenanceLog.Data.Core
{
    public partial class CombinedCosts
    {
        public int RowId { get; set; }
        public string RowSource { get; set; }
        public int CarId { get; set; }
        public DateTime Date { get; set; }
        public decimal? Amount { get; set; }
        public decimal? TotalMiles { get; set; }
    }
}
