using System;
using System.Collections.Generic;

namespace CarMaintenanceLog.Data.Core
{
    public partial class FillUps
    {
        public int FillUpId { get; set; }
        public int CarId { get; set; }
        public DateTime Date { get; set; }
        public decimal CostPerGallon { get; set; }
        public decimal Gallons { get; set; }
        public int Octane { get; set; }
        public decimal TankMiles { get; set; }
        public decimal TotalMiles { get; set; }
        public string Station { get; set; }
        public string Notes { get; set; }
        public decimal? ExtendedCost { get; set; }
        public decimal? MilesPerGallon { get; set; }

        public virtual Cars Car { get; set; }
    }
}
