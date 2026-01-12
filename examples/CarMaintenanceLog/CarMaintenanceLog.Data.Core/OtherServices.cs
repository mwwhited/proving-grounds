using System;
using System.Collections.Generic;

namespace CarMaintenanceLog.Data.Core
{
    public partial class OtherServices
    {
        public int OtherServiceId { get; set; }
        public int CarId { get; set; }
        public DateTime Date { get; set; }
        public decimal Miles { get; set; }
        public string Item { get; set; }
        public decimal Cost { get; set; }
        public decimal Rate { get; set; }
        public string Location { get; set; }
        public string Notes { get; set; }
        public decimal? ExtendedCost { get; set; }

        public virtual Cars Car { get; set; }
    }
}
