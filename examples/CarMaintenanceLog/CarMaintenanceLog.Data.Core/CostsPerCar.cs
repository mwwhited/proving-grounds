using System;
using System.Collections.Generic;

namespace CarMaintenanceLog.Data.Core
{
    public partial class CostsPerCar
    {
        public int CarId { get; set; }
        public decimal? FillUps { get; set; }
        public decimal? InsurancePayments { get; set; }
        public decimal? Payments { get; set; }
        public decimal? OilChanges { get; set; }
        public decimal? OtherServices { get; set; }
        public decimal? Tires { get; set; }
        public decimal? TotalCost { get; set; }
    }
}
